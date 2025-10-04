from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from database import get_db, User, Transaction, ReferralStats
from pydantic import BaseModel
from datetime import datetime, timedelta
from typing import List, Optional
from sqlalchemy import func, desc

router = APIRouter()

class StatsRequest(BaseModel):
    user_id: int
    period_days: Optional[int] = 30

@router.get("/dashboard/{user_id}")
async def get_dashboard_stats(user_id: int, db: Session = Depends(get_db)):
    """Получение статистики для дашборда"""
    user = db.query(User).filter(User.id == user_id).first()
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Пользователь не найден"
        )
    
    # Общая статистика
    total_earnings = db.query(func.sum(Transaction.amount_ndn)).filter(
        Transaction.user_id == user_id,
        Transaction.type == "referral_reward"
    ).scalar() or 0
    
    total_spent = db.query(func.sum(Transaction.amount_ndn)).filter(
        Transaction.user_id == user_id,
        Transaction.type.in_(["pro_purchase", "buy_ndn"]),
        Transaction.amount_ndn < 0
    ).scalar() or 0
    
    # Статистика за последние 30 дней
    thirty_days_ago = datetime.utcnow() - timedelta(days=30)
    recent_earnings = db.query(func.sum(Transaction.amount_ndn)).filter(
        Transaction.user_id == user_id,
        Transaction.type == "referral_reward",
        Transaction.created_at >= thirty_days_ago
    ).scalar() or 0
    
    # Количество рефералов
    total_referrals = db.query(func.count(User.id)).filter(User.inviter_id == user_id).scalar() or 0
    
    # Pro рефералы
    pro_referrals = db.query(func.count(User.id)).filter(
        User.inviter_id == user_id,
        User.is_pro == True
    ).scalar() or 0
    
    return {
        "user": {
            "username": user.username,
            "first_name": user.first_name,
            "balance_ndn": float(user.balance_ndn),
            "is_pro": user.is_pro,
            "referral_link": user.referral_link
        },
        "stats": {
            "total_earnings": float(total_earnings),
            "total_spent": float(abs(total_spent)),
            "recent_earnings": float(recent_earnings),
            "total_referrals": total_referrals,
            "pro_referrals": pro_referrals,
            "conversion_rate": (pro_referrals / total_referrals * 100) if total_referrals > 0 else 0
        }
    }

@router.get("/transactions/{user_id}")
async def get_transactions(user_id: int, limit: int = 50, offset: int = 0, db: Session = Depends(get_db)):
    """Получение истории транзакций"""
    user = db.query(User).filter(User.id == user_id).first()
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Пользователь не найден"
        )
    
    transactions = db.query(Transaction).filter(
        Transaction.user_id == user_id
    ).order_by(desc(Transaction.created_at)).offset(offset).limit(limit).all()
    
    return {
        "transactions": [
            {
                "id": t.id,
                "type": t.type,
                "amount_ndn": float(t.amount_ndn),
                "amount_stars": float(t.amount_stars) if t.amount_stars else None,
                "description": t.description,
                "referral_level": t.referral_level,
                "created_at": t.created_at
            }
            for t in transactions
        ],
        "total": db.query(func.count(Transaction.id)).filter(Transaction.user_id == user_id).scalar()
    }

@router.get("/leaderboard")
async def get_leaderboard(db: Session = Depends(get_db)):
    """Получение таблицы лидеров"""
    # Топ по заработку
    top_earners = db.query(
        User.username,
        User.first_name,
        func.sum(Transaction.amount_ndn).label('total_earnings')
    ).join(Transaction).filter(
        Transaction.type == "referral_reward"
    ).group_by(User.id).order_by(desc('total_earnings')).limit(10).all()
    
    # Топ по количеству рефералов
    top_referrers = db.query(
        User.username,
        User.first_name,
        func.count(User.id).label('referrals_count')
    ).join(User, User.inviter_id == User.id).group_by(User.id).order_by(desc('referrals_count')).limit(10).all()
    
    return {
        "top_earners": [
            {
                "username": u.username,
                "first_name": u.first_name,
                "total_earnings": float(u.total_earnings)
            }
            for u in top_earners
        ],
        "top_referrers": [
            {
                "username": u.username,
                "first_name": u.first_name,
                "referrals_count": u.referrals_count
            }
            for u in top_referrers
        ]
    }

@router.get("/game-rules")
async def get_game_rules():
    """Получение правил игры"""
    return {
        "title": "Правила игры NodeOn Pyramid",
        "description": "Реферальная игра с монетами NDN",
        "rules": [
            {
                "title": "Как начать играть",
                "content": "1. Зарегистрируйтесь в боте\n2. Купите 1000 NDN за Telegram Stars\n3. Приобретите Pro статус за 1000 NDN\n4. Получите свою реферальную ссылку"
            },
            {
                "title": "Реферальная система",
                "content": "За каждого друга, который купит Pro статус:\n• Уровень 1: 200 NDN\n• Уровень 2: 150 NDN\n• Уровень 3: 150 NDN\n• Уровень 4: 150 NDN\n• Уровень 5: 150 NDN\n• Уровень 6: 150 NDN\n• Уровень 7: 150 NDN"
            },
            {
                "title": "Пример заработка",
                "content": "При 10 рефералах на каждом уровне:\n• Уровень 1: 10 × 200 = 2,000 NDN\n• Уровень 2: 100 × 150 = 15,000 NDN\n• Уровень 3: 1,000 × 150 = 150,000 NDN\n• Итого: 180,000+ NDN"
            },
            {
                "title": "Вывод средств",
                "content": "NDN можно вывести обратно в Telegram Stars по курсу 1:1"
            }
        ],
        "costs": {
            "pro_status": 1000,
            "ndn_to_stars_rate": 1.0
        }
    }
