#!/usr/bin/env python3
"""
NodeOn Pyramid API с исправленной авторизацией через Telegram
"""

from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
import requests
import json
import os
import hashlib
import hmac
import urllib.parse
from datetime import datetime
from typing import Optional, Dict, Any

app = FastAPI(title="NodeOn Pyramid API", version="1.0.0")

# CORS настройки
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Настройки Supabase
SUPABASE_URL = "https://ahxwpzgltlzlvrtrbanm.supabase.co"
SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoeHdwemdsdGx6bHZydHJiYW5tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1MDMxNDksImV4cCI6MjA3NTA3OTE0OX0.h4sMVhVwvRUiHgbevDgv9W1G2S__uDWPUSCiXdrEy4E"

# Telegram Bot Token для валидации подписи
TELEGRAM_BOT_TOKEN = os.getenv("TELEGRAM_BOT_TOKEN", "7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ")

def get_supabase_headers():
    """Получение заголовков для Supabase API"""
    return {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json",
        "Prefer": "return=representation"
    }

def verify_telegram_auth(init_data: str) -> Dict[str, Any]:
    """
    Строгая верификация Telegram данных с проверкой подписи
    ТОЛЬКО для Telegram Mini App
    """
    try:
        # Проверяем, что init_data не пустой
        if not init_data or init_data.strip() == "":
            raise ValueError("Требуется авторизация через Telegram. Откройте приложение в Telegram Mini App.")
        
        # URL декодируем данные
        decoded_data = urllib.parse.unquote(init_data)
        
        # Парсим данные
        data = {}
        for item in decoded_data.split('&'):
            if '=' in item:
                key, value = item.split('=', 1)
                data[key] = value
        
        # Проверяем обязательные поля Telegram
        required_fields = ['user', 'auth_date', 'hash']
        for field in required_fields:
            if field not in data:
                raise ValueError(f"Отсутствует обязательное поле Telegram: {field}")
        
        # Проверяем user данные
        try:
            user_data = json.loads(data['user'])
            if 'id' not in user_data:
                raise ValueError("Отсутствует ID пользователя Telegram")
        except json.JSONDecodeError:
            raise ValueError("Неверный формат данных пользователя Telegram")
        
        # Проверяем auth_date (не старше 24 часов)
        try:
            auth_date = int(data['auth_date'])
            if datetime.now().timestamp() - auth_date > 86400:  # 24 часа
                raise ValueError("Данные авторизации устарели")
        except ValueError:
            raise ValueError("Неверный формат даты авторизации")
        
        # ВАЛИДАЦИЯ ПОДПИСИ TELEGRAM
        if not verify_telegram_signature(init_data):
            raise ValueError("Неверная подпись Telegram данных")
        
        print(f"✅ Successfully verified Telegram user: {user_data.get('first_name')} (@{user_data.get('username')}) ID: {user_data.get('id')}")
        return user_data
        
    except Exception as e:
        print(f"❌ Telegram auth error: {e}")
        raise ValueError(f"Ошибка авторизации Telegram: {str(e)}")

def verify_telegram_signature(init_data: str) -> bool:
    """
    Проверка подписи Telegram данных
    """
    try:
        # Парсим данные
        data = {}
        for item in init_data.split('&'):
            if '=' in item:
                key, value = item.split('=', 1)
                data[key] = value
        
        if 'hash' not in data:
            return False
        
        # Извлекаем hash
        received_hash = data.pop('hash')
        
        # Создаем строку для проверки
        data_check_string = '\n'.join([f"{k}={v}" for k, v in sorted(data.items())])
        
        # Создаем секретный ключ
        secret_key = hmac.new(
            "WebAppData".encode(),
            TELEGRAM_BOT_TOKEN.encode(),
            hashlib.sha256
        ).digest()
        
        # Вычисляем hash
        calculated_hash = hmac.new(
            secret_key,
            data_check_string.encode(),
            hashlib.sha256
        ).hexdigest()
        
        # Сравниваем hash
        return hmac.compare_digest(received_hash, calculated_hash)
        
    except Exception as e:
        print(f"❌ Signature verification error: {e}")
        return False

def validate_referral_token(referral_token: str) -> Optional[Dict[str, Any]]:
    """Валидация реферального токена"""
    if not referral_token:
        return None
    
    headers = get_supabase_headers()
    
    try:
        # Вызываем функцию валидации
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/validate_referral_link",
            headers=headers,
            json={"referral_token": referral_token}
        )
        
        if response.status_code == 200:
            result = response.json()
            if result and result[0].get('is_valid'):
                return {
                    'inviter_id': result[0].get('inviter_id'),
                    'inviter_telegram_id': result[0].get('inviter_telegram_id'),
                    'inviter_name': result[0].get('inviter_name'),
                    'inviter_is_pro': result[0].get('inviter_is_pro')
                }
    except Exception as e:
        print(f"Referral validation error: {e}")
    
    return None

