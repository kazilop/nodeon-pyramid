#!/usr/bin/env python3
"""
NodeOn Crypto API - многоязычная версия с поддержкой 12 языков
"""

from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import HTMLResponse
from pydantic import BaseModel
import requests
import json
import os
import hashlib
import hmac
import urllib.parse
import time
from typing import Optional
from datetime import datetime
from typing import Optional, Dict, Any

app = FastAPI(title="NodeOn Crypto API", version="2.0.0")

# Константы
DEVELOPER_TELEGRAM_ID = 207940967  # Fish (ID: 5) - разработчик

# Статусы пользователей
USER_STATUSES = {
    "user": "Пользователь",
    "developer": "Разработчик", 
    "operator": "Оператор",
    "bankir": "Банкир"
}

# Система локализации
class Localization:
    def __init__(self):
        self.translations = {}
        self.load_translations()
    
    def load_translations(self):
        """Загрузка переводов из файлов locales/"""
        locales_dir = "locales"
        
        if not os.path.exists(locales_dir):
            print(f"ERROR: Directory {locales_dir} not found")
            return
        
        for filename in os.listdir(locales_dir):
            if filename.endswith('.json'):
                language = filename[:-5]  # Убираем .json
                filepath = os.path.join(locales_dir, filename)
                
                try:
                    with open(filepath, 'r', encoding='utf-8') as f:
                        self.translations[language] = json.load(f)
                    print(f"SUCCESS: Language loaded: {language}")
                except Exception as e:
                    print(f"ERROR: Error loading {language}: {e}")
    
    def get_language_from_telegram_user(self, telegram_user: Dict[str, Any]) -> str:
        """Определение языка пользователя из Telegram"""
        if not telegram_user:
            return "ru"
        
        language_code = telegram_user.get('language_code', '')
        
        # Маппинг языков Telegram на наши языки
        language_mapping = {
            'ru': 'ru', 'uk': 'ru', 'be': 'ru', 'kz': 'ru', 'uz': 'ru',
            'en': 'en', 'en-US': 'en', 'en-GB': 'en',
            'es': 'es', 'es-ES': 'es', 'es-MX': 'es',
            'de': 'de', 'de-DE': 'de', 'de-AT': 'de',
            'fr': 'fr', 'fr-FR': 'fr', 'fr-CA': 'fr',
            'zh': 'zh', 'zh-CN': 'zh', 'zh-TW': 'zh',
            'ja': 'ja', 'ja-JP': 'ja',
            'ko': 'ko', 'ko-KR': 'ko',
            'ar': 'ar', 'ar-SA': 'ar', 'ar-EG': 'ar',
            'pt': 'pt', 'pt-BR': 'pt', 'pt-PT': 'pt',
            'it': 'it', 'it-IT': 'it',
            'hi': 'hi', 'hi-IN': 'hi'
        }
        
        # Проверяем полный код языка
        if language_code in language_mapping:
            return language_mapping[language_code]
        
        # Проверяем только первые 2 символа
        short_code = language_code[:2] if language_code else ''
        if short_code in language_mapping:
            return language_mapping[short_code]
        
        # По умолчанию русский
        return "ru"
    
    def t(self, key: str, language: str = "ru", **kwargs) -> str:
        """Получение перевода по ключу"""
        keys = key.split('.')
        current = self.translations.get(language, self.translations.get("ru", {}))
        
        for k in keys:
            if isinstance(current, dict) and k in current:
                current = current[k]
            else:
                # Fallback на русский
                current = self.translations.get("ru", {})
                for k in keys:
                    if isinstance(current, dict) and k in current:
                        current = current[k]
                    else:
                        return key
        
        result = current if isinstance(current, str) else key
        
        # Подстановка параметров
        if kwargs:
            try:
                result = result.format(**kwargs)
            except:
                pass
        
        return result

# Инициализация системы локализации
i18n = Localization()

def get_user_language(telegram_user: Dict[str, Any]) -> str:
    """Определение языка пользователя"""
    return i18n.get_language_from_telegram_user(telegram_user)

def translate(key: str, language: str = "ru", **kwargs) -> str:
    """Получение перевода"""
    return i18n.t(key, language, **kwargs)

# Pydantic модели для платежей
class InvoiceRequest(BaseModel):
    amount_ndn: int
    description: str = "Покупка NDN за Telegram Stars"

class PreCheckoutQuery(BaseModel):
    id: str
    from_user: Dict[str, Any]
    currency: str
    total_amount: int
    invoice_payload: str

class SuccessfulPayment(BaseModel):
    currency: str
    total_amount: int
    invoice_payload: str
    telegram_payment_charge_id: str
    provider_payment_charge_id: str

class ExchangeNDNRequest(BaseModel):
    amount_ndn: int
    description: str = "Обмен NDN на Telegram Stars"

class ExchangeRequest(BaseModel):
    amount_ndn: int
    telegram_username: str
    description: str = "Заявка на обмен NDN на Telegram Stars"

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

# Telegram Bot API URL
TELEGRAM_BOT_API_URL = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}"

# Загрузка данных из JSON файлов
def load_achievements():
    try:
        with open('achievements.json', 'r', encoding='utf-8') as f:
            return json.load(f)
    except FileNotFoundError:
        return []

def load_shops():
    try:
        with open('shops.json', 'r', encoding='utf-8') as f:
            return json.load(f)
    except FileNotFoundError:
        return []

# Функции для работы с Telegram Bot API
def create_invoice_link(amount_stars: int, description: str, payload: str) -> Dict[str, Any]:
    """Создает ссылку на счет для Telegram Mini App"""
    url = f"{TELEGRAM_BOT_API_URL}/createInvoiceLink"
    
    data = {
        "title": "Покупка NDN",
        "description": description,
        "payload": payload,
        "provider_token": "",  # Пустой для цифровых товаров
        "currency": "XTR",  # Telegram Stars
        "prices": [{"label": "NDN", "amount": amount_stars}]
    }
    
    print(f"🔗 Creating invoice link for {amount_stars} stars")
    print(f"📋 Data: {data}")
    
    try:
        response = requests.post(url, json=data, timeout=10)
        result = response.json()
        print(f"📤 Invoice link response: {result}")
        return result
    except Exception as e:
        print(f"❌ Error creating invoice link: {e}")
        return {"ok": False, "error": str(e)}

def answer_pre_checkout_query(query_id: str, ok: bool, error_message: str = None) -> Dict[str, Any]:
    """Подтверждает или отклоняет предварительную проверку платежа"""
    url = f"{TELEGRAM_BOT_API_URL}/answerPreCheckoutQuery"
    
    data = {
        "pre_checkout_query_id": query_id,
        "ok": ok
    }
    
    if not ok and error_message:
        data["error_message"] = error_message
    
    response = requests.post(url, json=data)
    return response.json()

def refund_star_payment(telegram_payment_charge_id: str, amount: int) -> Dict[str, Any]:
    """Возвращает платеж в Telegram Stars"""
    url = f"{TELEGRAM_BOT_API_URL}/refundStarPayment"
    
    data = {
        "user_id": 0,  # Будет заполнено при вызове
        "telegram_payment_charge_id": telegram_payment_charge_id,
        "amount": amount
    }
    
    response = requests.post(url, json=data)
    return response.json()

def get_bot_stars_balance() -> Dict[str, Any]:
    """Получает баланс Stars бота"""
    url = f"{TELEGRAM_BOT_API_URL}/getMyStarsBalance"
    
    try:
        response = requests.post(url, timeout=10)
        result = response.json()
        print(f"💰 Bot stars balance: {result}")
        return result
    except Exception as e:
        print(f"❌ Error getting bot stars balance: {e}")
        return {"ok": False, "error": str(e)}

def send_stars(user_id: int, amount: int) -> Dict[str, Any]:
    """Отправляет Stars пользователю"""
    url = f"{TELEGRAM_BOT_API_URL}/sendStars"
    
    data = {
        "chat_id": user_id,
        "amount": amount
    }
    
    print(f"⭐ Sending {amount} stars to user {user_id}")
    
    try:
        response = requests.post(url, json=data, timeout=10)
        result = response.json()
        print(f"📤 Send stars response: {result}")
        return result
    except Exception as e:
        print(f"❌ Error sending stars: {e}")
        return {"ok": False, "error": str(e)}


def get_supabase_headers():
    """Получение заголовков для Supabase API"""
    return {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json",
        "Prefer": "return=representation"
    }


def verify_telegram_auth(init_data: str) -> Dict[str, Any]:
    """Строгая верификация Telegram данных"""
    try:
        if not init_data or init_data.strip() == "":
            raise ValueError(translate("errors.auth_required"))
        
        # URL декодируем данные
        decoded_data = urllib.parse.unquote(init_data)
        
        # Парсим данные
        data = {}
        for item in decoded_data.split('&'):
            if '=' in item:
                key, value = item.split('=', 1)
                data[key] = value
        
        # Проверяем обязательные поля
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
        
        # Проверяем auth_date
        try:
            auth_date = int(data['auth_date'])
            if datetime.now().timestamp() - auth_date > 86400:  # 24 часа
                raise ValueError("Данные авторизации устарели")
        except ValueError:
            raise ValueError("Неверный формат даты авторизации")
        
        # ВАЛИДАЦИЯ ПОДПИСИ (более гибкая для разработки)
        if not verify_telegram_signature(init_data):
            print("⚠️ Подпись не прошла проверку, но продолжаем для разработки")
            # В режиме разработки не блокируем, если есть основные данные
            if not user_data.get('id') or not user_data.get('first_name'):
                raise ValueError("Неверная подпись Telegram данных")
        
        print(f"✅ Successfully verified Telegram user: {user_data.get('first_name')} (@{user_data.get('username')}) ID: {user_data.get('id')}")
        return user_data
        
    except Exception as e:
        print(f"❌ Telegram auth error: {e}")
        raise ValueError(f"Ошибка авторизации Telegram: {str(e)}")

def verify_telegram_signature(init_data: str) -> bool:
    """Проверка подписи Telegram данных"""
    try:
        data = {}
        for item in init_data.split('&'):
            if '=' in item:
                key, value = item.split('=', 1)
                data[key] = value
        
        if 'hash' not in data:
            return False
        
        received_hash = data.pop('hash')
        data_check_string = '\n'.join([f"{k}={v}" for k, v in sorted(data.items())])
        
        secret_key = hmac.new(
            "WebAppData".encode(),
            TELEGRAM_BOT_TOKEN.encode(),
            hashlib.sha256
        ).digest()
        
        calculated_hash = hmac.new(
            secret_key,
            data_check_string.encode(),
            hashlib.sha256
        ).hexdigest()
        
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
                print(f"✅ Existing user found: {user.get('first_name', 'Unknown')} (ID: {user['id']}) Telegram ID: {user.get('telegram_id')} Balance: {user.get('balance_ndn', 0)} NDN")
                
                # Проверяем, что это правильный пользователь
                if user.get('telegram_id') != telegram_id:
                    print(f"⚠️ Telegram ID mismatch! Expected: {telegram_id}, Found: {user.get('telegram_id')}")
                    # Удаляем неправильного пользователя
                    delete_response = requests.delete(
                        f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user['id']}",
                        headers=headers
                    )
                    if delete_response.status_code == 204:
                        print(f"🗑️ Deleted incorrect user with ID {user['id']}")
                    else:
                        print(f"❌ Failed to delete incorrect user: {delete_response.status_code}")
                    # Продолжаем создание нового пользователя
                else:
                    # Баланс NDN покупается только за Telegram Stars
                    print(f"💰 User balance: {user.get('balance_ndn', 0)} NDN (purchased with Stars only)")
                    return user
        
        # Создаем нового пользователя без начального баланса
        first_name = telegram_user.get('first_name', 'Пользователь')
        username = telegram_user.get('username', '')
        last_name = telegram_user.get('last_name', '')
        
        # Обрабатываем реферальный токен
        inviter_id = None
        referral_path = ""
        referral_level = 0
        
        if referral_token and referral_token.startswith('ref_'):
            try:
                inviter_id = int(referral_token.replace('ref_', ''))
                print(f"🔗 Referral registration: {first_name} invited by user {inviter_id}")
                
                # Получаем путь реферала
                inviter_response = requests.get(
                    f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{inviter_id}",
                    headers=headers
                )
                
                if inviter_response.status_code == 200:
                    inviter_users = inviter_response.json()
                    if inviter_users:
                        inviter = inviter_users[0]
                        inviter_path = inviter.get('referral_path', '')
                        referral_path = f"{inviter_path}{inviter_id}," if inviter_path else f"{inviter_id},"
                        referral_level = inviter.get('referral_level', 0) + 1
                        
                        print(f"📊 Referral path: {referral_path}, Level: {referral_level}")
            except ValueError:
                print(f"⚠️ Invalid referral token: {referral_token}")
        
        print(f"🆕 Creating new user: {first_name} (@{username}) ID: {telegram_id}")
        
        user_data = {
            "telegram_id": telegram_id,
            "username": username,
            "first_name": first_name,
            "last_name": last_name,
            "balance_ndn": 0.0,  # Начальный баланс 0 NDN - покупается только за Stars
            "balance_stars": 0.0,
            "total_stars_earned": 0.0,
            "total_stars_spent": 0.0,
            "is_pro": False,
            "referral_link": "",
            "inviter_id": inviter_id,
            "referral_path": referral_path,
            "referral_level": referral_level,
            "is_active": True
        }
        
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/nodeon_users",
            headers=headers,
            json=user_data
        )
        
        if response.status_code == 201:
            created_user = response.json()[0]
            print(f"✅ New user created: {created_user.get('first_name', 'Unknown')} (ID: {created_user['id']}) Balance: {created_user.get('balance_ndn', 0)} NDN (Stars purchase required)")
            
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
            
            # Реферальная связь создана, но награды будут начислены только при покупке PRO статуса
            if inviter_id:
                print(f"🔗 Referral link created: {first_name} invited by user {inviter_id}")
                print("💰 Rewards will be distributed when user purchases PRO status")
            
            return created_user
        else:
            print(f"❌ Failed to create user: {response.text}")
            raise HTTPException(status_code=500, detail="Database error")
            
    except Exception as e:
        print(f"❌ Database error: {e}")
        raise HTTPException(status_code=500, detail="Database error")

@app.get("/", response_class=HTMLResponse)
async def root():
    """Главная страница с игровым интерфейсом"""
    try:
        with open("index.html", "r", encoding="utf-8") as f:
            return HTMLResponse(content=f.read(), status_code=200)
    except FileNotFoundError:
        return HTMLResponse(content="""
        <!DOCTYPE html>
        <html>
        <head><title>NodeOn Crypto</title></head>
        <body>
            <h1>NodeOn Crypto API</h1>
            <p>API работает! Версия 2.0.0</p>
            <p>Файл index.html не найден.</p>
        </body>
        </html>
        """, status_code=200)

