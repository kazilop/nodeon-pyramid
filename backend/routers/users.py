from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from database import get_db, User, Transaction
from pydantic import BaseModel
from datetime import datetime
import secrets
import string

router = APIRouter()

class ProPurchaseRequest(BaseModel):
    user_id: int

class WithdrawRequest(BaseModel):
    user_id: int
    amount_ndn: float

def generate_referral_link() -> str:
    """Генерация уникальной реферальной ссылки"""
    return ''.join(secrets.choices(string.ascii_letters + string.digits, k=16))

@router.post("/buy-pro")
async def buy_pro(request: ProPurchaseRequest, db: Session = Depends(get_db)):
    """Покупка Pro статуса за 1000 NDN"""
    user = db.query(User).filter(User.id == request.user_id).first()
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Пользователь не найден"
        )
    
    if user.is_pro:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="У вас уже есть Pro статус"
        )
    
    pro_cost = 1000  # Из конфига
    if user.balance_ndn < pro_cost:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Недостаточно NDN для покупки Pro статуса"
        )
    
    # Списываем NDN
    user.balance_ndn -= pro_cost
    user.is_pro = True
    user.referral_link = generate_referral_link()
    
    # Создаем транзакцию
    transaction = Transaction(
        user_id=user.id,
        type="pro_purchase",
        amount_ndn=-pro_cost,
        description="Покупка Pro статуса"
    )
    db.add(transaction)
    
    # Распределяем награды по реферальной цепочке
    await distribute_referral_rewards(user, db)
    
    db.commit()
    
    return {
        "message": "Pro статус успешно приобретен!",
        "referral_link": user.referral_link,
        "new_balance": float(user.balance_ndn)
    }

async def distribute_referral_rewards(user: User, db: Session):
    """Распределение наград по реферальной цепочке"""
    from config import settings
    
    current_user = user
    level = 1
    
    # Комиссия разработчику
    dev_transaction = Transaction(
        user_id=settings.developer_telegram_id,  # ID разработчика
        type="developer_fee",
        amount_ndn=settings.developer_fee,
        description=f"Комиссия с покупки Pro статуса пользователя {user.telegram_id}",
        referral_level=0
    )
    db.add(dev_transaction)
    
    # Проходим по цепочке рефералов
    while current_user.inviter_id and level <= settings.referral_levels:
        inviter = db.query(User).filter(User.id == current_user.inviter_id).first()
        if not inviter:
            break
        
        reward = settings.referral_rewards[level - 1] if level <= len(settings.referral_rewards) else 0
        
        if reward > 0:
            inviter.balance_ndn += reward
            
            # Создаем транзакцию награды
            reward_transaction = Transaction(
                user_id=inviter.id,
                type="referral_reward",
                amount_ndn=reward,
                description=f"Реферальная награда за уровень {level}",
                referral_level=level
            )
            db.add(reward_transaction)
        
        current_user = inviter
        level += 1

@router.post("/withdraw")
async def request_withdraw(request: WithdrawRequest, db: Session = Depends(get_db)):
    """Запрос на вывод NDN в Telegram Stars"""
    user = db.query(User).filter(User.id == request.user_id).first()
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Пользователь не найден"
        )
    
    if request.amount_ndn <= 0:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Сумма должна быть больше 0"
        )
    
    if user.balance_ndn < request.amount_ndn:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Недостаточно NDN на балансе"
        )
    
    # Конвертируем NDN в Stars (1 NDN = 1 Star)
    stars_amount = request.amount_ndn
    
    # Списываем NDN
    user.balance_ndn -= request.amount_ndn
    
    # Создаем транзакцию
    transaction = Transaction(
        user_id=user.id,
        type="withdraw_ndn",
        amount_ndn=-request.amount_ndn,
        amount_stars=stars_amount,
        description=f"Запрос на вывод {request.amount_ndn} NDN в Stars"
    )
    db.add(transaction)
    
    db.commit()
    
    return {
        "message": "Заявка на вывод создана",
        "amount_ndn": request.amount_ndn,
        "amount_stars": float(stars_amount),
        "new_balance": float(user.balance_ndn)
    }

@router.get("/balance/{user_id}")
async def get_balance(user_id: int, db: Session = Depends(get_db)):
    """Получение баланса пользователя"""
    user = db.query(User).filter(User.id == user_id).first()
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Пользователь не найден"
        )
    
    return {
        "balance_ndn": float(user.balance_ndn),
        "is_pro": user.is_pro
    }