def get_or_create_user(telegram_user: Dict[str, Any], referral_token: str = None) -> Dict[str, Any]:
    """Получить или создать пользователя в Supabase"""
    telegram_id = telegram_user.get('id')
    if not telegram_id:
        raise HTTPException(status_code=400, detail="Invalid user data")
    
    headers = get_supabase_headers()
    
    try:
        # Ищем существующего пользователя
        response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?telegram_id=eq.{telegram_id}",
            headers=headers
        )
        
        if response.status_code == 200:
            users = response.json()
            if users:
                user = users[0]
                print(f"✅ Existing user found: {user['first_name']} (ID: {user['id']})")
                return user
        
        # Валидируем реферальный токен
        inviter_data = None
        if referral_token:
            inviter_data = validate_referral_token(referral_token)
            if inviter_data:
                print(f"✅ Valid referral token: {inviter_data['inviter_name']} (ID: {inviter_data['inviter_id']})")
            else:
                print(f"❌ Invalid referral token: {referral_token}")
        
        # Создаем нового пользователя
        user_data = {
            "telegram_id": telegram_id,
            "username": telegram_user.get('username'),
            "first_name": telegram_user.get('first_name'),
            "last_name": telegram_user.get('last_name'),
            "balance_ndn": 0.0,
            "balance_stars": 0.0,
            "total_stars_earned": 0.0,
            "total_stars_spent": 0.0,
            "is_pro": False,
            "referral_link": "",
            "inviter_id": inviter_data['inviter_id'] if inviter_data else None,
            "referral_path": "",
            "referral_level": 0,
            "is_active": True
        }
        
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/nodeon_users",
            headers=headers,
            json=user_data
        )
        
        if response.status_code == 201:
            created_user = response.json()[0]
            print(f"✅ New user created: {created_user['first_name']} (ID: {created_user['id']})")
            
            # Создаем статистику рефералов
            for level in range(1, 8):
                stats_data = {
                    "user_id": created_user["id"],
                    "level": level,
                    "total_referrals": 0,
                    "total_earnings": 0.0
                }
                
                requests.post(
                    f"{SUPABASE_URL}/rest/v1/nodeon_referral_stats",
                    headers=headers,
                    json=stats_data
                )
            
            # Если есть пригласивший, обновляем его статистику
            if inviter_data:
                update_inviter_stats(inviter_data['inviter_id'], created_user['id'])
            
            return created_user
        else:
            print(f"❌ Failed to create user: {response.text}")
            raise HTTPException(status_code=500, detail="Database error")
            
    except Exception as e:
        print(f"❌ Database error: {e}")
        raise HTTPException(status_code=500, detail="Database error")

def update_inviter_stats(inviter_id: int, new_user_id: int):
    """Обновление статистики пригласившего"""
    headers = get_supabase_headers()
    
    try:
        # Получаем уровень пригласившего
        response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{inviter_id}",
            headers=headers
        )
        
        if response.status_code == 200:
            users = response.json()
            if users:
                inviter_level = users[0].get('referral_level', 0)
                
                # Обновляем статистику для каждого уровня
                for level in range(1, min(inviter_level + 2, 8)):
                    stats_data = {
                        "user_id": inviter_id,
                        "level": level,
                        "total_referrals": 1,
                        "total_earnings": 0.0
                    }
                    
                    # Обновляем или создаем запись
                    requests.post(
                        f"{SUPABASE_URL}/rest/v1/nodeon_referral_stats",
                        headers=headers,
                        json=stats_data
                    )
    except Exception as e:
        print(f"Error updating inviter stats: {e}")

@app.get("/")
async def root():
    return {"message": "NodeOn Pyramid API", "status": "running"}

@app.get("/api/test")
async def api_test_endpoint():
    return {"message": "Supabase API is working", "status": "ok"}