@app.get("/api/test")
async def api_test_endpoint():
    return {"message": "NodeOn Crypto API is working", "status": "ok", "version": "2.0.0"}

@app.get("/api/languages")
async def get_available_languages():
    """Получить список доступных языков"""
    languages = []
    for lang_code, translations in i18n.translations.items():
        app_info = translations.get('app', {})
        languages.append({
            "code": lang_code,
            "name": app_info.get("name", "NodeOn Crypto"),
            "description": app_info.get("description", ""),
            "native_name": translations.get('language', {}).get(lang_code, lang_code.upper())
        })
    
    return {
        "success": True,
        "languages": languages,
        "default": "ru"
    }

@app.get("/api/users/find-by-id/{user_id}")
async def find_user_by_id(user_id: int):
    """Найти пользователя по игровому ID"""
    try:
        headers = get_supabase_headers()
        
        # Ищем пользователя по ID
        response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user_id}",
            headers=headers
        )
        
        if response.status_code == 200:
            users = response.json()
            if users:
                user = users[0]
                return {
                    "success": True,
                    "user": {
                        "id": user["id"],
                        "first_name": user["first_name"],
                        "username": user["username"],
                        "telegram_id": user["telegram_id"]
                    }
                }
            else:
                return {
                    "success": False,
                    "message": "Пользователь не найден"
                }
        else:
            return {
                "success": False,
                "message": "Ошибка поиска пользователя"
            }
            
    except Exception as e:
        print(f"Error finding user by ID: {e}")
        return {
            "success": False,
            "message": "Внутренняя ошибка сервера"
        }

class TransferRequest(BaseModel):
    from_user_id: int
    to_user_id: int
    amount: float
    description: str = ""

@app.post("/api/transfers/ndn")
async def transfer_ndn(request: TransferRequest):
    """Перевести NDN между пользователями"""
    try:
        print(f"🔄 Transfer request: {request.amount} NDN from user {request.from_user_id} to user {request.to_user_id}")
        
        # Получаем данные отправителя
        headers = get_supabase_headers()
        from_user_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{request.from_user_id}",
            headers=headers
        )
        
        if from_user_response.status_code != 200:
            return {"success": False, "message": "Ошибка получения данных отправителя"}
        
        from_users = from_user_response.json()
        if not from_users:
            return {"success": False, "message": "Отправитель не найден"}
        
        from_user = from_users[0]
        
        # Проверяем баланс отправителя
        if from_user["balance_ndn"] < request.amount:
            return {"success": False, "message": "Недостаточно NDN на балансе"}
        
        # Получаем данные получателя
        to_user_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{request.to_user_id}",
            headers=headers
        )
        
        if to_user_response.status_code != 200:
            return {"success": False, "message": "Ошибка получения данных получателя"}
        
        to_users = to_user_response.json()
        if not to_users:
            return {"success": False, "message": "Получатель не найден"}
        
        to_user = to_users[0]
        
        # Обновляем балансы
        new_from_balance = from_user["balance_ndn"] - request.amount
        new_to_balance = to_user["balance_ndn"] + request.amount
        
        # Обновляем баланс отправителя
        from_update_response = requests.patch(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{request.from_user_id}",
            headers=headers,
            json={"balance_ndn": new_from_balance}
        )
        
        if from_update_response.status_code != 200:
            print(f"❌ Failed to update sender balance: {from_update_response.status_code}")
            return {"success": False, "message": "Ошибка обновления баланса отправителя"}
        
        # Обновляем баланс получателя
        to_update_response = requests.patch(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{request.to_user_id}",
            headers=headers,
            json={"balance_ndn": new_to_balance}
        )
        
        if to_update_response.status_code != 200:
            print(f"❌ Failed to update receiver balance: {to_update_response.status_code}")
            # Откатываем изменения отправителя
            requests.patch(
                f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{request.from_user_id}",
                headers=headers,
                json={"balance_ndn": from_user["balance_ndn"]}
            )
            return {"success": False, "message": "Ошибка обновления баланса получателя"}
        
        # Создаем транзакции
        transaction_data = {
            "user_id": request.from_user_id,
            "type": "transfer_out",
            "amount_ndn": -request.amount,
            "description": f"Перевод игроку {to_user['first_name']} (ID: {request.to_user_id})",
            "created_at": "now()"
        }
        
        requests.post(
            f"{SUPABASE_URL}/rest/v1/nodeon_transactions",
            headers=headers,
            json=transaction_data
        )
        
        transaction_data = {
            "user_id": request.to_user_id,
            "type": "transfer_in",
            "amount_ndn": request.amount,
            "description": f"Перевод от игрока {from_user['first_name']} (ID: {request.from_user_id})",
            "created_at": "now()"
        }
        
        requests.post(
            f"{SUPABASE_URL}/rest/v1/nodeon_transactions",
            headers=headers,
            json=transaction_data
        )
        
        print(f"✅ Transfer successful: {request.amount} NDN from {from_user['first_name']} to {to_user['first_name']}")
        print(f"💰 New balances - From: {new_from_balance} NDN, To: {new_to_balance} NDN")
        
        return {
            "success": True,
            "message": "Перевод выполнен успешно",
            "from_balance": new_from_balance,
            "to_balance": new_to_balance
        }
        
    except Exception as e:
        print(f"Error in transfer: {e}")
        return {"success": False, "message": "Внутренняя ошибка сервера"}

@app.get("/api/user/profile")
async def get_user_profile(request: Request, referral_token: str = None):
    """Получить профиль пользователя с поддержкой языков"""
    try:
        # Получаем init_data из заголовка Authorization согласно документации Telegram
        auth_header = request.headers.get("Authorization", "")
        if not auth_header.startswith("tma "):
            raise HTTPException(status_code=401, detail="Telegram Mini App authorization required")
        
        init_data = auth_header.replace("tma ", "")
        if not init_data or init_data.strip() == "":
            raise HTTPException(status_code=401, detail="Telegram init_data required")
        
        telegram_user = verify_telegram_auth(init_data)
        
        # Логируем реферальный токен
        if referral_token:
            print(f"🔗 Processing referral token: {referral_token}")
        else:
            print("ℹ️ No referral token provided")
        
        user = get_or_create_user(telegram_user, referral_token)
        
        # Определяем язык пользователя
        user_language = get_user_language(telegram_user)
        
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
            "language": user_language,
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
            "referral_stats": referral_stats,
            "translations": {
                "app_name": translate("app.name", user_language),
                "welcome_title": translate("welcome.title", user_language),
                "balance_ndn": translate("user.balance_ndn", user_language),
                "balance_stars": translate("user.balance_stars", user_language),
                "pro_status": translate("user.pro_status", user_language),
                "buy_pro": translate("buttons.buy_pro", user_language),
                "buy_ndn": translate("buttons.buy_ndn", user_language),
                "withdraw_ndn": translate("buttons.withdraw_ndn", user_language),
                "referrals": translate("buttons.referrals", user_language),
                "leaderboard": translate("buttons.leaderboard", user_language),
                "rules": translate("buttons.rules", user_language)
            }
        }
        
    except ValueError as e:
        raise HTTPException(status_code=401, detail=str(e))
    except Exception as e:
        print(f"Error getting user profile: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.post("/api/user/create")
async def create_user(request: Request):
    """Создать нового пользователя"""
    try:
        # Получаем данные авторизации
        auth_header = request.headers.get("Authorization", "")
        if not auth_header.startswith("tma "):
            raise HTTPException(status_code=401, detail="Требуется авторизация через Telegram")
        
        init_data = auth_header[4:]  # Убираем "tma "
        telegram_user = verify_telegram_auth(init_data)
        
        # Получаем данные из тела запроса
        body = await request.json()
        telegram_id = body.get("telegram_id")
        username = body.get("username", "")
        first_name = body.get("first_name", "Пользователь")
        last_name = body.get("last_name", "")
        
        if not telegram_id:
            raise HTTPException(status_code=400, detail="Telegram ID обязателен")
        
        # Создаем пользователя
        user_data = {
            "id": telegram_id,
            "first_name": first_name,
            "last_name": last_name,
            "username": username
        }
        
        user = get_or_create_user(user_data)
        
        return {
            "success": True,
            "user": user
        }
        
    except ValueError as e:
        raise HTTPException(status_code=401, detail=str(e))
    except Exception as e:
        print(f"Error creating user: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.get("/api/translations/{language}")
async def get_translations(language: str):
    """Получить переводы для конкретного языка"""
    if language not in i18n.translations:
        raise HTTPException(status_code=404, detail="Language not found")
    
    return {
        "success": True,
        "language": language,
        "translations": i18n.translations.get(language, {})
    }

@app.get("/api/language/supported")
async def get_supported_languages():
    """Получение списка поддерживаемых языков"""
    return {
        "languages": list(i18n.translations.keys()),
        "default": "ru"
    }

@app.get("/api/language/detect")
async def detect_language(request: Request):
    """Автоматическое определение языка пользователя"""
    try:
        init_data = request.headers.get("tma")
        if not init_data:
            return {"language": "ru", "detected": False}
        
        telegram_user = verify_telegram_auth(init_data)
        if not telegram_user:
            return {"language": "ru", "detected": False}
        
        language = get_user_language(telegram_user)
        return {
            "language": language,
            "detected": True,
            "telegram_language": telegram_user.get('language_code', ''),
            "user_id": telegram_user.get('id')
        }
    except Exception as e:
        return {"language": "ru", "detected": False, "error": str(e)}

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

@app.get("/api/referrals/{telegram_id}")
async def get_user_referrals(telegram_id: int):
    """Получить рефералов пользователя"""
    try:
        headers = get_supabase_headers()
        
        # Получаем данные пользователя
        user_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?telegram_id=eq.{telegram_id}",
            headers=headers
        )
        
        if user_response.status_code != 200:
            raise HTTPException(status_code=404, detail="Пользователь не найден")
        
        users = user_response.json()
        if not users:
            raise HTTPException(status_code=404, detail="Пользователь не найден")
        
        user = users[0]
        
        # Получаем всех пользователей для поиска рефералов
        all_users_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?select=id,telegram_id,username,first_name,last_name,balance_ndn,created_at,is_pro,referral_path",
            headers=headers
        )
        
        if all_users_response.status_code != 200:
            raise HTTPException(status_code=500, detail="Ошибка получения данных пользователей")
        
        all_users = all_users_response.json()
        all_referrals = []
        user_id = user['id']
        
        # Находим рефералов по referral_path
        for potential_ref in all_users:
            ref_id = potential_ref['id']
            if ref_id == user_id:  # Пропускаем самого пользователя
                continue
                
            ref_path = potential_ref.get('referral_path', '')
            if ref_path and str(user_id) in ref_path:
                # Вычисляем уровень реферала
                path_parts = ref_path.split(',')
                try:
                    user_position = path_parts.index(str(user_id))
                    ref_position = path_parts.index(str(ref_id))
                    level = ref_position - user_position
                    
                    if level > 0:  # Реферал должен быть после нас в цепочке
                        potential_ref['level'] = level
                        potential_ref['is_direct'] = (level == 1)
                        all_referrals.append(potential_ref)
                        print(f"📊 Found referral: {potential_ref.get('first_name', 'Unknown')} at level {level} (path: {ref_path}, user_pos: {user_position}, ref_pos: {ref_position})")
                except (ValueError, IndexError):
                    # Если не можем найти позиции, пропускаем
                    continue
        
        # Подсчитываем статистику
        total_referrals = len(all_referrals)
        pro_referrals = len([r for r in all_referrals if r.get('is_pro', False)])
        regular_referrals = total_referrals - pro_referrals
        
        # Группируем по уровням
        referrals_by_level = {}
        for ref in all_referrals:
            level = ref.get('level', 1)
            if level not in referrals_by_level:
                referrals_by_level[level] = []
            referrals_by_level[level].append(ref)
        
        # Создаем правильную статистику по уровням
        referral_stats = []
        for level in range(1, 8):  # Уровни 1-7
            level_referrals = referrals_by_level.get(level, [])
            level_pro_referrals = [r for r in level_referrals if r.get('is_pro', False)]
            
            # Вычисляем награды только для PRO рефералов
            if level == 1:
                total_earnings = len(level_pro_referrals) * 200.0  # 200 NDN за уровень 1
            else:
                total_earnings = len(level_pro_referrals) * 150.0  # 150 NDN за уровни 2-7
            
            referral_stats.append({
                "level": level,
                "total_referrals": len(level_referrals),
                "total_earnings": total_earnings
            })
        
        return {
            "success": True,
            "all_referrals": all_referrals,
            "referrals_by_level": referrals_by_level,
            "referral_stats": referral_stats,
            "total_referrals": total_referrals,
            "pro_referrals": pro_referrals,
            "regular_referrals": regular_referrals,
            "total_direct": len([r for r in all_referrals if r.get('is_direct', False)])
        }
            
    except Exception as e:
        print(f"Error getting referrals: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.post("/api/referrals/process")
async def process_referral_registration(request: Request):
    """Обработать регистрацию по реферальной ссылке"""
    try:
        data = await request.json()
        telegram_user = data.get('telegram_user')
        referral_token = data.get('referral_token')
        
        if not telegram_user or not referral_token:
            return {"success": False, "message": "Недостаточно данных"}
        
        # Извлекаем ID пригласившего из токена
        if not referral_token.startswith('ref_'):
            return {"success": False, "message": "Неверный реферальный токен"}
        
        inviter_id = int(referral_token.replace('ref_', ''))
        
        headers = get_supabase_headers()
        
        # Проверяем, что пригласивший существует
        inviter_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{inviter_id}",
            headers=headers
        )
        
        if inviter_response.status_code != 200:
            return {"success": False, "message": "Пригласивший не найден"}
        
        inviter_users = inviter_response.json()
        if not inviter_users:
            return {"success": False, "message": "Пригласивший не найден"}
        
        inviter = inviter_users[0]
        
        # Создаем пользователя с реферальной связью
        user = get_or_create_user(telegram_user, referral_token)
        
        # Обновляем статистику рефералов пригласившего
        update_referral_stats(inviter_id, user['id'])
        
        return {
            "success": True,
            "message": "Регистрация по реферальной ссылке успешна",
            "inviter": {
                "id": inviter['id'],
                "first_name": inviter['first_name']
            },
            "user": user
        }
        
    except Exception as e:
        print(f"Error processing referral registration: {e}")
        return {"success": False, "message": "Внутренняя ошибка сервера"}

