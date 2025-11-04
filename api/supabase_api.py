from fastapi import FastAPI, HTTPException, Depends
from fastapi.middleware.cors import CORSMiddleware
import requests
import json
import hmac
import hashlib
from datetime import datetime
from decimal import Decimal

app = FastAPI(title="NodeOn Supabase API", version="1.0.0")

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

def get_supabase_headers():
    """Получение заголовков для Supabase API"""
    return {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }

def verify_telegram_auth(init_data: str) -> dict:
    """Упрощенная верификация Telegram данных"""
    try:
        if not init_data or init_data == "test_data":
            # Для тестирования возвращаем тестовые данные
            return {
                "id": 123456789,
                "first_name": "Тестовый",
                "last_name": "Пользователь",
                "username": "testuser"
            }
        
        # Парсим данные
        data = {}
        for item in init_data.split('&'):
            if '=' in item:
                key, value = item.split('=', 1)
                data[key] = value
        
        # Парсим user данные
        user_data_str = data.get('user', '{}')
        if user_data_str:
            user_data = json.loads(user_data_str)
        else:
            user_data = {}
        
        return user_data
        
    except Exception as e:
        print(f"Telegram auth error: {e}")
        return {
            "id": 123456789,
            "first_name": "Пользователь",
            "last_name": "",
            "username": "user"
        }

def get_or_create_user(telegram_user: dict):
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
                return users[0]
        
        # Создаем нового пользователя
        user_data = {
            "telegram_id": telegram_id,
            "username": telegram_user.get('username') or None,
            "first_name": telegram_user.get('first_name') or 'Пользователь',
            "last_name": telegram_user.get('last_name') or '',
            "balance_ndn": 0.0,
            "is_pro": False,
            "referral_link": "",
            "inviter_id": None,
            "created_at": datetime.utcnow().isoformat(),
            "updated_at": datetime.utcnow().isoformat()
        }
        
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/nodeon_users",
            headers=headers,
            json=user_data
        )
        
        if response.status_code == 201:
            created_user = response.json()[0]
            
            # Создаем статистику рефералов
            for level in range(1, 8):
                stats_data = {
                    "user_id": created_user["id"],
                    "level": level,
                    "total_referrals": 0,
                    "total_earnings": 0.0,
                    "updated_at": datetime.utcnow().isoformat()
                }
                
                requests.post(
                    f"{SUPABASE_URL}/rest/v1/nodeon_referral_stats",
                    headers=headers,
                    json=stats_data
                )
            
            return created_user
        else:
            raise HTTPException(status_code=500, detail="Failed to create user")
            
    except Exception as e:
        print(f"Database error: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/")
async def root():
    return {"message": "NodeOn Supabase API", "status": "running"}

@app.get("/test")
async def test_endpoint():
    return {"message": "Supabase API is working", "status": "ok"}

@app.get("/api/user/profile")
async def get_user_profile(init_data: str = None):
    """Получить профиль пользователя"""
    try:
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        
        # Получаем статистику рефералов
        headers = get_supabase_headers()
        response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_referral_stats?user_id=eq.{user['id']}",
            headers=headers
        )
        
        stats_dict = {}
        if response.status_code == 200:
            stats = response.json()
            for stat in stats:
                stats_dict[stat['level']] = {
                    'referrals': stat['total_referrals'],
                    'earnings': float(stat['total_earnings'])
                }
        
        # Генерируем реферальную ссылку только для Pro пользователей
        referral_link = ""
        if user.get('is_pro') and user.get('referral_link'):
            referral_link = user['referral_link']
        
        return {
            "user": {
                "id": user["id"],
                "telegram_id": user["telegram_id"],
                "username": user["username"],
                "first_name": user["first_name"],
                "last_name": user["last_name"],
                "balance_ndn": float(user["balance_ndn"]),
                "is_pro": user["is_pro"],
                "referral_link": referral_link,
                "created_at": user["created_at"]
            },
            "referral_stats": stats_dict
        }
        
    except Exception as e:
        print(f"Error getting user profile: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/api/pro/buy")
async def buy_pro_status(init_data: str = None):
    """Покупка Pro статуса за 1000 NDN"""
    try:
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        
        pro_cost = 1000.0
        
        if user.get('is_pro'):
            raise HTTPException(status_code=400, detail="User already has Pro status")
        
        if user.get('balance_ndn', 0) < pro_cost:
            raise HTTPException(status_code=400, detail="Insufficient NDN balance")
        
        headers = get_supabase_headers()
        
        # Обновляем пользователя
        update_data = {
            "balance_ndn": user['balance_ndn'] - pro_cost,
            "is_pro": True,
            "referral_link": f"https://t.me/pro_stars_bot?startapp=ref_{user['id']}",
            "updated_at": datetime.utcnow().isoformat()
        }
        
        response = requests.patch(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user['id']}",
            headers=headers,
            json=update_data
        )
        
        if response.status_code != 200:
            raise HTTPException(status_code=500, detail="Failed to update user")
        
        # Создаем транзакцию
        transaction_data = {
            "user_id": user["id"],
            "type": "pro_purchase",
            "amount_ndn": pro_cost,
            "description": "Покупка Pro статуса",
            "created_at": datetime.utcnow().isoformat()
        }
        
        requests.post(
            f"{SUPABASE_URL}/rest/v1/nodeon_transactions",
            headers=headers,
            json=transaction_data
        )
        
        return {
            "success": True,
            "message": "Pro статус активирован!",
            "new_balance": float(update_data["balance_ndn"]),
            "referral_link": update_data["referral_link"]
        }
        
    except HTTPException:
        raise
    except Exception as e:
        print(f"Error buying Pro status: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/api/ndn/buy")
