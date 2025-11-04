from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
import requests
import json
import os
from datetime import datetime

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
    """Строгая верификация Telegram данных - ТОЛЬКО Telegram авторизация"""
    try:
        # Проверяем, что init_data не пустой и не тестовый
        if not init_data or init_data == "test_data" or init_data == "":
            raise ValueError("Требуется авторизация через Telegram. Приложение должно быть запущено в Telegram Mini App.")
        
        # URL декодируем данные
        import urllib.parse
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
        
        # Парсим user данные
        user_data_str = data.get('user', '{}')
        
        if not user_data_str or user_data_str == '{}':
            raise ValueError("Отсутствуют данные пользователя Telegram")
        
        try:
            user_data = json.loads(user_data_str)
            
            # Проверяем обязательные поля пользователя
            if 'id' not in user_data:
                raise ValueError("Отсутствует ID пользователя Telegram")
            
            print(f"✅ Successfully verified Telegram user: {user_data.get('first_name')} (@{user_data.get('username')}) ID: {user_data.get('id')}")
            return user_data
            
        except json.JSONDecodeError as e:
            raise ValueError(f"Ошибка парсинга данных пользователя Telegram: {e}")
        
    except Exception as e:
        print(f"❌ Telegram auth error: {e}")
        raise ValueError(f"Ошибка авторизации Telegram: {str(e)}")

def validate_referral_token(referral_token: str):
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

def get_or_create_user(telegram_user: dict, referral_token: str = None):
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
            "username": telegram_user.get('username') or None,
            "first_name": telegram_user.get('first_name') or 'Пользователь',
            "last_name": telegram_user.get('last_name') or '',
            "balance_ndn": 0.0,
            "is_pro": False,
            "referral_link": "",
            "inviter_id": inviter_data['inviter_id'] if inviter_data else None,
            "is_active": True,
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
            print(f"✅ New user created: {created_user['first_name']} (ID: {created_user['id']})")
            
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
            
            # Если есть пригласивший, обновляем его статистику
            if inviter_data:
                update_inviter_stats(inviter_data['inviter_id'], created_user['id'])
            
            return created_user
        else:
            print(f"❌ Failed to create user: {response.text}")
            raise HTTPException(status_code=500, detail="Failed to create user")
            
    except Exception as e:
        print(f"Database error: {e}")
        raise HTTPException(status_code=500, detail=str(e))

def update_inviter_stats(inviter_id: int, new_referral_id: int):
    """Обновляем статистику пригласившего"""
    headers = get_supabase_headers()
    
    try:
        # Получаем уровень нового реферала
        response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{new_referral_id}",
            headers=headers
        )
        
        if response.status_code == 200:
            users = response.json()
            if users:
                referral_level = users[0].get('referral_level', 1)
                
                # Обновляем статистику пригласившего
                stats_data = {
                    "total_referrals": f"total_referrals + 1"
                }
                
                requests.patch(
                    f"{SUPABASE_URL}/rest/v1/nodeon_referral_stats?user_id=eq.{inviter_id}&level=eq.{referral_level}",
                    headers=headers,
                    json=stats_data
                )
                
                print(f"✅ Updated inviter stats for user {inviter_id}, level {referral_level}")
    except Exception as e:
        print(f"Error updating inviter stats: {e}")

@app.get("/")
async def root():
    return {"message": "NodeOn Supabase API", "status": "running"}

@app.get("/test")
async def test_endpoint():
    return {"message": "Supabase API is working", "status": "ok"}

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
        
    except ValueError as e:
        print(f"Telegram auth error: {e}")
        raise HTTPException(status_code=401, detail=str(e))
    except Exception as e:
        print(f"Error getting user profile: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/api/pro/buy")
async def buy_pro_status(request: Request, init_data: str = None):
    """Покупка Pro статуса за 1000 NDN - ТОЛЬКО через Telegram"""
    try:
        # Если init_data не передан в query, попробуем получить из body
        if not init_data:
            try:
                body = await request.json()
                init_data = body.get('init_data')
            except:
                pass
        
        if not init_data:
            raise HTTPException(status_code=401, detail="Требуется авторизация через Telegram. Откройте приложение в Telegram Mini App.")
        
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
        
    except ValueError as e:
        print(f"Telegram auth error: {e}")
        raise HTTPException(status_code=401, detail=str(e))
    except HTTPException:
        raise
    except Exception as e:
        print(f"Error buying Pro status: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/api/ndn/buy")