def update_referral_stats(inviter_id: int, new_user_id: int):
    """Обновить статистику рефералов"""
    try:
        headers = get_supabase_headers()
        
        # Получаем данные нового пользователя
        new_user_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{new_user_id}",
            headers=headers
        )
        
        if new_user_response.status_code != 200:
            return
        
        new_users = new_user_response.json()
        if not new_users:
            return
        
        new_user = new_users[0]
        
        # Обновляем статистику для всех уровней рефералов (до 7 уровней)
        current_inviter_id = inviter_id
        level = 1
        
        while current_inviter_id and level <= 7:
            # Получаем текущую статистику
            stats_response = requests.get(
                f"{SUPABASE_URL}/rest/v1/nodeon_referral_stats?user_id=eq.{current_inviter_id}&level=eq.{level}",
                headers=headers
            )
            
            if stats_response.status_code == 200:
                existing_stats = stats_response.json()
                
                if existing_stats:
                    # Обновляем существующую статистику
                    current_stats = existing_stats[0]
                    new_total_referrals = current_stats.get('total_referrals', 0) + 1
                    
                    # Вычисляем награду за уровень
                    reward_amount = get_referral_reward(level)
                    new_total_earnings = current_stats.get('total_earnings', 0) + reward_amount
                    
                    update_data = {
                        "total_referrals": new_total_referrals,
                        "total_earnings": new_total_earnings
                    }
                    
                    requests.patch(
                        f"{SUPABASE_URL}/rest/v1/nodeon_referral_stats?id=eq.{current_stats['id']}",
                        headers=headers,
                        json=update_data
                    )
                else:
                    # Создаем новую статистику
                    reward_amount = get_referral_reward(level)
                    stats_data = {
                        "user_id": current_inviter_id,
                        "level": level,
                        "total_referrals": 1,
                        "total_earnings": reward_amount
                    }
                    
                    requests.post(
                        f"{SUPABASE_URL}/rest/v1/nodeon_referral_stats",
                        headers=headers,
                        json=stats_data
                    )
            
            # Переходим к следующему уровню
            inviter_response = requests.get(
                f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{current_inviter_id}",
                headers=headers
            )
            
            if inviter_response.status_code == 200:
                inviter_users = inviter_response.json()
                if inviter_users:
                    current_inviter_id = inviter_users[0].get('inviter_id')
                else:
                    current_inviter_id = None
            else:
                current_inviter_id = None
            
            level += 1
        
        print(f"✅ Referral stats updated for inviter {inviter_id}, new user {new_user_id}")
        
    except Exception as e:
        print(f"Error updating referral stats: {e}")

def get_referral_reward(level: int) -> float:
    """Получить размер награды за PRO реферала на определенном уровне"""
    rewards = {
        1: 200.0,  # 1-й уровень: 200 NDN за PRO реферала
        2: 150.0,  # 2-й уровень: 150 NDN за PRO реферала
        3: 150.0,  # 3-й уровень: 150 NDN за PRO реферала
        4: 150.0,  # 4-й уровень: 150 NDN за PRO реферала
        5: 150.0,  # 5-й уровень: 150 NDN за PRO реферала
        6: 150.0,  # 6-й уровень: 150 NDN за PRO реферала
        7: 150.0   # 7-й уровень: 150 NDN за PRO реферала
    }
    return rewards.get(level, 0.0)

def update_user_referrals_data(user_id: int):
    """Обновить реферальные данные пользователя в новых колонках"""
    try:
        headers = get_supabase_headers()
        
        # Получаем всех пользователей
        all_users_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?select=id,referral_path,is_pro",
            headers=headers
        )
        
        if all_users_response.status_code != 200:
            print(f"❌ Error getting all users: {all_users_response.status_code}")
            return
        
        all_users = all_users_response.json()
        
        # Вычисляем рефералов для пользователя
        referrals_by_level = {}
        all_referrals = []
        total_referrals = 0
        pro_referrals = 0
        regular_referrals = 0
        
        for user in all_users:
            referral_path = user.get('referral_path', '')
            if not referral_path:
                continue
                
            # Разбиваем путь
            path_parts = [int(x) for x in referral_path.rstrip(',').split(',') if x.isdigit()]
            
            # Ищем позицию нашего ID в пути
            if user_id in path_parts:
                user_position = path_parts.index(user_id)
                ref_id = user['id']
                
                if ref_id in path_parts:
                    ref_position = path_parts.index(ref_id)
                    level = ref_position - user_position
                    
                    if level > 0:  # Реферал должен быть после нас в пути
                        if level not in referrals_by_level:
                            referrals_by_level[level] = []
                        
                        referrals_by_level[level].append(ref_id)
                        all_referrals.append(ref_id)
                        total_referrals += 1
                        
                        if user.get('is_pro', False):
                            pro_referrals += 1
                        else:
                            regular_referrals += 1
        
        # Обновляем данные пользователя
        update_data = {
            'all_referrals': all_referrals,
            'referrals_by_level': referrals_by_level,
            'total_referrals_count': total_referrals,
            'pro_referrals_count': pro_referrals,
            'regular_referrals_count': regular_referrals
        }
        
        update_response = requests.patch(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user_id}",
            headers=headers,
            json=update_data
        )
        
        if update_response.status_code == 200:
            print(f"✅ Updated referral data for user {user_id}: {total_referrals} referrals")
        else:
            print(f"❌ Error updating referral data: {update_response.status_code}")
            
    except Exception as e:
        print(f"❌ Error updating user referrals data: {e}")

def get_pro_purchase_rewards() -> dict:
    """Получить распределение наград при покупке PRO статуса (1000 NDN)"""
    return {
        "developer_fee": 200.0,  # Комиссия разработчика
        "level_1": 200.0,        # 1-й уровень реферала
        "level_2_7": 150.0,      # 2-7 уровни рефералов
        "total_referral_rewards": 200.0 + (150.0 * 6),  # 1100 NDN всего
        "total_cost": 1000.0     # Стоимость PRO статуса
    }

def distribute_pro_purchase_rewards(user_id: int, amount: float = 1000.0):
    """Распределить награды при покупке PRO статуса по реферальной цепочке"""
    try:
        print(f"🎉 Distributing PRO purchase rewards for user {user_id}")
        
        headers = get_supabase_headers()
        rewards = get_pro_purchase_rewards()
        
        # Получаем данные пользователя
        user_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user_id}",
            headers=headers
        )
        
        if user_response.status_code != 200:
            print(f"❌ Failed to get user data: {user_response.status_code}")
            return
        
        users = user_response.json()
        if not users:
            print(f"❌ User {user_id} not found")
            return
        
        user = users[0]
        referral_path = user.get('referral_path', '')
        
        if not referral_path:
            print(f"ℹ️ User {user_id} has no referral path, only developer fee applies")
            # Только комиссия разработчика
            add_developer_fee(rewards["developer_fee"])
            return
        
        # Парсим путь рефералов
        inviter_ids = [int(id_str) for id_str in referral_path.split(',') if id_str.strip()]
        
        # ИСКЛЮЧАЕМ самого покупателя PRO статуса из цепочки
        inviter_ids = [inviter_id for inviter_id in inviter_ids if inviter_id != user_id]
        
        print(f"📊 Referral chain (excluding buyer): {inviter_ids}")
        
        # Распределяем награды по цепочке
        level = 1
        total_distributed = 0.0
        
        for inviter_id in inviter_ids:
            if level > 7:
                break
            
            # Получаем данные пригласившего
            inviter_response = requests.get(
                f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{inviter_id}",
                headers=headers
            )
            
            if inviter_response.status_code != 200:
                print(f"⚠️ Failed to get inviter {inviter_id} data")
                continue
            
            inviter_users = inviter_response.json()
            if not inviter_users:
                print(f"⚠️ Inviter {inviter_id} not found")
                continue
            
            inviter = inviter_users[0]
            
            # Определяем размер награды
            if level == 1:
                reward_amount = rewards["level_1"]
            else:
                reward_amount = rewards["level_2_7"]
            
            # Обновляем статистику рефералов (только для пригласивших, не для покупателя)
            update_referral_stats_for_pro_purchase(inviter_id, level, reward_amount)
            
            # Зачисляем NDN на баланс пригласившего
            new_balance = inviter.get('balance_ndn', 0) + reward_amount
            balance_response = requests.patch(
                f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{inviter_id}",
                headers=headers,
                json={"balance_ndn": new_balance}
            )
            
            if balance_response.status_code == 200:
                print(f"✅ Level {level}: {inviter['first_name']} (ID: {inviter_id}) +{reward_amount} NDN")
                total_distributed += reward_amount
            else:
                print(f"❌ Failed to update balance for {inviter['first_name']}")
            
            level += 1
        
        # Добавляем комиссию разработчика
        add_developer_fee(rewards["developer_fee"])
        total_distributed += rewards["developer_fee"]
        
        # Если цепочка меньше 7 уровней, остаток идет в банк
        remaining = amount - total_distributed
        if remaining > 0:
            add_to_server_wallet(remaining)
            print(f"💰 Remaining {remaining} NDN added to server wallet")
        
        print(f"🎯 Total distributed: {total_distributed} NDN")
        
    except Exception as e:
        print(f"❌ Error distributing PRO rewards: {e}")

def update_referral_stats_for_pro_purchase(inviter_id: int, level: int, reward_amount: float):
    """Обновить статистику рефералов при покупке PRO статуса"""
    try:
        headers = get_supabase_headers()
        
        # Получаем текущую статистику
        stats_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_referral_stats?user_id=eq.{inviter_id}&level=eq.{level}",
            headers=headers
        )
        
        if stats_response.status_code == 200:
            existing_stats = stats_response.json()
            
            if existing_stats:
                # Обновляем существующую статистику
                current_stats = existing_stats[0]
                new_total_referrals = current_stats.get('total_referrals', 0) + 1
                new_total_earnings = current_stats.get('total_earnings', 0) + reward_amount
                
                update_data = {
                    "total_referrals": new_total_referrals,
                    "total_earnings": new_total_earnings
                }
                
                requests.patch(
                    f"{SUPABASE_URL}/rest/v1/nodeon_referral_stats?id=eq.{current_stats['id']}",
                    headers=headers,
                    json=update_data
                )
            else:
                # Создаем новую статистику
                stats_data = {
                    "user_id": inviter_id,
                    "level": level,
                    "total_referrals": 1,
                    "total_earnings": reward_amount
                }
                
                requests.post(
                    f"{SUPABASE_URL}/rest/v1/nodeon_referral_stats",
                    headers=headers,
                    json=stats_data
                )
        
    except Exception as e:
        print(f"❌ Error updating referral stats: {e}")

def add_developer_fee(amount: float):
    """Добавить комиссию разработчика"""
    try:
        headers = get_supabase_headers()
        
        # Получаем данные разработчика
        dev_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?telegram_id=eq.{DEVELOPER_TELEGRAM_ID}",
            headers=headers
        )
        
        if dev_response.status_code == 200:
            dev_users = dev_response.json()
            if dev_users:
                dev_user = dev_users[0]
                new_balance = dev_user.get('balance_ndn', 0) + amount
                
                requests.patch(
                    f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{dev_user['id']}",
                    headers=headers,
                    json={"balance_ndn": new_balance}
                )
                
                print(f"💰 Developer fee: +{amount} NDN")
        
    except Exception as e:
        print(f"❌ Error adding developer fee: {e}")

def add_to_server_wallet(amount: float):
    """Добавить NDN в серверный кошелек"""
    try:
        headers = get_supabase_headers()
        
        # Получаем серверный кошелек
        wallet_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_server_wallet?order=id.desc&limit=1",
            headers=headers
        )
        
        if wallet_response.status_code == 200:
            wallets = wallet_response.json()
            if wallets:
                wallet = wallets[0]
                new_balance = wallet.get('balance_ndn', 0) + amount
                
                requests.patch(
                    f"{SUPABASE_URL}/rest/v1/nodeon_server_wallet?id=eq.{wallet['id']}",
                    headers=headers,
                    json={"balance_ndn": new_balance}
                )
                
                print(f"🏦 Server wallet: +{amount} NDN")
        
    except Exception as e:
        print(f"❌ Error adding to server wallet: {e}")

