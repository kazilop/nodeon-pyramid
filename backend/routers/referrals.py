from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from database import get_db, User, ReferralStats, Transaction
from pydantic import BaseModel
from datetime import datetime
from typing import List, Optional

router = APIRouter()

class ReferralLinkRequest(BaseModel):
    user_id: int

class JoinByReferralRequest(BaseModel):
    user_id: int
    referral_code: str

@router.post("/join-by-referral")
async def join_by_referral(request: JoinByReferralRequest, db: Session = Depends(get_db)):
    """Присоединение по реферальной ссылке"""
    user = db.query(User).filter(User.id == request.user_id).first()
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Пользователь не найден"
        )
    
    if user.inviter_id:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Пользователь уже присоединился по реферальной ссылке"
        )
    
    # Ищем пользователя с такой реферальной ссылкой
    inviter = db.query(User).filter(User.referral_link == request.referral_code).first()
    
    if not inviter:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Неверная реферальная ссылка"
        )
    
    if inviter.id == user.id:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Нельзя использовать собственную реферальную ссылку"
        )
    
    # Устанавливаем реферала
    user.inviter_id = inviter.id
    
    db.commit()
    
    return {
        "message": "Вы успешно присоединились по реферальной ссылке!",
        "inviter": {
            "username": inviter.username,
            "first_name": inviter.first_name
        }
    }

@router.get("/referral-stats/{user_id}")
async def get_referral_stats(user_id: int, db: Session = Depends(get_db)):
    """Получение статистики рефералов"""
    user = db.query(User).filter(User.id == user_id).first()
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Пользователь не найден"
        )
    
    if not user.is_pro:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Pro статус требуется для просмотра статистики"
        )
    
    # Получаем статистику по уровням
    stats = db.query(ReferralStats).filter(ReferralStats.user_id == user_id).all()
    
    # Если статистики нет, создаем
    if not stats:
        for level in range(1, 8):  # 7 уровней
            stat = ReferralStats(
                user_id=user_id,
                level=level,
                total_referrals=0,
                total_earnings=0
            )
            db.add(stat)
        db.commit()
        stats = db.query(ReferralStats).filter(ReferralStats.user_id == user_id).all()
    
    # Подсчитываем общую статистику
    total_referrals = sum(stat.total_referrals for stat in stats)
    total_earnings = sum(float(stat.total_earnings) for stat in stats)
    
    # Получаем рефералов по уровням
    level_stats = []
    for level in range(1, 8):
        level_stat = next((s for s in stats if s.level == level), None)
        if level_stat:
            level_stats.append({
                "level": level,
                "referrals_count": level_stat.total_referrals,
                "earnings": float(level_stat.total_earnings)
            })
        else:
            level_stats.append({
                "level": level,
                "referrals_count": 0,
                "earnings": 0.0
            })
    
    return {
        "referral_link": user.referral_link,
        "total_referrals": total_referrals,
        "total_earnings": total_earnings,
        "level_stats": level_stats
    }

@router.get("/referral-tree/{user_id}")
async def get_referral_tree(user_id: int, db: Session = Depends(get_db)):
    """Получение дерева рефералов"""
    user = db.query(User).filter(User.id == user_id).first()
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Пользователь не найден"
        )
    
    if not user.is_pro:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Pro статус требуется для просмотра дерева рефералов"
        )
    
    def build_tree(user_id: int, level: int = 1, max_level: int = 7) -> dict:
        if level > max_level:
            return None
        
        user = db.query(User).filter(User.id == user_id).first()
        if not user:
            return None
        
        # Получаем прямых рефералов
        direct_referrals = db.query(User).filter(User.inviter_id == user_id).all()
        
        children = []
        for referral in direct_referrals:
            child_tree = build_tree(referral.id, level + 1, max_level)
            if child_tree:
                children.append(child_tree)
        
        return {
            "user_id": user.id,
            "username": user.username,
            "first_name": user.first_name,
            "is_pro": user.is_pro,
            "level": level,
            "children": children
        }
    
    tree = build_tree(user_id)
    
    return {
        "referral_tree": tree,
        "max_levels": 7
    }

@router.get("/referral-link/{user_id}")
async def get_referral_link(user_id: int, db: Session = Depends(get_db)):
    """Получение реферальной ссылки"""
    user = db.query(User).filter(User.id == user_id).first()
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Пользователь не найден"
        )
    
    if not user.is_pro:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Pro статус требуется для получения реферальной ссылки"
        )
    
    return {
        "referral_link": user.referral_link,
        "full_url": f"https://t.me/{settings.telegram_bot_username}?start={user.referral_link}"
    }
