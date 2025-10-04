from pydantic_settings import BaseSettings
from typing import Optional

class Settings(BaseSettings):
    # Database
    database_url: str = "postgresql://postgres.nodeon:G-Gje9!Jr4B9-$C@ahxwpzgltlzlvrtrbanm.supabase.co:5432/postgres"
    supabase_url: str = "https://ahxwpzgltlzlvrtrbanm.supabase.co"
    supabase_anon_key: str = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoeHdwemdsdGx6bHZydHJiYW5tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1MDMxNDksImV4cCI6MjA3NTA3OTE0OX0.h4sMVhVwvRUiHgbevDgv9W1G2S__uDWPUSCiXdrEy4E"
    
    # Redis
    redis_url: str = "redis://redis:6379"
    
    # Telegram
    telegram_bot_token: str
    telegram_bot_username: str
    telegram_webhook_url: Optional[str] = None
    
    # Security
    secret_key: str
    
    # Developer
    developer_telegram_id: int
    
    # App
    app_name: str = "NodeOn Pyramid"
    app_description: str = "Реферальная игра с монетами NDN"
    
    # Referral system
    referral_levels: int = 7
    referral_rewards: list[int] = [200, 150, 150, 150, 150, 150, 150]  # Награды по уровням
    pro_cost: int = 1000  # Стоимость Pro статуса в NDN
    developer_fee: int = 200  # Комиссия разработчика
    
    class Config:
        env_file = ".env"

settings = Settings()
