from fastapi import FastAPI, HTTPException, Depends, Request
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
from database import get_db, User, Transaction, ReferralStats, PaymentRequest
from config import settings
import hashlib
import hmac
import json
import logging
from datetime import datetime
from decimal import Decimal
import uuid

# Настройка логирования
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(title="NodeOn NDN API", version="1.0.0")

# CORS настройки
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

def verify_telegram_auth(init_data: str) -> dict:
    """Верификация данных от Telegram"""
    try:
        # Парсим данные
        data = {}
        for item in init_data.split('&'):
            key, value = item.split('=')
            data[key] = value
        
        # Проверяем hash
        bot_token = settings.telegram_bot_token
        secret_key = hmac.new(
            b"WebAppData", 
            bot_token.encode(), 
            hashlib.sha256
        ).digest()
        
        check_string = '\n'.join([f"{k}={v}" for k, v in sorted(data.items()) if k != 'hash'])
        calculated_hash = hmac.new(
            secret_key,
            check_string.encode(),
            hashlib.sha256
        ).hexdigest()
        
        if calculated_hash != data.get('hash'):
            raise HTTPException(status_code=401, detail="Invalid Telegram auth")
        
        # Парсим user данные
        user_data = json.loads(data.get('user', '{}'))
        return user_data
        
    except Exception as e:
        logger.error(f"Telegram auth verification failed: {e}")
        raise HTTPException(status_code=401, detail="Invalid auth data")

def get_or_create_user(telegram_user: dict, db: Session) -> User:
    """Получить или создать пользователя"""
    telegram_id = telegram_user.get('id')
    if not telegram_id:
        raise HTTPException(status_code=400, detail="Invalid user data")
    
    user = db.query(User).filter(User.telegram_id == telegram_id).first()
    
    if not user:
        # Создаем нового пользователя
        user = User(
            telegram_id=telegram_id,
            username=telegram_user.get('username'),
            first_name=telegram_user.get('first_name'),
            last_name=telegram_user.get('last_name'),
            balance_ndn=Decimal('0'),
            is_pro=False,
            referral_link=f"https://t.me/{settings.telegram_bot_username}?start=ref_{telegram_id}"
        )
        db.add(user)
        db.commit()
        db.refresh(user)
        
        # Создаем статистику рефералов
        for level in range(1, 8):
            stats = ReferralStats(
                user_id=user.id,
                level=level,
                total_referrals=0,
                total_earnings=Decimal('0')
            )
            db.add(stats)
        db.commit()
    
    return user

@app.get("/")
async def root():
    return {"message": "NodeOn NDN API", "status": "running"}

@app.get("/api/user/profile")
async def get_user_profile(
    init_data: str,
    db: Session = Depends(get_db)
):
    """Получить профиль пользователя"""
    try:
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user, db)
        
        # Получаем статистику рефералов
        referral_stats = db.query(ReferralStats).filter(
            ReferralStats.user_id == user.id
        ).all()
        
        stats_dict = {stat.level: {
            'referrals': stat.total_referrals,
            'earnings': float(stat.total_earnings)
        } for stat in referral_stats}
        
        return {
            "user": {
                "id": user.id,
                "telegram_id": user.telegram_id,
                "username": user.username,
                "first_name": user.first_name,
                "last_name": user.last_name,
                "balance_ndn": float(user.balance_ndn),
                "is_pro": user.is_pro,
                "referral_link": user.referral_link,
                "created_at": user.created_at.isoformat()
            },
            "referral_stats": stats_dict
        }
    except Exception as e:
        logger.error(f"Error getting user profile: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/api/ndn/buy")
async def buy_ndn(
    request: Request,
    init_data: str,
    db: Session = Depends(get_db)
):
    """Покупка NDN за Telegram Stars"""
    try:
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user, db)
        
        data = await request.json()
        amount_ndn = Decimal(str(data.get('amount_ndn', 0)))
        amount_stars = Decimal(str(data.get('amount_stars', 0)))
        
        if amount_ndn <= 0 or amount_stars <= 0:
            raise HTTPException(status_code=400, detail="Invalid amounts")
        
        # Создаем запрос на покупку
        payment_request = PaymentRequest(
            user_id=user.id,
            amount_ndn=amount_ndn,
            amount_stars=amount_stars,
            status="pending"
        )
        db.add(payment_request)
        db.commit()
        
        return {
            "success": True,
            "message": "Запрос на покупку NDN создан",
            "payment_request_id": payment_request.id,
            "amount_ndn": float(amount_ndn),
            "amount_stars": float(amount_stars)
        }
        
    except Exception as e:
        logger.error(f"Error buying NDN: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/api/ndn/withdraw")