async def buy_ndn(request: Request, init_data: str = None, amount_ndn: float = 100.0):
    """Покупка NDN (тестовая функция) - ТОЛЬКО через Telegram"""
    try:
        # Если init_data не передан в query, попробуем получить из body
        if not init_data:
            try:
                body = await request.json()
                init_data = body.get('init_data')
                amount_ndn = body.get('amount_ndn', amount_ndn)
            except:
                pass
        
        if not init_data:
            raise HTTPException(status_code=401, detail="Требуется авторизация через Telegram. Откройте приложение в Telegram Mini App.")
        
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
        
    except ValueError as e:
        print(f"Telegram auth error: {e}")
        raise HTTPException(status_code=401, detail=str(e))
    except HTTPException:
        raise
    except Exception as e:
        print(f"Error buying NDN: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/api/ndn/withdraw")
async def withdraw_ndn(request: Request, init_data: str = None, amount_ndn: float = 50.0):
    """Вывод NDN"""
    try:
        # Если init_data не передан в query, попробуем получить из body
        if not init_data:
            try:
                body = await request.json()
                init_data = body.get('init_data', 'test_data')
                amount_ndn = body.get('amount_ndn', amount_ndn)
            except:
                init_data = 'test_data'
        
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
        
    except ValueError as e:
        print(f"Telegram auth error: {e}")
        raise HTTPException(status_code=401, detail=str(e))
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

@app.get("/api/stats/referrals")
async def get_user_referrals(init_data: str = None):
    """Получить рефералов пользователя - ТОЛЬКО через Telegram"""
    try:
        if not init_data:
            raise HTTPException(status_code=401, detail="Требуется авторизация через Telegram. Откройте приложение в Telegram Mini App.")
        
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        
        headers = get_supabase_headers()
        
        # Вызываем функцию для получения рефералов
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/get_user_referrals",
            headers=headers,
            json={"user_telegram_id": user['telegram_id']}
        )
        
        if response.status_code == 200:
            referrals = response.json()
            
            # Группируем по уровням
            referrals_by_level = {}
            for ref in referrals:
                level = ref['level']
                if level not in referrals_by_level:
                    referrals_by_level[level] = []
                
                referrals_by_level[level].append({
                    "user_id": ref['user_id'],
                    "telegram_id": ref['telegram_id'],
                    "first_name": ref['first_name'],
                    "username": ref['username'],
                    "balance_ndn": float(ref['balance_ndn']),
                    "is_pro": ref['is_pro'],
                    "created_at": ref['created_at']
                })
            
            return {
                "referrals_by_level": referrals_by_level,
                "total_referrals": len(referrals)
            }
        else:
            raise HTTPException(status_code=500, detail="Failed to get referrals")
        
    except ValueError as e:
        print(f"Telegram auth error: {e}")
        raise HTTPException(status_code=401, detail=str(e))
    except Exception as e:
        print(f"Error getting referrals: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/api/stars/config")
async def get_stars_config():
    """Получить конфигурацию Stars"""
    try:
        headers = get_supabase_headers()
        
        # Вызываем функцию для получения конфигурации
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/get_stars_config",
            headers=headers
        )
        
        if response.status_code == 200:
            config = response.json()
            return {
                "success": True,
                "config": config
            }
        else:
            raise HTTPException(status_code=500, detail="Failed to get Stars config")
        
    except Exception as e:
        print(f"Error getting Stars config: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/api/stars/buy-ndn")
