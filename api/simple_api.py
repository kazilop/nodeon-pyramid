from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
import uvicorn
import os

app = FastAPI(title="NodeOn Simple API", version="1.0.0")

# CORS настройки
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
async def root():
    return {"message": "NodeOn Simple API", "status": "running"}

@app.get("/test")
async def test_endpoint():
    return {"message": "Simple API is working", "status": "ok"}

@app.get("/api/user/profile")
async def get_user_profile(init_data: str = None):
    """Упрощенный профиль пользователя для тестирования"""
    try:
        # Возвращаем тестовые данные
        return {
            "user": {
                "id": 1,
                "telegram_id": 123456789,
                "username": "testuser",
                "first_name": "Тестовый",
                "last_name": "Пользователь",
                "balance_ndn": 1000.0,
                "is_pro": False,
                "referral_link": "",
                "created_at": "2024-01-01T00:00:00"
            },
            "referral_stats": {
                1: {"referrals": 0, "earnings": 0.0},
                2: {"referrals": 0, "earnings": 0.0},
                3: {"referrals": 0, "earnings": 0.0},
                4: {"referrals": 0, "earnings": 0.0},
                5: {"referrals": 0, "earnings": 0.0},
                6: {"referrals": 0, "earnings": 0.0},
                7: {"referrals": 0, "earnings": 0.0}
            }
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/api/pro/buy")
async def buy_pro_status(init_data: str = None):
    """Упрощенная покупка Pro статуса"""
    try:
        return {
            "success": True,
            "message": "Pro статус активирован!",
            "new_balance": 0.0,
            "referral_link": "https://t.me/pro_stars_bot?startapp=test_token"
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/api/ndn/buy")
async def buy_ndn(init_data: str = None, amount_ndn: float = 100.0):
    """Упрощенная покупка NDN"""
    try:
        return {
            "success": True,
            "message": "Запрос на покупку NDN создан",
            "payment_request_id": 1,
            "amount_ndn": amount_ndn,
            "amount_stars": amount_ndn * 0.1
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/api/ndn/withdraw")
async def withdraw_ndn(init_data: str = None, amount_ndn: float = 50.0):
    """Упрощенный вывод NDN"""
    try:
        return {
            "success": True,
            "message": "Запрос на вывод NDN создан",
            "payment_request_id": 1,
            "amount_ndn": amount_ndn,
            "amount_stars": amount_ndn * 0.1
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/api/stats/leaderboard")
async def get_leaderboard():
    """Упрощенный лидерборд"""
    try:
        return {
            "leaderboard": [
                {
                    "rank": 1,
                    "username": "TopUser1",
                    "first_name": "Топ",
                    "balance_ndn": 5000.0,
                    "is_pro": True
                },
                {
                    "rank": 2,
                    "username": "TopUser2",
                    "first_name": "Второй",
                    "balance_ndn": 3000.0,
                    "is_pro": True
                }
            ],
            "total_users": 2
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

if __name__ == "__main__":
    port = int(os.getenv("PORT", 8000))
    uvicorn.run(app, host="0.0.0.0", port=port)