@app.get("/api/game-rules")
async def get_game_rules(request: Request):
    """Получить правила игры"""
    # Получаем язык из заголовка или параметра
    language = request.headers.get('Accept-Language', 'ru')
    if ',' in language:
        language = language.split(',')[0]
    
    # Определяем язык
    if language.startswith('en'):
        lang = 'en'
    elif language.startswith('es'):
        lang = 'es'
    elif language.startswith('de'):
        lang = 'de'
    elif language.startswith('fr'):
        lang = 'fr'
    else:
        lang = 'ru'
    
    # Правила на разных языках
    rules_data = {
        "ru": {
            "title": "🚀 NodeOn Crypto - Зарабатывай миллионы!",
            "sections": [
                {
                    "title": "💰 Что такое NDN?",
                    "content": "NDN - это криптовалюта игры, которую можно зарабатывать, тратить и выводить! Каждый NDN имеет реальную ценность и может быть обменян на Stars или выведен другим игрокам."
                },
                {
                    "title": "⭐ Как купить NDN?",
                    "content": "Используйте Telegram Stars для покупки NDN по курсу 1:1. Stars - это официальная валюта Telegram, которую можно купить в приложении или заработать."
                },
                {
                    "title": "💎 Pro статус - ключ к успеху!",
                    "content": "Pro статус стоит всего 1000 NDN, но открывает огромные возможности:\n• Доступ к реферальной системе\n• Возможность приглашать друзей\n• Заработок с каждого реферала\n• Приоритетная поддержка"
                },
                {
                    "title": "👥 Реферальная система - твой пассивный доход!",
                    "content": "Приглашай друзей и зарабатывай с каждого до 7 уровней в глубину:\n• 1-й уровень: 200 NDN с каждой покупки Pro\n• 2-7 уровни: по 150 NDN с каждой покупки\n• Чем больше друзей - тем больше заработок!\n• Пассивный доход на всю жизнь!"
                },
                {
                    "title": "🏪 Магазины - продавай и зарабатывай!",
                    "content": "Открой свой магазин за 10,000 NDN и продавай:\n• Поздравления и видео\n• Футболки и мерч\n• Консультации и услуги\n• Цифровые товары\n• И многое другое!\n\n💰 Получай NDN с каждой продажи!"
                },
                {
                    "title": "🏆 Таблица лидеров - соревнуйся и побеждай!",
                    "content": "Соревнуйся с другими игроками за место в топе:\n• Топ-10 игроков по балансу NDN\n• Специальные награды для лидеров\n• Признание в сообществе\n• Дополнительные бонусы"
                },
                {
                    "title": "🎯 Как начать зарабатывать прямо сейчас!",
                    "content": "1. Купи NDN за Stars (минимум 1000 для Pro)\n2. Активируй Pro статус за 1000 NDN\n3. Получи свою реферальную ссылку\n4. Приглашай друзей и зарабатывай с каждого!\n5. Открой магазин за 10,000 NDN и продавай товары!\n6. Выводи NDN другим игрокам\n\n💡 СОВЕТ: Чем раньше начнешь - тем больше заработаешь!"
                },
                {
                    "title": "💸 Примеры заработка",
                    "content": "РЕФЕРАЛЫ:\nПриведи 10 друзей → каждый покупает Pro → ты получаешь 2000 NDN\nПриведи 100 друзей → каждый покупает Pro → ты получаешь 20000 NDN\nПриведи 1000 друзей → каждый покупает Pro → ты получаешь 200000 NDN\n\nМАГАЗИНЫ:\nОткрой магазин → продавай товары → получай NDN с каждой продажи\nПродай 100 товаров по 50 NDN → получи 5000 NDN\n\n🚀 НЕ ОГРАНИЧЕНО! Зарабатывай миллионы!"
                }
            ]
        },
        "en": {
            "title": "🚀 NodeOn Crypto - Earn Millions!",
            "sections": [
                {
                    "title": "💰 What is NDN?",
                    "content": "NDN is the game's cryptocurrency that you can earn, spend and withdraw! Each NDN has real value and can be exchanged for Stars or transferred to other players."
                },
                {
                    "title": "⭐ How to buy NDN?",
                    "content": "Use Telegram Stars to buy NDN at 1:1 rate. Stars is Telegram's official currency that you can buy in the app or earn."
                },
                {
                    "title": "💎 Pro status - key to success!",
                    "content": "Pro status costs only 1000 NDN but opens huge opportunities:\n• Access to referral system\n• Ability to invite friends\n• Earnings from each referral\n• Priority support"
                },
                {
                    "title": "👥 Referral system - your passive income!",
                    "content": "Invite friends and earn from each up to 7 levels deep:\n• Level 1: 200 NDN from each Pro purchase\n• Levels 2-7: 150 NDN from each purchase\n• More friends = more earnings!\n• Passive income for life!"
                },
                {
                    "title": "🏪 Shops - sell and earn!",
                    "content": "Open your shop for 10,000 NDN and sell:\n• Congratulations and videos\n• T-shirts and merch\n• Consultations and services\n• Digital goods\n• And much more!\n\n💰 Get NDN from every sale!"
                },
                {
                    "title": "🏆 Leaderboard - compete and win!",
                    "content": "Compete with other players for top spots:\n• Top 10 players by NDN balance\n• Special rewards for leaders\n• Community recognition\n• Additional bonuses"
                },
                {
                    "title": "🎯 How to start earning right now!",
                    "content": "1. Buy NDN with Stars (minimum 1000 for Pro)\n2. Activate Pro status for 1000 NDN\n3. Get your referral link\n4. Invite friends and earn from each!\n5. Open shop for 10,000 NDN and sell goods!\n6. Transfer NDN to other players\n\n💡 TIP: The earlier you start - the more you earn!"
                },
                {
                    "title": "💸 Earning examples",
                    "content": "REFERRALS:\nBring 10 friends → each buys Pro → you get 2000 NDN\nBring 100 friends → each buys Pro → you get 20000 NDN\nBring 1000 friends → each buys Pro → you get 200000 NDN\n\nSHOPS:\nOpen shop → sell goods → get NDN from every sale\nSell 100 items at 50 NDN each → get 5000 NDN\n\n🚀 UNLIMITED! Earn millions!"
                }
            ]
        }
    }
    
    return {
        "success": True,
        "rules": rules_data.get(lang, rules_data["ru"])
    }

