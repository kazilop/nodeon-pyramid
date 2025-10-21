#!/usr/bin/env python3
"""
Скрипт для настройки базы данных Supabase
Запускать после деплоя на Railway
"""

import os
import requests
import json
from dotenv import load_dotenv

# Загружаем переменные окружения
load_dotenv()

SUPABASE_URL = os.getenv('SUPABASE_URL')
SUPABASE_ANON_KEY = os.getenv('SUPABASE_ANON_KEY')

def create_tables():
    """Создание таблиц в Supabase"""
    
    if not SUPABASE_URL or not SUPABASE_ANON_KEY:
        print("❌ SUPABASE_URL и SUPABASE_ANON_KEY должны быть установлены")
        return False
    
    headers = {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }
    
    # SQL для создания таблиц
    sql_commands = [
        # Таблица пользователей
        """
        CREATE TABLE IF NOT EXISTS nodeon_users (
            id SERIAL PRIMARY KEY,
            telegram_id BIGINT UNIQUE NOT NULL,
            username VARCHAR(255),
            first_name VARCHAR(255),
            last_name VARCHAR(255),
            balance_ndn DECIMAL(15,2) DEFAULT 0.0,
            balance_stars DECIMAL(15,2) DEFAULT 0.0,
            is_pro BOOLEAN DEFAULT FALSE,
            referral_link VARCHAR(255) UNIQUE,
            inviter_id INTEGER REFERENCES nodeon_users(id),
            created_at TIMESTAMP DEFAULT NOW(),
            updated_at TIMESTAMP DEFAULT NOW()
        );
        """,
        
        # Таблица транзакций
        """
        CREATE TABLE IF NOT EXISTS nodeon_transactions (
            id SERIAL PRIMARY KEY,
            user_id INTEGER REFERENCES nodeon_users(id),
            type VARCHAR(50) NOT NULL,
            amount_ndn DECIMAL(15,2) DEFAULT 0.0,
            amount_stars DECIMAL(15,2) DEFAULT 0.0,
            description TEXT,
            referral_level INTEGER,
            created_at TIMESTAMP DEFAULT NOW()
        );
        """,
        
        # Таблица статистики рефералов
        """
        CREATE TABLE IF NOT EXISTS nodeon_referral_stats (
            id SERIAL PRIMARY KEY,
            user_id INTEGER REFERENCES nodeon_users(id),
            level INTEGER NOT NULL,
            total_referrals INTEGER DEFAULT 0,
            total_earnings DECIMAL(15,2) DEFAULT 0.0,
            created_at TIMESTAMP DEFAULT NOW(),
            updated_at TIMESTAMP DEFAULT NOW()
        );
        """,
        
        # Таблица данных майнера
        """
        CREATE TABLE IF NOT EXISTS nodeon_miner_data (
            id SERIAL PRIMARY KEY,
            user_id INTEGER REFERENCES nodeon_users(id),
            miner_data JSONB NOT NULL,
            created_at TIMESTAMP DEFAULT NOW(),
            updated_at TIMESTAMP DEFAULT NOW()
        );
        """,
        
        # Таблица статистики майнера
        """
        CREATE TABLE IF NOT EXISTS nodeon_miner_stats (
            id SERIAL PRIMARY KEY,
            user_id INTEGER REFERENCES nodeon_users(id),
            total_gas_earned DECIMAL(15,2) DEFAULT 0.0,
            total_farms INTEGER DEFAULT 0,
            total_upgrades INTEGER DEFAULT 0,
            level INTEGER DEFAULT 1,
            created_at TIMESTAMP DEFAULT NOW(),
            updated_at TIMESTAMP DEFAULT NOW()
        );
        """,
        
        # Таблица достижений
        """
        CREATE TABLE IF NOT EXISTS nodeon_achievements (
            id SERIAL PRIMARY KEY,
            user_id INTEGER REFERENCES nodeon_users(id),
            achievement_id VARCHAR(100) NOT NULL,
            unlocked_at TIMESTAMP DEFAULT NOW(),
            UNIQUE(user_id, achievement_id)
        );
        """,
        
        # Таблица магазинов
        """
        CREATE TABLE IF NOT EXISTS nodeon_shops (
            id SERIAL PRIMARY KEY,
            user_id INTEGER REFERENCES nodeon_users(id),
            shop_data JSONB NOT NULL,
            created_at TIMESTAMP DEFAULT NOW(),
            updated_at TIMESTAMP DEFAULT NOW()
        );
        """
    ]
    
    print("🔧 Создание таблиц в Supabase...")
    
    for i, sql in enumerate(sql_commands, 1):
        try:
            # Выполняем SQL через REST API
            url = f"{SUPABASE_URL}/rest/v1/rpc/exec_sql"
            data = {"sql": sql}
            
            response = requests.post(url, headers=headers, json=data)
            
            if response.status_code in [200, 201]:
                print(f"✅ Таблица {i} создана успешно")
            else:
                print(f"⚠️ Таблица {i}: {response.status_code} - {response.text}")
                
        except Exception as e:
            print(f"❌ Ошибка создания таблицы {i}: {e}")
    
    print("🎉 Настройка базы данных завершена!")

def create_developer_user():
    """Создание аккаунта разработчика"""
    
    developer_id = os.getenv('DEVELOPER_TELEGRAM_ID')
    if not developer_id:
        print("⚠️ DEVELOPER_TELEGRAM_ID не установлен, пропускаем создание аккаунта разработчика")
        return
    
    headers = {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }
    
    # Данные разработчика
    developer_data = {
        "telegram_id": int(developer_id),
        "username": "developer",
        "first_name": "Developer",
        "balance_ndn": 1000000.0,  # 1 миллион NDN для разработчика
        "balance_stars": 10000.0,  # 10 тысяч Stars
        "is_pro": True,
        "referral_link": "developer"
    }
    
    try:
        url = f"{SUPABASE_URL}/rest/v1/nodeon_users"
        response = requests.post(url, headers=headers, json=developer_data)
        
        if response.status_code in [200, 201]:
            print(f"✅ Аккаунт разработчика создан: {developer_id}")
        else:
            print(f"⚠️ Аккаунт разработчика: {response.status_code} - {response.text}")
            
    except Exception as e:
        print(f"❌ Ошибка создания аккаунта разработчика: {e}")

if __name__ == "__main__":
    print("🚀 Настройка базы данных NodeOn Pyramid")
    print("=" * 50)
    
    create_tables()
    create_developer_user()
    
    print("=" * 50)
    print("✅ Настройка завершена!")
    print("📝 Не забудьте:")
    print("   1. Настроить Telegram Bot")
    print("   2. Обновить webhook URL")
    print("   3. Проверить работу API")
