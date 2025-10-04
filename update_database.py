#!/usr/bin/env python3
"""
Скрипт для обновления базы данных NodeOn
Добавляет поля для NDN балансов и Telegram Stars
"""

import os
import sys
import asyncio
from sqlalchemy import create_engine, text
from dotenv import load_dotenv

# Загружаем переменные окружения
load_dotenv()

# Подключение к базе данных
DATABASE_URL = os.getenv('DATABASE_URL')
if not DATABASE_URL:
    print("❌ Ошибка: DATABASE_URL не найден в .env файле")
    sys.exit(1)

engine = create_engine(DATABASE_URL)

async def update_database():
    """Обновление базы данных для продакшн версии"""
    
    print("🚀 Обновление базы данных NodeOn...")
    
    try:
        with engine.connect() as conn:
            # Проверяем существование таблицы users
            result = conn.execute(text("""
                SELECT EXISTS (
                    SELECT FROM information_schema.tables 
                    WHERE table_name = 'nodeon_users'
                );
            """))
            
            if not result.scalar():
                print("❌ Таблица nodeon_users не найдена. Сначала создайте таблицы.")
                return False
            
            # Добавляем поля для NDN балансов
            print("📊 Добавление полей для NDN...")
            
            # Добавляем поле balance_ndn если его нет
            try:
                conn.execute(text("""
                    ALTER TABLE nodeon_users 
                    ADD COLUMN IF NOT EXISTS balance_ndn DECIMAL(15,2) DEFAULT 0.0;
                """))
                print("✅ Поле balance_ndn добавлено")
            except Exception as e:
                print(f"⚠️ Поле balance_ndn уже существует: {e}")
            
            # Добавляем поле total_earned_ndn
            try:
                conn.execute(text("""
                    ALTER TABLE nodeon_users 
                    ADD COLUMN IF NOT EXISTS total_earned_ndn DECIMAL(15,2) DEFAULT 0.0;
                """))
                print("✅ Поле total_earned_ndn добавлено")
            except Exception as e:
                print(f"⚠️ Поле total_earned_ndn уже существует: {e}")
            
            # Добавляем поле telegram_stars_balance
            try:
                conn.execute(text("""
                    ALTER TABLE nodeon_users 
                    ADD COLUMN IF NOT EXISTS telegram_stars_balance INTEGER DEFAULT 0;
                """))
                print("✅ Поле telegram_stars_balance добавлено")
            except Exception as e:
                print(f"⚠️ Поле telegram_stars_balance уже существует: {e}")
            
            # Добавляем поле last_activity
            try:
                conn.execute(text("""
                    ALTER TABLE nodeon_users 
                    ADD COLUMN IF NOT EXISTS last_activity TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
                """))
                print("✅ Поле last_activity добавлено")
            except Exception as e:
                print(f"⚠️ Поле last_activity уже существует: {e}")
            
            # Обновляем таблицу транзакций
            print("📈 Обновление таблицы транзакций...")
            
            # Добавляем поле stars_amount
            try:
                conn.execute(text("""
                    ALTER TABLE nodeon_transactions 
                    ADD COLUMN IF NOT EXISTS stars_amount INTEGER DEFAULT 0;
                """))
                print("✅ Поле stars_amount добавлено в транзакции")
            except Exception as e:
                print(f"⚠️ Поле stars_amount уже существует: {e}")
            
            # Добавляем поле transaction_hash
            try:
                conn.execute(text("""
                    ALTER TABLE nodeon_transactions 
                    ADD COLUMN IF NOT EXISTS transaction_hash VARCHAR(255);
                """))
                print("✅ Поле transaction_hash добавлено в транзакции")
            except Exception as e:
                print(f"⚠️ Поле transaction_hash уже существует: {e}")
            
            # Создаем таблицу для курсов обмена
            print("💱 Создание таблицы курсов обмена...")
            
            conn.execute(text("""
                CREATE TABLE IF NOT EXISTS nodeon_exchange_rates (
                    id SERIAL PRIMARY KEY,
                    from_currency VARCHAR(10) NOT NULL,
                    to_currency VARCHAR(10) NOT NULL,
                    rate DECIMAL(10,4) NOT NULL,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                );
            """))
            print("✅ Таблица nodeon_exchange_rates создана")
            
            # Добавляем базовые курсы обмена
            conn.execute(text("""
                INSERT INTO nodeon_exchange_rates (from_currency, to_currency, rate)
                VALUES ('stars', 'ndn', 1.0)
                ON CONFLICT DO NOTHING;
            """))
            print("✅ Базовые курсы обмена добавлены")
            
            # Создаем таблицу для платежных запросов
            print("💳 Создание таблицы платежных запросов...")
            
            conn.execute(text("""
                CREATE TABLE IF NOT EXISTS nodeon_payment_requests (
                    id SERIAL PRIMARY KEY,
                    user_id INTEGER REFERENCES nodeon_users(id),
                    amount_stars INTEGER NOT NULL,
                    amount_ndn DECIMAL(15,2) NOT NULL,
                    status VARCHAR(20) DEFAULT 'pending',
                    telegram_payment_id VARCHAR(255),
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    completed_at TIMESTAMP
                );
            """))
            print("✅ Таблица nodeon_payment_requests создана")
            
            # Создаем индексы для производительности
            print("🔍 Создание индексов...")
            
            try:
                conn.execute(text("""
                    CREATE INDEX IF NOT EXISTS idx_users_balance_ndn 
                    ON nodeon_users(balance_ndn);
                """))
                print("✅ Индекс для balance_ndn создан")
            except Exception as e:
                print(f"⚠️ Индекс уже существует: {e}")
            
            try:
                conn.execute(text("""
                    CREATE INDEX IF NOT EXISTS idx_transactions_stars 
                    ON nodeon_transactions(stars_amount);
                """))
                print("✅ Индекс для stars_amount создан")
            except Exception as e:
                print(f"⚠️ Индекс уже существует: {e}")
            
            # Подтверждаем изменения
            conn.commit()
            
            print("\n🎉 База данных успешно обновлена для продакшн версии!")
            print("📊 Добавлены поля:")
            print("   - balance_ndn (баланс NDN)")
            print("   - total_earned_ndn (всего заработано)")
            print("   - telegram_stars_balance (баланс Stars)")
            print("   - last_activity (последняя активность)")
            print("   - stars_amount (сумма в Stars)")
            print("   - transaction_hash (хэш транзакции)")
            print("   - Таблицы курсов обмена и платежных запросов")
            
            return True
            
    except Exception as e:
        print(f"❌ Ошибка при обновлении базы данных: {e}")
        return False

if __name__ == "__main__":
    asyncio.run(update_database())