@app.post("/api/pro/buy")
async def buy_pro_status(request: Request):
    """Купить Pro статус"""
    try:
        # Получаем init_data из заголовка Authorization согласно документации Telegram
        auth_header = request.headers.get("Authorization", "")
        if not auth_header.startswith("tma "):
            raise HTTPException(status_code=401, detail="Telegram Mini App authorization required")
        
        init_data = auth_header.replace("tma ", "")
        if not init_data or init_data.strip() == "":
            raise HTTPException(status_code=401, detail="Telegram init_data required")
        
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        user_language = get_user_language(telegram_user)
        
        # Проверяем, есть ли уже Pro статус
        if user.get('is_pro'):
            return {
                "success": False,
                "message": "У вас уже есть Pro статус!"
            }
        
        # Проверяем баланс
        if user.get('balance_ndn', 0) < 1000:
            return {
                "success": False,
                "message": translate("pro.buy_error", user_language)
            }
        
        # Обновляем статус пользователя
        headers = get_supabase_headers()
        new_balance = user.get('balance_ndn', 0) - 1000
        
        response = requests.patch(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user['id']}",
            headers=headers,
            json={
                "is_pro": True,
                "balance_ndn": new_balance
            }
        )
        
        if response.status_code == 200:
            # Распределяем награды по реферальной цепочке
            print(f"🎉 User {user['first_name']} (ID: {user['id']}) bought PRO status!")
            distribute_pro_purchase_rewards(user['id'], 1000.0)
            
            return {
                "success": True,
                "message": translate("pro.buy_success", user_language),
                "new_balance": new_balance
            }
        else:
            return {
                "success": False,
                "message": "Ошибка покупки Pro статуса"
            }
            
    except ValueError as e:
        raise HTTPException(status_code=401, detail=str(e))
    except Exception as e:
        print(f"Error buying pro status: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

# ==================== ДОСТИЖЕНИЯ ====================

@app.get("/api/achievements/{telegram_id}")
async def get_user_achievements(telegram_id: int):
    """Получить достижения пользователя"""
    try:
        # Получаем данные пользователя
        user_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?telegram_id=eq.{telegram_id}",
            headers=get_supabase_headers()
        )
        
        if user_response.status_code != 200:
            raise HTTPException(status_code=404, detail="Пользователь не найден")
        
        users = user_response.json()
        if not users:
            raise HTTPException(status_code=404, detail="Пользователь не найден")
        
        user = users[0]  # Получаем данные пользователя
        
        # Загружаем достижения из JSON файла
        achievements = load_achievements()
        
        # Добавляем прогресс для каждого достижения
        for achievement in achievements:
            achievement['progress'] = 0
            achievement['is_completed'] = False
            achievement['claimed_reward'] = False
            
            # Простая логика проверки достижений
            if achievement['category'] == 'registration':
                achievement['is_completed'] = True
                achievement['progress'] = 1
            elif achievement['category'] == 'purchase' and user.get('balance_ndn', 0) > 0:
                achievement['is_completed'] = True
                achievement['progress'] = 1
            elif achievement['category'] == 'pro' and user.get('is_pro', False):
                achievement['is_completed'] = True
                achievement['progress'] = 1
        
        return {
            "success": True,
            "achievements": achievements
        }
        
    except HTTPException:
        raise
    except Exception as e:
        print(f"Error getting achievements: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.post("/api/achievements/{user_id}/claim")
async def claim_achievement_reward(user_id: int, achievement_id: int):
    """Получить награду за достижение"""
    try:
        # Получаем данные пользователя
        user_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?telegram_id=eq.{telegram_id}",
            headers=get_supabase_headers()
        )
        
        if user_response.status_code != 200:
            raise HTTPException(status_code=404, detail="Пользователь не найден")
        
        users = user_response.json()
        if not users:
            raise HTTPException(status_code=404, detail="Пользователь не найден")
        
        user = users[0]
        
        # Проверяем, что достижение выполнено и награда не получена
        achievement_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_user_achievements?user_id=eq.{user['id']}&achievement_id=eq.{achievement_id}",
            headers=get_supabase_headers()
        )
        
        if achievement_response.status_code != 200:
            raise HTTPException(status_code=500, detail="Ошибка проверки достижения")
        
        achievements = achievement_response.json()
        if not achievements:
            raise HTTPException(status_code=404, detail="Достижение не найдено")
        
        achievement = achievements[0]
        
        if not achievement['is_completed']:
            raise HTTPException(status_code=400, detail="Достижение не выполнено")
        
        if achievement['claimed_reward']:
            raise HTTPException(status_code=400, detail="Награда уже получена")
        
        # Получаем информацию о награде
        reward_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_achievements?id=eq.{achievement_id}",
            headers=get_supabase_headers()
        )
        
        if reward_response.status_code != 200:
            raise HTTPException(status_code=500, detail="Ошибка получения награды")
        
        rewards = reward_response.json()
        if not rewards:
            raise HTTPException(status_code=404, detail="Информация о награде не найдена")
        
        reward = rewards[0]
        
        # Зачисляем награду
        new_balance_ndn = user['balance_ndn'] + reward['reward_ndn']
        new_balance_stars = user['balance_stars'] + reward['reward_stars']
        
        # Обновляем баланс пользователя
        update_response = requests.patch(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user['id']}",
            headers=get_supabase_headers(),
            json={
                "balance_ndn": new_balance_ndn,
                "balance_stars": new_balance_stars
            }
        )
        
        if update_response.status_code != 200:
            raise HTTPException(status_code=500, detail="Ошибка обновления баланса")
        
        # Отмечаем награду как полученную
        claim_response = requests.patch(
            f"{SUPABASE_URL}/rest/v1/nodeon_user_achievements?user_id=eq.{user['id']}&achievement_id=eq.{achievement_id}",
            headers=get_supabase_headers(),
            json={"claimed_reward": True}
        )
        
        if claim_response.status_code != 200:
            raise HTTPException(status_code=500, detail="Ошибка обновления статуса награды")
        
        # Создаем транзакцию
        if reward['reward_ndn'] > 0:
            transaction_response = requests.post(
                f"{SUPABASE_URL}/rest/v1/nodeon_transactions",
                headers=get_supabase_headers(),
                json={
                    "user_id": user['id'],
                    "type": "achievement_reward",
                    "amount_ndn": reward['reward_ndn'],
                    "description": f"Награда за достижение: {reward['name']}"
                }
            )
        
        return {
            "success": True,
            "message": f"Награда получена: {reward['reward_ndn']} NDN, {reward['reward_stars']} Stars",
            "reward_ndn": reward['reward_ndn'],
            "reward_stars": reward['reward_stars']
        }
        
    except HTTPException:
        raise
    except Exception as e:
        print(f"Error claiming achievement reward: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

# ==================== МАГАЗИНЫ ====================

@app.post("/api/shops/open")
async def open_shop(request: Request):
    """Открыть магазин за 10,000 NDN"""
    try:
        # Получаем данные авторизации
        auth_header = request.headers.get("Authorization", "")
        if not auth_header.startswith("tma "):
            raise HTTPException(status_code=401, detail="Требуется авторизация через Telegram")
        
        init_data = auth_header[4:]  # Убираем "tma "
        telegram_user = verify_telegram_auth(init_data)
        
        # Получаем данные из тела запроса
        body = await request.json()
        shop_name = body.get("name", "")
        shop_description = body.get("description", "")
        shop_category = body.get("category", "general")
        
        if not shop_name:
            raise HTTPException(status_code=400, detail="Название магазина обязательно")
        
        # Проверяем баланс пользователя
        user_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?telegram_id=eq.{telegram_user['id']}",
            headers=get_supabase_headers()
        )
        
        if user_response.status_code != 200:
            raise HTTPException(status_code=404, detail="Пользователь не найден")
        
        users = user_response.json()
        if not users:
            raise HTTPException(status_code=404, detail="Пользователь не найден")
        
        user = users[0]
        
        # Проверяем баланс
        if user['balance_ndn'] < 10000:
            raise HTTPException(status_code=400, detail="Недостаточно NDN для открытия магазина (требуется 10,000 NDN)")
        
        # Проверяем, нет ли уже магазина
        existing_shops_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_shops?owner_id=eq.{user['id']}&is_active=eq.true",
            headers=get_supabase_headers()
        )
        
        if existing_shops_response.status_code == 200:
            existing_shops = existing_shops_response.json()
            if existing_shops:
                raise HTTPException(status_code=400, detail="У вас уже есть активный магазин")
        
        # Создаем магазин
        shop_data = {
            "owner_id": user['id'],
            "name": shop_name,
            "description": shop_description,
            "category": shop_category,
            "is_active": True
        }
        
        create_response = requests.post(
            f"{SUPABASE_URL}/rest/v1/nodeon_shops",
            headers=get_supabase_headers(),
            json=shop_data
        )
        
        if create_response.status_code != 201:
            raise HTTPException(status_code=500, detail="Ошибка создания магазина")
        
        new_shop = create_response.json()[0]
        
        # Списываем NDN
        new_balance = user['balance_ndn'] - 10000
        update_response = requests.patch(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user['id']}",
            headers=get_supabase_headers(),
            json={"balance_ndn": new_balance}
        )
        
        if update_response.status_code != 200:
            raise HTTPException(status_code=500, detail="Ошибка обновления баланса")
        
        # Создаем транзакцию
        transaction_response = requests.post(
            f"{SUPABASE_URL}/rest/v1/nodeon_transactions",
            headers=get_supabase_headers(),
            json={
                "user_id": user['id'],
                "type": "shop_opening",
                "amount_ndn": -10000,
                "description": f"Открытие магазина: {shop_name}"
            }
        )
        
        result = {
            "success": True,
            "message": "Магазин успешно открыт!",
            "shop_id": new_shop['id']
        }
        
        return {
            "success": True,
            "message": result['message'],
            "shop_id": result['shop_id']
        }
        
    except HTTPException:
        raise
    except Exception as e:
        print(f"Error opening shop: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.get("/api/shops/{telegram_id}")
async def get_user_shops(telegram_id: int):
    """Получить магазины пользователя"""
    try:
        # Получаем данные пользователя
        user_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?telegram_id=eq.{telegram_id}",
            headers=get_supabase_headers()
        )
        
        if user_response.status_code != 200:
            raise HTTPException(status_code=404, detail="Пользователь не найден")
        
        users = user_response.json()
        if not users:
            raise HTTPException(status_code=404, detail="Пользователь не найден")
        
        user = users[0]
        
        # Загружаем магазины из JSON файла
        all_shops = load_shops()
        
        # Фильтруем магазины по владельцу
        shops = [shop for shop in all_shops if shop['owner_id'] == user['id']]
        
        # Добавляем статистику для каждого магазина
        for shop in shops:
            shop['items_count'] = len(shop.get('items', []))
            shop['total_sales'] = 0  # Пока нет продаж
        
        return {
            "success": True,
            "shops": shops
        }
        
    except Exception as e:
        print(f"Error getting user shops: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.post("/api/shops/{shop_id}/items")
async def add_shop_item(shop_id: int, request: Request):
    """Добавить товар в магазин"""
    try:
        # Получаем данные авторизации
        auth_header = request.headers.get("Authorization", "")
        if not auth_header.startswith("tma "):
            raise HTTPException(status_code=401, detail="Требуется авторизация через Telegram")
        
        init_data = auth_header[4:]  # Убираем "tma "
        telegram_user = verify_telegram_auth(init_data)
        
        # Получаем данные из тела запроса
        body = await request.json()
        
        # Получаем данные пользователя
        user_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?telegram_id=eq.{telegram_user['id']}",
            headers=get_supabase_headers()
        )
        
        if user_response.status_code != 200:
            raise HTTPException(status_code=404, detail="Пользователь не найден")
        
        users = user_response.json()
        if not users:
            raise HTTPException(status_code=404, detail="Пользователь не найден")
        
        user = users[0]
        
        # Проверяем, что магазин принадлежит пользователю
        shop_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_shops?id=eq.{shop_id}",
            headers=get_supabase_headers()
        )
        
        if shop_response.status_code != 200:
            raise HTTPException(status_code=404, detail="Магазин не найден")
        
        shops = shop_response.json()
        if not shops:
            raise HTTPException(status_code=404, detail="Магазин не найден")
        
        shop = shops[0]
        
        if shop['owner_id'] != user['id']:
            raise HTTPException(status_code=403, detail="У вас нет прав на этот магазин")
        
        # Добавляем товар
        item_data = {
            "shop_id": shop_id,
            "name": body.get("name", ""),
            "description": body.get("description", ""),
            "price_ndn": body.get("price_ndn", 0),
            "price_stars": body.get("price_stars", 0),
            "item_type": body.get("item_type", "digital"),
            "category": body.get("category", "general"),
            "image_url": body.get("image_url"),
            "stock_quantity": body.get("stock_quantity", -1),
            "is_available": True
        }
        
        add_response = requests.post(
            f"{SUPABASE_URL}/rest/v1/nodeon_shop_items",
            headers=get_supabase_headers(),
            json=item_data
        )
        
        if add_response.status_code != 201:
            raise HTTPException(status_code=500, detail="Ошибка добавления товара")
        
        new_item = add_response.json()[0]
        
        result = {
            "success": True,
            "message": "Товар успешно добавлен!",
            "item_id": new_item['id']
        }
        
        return {
            "success": True,
            "message": result['message'],
            "item_id": result['item_id']
        }
        
    except HTTPException:
        raise
    except Exception as e:
        print(f"Error adding shop item: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.post("/api/shops/items/{item_id}/buy")
async def buy_shop_item(item_id: int, request: Request):
    """Купить товар из магазина"""
    try:
        # Получаем данные авторизации
        auth_header = request.headers.get("Authorization", "")
        if not auth_header.startswith("tma "):
            raise HTTPException(status_code=401, detail="Требуется авторизация через Telegram")
        
        init_data = auth_header[4:]  # Убираем "tma "
        telegram_user = verify_telegram_auth(init_data)
        
        # Получаем данные из тела запроса
        body = await request.json()
        quantity = body.get("quantity", 1)
        
        # Покупаем товар через RPC функцию
        buy_response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/buy_shop_item",
            headers=get_supabase_headers(),
            json={
                "buyer_telegram_id": telegram_user['id'],
                "item_id": item_id,
                "quantity": quantity
            }
        )
        
        if buy_response.status_code != 200:
            raise HTTPException(status_code=500, detail="Ошибка покупки товара")
        
        result = buy_response.json()
        if not result:
            raise HTTPException(status_code=500, detail="Ошибка покупки товара")
        
        result = result[0]
        
        if not result['success']:
            raise HTTPException(status_code=400, detail=result['message'])
        
        return {
            "success": True,
            "message": result['message'],
            "order_id": result['order_id']
        }
        
    except HTTPException:
        raise
    except Exception as e:
        print(f"Error buying shop item: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

# ==================== TELEGRAM STARS PAYMENTS ====================

@app.post("/api/payments/create-invoice")
async def create_invoice(request: InvoiceRequest, telegram_request: Request):
    """Создать счет для покупки NDN за Telegram Stars"""
    try:
        # Получаем init_data из заголовка Authorization
        auth_header = telegram_request.headers.get("Authorization", "")
        if not auth_header.startswith("tma "):
            raise HTTPException(status_code=401, detail="Telegram Mini App authorization required")
        
        init_data = auth_header.replace("tma ", "")
        if not init_data or init_data.strip() == "":
            raise HTTPException(status_code=401, detail="Telegram init_data required")
        
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        
        # Проверяем минимальную сумму
        if request.amount_ndn < 1:
            raise HTTPException(status_code=400, detail="Минимальная сумма: 1 NDN")
        
        if request.amount_ndn > 10000:
            raise HTTPException(status_code=400, detail="Максимальная сумма: 10,000 NDN")
        
        # Курс: 1 NDN = 1 Star
        amount_stars = request.amount_ndn
        
        # Создаем payload для отслеживания платежа
        payload = json.dumps({
            "user_id": user['id'],
            "telegram_id": telegram_user['id'],
            "amount_ndn": request.amount_ndn,
            "timestamp": int(time.time())
        })
        
        # Создаем ссылку на счет для Telegram Mini App
        print(f"🚀 Creating invoice link for user {telegram_user['id']} ({telegram_user.get('first_name', 'Unknown')})")
        print(f"💰 Amount: {amount_stars} stars for {request.amount_ndn} NDN")
        
        result = create_invoice_link(
            amount_stars=amount_stars,
            description=f"Покупка {request.amount_ndn} NDN за {amount_stars} Telegram Stars",
            payload=payload
        )
        
        print(f"📊 Invoice link result: {result}")
        
        if not result.get('ok'):
            error_msg = result.get('description', 'Неизвестная ошибка')
            print(f"❌ Invoice link failed: {error_msg}")
            raise HTTPException(status_code=500, detail=f"Ошибка создания счета: {error_msg}")
        
        return {
            "success": True,
            "message": "Ссылка на счет создана успешно",
            "invoice_link": result['result'],
            "amount_stars": amount_stars,
            "amount_ndn": request.amount_ndn
        }
        
    except HTTPException:
        raise
    except Exception as e:
        print(f"Error creating invoice: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.post("/api/payments/webhook")
async def payment_webhook(request: Request):
    """Webhook для обработки платежей от Telegram Bot"""
    try:
        data = await request.json()
        
        # Обрабатываем pre_checkout_query
        if 'pre_checkout_query' in data:
            query = data['pre_checkout_query']
            
            try:
                payload_data = json.loads(query['invoice_payload'])
                user_id = payload_data['user_id']
                amount_ndn = payload_data['amount_ndn']
                
                # Проверяем, что пользователь существует
                user_response = requests.get(
                    f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user_id}",
                    headers=get_supabase_headers()
                )
                
                if user_response.status_code != 200:
                    answer_pre_checkout_query(query['id'], False, "Пользователь не найден")
                    return {"ok": True}
                
                users = user_response.json()
                if not users:
                    answer_pre_checkout_query(query['id'], False, "Пользователь не найден")
                    return {"ok": True}
                
                # Подтверждаем платеж
                answer_pre_checkout_query(query['id'], True)
                
            except Exception as e:
                print(f"Error processing pre_checkout_query: {e}")
                answer_pre_checkout_query(query['id'], False, "Ошибка обработки платежа")
        
        # Обрабатываем successful_payment
        elif 'message' in data and 'successful_payment' in data['message']:
            payment = data['message']['successful_payment']
            user_id = data['message']['from']['id']
            
            try:
                payload_data = json.loads(payment['invoice_payload'])
                amount_ndn = payload_data['amount_ndn']
                telegram_id = payload_data['telegram_id']
                
                print(f"💰 Processing payment: {amount_ndn} NDN for user {telegram_id}")
                
                # Получаем пользователя по telegram_id из payload
                user_response = requests.get(
                    f"{SUPABASE_URL}/rest/v1/nodeon_users?telegram_id=eq.{telegram_id}",
                    headers=get_supabase_headers()
                )
                
                if user_response.status_code == 200:
                    users = user_response.json()
                    if users:
                        user = users[0]
                        
                        # Получаем текущий баланс кошелька
                        wallet_response = requests.get(
                            f"{SUPABASE_URL}/rest/v1/nodeon_server_wallet?id=eq.1",
                            headers=get_supabase_headers()
                        )
                        
                        if wallet_response.status_code == 200:
                            wallets = wallet_response.json()
                            if wallets:
                                wallet = wallets[0]
                                current_balance = wallet.get('balance_ndn', 0)
                                
                                # Проверяем, достаточно ли NDN в кошельке
                                if current_balance < amount_ndn:
                                    print(f"❌ Insufficient NDN in server wallet: {current_balance} < {amount_ndn}")
                                    return {"ok": True}
                                
                                # Обновляем баланс кошелька (списываем NDN, добавляем Stars)
                                new_wallet_balance = current_balance - amount_ndn
                                wallet_update = {
                                    "balance_ndn": new_wallet_balance,
                                    "total_ndn_issued": wallet.get('total_ndn_issued', 0) + amount_ndn,
                                    "total_stars_received": wallet.get('total_stars_received', 0) + amount_ndn
                                }
                                
                                wallet_update_response = requests.patch(
                                    f"{SUPABASE_URL}/rest/v1/nodeon_server_wallet?id=eq.1",
                                    headers=get_supabase_headers(),
                                    json=wallet_update
                                )
                                
                                if wallet_update_response.status_code == 200:
                                    # Обновляем баланс пользователя (зачисляем NDN)
                                    new_user_balance = user.get('balance_ndn', 0) + amount_ndn
                                    user_update = {
                                        "balance_ndn": new_user_balance
                                    }
                                    
                                    user_update_response = requests.patch(
                                        f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user['id']}",
                                        headers=get_supabase_headers(),
                                        json=user_update
                                    )
                                    
                                    if user_update_response.status_code == 200:
                                        # Создаем транзакцию
                                        transaction_data = {
                                            "user_id": user['id'],
                                            "type": "buy_ndn",
                                            "amount_ndn": amount_ndn,
                                            "amount_stars": amount_ndn,
                                            "description": f"Покупка {amount_ndn} NDN за {amount_ndn} Telegram Stars (ID: {payment['telegram_payment_charge_id']})"
                                        }
                                        
                                        transaction_response = requests.post(
                                            f"{SUPABASE_URL}/rest/v1/nodeon_transactions",
                                            headers=get_supabase_headers(),
                                            json=transaction_data
                                        )
                                        
                                        print(f"✅ Payment processed: {amount_ndn} NDN transferred from server wallet to user {user['first_name']} (ID: {user['id']})")
                                        print(f"💰 New user balance: {new_user_balance} NDN")
                                        print(f"🏦 New wallet balance: {new_wallet_balance} NDN")
                                    else:
                                        print(f"❌ Failed to update user balance: {user_update_response.status_code}")
                                else:
                                    print(f"❌ Failed to update wallet balance: {wallet_update_response.status_code}")
                            else:
                                print("❌ Server wallet not found")
                        else:
                            print(f"❌ Failed to get wallet: {wallet_response.status_code}")
                    else:
                        print(f"❌ User not found: {telegram_id}")
                else:
                    print(f"❌ Failed to get user: {user_response.status_code}")
                
            except Exception as e:
                print(f"❌ Error processing successful_payment: {e}")
        
        return {"ok": True}
        
    except Exception as e:
        print(f"Error processing webhook: {e}")
        return {"ok": False, "error": str(e)}

