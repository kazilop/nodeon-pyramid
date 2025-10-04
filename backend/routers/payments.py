from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from database import get_db, User, Transaction
from pydantic import BaseModel
from datetime import datetime
import httpx
from config import settings

router = APIRouter()

class TelegramStarsPayment(BaseModel):
    user_id: int
    amount_stars: int
    payment_id: str

class BuyNDNRequest(BaseModel):
    user_id: int
    amount_stars: int

@router.post("/buy-ndn")
async def buy_ndn(request: BuyNDNRequest, db: Session = Depends(get_db)):
    """Покупка NDN за Telegram Stars"""
    user = db.query(User).filter(User.id == request.user_id).first()
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Пользователь не найден"
        )
    
    if request.amount_stars <= 0:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Сумма должна быть больше 0"
        )
    
    # Конвертируем Stars в NDN (1 Star = 1 NDN)
    ndn_amount = request.amount_stars
    
    # Зачисляем NDN
    user.balance_ndn += ndn_amount
    
    # Создаем транзакцию
    transaction = Transaction(
        user_id=user.id,
        type="buy_ndn",
        amount_ndn=ndn_amount,
        amount_stars=request.amount_stars,
        description=f"Покупка {ndn_amount} NDN за {request.amount_stars} Stars"
    )
    db.add(transaction)
    
    db.commit()
    
    return {
        "message": "NDN успешно зачислены",
        "amount_ndn": ndn_amount,
        "amount_stars": request.amount_stars,
        "new_balance": float(user.balance_ndn)
    }

@router.post("/telegram-stars-webhook")
async def telegram_stars_webhook(payment_data: dict):
    """Webhook для обработки платежей через Telegram Stars"""
    # Здесь должна быть логика обработки webhook от Telegram
    # В реальном приложении нужно проверить подпись и обработать платеж
    
    try:
        user_id = payment_data.get("user_id")
        amount_stars = payment_data.get("amount_stars")
        payment_id = payment_data.get("payment_id")
        
        # Обрабатываем платеж
        # В реальном приложении здесь будет вызов функции покупки NDN
        
        return {"status": "success", "message": "Платеж обработан"}
    
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=f"Ошибка обработки платежа: {str(e)}"
        )

@router.get("/payment-methods")
async def get_payment_methods():
    """Получение доступных способов оплаты"""
    return {
        "methods": [
            {
                "id": "telegram_stars",
                "name": "Telegram Stars",
                "description": "Оплата через официальную систему Telegram Stars",
                "min_amount": 1,
                "max_amount": 10000,
                "rate": 1.0  # 1 Star = 1 NDN
            }
        ]
    }

@router.get("/exchange-rate")
async def get_exchange_rate():
    """Получение курса обмена"""
    return {
        "ndn_to_stars": 1.0,  # 1 NDN = 1 Star
        "stars_to_ndn": 1.0   # 1 Star = 1 NDN
    }
