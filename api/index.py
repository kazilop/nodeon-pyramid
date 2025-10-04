from fastapi import FastAPI, HTTPException, Depends
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
import uvicorn
from contextlib import asynccontextmanager
import os

# Импорты из основного приложения
import sys
sys.path.append('..')

from backend.database import engine, Base
from backend.routers import auth, users, payments, referrals, stats
from backend.config import settings

# Создаем таблицы при запуске
@asynccontextmanager
async def lifespan(app: FastAPI):
    Base.metadata.create_all(bind=engine)
    yield

app = FastAPI(
    title="NodeOn Pyramid API",
    description="API для реферальной игры с монетами NDN",
    version="1.0.0",
    lifespan=lifespan
)

# CORS настройки
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Подключаем роутеры
app.include_router(auth.router, prefix="/api/auth", tags=["auth"])
app.include_router(users.router, prefix="/api/users", tags=["users"])
app.include_router(payments.router, prefix="/api/payments", tags=["payments"])
app.include_router(referrals.router, prefix="/api/referrals", tags=["referrals"])
app.include_router(stats.router, prefix="/api/stats", tags=["stats"])

# Подключаем NDN API
from ndn_api import app as ndn_app
app.mount("/ndn", ndn_app)

@app.get("/")
async def root():
    return {"message": "NodeOn Pyramid API", "version": "1.0.0"}

@app.get("/health")
async def health_check():
    return {"status": "healthy"}

@app.post("/webhook")
async def telegram_webhook(request: dict):
    """Webhook для Telegram бота"""
    try:
        # Здесь будет обработка webhook от Telegram
        # Пока просто возвращаем OK
        return {"status": "ok"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