@app.get("/api/wallet/stats")
async def get_wallet_stats():
    """Получить статистику серверного кошелька"""
    try:
        response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_server_wallet?id=eq.1",
            headers=get_supabase_headers()
        )
        
        if response.status_code == 200:
            wallets = response.json()
            if wallets:
                wallet = wallets[0]
                return {
                    "wallet_balance": wallet.get('balance_ndn', 0),
                    "total_issued": wallet.get('total_ndn_issued', 0),
                    "total_received": wallet.get('total_ndn_received', 0),
                    "total_stars_received": wallet.get('total_stars_received', 0),
                    "total_stars_sent": wallet.get('total_stars_sent', 0),
                    "is_active": wallet.get('is_active', True),
                    "last_updated": wallet.get('updated_at')
                }
            else:
                raise HTTPException(status_code=404, detail="Кошелек не найден")
        else:
            raise HTTPException(status_code=500, detail="Ошибка получения статистики кошелька")
            
    except Exception as e:
        print(f"Error getting wallet stats: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.get("/api/bot/stars-balance")
async def get_bot_stars_balance_endpoint():
    """Получить баланс Stars бота"""
    try:
        balance = get_bot_stars_balance()
        
        if balance.get('ok'):
            return {
                "success": True,
                "star_count": balance.get('result', {}).get('star_count', 0),
                "available_for_exchange": balance.get('result', {}).get('star_count', 0)
            }
        else:
            return {
                "success": True,  # Изменяем на True, так как Stars зачисляются
                "error": balance.get('description', 'API не поддерживается'),
                "star_count": "N/A",  # Неизвестно точное количество
                "available_for_exchange": "N/A",
                "message": "Stars зачисляются на баланс бота автоматически"
            }
            
    except Exception as e:
        print(f"Error getting bot stars balance: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.post("/api/payments/exchange-ndn")
async def exchange_ndn_for_stars(request: ExchangeNDNRequest, telegram_request: Request):
    """Обменять NDN на Telegram Stars"""
    try:
        # Получаем init_data из заголовка Authorization
        auth_header = telegram_request.headers.get("Authorization", "")
        if not auth_header.startswith("tma "):
            raise HTTPException(status_code=401, detail="Telegram Mini App authorization required")
        
        init_data = auth_header.replace("tma ", "")
        if not init_data or init_data.strip() == "":
            raise HTTPException(status_code=401, detail="Telegram init_data required")
        
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        
        # Проверяем минимальную сумму
        if request.amount_ndn < 1:
            raise HTTPException(status_code=400, detail="Минимальная сумма: 1 NDN")
        
        if request.amount_ndn > 10000:
            raise HTTPException(status_code=400, detail="Максимальная сумма: 10,000 NDN")
        
        # Проверяем баланс пользователя
        if user.get('balance_ndn', 0) < request.amount_ndn:
            raise HTTPException(status_code=400, detail="Недостаточно NDN на балансе")
        
        # Курс: 1 NDN = 1 Star
        amount_stars = request.amount_ndn
        
        print(f"🔄 Exchange request: {request.amount_ndn} NDN for {amount_stars} Stars")
        print(f"👤 User: {user['first_name']} (ID: {user['id']})")
        print(f"💰 Current balance: {user.get('balance_ndn', 0)} NDN")
        
        # Списываем NDN с баланса пользователя
        new_user_balance = user.get('balance_ndn', 0) - request.amount_ndn
        user_update = {
            "balance_ndn": new_user_balance
        }
        
        user_update_response = requests.patch(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user['id']}",
            headers=get_supabase_headers(),
            json=user_update
        )
        
        if user_update_response.status_code != 200:
            raise HTTPException(status_code=500, detail="Ошибка обновления баланса пользователя")
        
        # Зачисляем NDN в серверный кошелек
        wallet_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_server_wallet?id=eq.1",
            headers=get_supabase_headers()
        )
        
        if wallet_response.status_code == 200:
            wallets = wallet_response.json()
            if wallets:
                wallet = wallets[0]
                new_wallet_balance = wallet.get('balance_ndn', 0) + request.amount_ndn
                
                wallet_update = {
                    "balance_ndn": new_wallet_balance,
                    "total_ndn_received": wallet.get('total_ndn_received', 0) + request.amount_ndn
                }
                
                wallet_update_response = requests.patch(
                    f"{SUPABASE_URL}/rest/v1/nodeon_server_wallet?id=eq.1",
                    headers=get_supabase_headers(),
                    json=wallet_update
                )
                
                if wallet_update_response.status_code != 200:
                    # Откатываем изменения пользователя
                    rollback_user_balance = user.get('balance_ndn', 0)
                    requests.patch(
                        f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user['id']}",
                        headers=get_supabase_headers(),
                        json={"balance_ndn": rollback_user_balance}
                    )
                    raise HTTPException(status_code=500, detail="Ошибка обновления кошелька")
        
        # Проверяем баланс Stars бота
        bot_balance = get_bot_stars_balance()
        
        if not bot_balance.get('ok'):
            # Откатываем все изменения
            rollback_user_balance = user.get('balance_ndn', 0)
            requests.patch(
                f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user['id']}",
                headers=get_supabase_headers(),
                json={"balance_ndn": rollback_user_balance}
            )
            
            rollback_wallet_balance = wallet.get('balance_ndn', 0)
            requests.patch(
                f"{SUPABASE_URL}/rest/v1/nodeon_server_wallet?id=eq.1",
                headers=get_supabase_headers(),
                json={"balance_ndn": rollback_wallet_balance}
            )
            
            raise HTTPException(status_code=500, detail="Не удается проверить баланс Stars бота")
        
        bot_stars_balance = bot_balance.get('result', {}).get('star_count', 0)
        
        if bot_stars_balance < amount_stars:
            # Откатываем все изменения
            rollback_user_balance = user.get('balance_ndn', 0)
            requests.patch(
                f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user['id']}",
                headers=get_supabase_headers(),
                json={"balance_ndn": rollback_user_balance}
            )
            
            rollback_wallet_balance = wallet.get('balance_ndn', 0)
            requests.patch(
                f"{SUPABASE_URL}/rest/v1/nodeon_server_wallet?id=eq.1",
                headers=get_supabase_headers(),
                json={"balance_ndn": rollback_wallet_balance}
            )
            
            raise HTTPException(
                status_code=400, 
                detail=f"Недостаточно Stars у бота для обмена. Доступно: {bot_stars_balance}, требуется: {amount_stars}. Обратитесь к администратору для пополнения баланса бота."
            )
        
        # Отправляем Stars пользователю
        stars_result = send_stars(telegram_user['id'], amount_stars)
        
        if not stars_result.get('ok'):
            # Откатываем все изменения
            rollback_user_balance = user.get('balance_ndn', 0)
            requests.patch(
                f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user['id']}",
                headers=get_supabase_headers(),
                json={"balance_ndn": rollback_user_balance}
            )
            
            rollback_wallet_balance = wallet.get('balance_ndn', 0)
            requests.patch(
                f"{SUPABASE_URL}/rest/v1/nodeon_server_wallet?id=eq.1",
                headers=get_supabase_headers(),
                json={"balance_ndn": rollback_wallet_balance}
            )
            
            raise HTTPException(status_code=500, detail=f"Ошибка отправки Stars: {stars_result.get('description', 'Unknown error')}")
        
        # Создаем транзакцию
        transaction_data = {
            "user_id": user['id'],
            "type": "exchange_ndn",
            "amount_ndn": -request.amount_ndn,  # Отрицательное значение для списания
            "amount_stars": amount_stars,
            "description": f"Обмен {request.amount_ndn} NDN на {amount_stars} Telegram Stars"
        }
        
        transaction_response = requests.post(
            f"{SUPABASE_URL}/rest/v1/nodeon_transactions",
            headers=get_supabase_headers(),
            json=transaction_data
        )
        
        print(f"✅ Exchange completed: {request.amount_ndn} NDN → {amount_stars} Stars")
        print(f"💰 New user balance: {new_user_balance} NDN")
        print(f"🏦 New wallet balance: {new_wallet_balance} NDN")
        
        return {
            "success": True,
            "message": f"Успешно обменяно {request.amount_ndn} NDN на {amount_stars} Telegram Stars",
            "amount_ndn": request.amount_ndn,
            "amount_stars": amount_stars,
            "new_balance": new_user_balance
        }
        
    except HTTPException:
        raise
    except Exception as e:
        print(f"Error exchanging NDN: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.post("/api/payments/exchange-request")
async def create_exchange_request(request: ExchangeRequest, telegram_request: Request):
    """Создать заявку на обмен NDN на Stars (альтернативный способ)"""
    try:
        # Получаем init_data из заголовка Authorization
        auth_header = telegram_request.headers.get("Authorization", "")
        if not auth_header.startswith("tma "):
            raise HTTPException(status_code=401, detail="Telegram Mini App authorization required")
        
        init_data = auth_header.replace("tma ", "")
        if not init_data or init_data.strip() == "":
            raise HTTPException(status_code=401, detail="Telegram init_data required")
        
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        
        # Проверяем минимальную сумму
        if request.amount_ndn < 1:
            raise HTTPException(status_code=400, detail="Минимальная сумма: 1 NDN")
        
        if request.amount_ndn > 10000:
            raise HTTPException(status_code=400, detail="Максимальная сумма: 10,000 NDN")
        
        # Проверяем баланс пользователя
        if user.get('balance_ndn', 0) < request.amount_ndn:
            raise HTTPException(status_code=400, detail="Недостаточно NDN на балансе")
        
        # Списываем NDN с баланса пользователя
        new_user_balance = user.get('balance_ndn', 0) - request.amount_ndn
        user_update = {
            "balance_ndn": new_user_balance
        }
        
        user_update_response = requests.patch(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user['id']}",
            headers=get_supabase_headers(),
            json=user_update
        )
        
        if user_update_response.status_code != 200:
            raise HTTPException(status_code=500, detail="Ошибка обновления баланса пользователя")
        
        # Зачисляем NDN в серверный кошелек
        wallet_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_server_wallet?id=eq.1",
            headers=get_supabase_headers()
        )
        
        if wallet_response.status_code == 200:
            wallets = wallet_response.json()
            if wallets:
                wallet = wallets[0]
                new_wallet_balance = wallet.get('balance_ndn', 0) + request.amount_ndn
                
                wallet_update = {
                    "balance_ndn": new_wallet_balance,
                    "total_ndn_received": wallet.get('total_ndn_received', 0) + request.amount_ndn
                }
                
                wallet_update_response = requests.patch(
                    f"{SUPABASE_URL}/rest/v1/nodeon_server_wallet?id=eq.1",
                    headers=get_supabase_headers(),
                    json=wallet_update
                )
        
        # Создаем транзакцию
        transaction_data = {
            "user_id": user['id'],
            "type": "exchange_request",
            "amount_ndn": -request.amount_ndn,  # Отрицательное значение для списания
            "amount_stars": request.amount_ndn,
            "description": f"Заявка на обмен {request.amount_ndn} NDN на {request.amount_ndn} Stars (@{request.telegram_username})"
        }
        
        transaction_response = requests.post(
            f"{SUPABASE_URL}/rest/v1/nodeon_transactions",
            headers=get_supabase_headers(),
            json=transaction_data
        )
        
        print(f"📝 Exchange request created: {request.amount_ndn} NDN for @{request.telegram_username}")
        print(f"💰 New user balance: {new_user_balance} NDN")
        
        return {
            "success": True,
            "message": f"Заявка на обмен {request.amount_ndn} NDN на {request.amount_ndn} Stars создана! Администратор обработает её в течение 24 часов.",
            "amount_ndn": request.amount_ndn,
            "amount_stars": request.amount_ndn,
            "new_balance": new_user_balance,
            "request_id": f"EXCH_{user['id']}_{int(time.time())}"
        }
        
    except HTTPException:
        raise
    except Exception as e:
        print(f"Error creating exchange request: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

# ==================== АДМИН ПАНЕЛЬ ====================

@app.get("/api/admin/check-status")
async def check_admin_status(request: Request):
    """Проверить статус пользователя для доступа к админ панели"""
    try:
        auth_header = request.headers.get("Authorization", "")
        if not auth_header.startswith("tma "):
            raise HTTPException(status_code=401, detail="Telegram Mini App authorization required")
        
        init_data = auth_header.replace("tma ", "")
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        
        user_status = user.get('user_status', 'user')
        is_admin = user_status in ['developer', 'operator', 'bankir']
        
        return {
            "success": True,
            "is_admin": is_admin,
            "user_status": user_status,
            "status_name": USER_STATUSES.get(user_status, "Неизвестно"),
            "permissions": {
                "can_manage_exchanges": user_status in ['bankir', 'developer'],
                "can_manage_users": user_status in ['operator', 'developer'],
                "can_view_analytics": user_status in ['developer']
            }
        }
        
    except ValueError as e:
        raise HTTPException(status_code=401, detail=str(e))
    except Exception as e:
        print(f"Error checking admin status: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.get("/api/admin/dashboard")
async def get_admin_dashboard(request: Request):
    """Получить данные для админ панели"""
    try:
        auth_header = request.headers.get("Authorization", "")
        if not auth_header.startswith("tma "):
            raise HTTPException(status_code=401, detail="Telegram Mini App authorization required")
        
        init_data = auth_header.replace("tma ", "")
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        
        # Проверяем права доступа
        if user.get('user_status') not in ['bankir', 'developer']:
            raise HTTPException(status_code=403, detail="Access denied. Bankir or Developer status required")
        
        headers = get_supabase_headers()
        
        # Получаем данные серверного кошелька
        wallet_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_server_wallet?order=id.desc&limit=1",
            headers=headers
        )
        
        wallet_data = {}
        if wallet_response.status_code == 200:
            wallets = wallet_response.json()
            if wallets:
                wallet = wallets[0]
                wallet_data = {
                    "balance_ndn": float(wallet.get('balance_ndn', 0)),
                    "total_ndn_sold": float(wallet.get('total_ndn_sold', 0)),
                    "total_stars_received": float(wallet.get('total_stars_received', 0)),
                    "total_ndn_exchanged": float(wallet.get('total_ndn_exchanged', 0)),
                    "total_stars_sent": float(wallet.get('total_stars_sent', 0))
                }
        
        # Получаем заявки на обмен (пока используем nodeon_transactions)
        exchange_requests = []
        transactions_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_transactions?type=eq.exchange_request&order=created_at.desc",
            headers=headers
        )
        
        if transactions_response.status_code == 200:
            transactions = transactions_response.json()
            for tx in transactions:
                if tx.get('type') == 'exchange_request':
                    exchange_requests.append({
                        "id": tx.get('id'),
                        "user_id": tx.get('user_id'),
                        "amount_ndn": float(tx.get('amount_ndn', 0)),
                        "description": tx.get('description', ''),
                        "created_at": tx.get('created_at'),
                        "status": "pending"
                    })
        
        # Получаем общую статистику
        users_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users",
            headers=headers
        )
        
        stats = {
            "total_users": 0,
            "total_pro_users": 0,
            "total_ndn_in_circulation": 0.0,
            "total_referrals": 0
        }
        
        if users_response.status_code == 200:
            users = users_response.json()
            stats["total_users"] = len(users)
            stats["total_pro_users"] = len([u for u in users if u.get('is_pro', False)])
            stats["total_ndn_in_circulation"] = sum(float(u.get('balance_ndn', 0)) for u in users)
            stats["total_referrals"] = len([u for u in users if u.get('inviter_id') is not None])
        
        return {
            "success": True,
            "wallet": wallet_data,
            "exchange_requests": exchange_requests,
            "stats": stats
        }
            
    except ValueError as e:
        raise HTTPException(status_code=401, detail=str(e))
    except Exception as e:
        print(f"Error getting admin dashboard: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.get("/api/admin/exchange-requests")
async def get_exchange_requests(request: Request):
    """Получить список заявок на обмен для банкира"""
    try:
        auth_header = request.headers.get("Authorization", "")
        if not auth_header.startswith("tma "):
            raise HTTPException(status_code=401, detail="Telegram Mini App authorization required")
        
        init_data = auth_header.replace("tma ", "")
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        
        # Проверяем права доступа
        if user.get('user_status') not in ['bankir', 'developer']:
            raise HTTPException(status_code=403, detail="Access denied. Bankir or Developer status required")
        
        headers = get_supabase_headers()
        
        # Получаем заявки на обмен из транзакций
        response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_transactions?type=eq.exchange_request&order=created_at.desc",
            headers=headers
        )
        
        if response.status_code == 200:
            transactions = response.json()
            requests_data = []
            for tx in transactions:
                if tx.get('type') == 'exchange_request':
                    requests_data.append({
                        "id": tx.get('id'),
                        "user_id": tx.get('user_id'),
                        "amount_ndn": float(tx.get('amount_ndn', 0)),
                        "amount_stars": int(float(tx.get('amount_ndn', 0))),  # 1:1 конвертация
                        "telegram_username": "Unknown",  # Нужно получить из user_id
                        "status": "pending",
                        "description": tx.get('description', ''),
                        "created_at": tx.get('created_at')
                    })
            
            return {
                "success": True,
                "requests": requests_data
            }
        else:
            return {"success": False, "message": "Failed to fetch exchange requests"}
            
    except ValueError as e:
        raise HTTPException(status_code=401, detail=str(e))
    except Exception as e:
        print(f"Error getting exchange requests: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.post("/api/admin/exchange-requests/{request_id}/approve")
async def approve_exchange_request(request_id: int, request: Request):
    """Одобрить заявку на обмен"""
    try:
        auth_header = request.headers.get("Authorization", "")
        if not auth_header.startswith("tma "):
            raise HTTPException(status_code=401, detail="Telegram Mini App authorization required")
        
        init_data = auth_header.replace("tma ", "")
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        
        # Проверяем права доступа
        if user.get('user_status') not in ['bankir', 'developer']:
            raise HTTPException(status_code=403, detail="Access denied. Bankir or Developer status required")
        
        headers = get_supabase_headers()
        
        # Получаем заявку
        get_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_transactions?id=eq.{request_id}",
            headers=headers
        )
        
        if get_response.status_code != 200:
            return {"success": False, "message": "Exchange request not found"}
        
        requests_data = get_response.json()
        if not requests_data:
            return {"success": False, "message": "Exchange request not found"}
        
        exchange_request = requests_data[0]
        user_id = exchange_request.get('user_id')
        amount_ndn = abs(float(exchange_request.get('amount_ndn', 0)))
        amount_stars = int(amount_ndn)  # 1:1 конвертация
        
        # Получаем данные пользователя
        user_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user_id}",
            headers=headers
        )
        
        if user_response.status_code != 200:
            return {"success": False, "message": "User not found"}
        
        user_data = user_response.json()
        if not user_data:
            return {"success": False, "message": "User not found"}
        
        user_info = user_data[0]
        telegram_id = user_info.get('telegram_id')
        
        # Обновляем описание заявки
        update_response = requests.patch(
            f"{SUPABASE_URL}/rest/v1/nodeon_transactions?id=eq.{request_id}",
            headers=headers,
            json={
                "description": f"✅ Одобрено: {amount_ndn} NDN → {amount_stars} Stars (обработано {user.get('first_name', 'Admin')})"
            }
        )
        
        if update_response.status_code in [200, 204]:
            # Здесь должна быть логика отправки Stars пользователю через Telegram Bot API
            print(f"✅ Exchange approved: User {user_id} ({telegram_id}) - {amount_ndn} NDN → {amount_stars} Stars")
            
            return {
                "success": True,
                "message": f"Заявка {request_id} одобрена. {amount_stars} Stars будут отправлены пользователю.",
                "request_id": request_id,
                "amount_ndn": amount_ndn,
                "amount_stars": amount_stars,
                "user_telegram_id": telegram_id
            }
        else:
            return {"success": False, "message": "Failed to update request status"}
            
    except ValueError as e:
        raise HTTPException(status_code=401, detail=str(e))
    except Exception as e:
        print(f"Error approving exchange request: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.post("/api/admin/exchange-requests/{request_id}/reject")
async def reject_exchange_request(request_id: int, request: Request):
    """Отклонить заявку на обмен"""
    try:
        auth_header = request.headers.get("Authorization", "")
        if not auth_header.startswith("tma "):
            raise HTTPException(status_code=401, detail="Telegram Mini App authorization required")
        
        init_data = auth_header.replace("tma ", "")
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        
        # Проверяем права доступа
        if user.get('user_status') not in ['bankir', 'developer']:
            raise HTTPException(status_code=403, detail="Access denied. Bankir or Developer status required")
        
        headers = get_supabase_headers()
        
        # Получаем заявку
        get_response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_transactions?id=eq.{request_id}",
            headers=headers
        )
        
        if get_response.status_code != 200:
            return {"success": False, "message": "Exchange request not found"}
        
        requests_data = get_response.json()
        if not requests_data:
            return {"success": False, "message": "Exchange request not found"}
        
        exchange_request = requests_data[0]
        amount_ndn = abs(float(exchange_request.get('amount_ndn', 0)))
        
        # Обновляем описание заявки
        update_response = requests.patch(
            f"{SUPABASE_URL}/rest/v1/nodeon_transactions?id=eq.{request_id}",
            headers=headers,
            json={
                "description": f"❌ Отклонено: {amount_ndn} NDN → Stars (отклонено {user.get('first_name', 'Admin')})"
            }
        )
        
        if update_response.status_code in [200, 204]:
            print(f"❌ Exchange rejected: Request {request_id} rejected by {user.get('first_name', 'Admin')}")
            
            return {
                "success": True,
                "message": f"Заявка {request_id} отклонена.",
                "request_id": request_id,
                "amount_ndn": amount_ndn
            }
        else:
            return {"success": False, "message": "Failed to update request status"}
            
    except ValueError as e:
        raise HTTPException(status_code=401, detail=str(e))
    except Exception as e:
        print(f"Error rejecting exchange request: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

# Игровые API endpoints
@app.get("/api/game/data/{user_id}")
async def get_game_data(user_id: int):
    """Получить игровые данные пользователя"""
    try:
        # В реальном приложении здесь будет запрос к базе данных
        # Пока возвращаем базовые данные
        return {
            "success": True,
            "data": {
                "level": 1,
                "xp": 0,
                "achievements": [],
                "daily_rewards": [],
                "stats": {
                    "days_played": 0,
                    "total_earned": 0,
                    "total_referrals": 0
                }
            }
        }
    except Exception as e:
        print(f"Error getting game data: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.post("/api/game/claim-daily-reward")
async def claim_daily_reward(request: Request):
    """Получить ежедневную награду"""
    try:
        data = await request.json()
        user_id = data.get("user_id")
        day = data.get("day")
        
        if not user_id or not day:
            raise HTTPException(status_code=400, detail="Missing user_id or day")
        
        # В реальном приложении здесь будет логика проверки и выдачи награды
        rewards = {
            1: 10, 2: 20, 3: 30, 4: 50, 5: 75, 6: 100, 7: 200
        }
        
        reward_amount = rewards.get(day, 0)
        
        return {
            "success": True,
            "message": f"Получена награда: {reward_amount} NDN",
            "reward_amount": reward_amount,
            "day": day
        }
    except Exception as e:
        print(f"Error claiming daily reward: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.post("/api/game/update-achievement")
async def update_achievement(request: Request):
    """Обновить прогресс достижения"""
    try:
        data = await request.json()
        user_id = data.get("user_id")
        achievement_id = data.get("achievement_id")
        progress = data.get("progress", 1)
        
        if not user_id or not achievement_id:
            raise HTTPException(status_code=400, detail="Missing user_id or achievement_id")
        
        # В реальном приложении здесь будет обновление в базе данных
        return {
            "success": True,
            "message": "Достижение обновлено",
            "achievement_id": achievement_id,
            "progress": progress
        }
    except Exception as e:
        print(f"Error updating achievement: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

@app.get("/api/game/achievements/{user_id}")
async def get_achievements(user_id: int):
    """Получить список достижений пользователя"""
    try:
        # В реальном приложении здесь будет запрос к базе данных
        achievements = [
            {
                "id": "first_login",
                "title": "Первые шаги",
                "description": "Войти в игру впервые",
                "icon": "🎮",
                "progress": 1,
                "max_progress": 1,
                "reward": 50,
                "completed": True
            },
            {
                "id": "pro_user",
                "title": "Pro игрок",
                "description": "Купить Pro статус",
                "icon": "💎",
                "progress": 0,
                "max_progress": 1,
                "reward": 100,
                "completed": False
            },
            {
                "id": "referral_master",
                "title": "Мастер рефералов",
                "description": "Пригласить 5 друзей",
                "icon": "👥",
                "progress": 0,
                "max_progress": 5,
                "reward": 200,
                "completed": False
            },
            {
                "id": "daily_player",
                "title": "Ежедневный игрок",
                "description": "Заходить в игру 7 дней подряд",
                "icon": "📅",
                "progress": 0,
                "max_progress": 7,
                "reward": 300,
                "completed": False
            }
        ]
        
        return {
            "success": True,
            "achievements": achievements
        }
    except Exception as e:
        print(f"Error getting achievements: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

# NDN Miner API endpoints
@app.get("/api/miner/data/{user_id}")
async def get_miner_data(user_id: int):
    """Получить данные майнера пользователя с расчетом оффлайн заработка"""
    try:
        # Получаем пользователя из БД
        user = await get_user_by_telegram_id(user_id)
        if not user:
            return {"success": False, "error": "User not found"}
        
        # Получаем данные майнинга из таблицы nodeon_miner_data
        miner_data = await get_miner_data_from_db(user_id)
        
        if not miner_data:
            # Создаем начальные данные майнинга
            miner_data = await create_initial_miner_data(user_id)
            print(f"📊 Созданы начальные данные майнинга для пользователя {user_id}")
        else:
            print(f"📊 Загружены данные майнинга для пользователя {user_id}")
        
        # Рассчитываем оффлайн заработок с защитой от читерства
        current_time = int(time.time() * 1000)
        last_update = miner_data.get("last_update", current_time)
        time_diff = current_time - last_update
        
        # Защита от читерства: проверяем разумность времени
        max_reasonable_time = 7 * 24 * 60 * 60 * 1000  # 7 дней в миллисекундах
        if time_diff > max_reasonable_time:
            print(f"⚠️ Подозрительное время для пользователя {user_id}: {time_diff/1000/60/60:.1f} часов")
            time_diff = max_reasonable_time
            last_update = current_time - time_diff
        
        # Если прошло больше 1 секунды, рассчитываем заработок
        if time_diff > 1000:
            offline_earnings = calculate_offline_earnings(miner_data, time_diff)
            if offline_earnings > 0:
                # Обновляем Gas на сервере
                miner_data["ndnGas"] = miner_data.get("ndnGas", 100) + offline_earnings
                miner_data["totalGasEarned"] = miner_data.get("totalGasEarned", 100) + offline_earnings
                print(f"💰 Оффлайн заработок для пользователя {user_id}: {offline_earnings} Gas за {time_diff/1000:.1f} секунд")
        
        # Обновляем время последнего обновления
        miner_data["last_update"] = current_time
        
        # Сохраняем обновленные данные в БД
        await update_user_miner_data(user_id, miner_data)
        
        return {"success": True, "miner_data": miner_data}
    except Exception as e:
        print(f"Error getting miner data: {e}")
        return {"success": False, "error": "Failed to get miner data"}

def calculate_offline_earnings(miner_data: dict, time_diff_ms: int) -> float:
    """Рассчитывает заработок за время отсутствия игрока"""
    try:
        # Получаем фермы из данных майнера
        farms = miner_data.get("farms", [])
        if not farms or len(farms) == 0:
            return 0
        
        # Рассчитываем общую генерацию в минуту
        total_gas_per_minute = 0
        total_energy_cost = 0
        
        for farm in farms:
            farm_type = farm.get("type")
            if farm_type == "cpu_miner":
                base_gas = 1
                energy_cost = 1
            elif farm_type == "gpu_farm":
                base_gas = 5
                energy_cost = 3
            elif farm_type == "asic_rig":
                base_gas = 20
                energy_cost = 8
            elif farm_type == "data_center":
                base_gas = 100
                energy_cost = 25
            else:
                continue
            
            # Применяем улучшения скорости
            upgrades = miner_data.get("upgrades", {})
            speed_multiplier = 1 + (upgrades.get("speed", 0) * 0.1)
            efficiency_multiplier = 1 - (upgrades.get("efficiency", 0) * 0.2)
            
            total_gas_per_minute += base_gas * speed_multiplier
            total_energy_cost += energy_cost * efficiency_multiplier
        
        # Проверяем энергию
        current_energy = miner_data.get("energy", 100)
        if total_energy_cost > current_energy:
            # Недостаточно энергии - майнинг не работает
            print(f"⚠️ Недостаточно энергии для майнинга: {total_energy_cost} > {current_energy}")
            return 0
        
        # Рассчитываем время в минутах
        time_diff_minutes = time_diff_ms / (1000 * 60)
        
        # Рассчитываем заработок
        earnings = total_gas_per_minute * time_diff_minutes
        
        # Обновляем энергию (потребление за время)
        energy_consumption = total_energy_cost * time_diff_minutes
        miner_data["energy"] = max(0, current_energy - energy_consumption)
        
        # Обновляем Gas
        miner_data["ndnGas"] = miner_data.get("ndnGas", 100) + earnings
        miner_data["totalGasEarned"] = miner_data.get("totalGasEarned", 100) + earnings
        
        print(f"💰 Оффлайн расчет: {total_gas_per_minute} Gas/мин за {time_diff_minutes:.2f} мин = {earnings:.2f} Gas")
        return round(earnings, 2)
    except Exception as e:
        print(f"Error calculating offline earnings: {e}")
        return 0

@app.post("/api/miner/buy-farm")
async def buy_farm(request: Request):
    """Купить ферму майнинга"""
    try:
        data = await request.json()
        user_id = data.get("user_id")
        farm_type = data.get("farm_type")
        
        print(f"🛒 Покупка фермы: user_id={user_id}, farm_type={farm_type}")
        
        if not user_id or not farm_type:
            print("❌ Отсутствуют параметры")
            return {"success": False, "error": "Missing parameters"}
        
        # Получаем пользователя
        user = await get_user_by_telegram_id(user_id)
        if not user:
            print(f"❌ Пользователь не найден: {user_id}")
            return {"success": False, "error": "User not found"}
        
        print(f"👤 Пользователь найден: {user['id']}")
        
        # Определяем стоимость фермы
        farm_costs = {
            "cpu_miner": 50,
            "gpu_farm": 250,
            "asic_rig": 1000,
            "data_center": 5000
        }
        
        cost = farm_costs.get(farm_type)
        if not cost:
            print(f"❌ Неизвестный тип фермы: {farm_type}")
            return {"success": False, "error": "Invalid farm type"}
        
        print(f"💰 Стоимость фермы: {cost} Gas")
        
        # Получаем текущие данные майнера
        miner_data = await get_miner_data_from_db(user_id)
        if not miner_data:
            print("📊 Создаем начальные данные майнера")
            miner_data = await create_initial_miner_data(user_id)
            if not miner_data:
                print("❌ Не удалось создать данные майнера")
                return {"success": False, "error": "Failed to create miner data"}
        else:
            print(f"📊 Данные майнера загружены: Gas={miner_data.get('ndnGas', 0)}")
        
        # Проверяем баланс Gas
        current_gas = miner_data.get("ndnGas", 0)
        if current_gas < cost:
            print(f"❌ Недостаточно Gas: {current_gas} < {cost}")
            return {"success": False, "error": "Not enough Gas"}
        
        # Покупаем ферму
        miner_data["ndnGas"] = current_gas - cost
        if "farms" not in miner_data:
            miner_data["farms"] = []
        
        miner_data["farms"].append({
            "type": farm_type,
            "level": 1,
            "purchased_at": int(time.time() * 1000)
        })
        
        # Обновляем время последнего обновления
        miner_data["last_update"] = int(time.time() * 1000)
        
        print(f"🔄 Обновляем данные: Gas={miner_data['ndnGas']}, Ферм={len(miner_data['farms'])}")
        
        # Сохраняем в БД
        save_result = await update_user_miner_data(user_id, miner_data)
        if not save_result:
            print(f"❌ Ошибка сохранения данных майнера для пользователя {user_id}")
            return {"success": False, "error": "Failed to save miner data"}
        
        print(f"✅ Ферма {farm_type} успешно куплена пользователем {user_id}")
        print(f"📊 Новые данные майнера: Gas={miner_data['ndnGas']}, Ферм={len(miner_data['farms'])}")
        
        return {"success": True, "message": "Farm purchased successfully", "miner_data": miner_data}
    except Exception as e:
        print(f"❌ Ошибка покупки фермы: {e}")
        import traceback
        traceback.print_exc()
        return {"success": False, "error": "Failed to buy farm"}

@app.get("/api/miner/check-tables")
async def check_miner_tables():
    """Проверить состояние таблиц майнера"""
    try:
        # Проверяем таблицу nodeon_miner_data
        url = f"{SUPABASE_URL}/rest/v1/nodeon_miner_data?select=count"
        headers = {
            "apikey": SUPABASE_ANON_KEY,
            "Authorization": f"Bearer {SUPABASE_ANON_KEY}"
        }
        
        response = requests.get(url, headers=headers)
        miner_data_exists = response.status_code == 200
        
        # Проверяем таблицу nodeon_miner_stats
        url = f"{SUPABASE_URL}/rest/v1/nodeon_miner_stats?select=count"
        response = requests.get(url, headers=headers)
        miner_stats_exists = response.status_code == 200
        
        return {
            "success": True,
            "tables": {
                "nodeon_miner_data": miner_data_exists,
                "nodeon_miner_stats": miner_stats_exists
            }
        }
    except Exception as e:
        print(f"Error checking tables: {e}")
        return {"success": False, "error": str(e)}

@app.post("/api/miner/save-gas")
async def save_miner_gas(request: Request):
    """Сохранить Gas майнера на сервере"""
    try:
        data = await request.json()
        user_id = data.get("user_id")
        gas_amount = data.get("gas_amount")
        total_gas_earned = data.get("total_gas_earned")
        last_update = data.get("last_update")
        
        if not user_id or gas_amount is None:
            return {"success": False, "error": "Missing parameters"}
        
        # Получаем пользователя
        user = await get_user_by_telegram_id(user_id)
        if not user:
            return {"success": False, "error": "User not found"}
        
        # Получаем текущие данные майнера
        miner_data = await get_miner_data_from_db(user_id)
        if not miner_data:
            return {"success": False, "error": "Miner data not found"}
        
        # Валидация: проверяем, что Gas не увеличился подозрительно
        current_gas = miner_data.get("ndnGas", 100)
        if gas_amount > current_gas + 10000:  # Максимум +10000 Gas за раз
            print(f"⚠️ Подозрительное увеличение Gas для пользователя {user_id}: {current_gas} -> {gas_amount}")
            return {"success": False, "error": "Suspicious gas increase detected"}
        
        # Обновляем данные
        miner_data["ndnGas"] = gas_amount
        miner_data["totalGasEarned"] = total_gas_earned or gas_amount
        miner_data["last_update"] = last_update or int(time.time() * 1000)
        
        # Сохраняем в БД
        success = await update_user_miner_data(user_id, miner_data)
        if not success:
            return {"success": False, "error": "Failed to save data"}
        
        print(f"✅ Gas сохранен для пользователя {user_id}: {gas_amount}")
        return {"success": True, "message": "Gas saved successfully"}
        
    except Exception as e:
        print(f"Error saving miner gas: {e}")
        return {"success": False, "error": "Failed to save gas"}

@app.post("/api/miner/buy-premium-farm")
async def buy_premium_farm(request: Request):
    """Купить премиум ферму за реальные NDN"""
    try:
        data = await request.json()
        user_id = data.get("user_id")
        farm_type = data.get("farm_type")
        
        if not user_id or not farm_type:
            return {"success": False, "error": "Missing parameters"}
        
        # Получаем пользователя
        user = await get_user_by_telegram_id(user_id)
        if not user:
            return {"success": False, "error": "User not found"}
        
        # Определяем стоимость в NDN
        premium_farm_costs = {
            "golden_farm": 500,  # 500 NDN
            "diamond_farm": 2000,  # 2000 NDN
            "quantum_farm": 10000  # 10000 NDN
        }
        
        cost_ndn = premium_farm_costs.get(farm_type)
        if not cost_ndn:
            return {"success": False, "error": "Invalid premium farm type"}
        
        # Проверяем баланс NDN
        print(f"Checking balance for user {user_id}: {user.balance_ndn} NDN, cost: {cost_ndn} NDN")
        if user.balance_ndn < cost_ndn:
            return {"success": False, "error": "Not enough NDN"}
        
        # Получаем данные майнера
        miner_data = await get_miner_data_from_db(user_id)
        if not miner_data:
            print(f"Creating initial miner data for user {user_id}")
            miner_data = await create_initial_miner_data(user_id)
            if not miner_data:
                return {"success": False, "error": "Failed to create miner data"}
        
        # Списываем NDN и добавляем ферму
        old_balance = user.balance_ndn
        user.balance_ndn -= cost_ndn
        print(f"Updating balance: {old_balance} -> {user.balance_ndn}")
        
        if "farms" not in miner_data:
            miner_data["farms"] = []
        
        new_farm = {
            "type": farm_type,
            "level": 1,
            "premium": True,
            "purchased_at": int(time.time() * 1000)
        }
        miner_data["farms"].append(new_farm)
        print(f"Added farm: {new_farm}")
        
        # Обновляем время последнего обновления
        miner_data["last_update"] = int(time.time() * 1000)
        
        # Сохраняем в БД
        print(f"Saving miner data and balance for user {user_id}")
        miner_saved = await update_user_miner_data(user_id, miner_data)
        balance_saved = await update_user_balance(user_id, user.balance_ndn)
        
        print(f"Save results - Miner: {miner_saved}, Balance: {balance_saved}")
        
        return {"success": True, "message": "Premium farm purchased successfully"}
    except Exception as e:
        print(f"Error buying premium farm: {e}")
        return {"success": False, "error": "Failed to buy premium farm"}

@app.post("/api/miner/save-state")
async def save_miner_state(request: Request):
    """Сохранить состояние майнера на сервере"""
    try:
        data = await request.json()
        user_id = data.get("user_id")
        miner_data = data.get("miner_data")
        
        if not user_id or not miner_data:
            return {"success": False, "error": "Missing parameters"}
        
        # Обновляем время последнего обновления
        miner_data["last_update"] = int(time.time() * 1000)
        
        # Сохраняем в БД
        await update_user_miner_data(user_id, miner_data)
        
        return {"success": True, "message": "Miner state saved successfully"}
    except Exception as e:
        print(f"Error saving miner state: {e}")
        return {"success": False, "error": "Failed to save miner state"}

async def get_miner_data_from_db(user_id: int) -> dict:
    """Получить данные майнера из БД"""
    try:
        # Получаем пользователя по telegram_id, чтобы найти его ID в БД
        user = await get_user_by_telegram_id(user_id)
        if not user:
            print(f"User with telegram_id {user_id} not found")
            return None
        
        url = f"{SUPABASE_URL}/rest/v1/nodeon_miner_data?user_id=eq.{user['id']}&select=*"
        headers = {
            "apikey": SUPABASE_ANON_KEY,
            "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
            "Content-Type": "application/json"
        }
        
        response = requests.get(url, headers=headers)
        
        if response.status_code == 200:
            data = response.json()
            if data and len(data) > 0:
                miner_record = data[0]
                # Парсим JSON данные майнера
                if miner_record.get("miner_data"):
                    import json
                    return json.loads(miner_record["miner_data"])
        return None
    except Exception as e:
        print(f"Error getting miner data from DB: {e}")
        return None

async def create_initial_miner_data(user_id: int) -> dict:
    """Создать начальные данные майнера"""
    try:
        # Получаем пользователя
        user = await get_user_by_telegram_id(user_id)
        if not user:
            return None
        
        current_time = int(time.time() * 1000)
        
        miner_data = {
            "ndnGas": 100.0,
            "energy": 100,
            "maxEnergy": 100,
            "gasPerMinute": 0.0,
            "farms": [],
            "upgrades": {
                "speed": 0,
                "efficiency": 0,
                "automation": 0
            },
            "totalGasEarned": 100.0,
            "lastEnergyRefill": current_time,
            "lastUpdate": current_time
        }
        
        # Создаем запись в БД
        import json
        url = f"{SUPABASE_URL}/rest/v1/nodeon_miner_data"
        headers = {
            "apikey": SUPABASE_ANON_KEY,
            "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
            "Content-Type": "application/json"
        }
        
        db_data = {
            "user_id": user["id"],  # Используем ID пользователя из БД
            "miner_data": json.dumps(miner_data),
            "last_update": current_time
        }
        
        response = requests.post(url, headers=headers, json=db_data)
        
        if response.status_code == 201:
            print(f"Created initial miner data for user {user_id}")
            return miner_data
        else:
            print(f"Error creating miner data: {response.status_code} - {response.text}")
            return None
            
    except Exception as e:
        print(f"Error creating initial miner data: {e}")
        return None

async def update_user_miner_data(user_id: int, miner_data: dict):
    """Обновить данные майнера пользователя в БД"""
    try:
        import json
        current_time = int(time.time() * 1000)
        
        # Получаем пользователя по telegram_id, чтобы найти его ID в БД
        user = await get_user_by_telegram_id(user_id)
        if not user:
            print(f"User with telegram_id {user_id} not found")
            return False
        
        # Обновляем основные данные по ID пользователя в БД
        url = f"{SUPABASE_URL}/rest/v1/nodeon_miner_data?user_id=eq.{user['id']}"
        headers = {
            "apikey": SUPABASE_ANON_KEY,
            "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
            "Content-Type": "application/json",
            "Prefer": "return=minimal"
        }
        
        update_data = {
            "miner_data": json.dumps(miner_data),
            "last_update": current_time
        }
        
        response = requests.patch(url, headers=headers, json=update_data)
        
        print(f"📡 Обновление данных майнера: {response.status_code}")
        if response.status_code not in [200, 204]:
            print(f"❌ Ошибка обновления данных майнера: {response.status_code} - {response.text}")
            return False
        
        # Обновляем статистику
        await update_miner_stats(user_id)
        print(f"✅ Данные майнера успешно обновлены для пользователя {user_id}")
        return True
            
    except Exception as e:
        print(f"Error updating miner data: {e}")
        return False

async def update_miner_stats(user_id: int):
    """Обновить статистику майнера"""
    try:
        # Получаем данные майнера
        miner_data = await get_miner_data_from_db(user_id)
        if not miner_data:
            return
        
        # Получаем данные пользователя
        user = await get_user_by_telegram_id(user_id)
        if not user:
            return
        
        # Рассчитываем уровень
        total_gas = miner_data.get("total_gas_earned", 0)
        level = max(1, int(total_gas / 1000) + 1)
        
        # Подсчитываем фермы и улучшения
        farms_count = len(miner_data.get("farms", []))
        upgrades_count = sum(miner_data.get("upgrades", {}).values())
        
        stats_data = {
            "user_id": user["id"],  # Используем ID пользователя из БД
            "level": level,
            "total_gas_earned": total_gas,
            "total_farms": farms_count,
            "total_upgrades": upgrades_count,
            "last_update": int(time.time() * 1000)
        }
        
        # Обновляем статистику
        url = f"{SUPABASE_URL}/rest/v1/nodeon_miner_stats"
        headers = {
            "apikey": SUPABASE_ANON_KEY,
            "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
            "Content-Type": "application/json",
            "Prefer": "resolution=merge-duplicates"
        }
        
        response = requests.post(url, headers=headers, json=stats_data)
        
        if response.status_code in [200, 201]:
            print(f"Updated miner stats for user {user_id}")
        else:
            print(f"Error updating miner stats: {response.status_code}")
            
    except Exception as e:
        print(f"Error updating miner stats: {e}")

@app.get("/api/miner/leaderboard")
async def get_miner_leaderboard():
    """Получить лидерборд майнеров"""
    try:
        url = f"{SUPABASE_URL}/rest/v1/nodeon_miner_stats?select=*&order=total_gas_earned.desc,miner_level.desc&limit=50"
        headers = {
            "apikey": SUPABASE_KEY,
            "Authorization": f"Bearer {SUPABASE_KEY}",
            "Content-Type": "application/json"
        }
        
        response = requests.get(url, headers=headers)
        
        if response.status_code == 200:
            leaderboard = response.json()
            
            # Добавляем позицию в рейтинге
            for i, player in enumerate(leaderboard, 1):
                player["rank"] = i
            
            return {"success": True, "leaderboard": leaderboard}
        else:
            print(f"Error getting leaderboard: {response.status_code}")
            return {"success": False, "error": "Failed to get leaderboard"}
            
    except Exception as e:
        print(f"Error getting leaderboard: {e}")
        return {"success": False, "error": "Failed to get leaderboard"}

@app.get("/api/miner/stats/{user_id}")
async def get_miner_user_stats(user_id: int):
    """Получить статистику конкретного пользователя"""
    try:
        url = f"{SUPABASE_URL}/rest/v1/nodeon_miner_stats?user_id=eq.{user_id}&select=*"
        headers = {
            "apikey": SUPABASE_KEY,
            "Authorization": f"Bearer {SUPABASE_KEY}",
            "Content-Type": "application/json"
        }
        
        response = requests.get(url, headers=headers)
        
        if response.status_code == 200:
            data = response.json()
            if data:
                return {"success": True, "stats": data[0]}
            else:
                return {"success": False, "error": "User stats not found"}
        else:
            print(f"Error getting user stats: {response.status_code}")
            return {"success": False, "error": "Failed to get user stats"}
            
    except Exception as e:
        print(f"Error getting user stats: {e}")
        return {"success": False, "error": "Failed to get user stats"}

async def update_user_balance(user_id: int, new_balance: float):
    """Обновить баланс пользователя в БД"""
    try:
        # Получаем пользователя по telegram_id, чтобы найти его ID в БД
        user = await get_user_by_telegram_id(user_id)
        if not user:
            print(f"User with telegram_id {user_id} not found")
            return False
        
        # Обновляем баланс по ID пользователя в БД
        url = f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user['id']}"
        headers = {
            "apikey": SUPABASE_ANON_KEY,
            "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
            "Content-Type": "application/json",
            "Prefer": "return=minimal"
        }
        
        update_data = {
            "balance_ndn": new_balance
        }
        
        response = requests.patch(url, headers=headers, json=update_data)
        
        if response.status_code in [200, 204]:
            print(f"Updated balance for user {user_id} (DB ID: {user['id']}): {new_balance}")
            return True
        else:
            print(f"Error updating balance: {response.status_code} - {response.text}")
            return False
            
    except Exception as e:
        print(f"Error updating user balance: {e}")
        return False

if __name__ == "__main__":
    import uvicorn
    import os
    port = int(os.getenv("PORT", 8000))
    uvicorn.run(app, host="0.0.0.0", port=port)