async def buy_ndn(init_data: str = None, amount_ndn: float = 100.0):
    """Покупка NDN"""
    try:
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        
        if amount_ndn <= 0:
            raise HTTPException(status_code=400, detail="Invalid amount")
        
        headers = get_supabase_headers()
        
        # Создаем запрос на покупку
        payment_data = {
            "user_id": user["id"],
            "amount_ndn": amount_ndn,
            "amount_stars": amount_ndn * 0.1,  # 1 NDN = 0.1 Stars
            "status": "pending",
            "created_at": datetime.utcnow().isoformat()
        }
        
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/nodeon_payment_requests",
            headers=headers,
            json=payment_data
        )
        
        if response.status_code == 201:
            payment = response.json()[0]
            return {
                "success": True,
                "message": "Запрос на покупку NDN создан",
                "payment_request_id": payment["id"],
                "amount_ndn": amount_ndn,
                "amount_stars": payment_data["amount_stars"]
            }
        else:
            raise HTTPException(status_code=500, detail="Failed to create payment request")
        
    except HTTPException:
        raise
    except Exception as e:
        print(f"Error buying NDN: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/api/ndn/withdraw")
async def withdraw_ndn(init_data: str = None, amount_ndn: float = 50.0):
    """Вывод NDN"""
    try:
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        
        if amount_ndn <= 0:
            raise HTTPException(status_code=400, detail="Invalid amount")
        
        if user.get('balance_ndn', 0) < amount_ndn:
            raise HTTPException(status_code=400, detail="Insufficient NDN balance")
        
        headers = get_supabase_headers()
        
        # Создаем запрос на вывод
        payment_data = {
            "user_id": user["id"],
            "amount_ndn": amount_ndn,
            "amount_stars": amount_ndn * 0.1,  # 1 NDN = 0.1 Stars
            "status": "pending",
            "created_at": datetime.utcnow().isoformat()
        }
        
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/nodeon_payment_requests",
            headers=headers,
            json=payment_data
        )
        
        if response.status_code == 201:
            payment = response.json()[0]
            return {
                "success": True,
                "message": "Запрос на вывод NDN создан",
                "payment_request_id": payment["id"],
                "amount_ndn": amount_ndn,
                "amount_stars": payment_data["amount_stars"]
            }
        else:
            raise HTTPException(status_code=500, detail="Failed to create withdrawal request")
        
    except HTTPException:
        raise
    except Exception as e:
        print(f"Error withdrawing NDN: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/api/stats/leaderboard")
async def get_leaderboard():
    """Получить таблицу лидеров"""
    try:
        headers = get_supabase_headers()
        
        response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?balance_ndn=gt.0&order=balance_ndn.desc&limit=10",
            headers=headers
        )
        
        if response.status_code == 200:
            users = response.json()
            leaderboard = []
            
            for i, user in enumerate(users, 1):
                leaderboard.append({
                    "rank": i,
                    "username": user.get("username") or f"User{user['telegram_id']}",
                    "first_name": user.get("first_name"),
                    "balance_ndn": float(user.get("balance_ndn", 0)),
                    "is_pro": user.get("is_pro", False)
                })
            
            return {
                "leaderboard": leaderboard,
                "total_users": len(users)
            }
        else:
            raise HTTPException(status_code=500, detail="Failed to get leaderboard")
        
    except Exception as e:
        print(f"Error getting leaderboard: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/api/stats/transactions")
async def get_user_transactions(init_data: str = None, limit: int = 20):
    """Получить транзакции пользователя"""
    try:
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        
        headers = get_supabase_headers()
        
        response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_transactions?user_id=eq.{user['id']}&order=created_at.desc&limit={limit}",
            headers=headers
        )
        
        if response.status_code == 200:
            transactions = response.json()
            transaction_list = []
            
            for tx in transactions:
                transaction_list.append({
                    "id": tx["id"],
                    "type": tx["type"],
                    "amount_ndn": float(tx["amount_ndn"]),
                    "amount_stars": float(tx["amount_stars"]) if tx.get("amount_stars") else None,
                    "description": tx.get("description"),
                    "referral_level": tx.get("referral_level"),
                    "created_at": tx["created_at"]
                })
            
            return {
                "transactions": transaction_list,
                "total": len(transaction_list)
            }
        else:
            raise HTTPException(status_code=500, detail="Failed to get transactions")
        
    except Exception as e:
        print(f"Error getting transactions: {e}")
        raise HTTPException(status_code=500, detail=str(e))

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
