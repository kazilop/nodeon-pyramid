#!/usr/bin/env python3
"""
Простой тест подключения к Supabase
"""

import os
from sqlalchemy import create_engine, text
from dotenv import load_dotenv

# Загружаем переменные окружения
load_dotenv()

def test_connection():
    """Тест подключения к базе данных"""
    
    database_url = os.getenv("DATABASE_URL")
    
    if not database_url:
        print("❌ DATABASE_URL не найден в .env файле")
        return False
    
    print(f"🔗 Подключение к базе данных...")
    print(f"   URL: {database_url[:50]}...")
    
    try:
        # Создаем подключение
        engine = create_engine(database_url)
        
        # Тестируем подключение
        with engine.connect() as conn:
            result = conn.execute(text("SELECT 1 as test"))
            test_value = result.fetchone()[0]
            
            if test_value == 1:
                print("✅ Подключение к базе данных успешно!")
                return True
            else:
                print("❌ Неожиданный результат теста")
                return False
        
    except Exception as e:
        print(f"❌ Ошибка при подключении к базе данных: {e}")
        return False

def create_tables():
    """Создание таблиц в базе данных"""
    
    database_url = os.getenv("DATABASE_URL")
    
    if not database_url:
        print("❌ DATABASE_URL не найден в .env файле")
        return False
    
    try:
        engine = create_engine(database_url)
        
        # SQL для создания таблиц
        create_tables_sql = """
        -- Создание таблицы пользователей
        CREATE TABLE IF NOT EXISTS users (
            id SERIAL PRIMARY KEY,
            telegram_id INTEGER UNIQUE NOT NULL,
            username VARCHAR(255),
            first_name VARCHAR(255),
            last_name VARCHAR(255),
            balance_ndn DECIMAL(10,2) DEFAULT 0,
            is_pro BOOLEAN DEFAULT FALSE,
            referral_link VARCHAR(255) UNIQUE,
            inviter_id INTEGER REFERENCES users(id),
            created_at TIMESTAMP DEFAULT NOW(),
            updated_at TIMESTAMP DEFAULT NOW()
        );

        -- Создание таблицы транзакций
        CREATE TABLE IF NOT EXISTS transactions (
            id SERIAL PRIMARY KEY,
            user_id INTEGER NOT NULL REFERENCES users(id),
            type VARCHAR(50) NOT NULL,
            amount_ndn DECIMAL(10,2) NOT NULL,
            amount_stars DECIMAL(10,2),
            description TEXT,
            referral_level INTEGER,
            created_at TIMESTAMP DEFAULT NOW()
        );

        -- Создание таблицы статистики рефералов
        CREATE TABLE IF NOT EXISTS referral_stats (
            id SERIAL PRIMARY KEY,
            user_id INTEGER NOT NULL REFERENCES users(id),
            level INTEGER NOT NULL,
            total_referrals INTEGER DEFAULT 0,
            total_earnings DECIMAL(10,2) DEFAULT 0,
            updated_at TIMESTAMP DEFAULT NOW()
        );

        -- Создание таблицы заявок на вывод
        CREATE TABLE IF NOT EXISTS payment_requests (
            id SERIAL PRIMARY KEY,
            user_id INTEGER NOT NULL REFERENCES users(id),
            amount_ndn DECIMAL(10,2) NOT NULL,
            amount_stars DECIMAL(10,2) NOT NULL,
            status VARCHAR(20) DEFAULT 'pending',
            created_at TIMESTAMP DEFAULT NOW(),
            processed_at TIMESTAMP
        );
        """
        
        with engine.connect() as conn:
            conn.execute(text(create_tables_sql))
            conn.commit()
        
        print("✅ Таблицы созданы успешно!")
        return True
        
    except Exception as e:
        print(f"❌ Ошибка при создании таблиц: {e}")
        return False

def main():
    """Основная функция"""
    
    print("🚀 Тест подключения к Supabase...")
    print()
    
    # Тестируем подключение
    if test_connection():
        print()
        print("📊 Создание таблиц...")
        if create_tables():
            print()
            print("✅ База данных готова к использованию!")
            print("   Теперь можно развертывать приложение на Vercel")
        else:
            print()
            print("❌ Ошибка создания таблиц")
    else:
        print()
        print("❌ Ошибка подключения к базе данных")
        print("   Проверьте DATABASE_URL в .env файле")

if __name__ == "__main__":
    main()
