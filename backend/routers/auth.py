from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from database import get_db, User
from pydantic import BaseModel
import hashlib
import hmac
import json
from config import settings

router = APIRouter()

class TelegramAuth(BaseModel):
    id: int
    first_name: str
    last_name: str = None
    username: str = None
    photo_url: str = None
    auth_date: int
    hash: str

def verify_telegram_auth(auth_data: TelegramAuth) -> bool:
    """Проверка подлинности данных от Telegram"""
    bot_token = settings.telegram_bot_token
    
    # Создаем строку для проверки
    data_check_string = f"auth_date={auth_data.auth_date}\nfirst_name={auth_data.first_name}\nid={auth_data.id}"
    if auth_data.last_name:
        data_check_string += f"\nlast_name={auth_data.last_name}"
    if auth_data.username:
        data_check_string += f"\nusername={auth_data.username}"
    if auth_data.photo_url:
        data_check_string += f"\nphoto_url={auth_data.photo_url}"
    
    # Создаем секретный ключ
    secret_key = hashlib.sha256(bot_token.encode()).digest()
    
    # Вычисляем хеш
    calculated_hash = hmac.new(
        secret_key,
        data_check_string.encode(),
        hashlib.sha256
    ).hexdigest()
    
    return calculated_hash == auth_data.hash

@router.post("/login")
async def login(auth_data: TelegramAuth, db: Session = Depends(get_db)):
    """Авторизация пользователя через Telegram"""
    
    # Проверяем подлинность данных
    if not verify_telegram_auth(auth_data):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Неверные данные авторизации"
        )
    
    # Ищем пользователя в базе
    user = db.query(User).filter(User.telegram_id == auth_data.id).first()
    
    if not user:
        # Создаем нового пользователя
        user = User(
            telegram_id=auth_data.id,
            username=auth_data.username or None,
            first_name=auth_data.first_name or 'Пользователь',
            last_name=auth_data.last_name or ''
        )
        db.add(user)
        db.commit()
        db.refresh(user)
    
    return {
        "user_id": user.id,
        "telegram_id": user.telegram_id,
        "username": user.username,
        "first_name": user.first_name,
        "last_name": user.last_name,
        "balance_ndn": float(user.balance_ndn),
        "is_pro": user.is_pro,
        "referral_link": user.referral_link
    }

@router.get("/me")
async def get_current_user(user_id: int, db: Session = Depends(get_db)):
    """Получение информации о текущем пользователе"""
    user = db.query(User).filter(User.id == user_id).first()
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Пользователь не найден"
        )
    
    return {
        "user_id": user.id,
        "telegram_id": user.telegram_id,
        "username": user.username,
        "first_name": user.first_name,
        "last_name": user.last_name,
        "balance_ndn": float(user.balance_ndn),
        "is_pro": user.is_pro,
        "referral_link": user.referral_link,
        "created_at": user.created_at
    }