@app.get("/api/user/profile")
async def get_user_profile(init_data: str = None, referral_token: str = None):
    """Получить профиль пользователя - ТОЛЬКО через Telegram"""
    try:
        if not init_data or init_data.strip() == "":
            raise HTTPException(status_code=401, detail="Требуется авторизация через Telegram. Откройте приложение в Telegram Mini App.")
        
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user, referral_token)
        
        # Получаем статистику рефералов
        headers = get_supabase_headers()
        response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_referral_stats?user_id=eq.{user['id']}",
            headers=headers
        )
        
        referral_stats = []
        if response.status_code == 200:
            referral_stats = response.json()
        
        # Генерируем реферальную ссылку только для Pro пользователей
        referral_link = None
        if user.get('is_pro'):
            referral_link = f"https://t.me/pro_stars_bot?startapp=ref_{user['id']}"
        
        return {
            "success": True,
            "user": {
                "id": user['id'],
                "telegram_id": user['telegram_id'],
                "username": user.get('username'),
                "first_name": user.get('first_name'),
                "last_name": user.get('last_name'),
                "balance_ndn": float(user.get('balance_ndn', 0)),
                "balance_stars": float(user.get('balance_stars', 0)),
                "is_pro": user.get('is_pro', False),
                "referral_link": referral_link,
                "created_at": user.get('created_at')
            },
            "referral_stats": referral_stats
        }
        
    except ValueError as e:
        raise HTTPException(status_code=401, detail=str(e))
    except Exception as e:
        print(f"Error getting user profile: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.post("/api/pro/buy")
async def buy_pro_status(init_data: str = None):
    """Купить Pro статус за 1000 NDN"""
    try:
        if not init_data:
            raise HTTPException(status_code=401, detail="Требуется авторизация через Telegram")
        
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        
        if user.get('is_pro'):
            return {"success": False, "message": "У вас уже есть Pro статус"}
        
        if user.get('balance_ndn', 0) < 1000:
            return {"success": False, "message": "Недостаточно NDN для покупки Pro статуса"}
        
        # Обновляем пользователя
        headers = get_supabase_headers()
        update_data = {
            "is_pro": True,
            "balance_ndn": user.get('balance_ndn', 0) - 1000,
            "referral_link": f"https://t.me/pro_stars_bot?startapp=ref_{user['id']}"
        }
        
        response = requests.patch(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user['id']}",
            headers=headers,
            json=update_data
        )
        
        if response.status_code == 200:
            # Создаем транзакцию
            transaction_data = {
                "user_id": user['id'],
                "type": "pro_purchase",
                "amount_ndn": -1000,
                "description": "Покупка Pro статуса"
            }
            
            requests.post(
                f"{SUPABASE_URL}/rest/v1/nodeon_transactions",
                headers=headers,
                json=transaction_data
            )
            
            return {
                "success": True,
                "message": "Pro статус успешно приобретен!",
                "referral_link": update_data["referral_link"]
            }
        else:
            return {"success": False, "message": "Ошибка обновления статуса"}
            
    except ValueError as e:
        raise HTTPException(status_code=401, detail=str(e))
    except Exception as e:
        print(f"Error buying pro status: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.get("/api/stars/config")
async def get_stars_config():
    """Получить конфигурацию Stars"""
    try:
        headers = get_supabase_headers()
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/get_stars_config",
            headers=headers,
            json={}
        )
        
        if response.status_code == 200:
            config = response.json()
            return {
                "success": True,
                "config": config
            }
        else:
            return {
                "success": False,
                "error": "Конфигурация Stars недоступна",
                "status": response.status_code
            }
            
    except Exception as e:
        print(f"Error getting stars config: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.get("/api/stats/leaderboard")
async def get_leaderboard():
    """Получить таблицу лидеров"""
    try:
        headers = get_supabase_headers()
        response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?is_active=eq.true&order=balance_ndn.desc&limit=10",
            headers=headers
        )
        
        if response.status_code == 200:
            users = response.json()
            leaders = []
            for i, user in enumerate(users, 1):
                leaders.append({
                    "rank": i,
                    "first_name": user.get('first_name'),
                    "username": user.get('username'),
                    "balance_ndn": float(user.get('balance_ndn', 0)),
                    "is_pro": user.get('is_pro', False)
                })
            
            return {
                "success": True,
                "leaders": leaders
            }
        else:
            return {"success": False, "message": "Ошибка получения лидеров"}
            
    except Exception as e:
        print(f"Error getting leaderboard: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.get("/api/stats/referrals")
async def get_referral_stats(init_data: str = None):
    """Получить статистику рефералов"""
    try:
        if not init_data:
            raise HTTPException(status_code=401, detail="Требуется авторизация через Telegram")
        
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        
        headers = get_supabase_headers()
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/get_user_referrals",
            headers=headers,
            json={"user_telegram_id": telegram_user['id']}
        )
        
        if response.status_code == 200:
            referrals = response.json()
            total_referrals = len(referrals)
            
            return {
                "success": True,
                "total_referrals": total_referrals,
                "referrals": referrals
            }
        else:
            return {"success": False, "message": "Ошибка получения статистики"}
            
    except ValueError as e:
        raise HTTPException(status_code=401, detail=str(e))
    except Exception as e:
        print(f"Error getting referral stats: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
