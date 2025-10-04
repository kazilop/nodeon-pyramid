#!/usr/bin/env python3
"""
NodeOn Pyramid API с поддержкой Stars и ЮКассы
"""

from fastapi import FastAPI, HTTPException, Query
from fastapi.middleware.cors import CORSMiddleware
import requests
import json
import urllib.parse
import hashlib
import hmac
import base64
import time
import uuid
from datetime import datetime
import os
from dotenv import load_dotenv

# Загружаем переменные окружения
load_dotenv()

app = FastAPI(title="NodeOn Pyramid API", version="1.0.0")

# CORS настройки
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Конфигурация Supabase
SUPABASE_URL = os.getenv("SUPABASE_URL", "https://ahxwpzgltlzlvrtrbanm.supabase.co")
SUPABASE_ANON_KEY = os.getenv("SUPABASE_ANON_KEY", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoeHdwemdsdGx6bHZydHJiYW5tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1MDMxNDksImV4cCI6MjA3NTA3OTE0OX0.h4sMVhVwvRUiHgbevDgv9W1G2S__uDWPUSCiXdrEy4E")

def get_supabase_headers():
    """Получить заголовки для Supabase API"""
    return {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json",
        "Prefer": "return=representation"
    }

def verify_telegram_auth(init_data: str):
    """Строгая проверка авторизации через Telegram"""
    if not init_data or init_data == "" or init_data is None:
        raise ValueError("Требуется авторизация через Telegram. Откройте приложение в Telegram Mini App.")
    
    # URL декодируем данные
    decoded_data = urllib.parse.unquote(init_data)
    
    # Парсим параметры
    data = {}
    for param in decoded_data.split('&'):
        if '=' in param:
            key, value = param.split('=', 1)
            data[key] = value
    
    # Проверяем обязательные поля
    required_fields = ['user', 'auth_date', 'hash']
    for field in required_fields:
        if field not in data:
            raise ValueError(f"Отсутствует обязательное поле Telegram: {field}")
    
    # Проверяем user
    try:
        user_data = json.loads(data['user'])
        if 'id' not in user_data:
            raise ValueError("Отсутствует ID пользователя Telegram")
    except json.JSONDecodeError:
        raise ValueError("Неверный формат данных пользователя Telegram")
    
    # Проверяем auth_date (не старше 24 часов)
    try:
        auth_date = int(data['auth_date'])
        if time.time() - auth_date > 86400:  # 24 часа
            raise ValueError("Данные авторизации устарели")
    except ValueError:
        raise ValueError("Неверный формат даты авторизации")
    
    return user_data

def get_or_create_user(telegram_user, referral_token=None):
    """Получить или создать пользователя"""
    headers = get_supabase_headers()
    
    # Ищем пользователя
    response = requests.get(
        f"{SUPABASE_URL}/rest/v1/nodeon_users?telegram_id=eq.{telegram_user['id']}",
        headers=headers
    )
    
    if response.status_code == 200:
        users = response.json()
        if users:
            return users[0]
    
    # Создаем нового пользователя
    inviter_id = None
    if referral_token:
        # Проверяем реферальный токен
        validation_response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/validate_referral_link",
            headers=headers,
            json={"referral_token": referral_token}
        )
        
        if validation_response.status_code == 200:
            validation_data = validation_response.json()
            if validation_data.get('is_valid'):
                inviter_id = validation_data.get('inviter_id')
    
    user_data = {
        "telegram_id": telegram_user['id'],
        "username": telegram_user.get('username'),
        "first_name": telegram_user.get('first_name'),
        "last_name": telegram_user.get('last_name'),
        "balance_ndn": 0.0,
        "balance_stars": 0.0,
        "is_pro": False,
        "is_active": True,
        "inviter_id": inviter_id
    }
    
    response = requests.post(
        f"{SUPABASE_URL}/rest/v1/nodeon_users",
        headers=headers,
        json=user_data
    )
    
    if response.status_code == 201:
        return response.json()[0]
    else:
        raise HTTPException(status_code=500, detail="Ошибка создания пользователя")

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
        if not init_data or init_data == "" or init_data is None:
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
        raise HTTPException(status_code=401, detail=f"Ошибка авторизации Telegram: {str(e)}")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Ошибка сервера: {str(e)}")

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
        raise HTTPException(status_code=401, detail=f"Ошибка авторизации Telegram: {str(e)}")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Ошибка сервера: {str(e)}")

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
        raise HTTPException(status_code=500, detail=f"Ошибка получения конфигурации: {str(e)}")