async def withdraw_ndn(
    request: Request,
    init_data: str,
    db: Session = Depends(get_db)
):
    """Вывод NDN в Telegram Stars"""
    try:
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user, db)
        
        data = await request.json()
        amount_ndn = Decimal(str(data.get('amount_ndn', 0)))
        
        if amount_ndn <= 0:
            raise HTTPException(status_code=400, detail="Invalid amount")
        
        if user.balance_ndn < amount_ndn:
            raise HTTPException(status_code=400, detail="Insufficient NDN balance")
        
        # Создаем запрос на вывод
        payment_request = PaymentRequest(
            user_id=user.id,
            amount_ndn=amount_ndn,
            amount_stars=amount_ndn * Decimal('0.1'),  # 1 NDN = 0.1 Stars
            status="pending"
        )
        db.add(payment_request)
        db.commit()
        
        return {
            "success": True,
            "message": "Запрос на вывод NDN создан",
            "payment_request_id": payment_request.id,
            "amount_ndn": float(amount_ndn),
            "amount_stars": float(payment_request.amount_stars)
        }
        
    except Exception as e:
        logger.error(f"Error withdrawing NDN: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/api/pro/buy")
async def buy_pro_status(
    init_data: str,
    db: Session = Depends(get_db)
):
    """Покупка Pro статуса за 1000 NDN"""
    try:
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user, db)
        
        pro_cost = Decimal('1000')
        
        if user.is_pro:
            raise HTTPException(status_code=400, detail="User already has Pro status")
        
        if user.balance_ndn < pro_cost:
            raise HTTPException(status_code=400, detail="Insufficient NDN balance")
        
        # Списываем NDN
        user.balance_ndn -= pro_cost
        user.is_pro = True
        
        # Создаем транзакцию
        transaction = Transaction(
            user_id=user.id,
            type="pro_purchase",
            amount_ndn=pro_cost,
            description="Покупка Pro статуса"
        )
        db.add(transaction)
        
        # Распределяем награды по реферальной цепочке
        current_user = user
        level = 1
        rewards = [200, 150, 150, 150, 150, 150, 150]  # Награды по уровням
        
        while current_user.inviter_id and level <= 7:
            inviter = db.query(User).filter(User.id == current_user.inviter_id).first()
            if not inviter:
                break
                
            reward = Decimal(str(rewards[level - 1]))
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
            
            # Обновляем статистику
            stats = db.query(ReferralStats).filter(
                ReferralStats.user_id == inviter.id,
                ReferralStats.level == level
            ).first()
            if stats:
                stats.total_referrals += 1
                stats.total_earnings += reward
            
            current_user = inviter
            level += 1
        
        # Комиссия разработчику
        developer_fee = Decimal('200')
        developer_transaction = Transaction(
            user_id=user.id,
            type="developer_fee",
            amount_ndn=developer_fee,
            description="Комиссия разработчику"
        )
        db.add(developer_transaction)
        
        db.commit()
        
        return {
            "success": True,
            "message": "Pro статус активирован!",
            "new_balance": float(user.balance_ndn),
            "referral_link": user.referral_link
        }
        
    except Exception as e:
        logger.error(f"Error buying Pro status: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/api/stats/leaderboard")
async def get_leaderboard(db: Session = Depends(get_db)):
    """Получить таблицу лидеров"""
    try:
        # Топ пользователей по балансу NDN
        top_users = db.query(User).filter(
            User.balance_ndn > 0
        ).order_by(User.balance_ndn.desc()).limit(10).all()
        
        leaderboard = []
        for i, user in enumerate(top_users, 1):
            leaderboard.append({
                "rank": i,
                "username": user.username or f"User{user.telegram_id}",
                "first_name": user.first_name,
                "balance_ndn": float(user.balance_ndn),
                "is_pro": user.is_pro
            })
        
        return {
            "leaderboard": leaderboard,
            "total_users": db.query(User).count()
        }
        
    except Exception as e:
        logger.error(f"Error getting leaderboard: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/api/stats/transactions")
async def get_user_transactions(
    init_data: str,
    limit: int = 20,
    db: Session = Depends(get_db)
):
    """Получить транзакции пользователя"""
    try:
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user, db)
        
        transactions = db.query(Transaction).filter(
            Transaction.user_id == user.id
        ).order_by(Transaction.created_at.desc()).limit(limit).all()
        
        transaction_list = []
        for tx in transactions:
            transaction_list.append({
                "id": tx.id,
                "type": tx.type,
                "amount_ndn": float(tx.amount_ndn),
                "amount_stars": float(tx.amount_stars) if tx.amount_stars else None,
                "description": tx.description,
                "referral_level": tx.referral_level,
                "created_at": tx.created_at.isoformat()
            })
        
        return {
            "transactions": transaction_list,
            "total": len(transaction_list)
        }
        
    except Exception as e:
        logger.error(f"Error getting transactions: {e}")
        raise HTTPException(status_code=500, detail=str(e))

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)