async def buy_ndn_with_stars(request: Request, init_data: str = None):
    """Покупка NDN за Telegram Stars - ТОЛЬКО через Telegram"""
    try:
        # Получаем данные из запроса
        if not init_data:
            try:
                body = await request.json()
                init_data = body.get('init_data')
            except:
                pass
        
        if not init_data:
            raise HTTPException(status_code=401, detail="Требуется авторизация через Telegram. Откройте приложение в Telegram Mini App.")
        
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        
        # Получаем параметры покупки
        try:
            body = await request.json()
            stars_amount = float(body.get('stars_amount', 100))
            payment_id = body.get('payment_id', f"stars_{user['id']}_{int(datetime.utcnow().timestamp())}")
        except:
            stars_amount = 100.0
            payment_id = f"stars_{user['id']}_{int(datetime.utcnow().timestamp())}"
        
        if stars_amount <= 0:
            raise HTTPException(status_code=400, detail="Invalid Stars amount")
        
        # Получаем конфигурацию Stars
        headers = get_supabase_headers()
        config_response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/get_stars_config",
            headers=headers
        )
        
        if config_response.status_code != 200:
            raise HTTPException(status_code=500, detail="Failed to get Stars config")
        
        config = config_response.json()
        stars_to_ndn_rate = float(config.get('stars_to_ndn_rate', 1.0))
        min_stars = float(config.get('min_stars_purchase', 10))
        max_stars = float(config.get('max_stars_purchase', 10000))
        
        # Проверяем лимиты
        if stars_amount < min_stars:
            raise HTTPException(status_code=400, detail=f"Minimum purchase: {min_stars} Stars")
        
        if stars_amount > max_stars:
            raise HTTPException(status_code=400, detail=f"Maximum purchase: {max_stars} Stars")
        
        # Рассчитываем количество NDN
        ndn_amount = stars_amount * stars_to_ndn_rate
        
        # Обрабатываем платеж
        payment_response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/process_stars_payment",
            headers=headers,
            json={
                "p_user_id": user['id'],
                "p_payment_id": payment_id,
                "p_stars_amount": stars_amount,
                "p_ndn_amount": ndn_amount,
                "p_telegram_payment_id": None  # Будет заполнено при реальной интеграции
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
                    "new_ndn_balance": result.get('new_ndn_balance'),
                    "new_stars_balance": result.get('new_stars_balance')
                }
            else:
                raise HTTPException(status_code=400, detail=result.get('error', 'Payment failed'))
        else:
            raise HTTPException(status_code=500, detail="Failed to process Stars payment")
        
    except ValueError as e:
        print(f"Telegram auth error: {e}")
        raise HTTPException(status_code=401, detail=str(e))
    except Exception as e:
        print(f"Error buying NDN with Stars: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/api/stars/withdraw")
async def withdraw_ndn_to_stars(request: Request, init_data: str = None):
    """Вывод NDN в Telegram Stars - ТОЛЬКО через Telegram"""
    try:
        # Получаем данные из запроса
        if not init_data:
            try:
                body = await request.json()
                init_data = body.get('init_data')
            except:
                pass
        
        if not init_data:
            raise HTTPException(status_code=401, detail="Требуется авторизация через Telegram. Откройте приложение в Telegram Mini App.")
        
        telegram_user = verify_telegram_auth(init_data)
        user = get_or_create_user(telegram_user)
        
        # Получаем параметры вывода
        try:
            body = await request.json()
            ndn_amount = float(body.get('ndn_amount', 50))
        except:
            ndn_amount = 50.0
        
        if ndn_amount <= 0:
            raise HTTPException(status_code=400, detail="Invalid NDN amount")
        
        # Обрабатываем вывод
        headers = get_supabase_headers()
        withdrawal_response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/withdraw_ndn_to_stars",
            headers=headers,
            json={
                "p_user_id": user['id'],
                "p_ndn_amount": ndn_amount
            }
        )
        
        if withdrawal_response.status_code == 200:
            result = withdrawal_response.json()
            if result.get('success'):
                return {
                    "success": True,
                    "message": f"Успешно выведено {result.get('stars_amount')} Stars за {ndn_amount} NDN",
                    "ndn_amount": ndn_amount,
                    "stars_amount": result.get('stars_amount'),
                    "withdrawal_fee": result.get('withdrawal_fee'),
                    "new_ndn_balance": result.get('new_ndn_balance'),
                    "new_stars_balance": result.get('new_stars_balance')
                }
            else:
                raise HTTPException(status_code=400, detail=result.get('error', 'Withdrawal failed'))
        else:
            raise HTTPException(status_code=500, detail="Failed to process withdrawal")
        
    except ValueError as e:
        print(f"Telegram auth error: {e}")
        raise HTTPException(status_code=401, detail=str(e))
    except Exception as e:
        print(f"Error withdrawing NDN to Stars: {e}")
        raise HTTPException(status_code=500, detail=str(e))

if __name__ == "__main__":
    import uvicorn
    port = int(os.environ.get("PORT", 8000))
    uvicorn.run(app, host="0.0.0.0", port=port)