@app.post("/api/stars/buy-ndn")
async def buy_ndn_with_stars(init_data: str = None, stars_amount: float = None):
    """Купить NDN за Telegram Stars"""
    try:
        if not init_data:
            raise HTTPException(status_code=401, detail="Требуется авторизация через Telegram")
        
        if not stars_amount or stars_amount <= 0:
            raise HTTPException(status_code=400, detail="Неверная сумма Stars")
        
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        
        # Получаем конфигурацию
        headers = get_supabase_headers()
        config_response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/get_stars_config",
            headers=headers,
            json={}
        )
        
        if config_response.status_code != 200:
            raise HTTPException(status_code=500, detail="Конфигурация Stars недоступна")
        
        config = config_response.json()
        min_stars = float(config.get('min_stars_purchase', 10))
        max_stars = float(config.get('max_stars_purchase', 10000))
        rate = float(config.get('stars_to_ndn_rate', 1.0))
        
        if stars_amount < min_stars or stars_amount > max_stars:
            raise HTTPException(
                status_code=400, 
                detail=f"Сумма должна быть от {min_stars} до {max_stars} Stars"
            )
        
        ndn_amount = stars_amount * rate
        payment_id = f"stars_{user['id']}_{int(time.time())}"
        
        # Обрабатываем платеж
        payment_response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/process_stars_payment",
            headers=headers,
            json={
                "p_user_id": user['id'],
                "p_payment_id": payment_id,
                "p_stars_amount": stars_amount,
                "p_ndn_amount": ndn_amount
            }
        )
        
        if payment_response.status_code == 200:
            result = payment_response.json()
            if result.get('success'):
                return {
                    "success": True,
                    "message": f"Успешно куплено {ndn_amount} NDN за {stars_amount} Stars",
                    "ndn_amount": ndn_amount,
                    "stars_amount": stars_amount,
                    "new_balance": result.get('new_ndn_balance')
                }
            else:
                return {"success": False, "message": result.get('error')}
        else:
            return {"success": False, "message": "Ошибка обработки платежа"}
            
    except ValueError as e:
        raise HTTPException(status_code=401, detail=f"Ошибка авторизации Telegram: {str(e)}")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Ошибка сервера: {str(e)}")

@app.post("/api/stars/withdraw")
async def withdraw_ndn_to_stars(init_data: str = None, ndn_amount: float = None):
    """Вывести NDN в Telegram Stars"""
    try:
        if not init_data:
            raise HTTPException(status_code=401, detail="Требуется авторизация через Telegram")
        
        if not ndn_amount or ndn_amount <= 0:
            raise HTTPException(status_code=400, detail="Неверная сумма NDN")
        
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        
        if user.get('balance_ndn', 0) < ndn_amount:
            raise HTTPException(status_code=400, detail="Недостаточно NDN для вывода")
        
        headers = get_supabase_headers()
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/withdraw_ndn_to_stars",
            headers=headers,
            json={
                "p_user_id": user['id'],
                "p_ndn_amount": ndn_amount
            }
        )
        
        if response.status_code == 200:
            result = response.json()
            if result.get('success'):
                return {
                    "success": True,
                    "message": f"Успешно выведено {result.get('stars_amount')} Stars",
                    "ndn_amount": ndn_amount,
                    "stars_amount": result.get('stars_amount'),
                    "withdrawal_fee": result.get('withdrawal_fee'),
                    "new_balance": result.get('new_ndn_balance')
                }
            else:
                return {"success": False, "message": result.get('error')}
        else:
            return {"success": False, "message": "Ошибка обработки вывода"}
            
    except ValueError as e:
        raise HTTPException(status_code=401, detail=f"Ошибка авторизации Telegram: {str(e)}")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Ошибка сервера: {str(e)}")

@app.get("/api/yookassa/config")
async def get_yookassa_config():
    """Получить конфигурацию ЮКассы"""
    try:
        headers = get_supabase_headers()
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/get_yookassa_config",
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
                "error": "Конфигурация ЮКассы недоступна",
                "status": response.status_code
            }
            
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Ошибка получения конфигурации: {str(e)}")

@app.post("/api/yookassa/create-payment")
async def create_yookassa_payment(init_data: str = None, amount_rub: float = None):
    """Создать платеж через ЮКассу"""
    try:
        if not init_data:
            raise HTTPException(status_code=401, detail="Требуется авторизация через Telegram")
        
        if not amount_rub or amount_rub <= 0:
            raise HTTPException(status_code=400, detail="Неверная сумма в рублях")
        
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        
        # Получаем конфигурацию
        headers = get_supabase_headers()
        config_response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/get_yookassa_config",
            headers=headers,
            json={}
        )
        
        if config_response.status_code != 200:
            raise HTTPException(status_code=500, detail="Конфигурация ЮКассы недоступна")
        
        config = config_response.json()
        min_rub = float(config.get('min_rub_purchase', 100))
        max_rub = float(config.get('max_rub_purchase', 50000))
        rate = float(config.get('rub_to_ndn_rate', 10.0))
        
        if amount_rub < min_rub or amount_rub > max_rub:
            raise HTTPException(
                status_code=400, 
                detail=f"Сумма должна быть от {min_rub} до {max_rub} рублей"
            )
        
        ndn_amount = amount_rub * rate
        payment_id = f"yookassa_{user['id']}_{int(time.time())}"
        
        # Создаем платеж в базе
        payment_response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/create_yookassa_payment",
            headers=headers,
            json={
                "p_user_id": user['id'],
                "p_payment_id": payment_id,
                "p_amount_rub": amount_rub,
                "p_ndn_amount": ndn_amount
            }
        )
        
        if payment_response.status_code == 200:
            result = payment_response.json()
            if result.get('success'):
                # Здесь должна быть интеграция с ЮКассой API
                # Пока возвращаем тестовые данные
                return {
                    "success": True,
                    "payment_id": payment_id,
                    "amount_rub": amount_rub,
                    "ndn_amount": ndn_amount,
                    "payment_url": f"https://yookassa.ru/payment/{payment_id}",
                    "message": "Платеж создан. Перейдите по ссылке для оплаты."
                }
            else:
                return {"success": False, "message": result.get('error')}
        else:
            return {"success": False, "message": "Ошибка создания платежа"}
            
    except ValueError as e:
        raise HTTPException(status_code=401, detail=f"Ошибка авторизации Telegram: {str(e)}")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Ошибка сервера: {str(e)}")

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
        raise HTTPException(status_code=500, detail=f"Ошибка сервера: {str(e)}")

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
        raise HTTPException(status_code=401, detail=f"Ошибка авторизации Telegram: {str(e)}")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Ошибка сервера: {str(e)}")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
