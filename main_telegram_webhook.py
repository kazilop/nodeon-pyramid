#!/usr/bin/env python3
"""
NodeOn Pyramid API с поддержкой Telegram webhook для Stars
"""

from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
import requests
import json
import os
import hashlib
import hmac
import urllib.parse
import time
from datetime import datetime
from typing import Optional, Dict, Any

app = FastAPI(title="NodeOn Pyramid API with Telegram Webhook", version="1.0.0")

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

# Telegram Bot Token
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
    """Строгая верификация Telegram данных с проверкой подписи"""
    try:
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
    """Проверка подписи Telegram данных"""
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
        
        # Создаем нового пользователя
        user_data = {
            "telegram_id": telegram_id,
            "username": telegram_user.get('username') or None,
            "first_name": telegram_user.get('first_name') or 'Пользователь',
            "last_name": telegram_user.get('last_name') or '',
            "balance_ndn": 0.0,
            "balance_stars": 0.0,
            "total_stars_earned": 0.0,
            "total_stars_spent": 0.0,
            "is_pro": False,
            "referral_link": "",
            "inviter_id": None,
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
            
            return created_user
        else:
            print(f"❌ Failed to create user: {response.text}")
            raise HTTPException(status_code=500, detail="Database error")
            
    except Exception as e:
        print(f"❌ Database error: {e}")
        raise HTTPException(status_code=500, detail="Database error")

@app.get("/")
async def root():
    return {"message": "NodeOn Pyramid API with Telegram Webhook", "status": "running"}

@app.get("/api/test")
async def api_test_endpoint():
    return {"message": "Supabase API with Telegram Webhook is working", "status": "ok"}

@app.post("/webhook")
async def telegram_webhook(request: Request):
    """Webhook для Telegram бота"""
    try:
        data = await request.json()
        print(f"📨 Received webhook: {json.dumps(data, indent=2)}")
        
        # Обрабатываем разные типы обновлений
        if 'message' in data:
            await handle_message(data['message'])
        elif 'callback_query' in data:
            await handle_callback_query(data['callback_query'])
        elif 'pre_checkout_query' in data:
            await handle_pre_checkout_query(data['pre_checkout_query'])
        
        return {"ok": True}
        
    except Exception as e:
        print(f"❌ Webhook error: {e}")
        return {"ok": False, "error": str(e)}

async def handle_message(message):
    """Обработка сообщений"""
    if 'successful_payment' in message:
        await handle_successful_payment(message)

async def handle_successful_payment(message):
    """Обработка успешного платежа"""
    try:
        payment = message['successful_payment']
        user = message['from']
        
        print(f"💰 Successful payment from user {user['id']}: {payment}")
        
        # Обрабатываем платеж
        result = await process_telegram_payment(payment, user)
        
        if result['success']:
            print(f"✅ Payment processed successfully: {result}")
        else:
            print(f"❌ Payment processing failed: {result}")
            
    except Exception as e:
        print(f"❌ Error handling successful payment: {e}")

async def process_telegram_payment(payment, user):
    """Обработка платежа от Telegram"""
    try:
        user_id = user['id']
        telegram_payment_charge_id = payment['telegram_payment_charge_id']
        total_amount = payment['total_amount']
        
        # Рассчитываем количество NDN (1 Star = 1 NDN)
        stars_amount = total_amount / 100  # Конвертируем из копеек
        ndn_amount = stars_amount
        
        # Обрабатываем покупку через серверный кошелек
        purchase_response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/process_stars_purchase",
            headers=get_supabase_headers(),
            json={
                "p_user_id": user_id,
                "p_stars_amount": stars_amount,
                "p_ndn_amount": ndn_amount,
                "p_payment_id": telegram_payment_charge_id
            }
        )
        
        if purchase_response.status_code == 200:
            data = purchase_response.json()
            if data.get('success'):
                return {
                    "success": True,
                    "ndn_amount": ndn_amount,
                    "stars_amount": stars_amount,
                    "transaction_id": data.get('transaction_id')
                }
            else:
                return {"success": False, "message": data.get('error')}
        else:
            return {"success": False, "message": "Ошибка обработки платежа"}
            
    except Exception as e:
        print(f"❌ Error processing payment: {e}")
        return {"success": False, "message": "Внутренняя ошибка"}

async def handle_callback_query(callback_query):
    """Обработка callback query"""
    print(f"🔘 Callback query: {callback_query}")

async def handle_pre_checkout_query(pre_checkout_query):
    """Обработка pre-checkout query"""
    print(f"💳 Pre-checkout query: {pre_checkout_query}")

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
                "total_stars_earned": float(user.get('total_stars_earned', 0)),
                "total_stars_spent": float(user.get('total_stars_spent', 0)),
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

@app.get("/api/wallet/balance")
async def get_server_wallet_balance():
    """Получить баланс серверного кошелька"""
    try:
        headers = get_supabase_headers()
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/get_server_wallet_balance",
            headers=headers,
            json={}
        )
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                return data
            else:
                return {"success": False, "error": data.get('error')}
        else:
            return {"success": False, "error": "Failed to get wallet balance"}
            
    except Exception as e:
        print(f"Error getting wallet balance: {e}")
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
                    "balance_stars": float(user.get('balance_stars', 0)),
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

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
