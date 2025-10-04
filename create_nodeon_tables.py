#!/usr/bin/env python3
"""
Создание таблиц для NodeOn Pyramid в Supabase
"""

import os
from sqlalchemy import create_engine, text
from dotenv import load_dotenv

# Загружаем переменные окружения
load_dotenv()

def create_tables():
    """Создание таблиц для NodeOn Pyramid"""
    
    database_url = os.getenv("DATABASE_URL")
    
    if not database_url:
        print("❌ DATABASE_URL не найден в .env файле")
        return False
    
    try:
        engine = create_engine(database_url)
        
        # SQL для создания таблиц с префиксом nodeon_
        create_tables_sql = """
        -- Создание таблицы пользователей NodeOn
        CREATE TABLE IF NOT EXISTS nodeon_users (
            id SERIAL PRIMARY KEY,
            telegram_id INTEGER UNIQUE NOT NULL,
            username VARCHAR(255),
            first_name VARCHAR(255),
            last_name VARCHAR(255),
            balance_ndn DECIMAL(10,2) DEFAULT 0,
            is_pro BOOLEAN DEFAULT FALSE,
            referral_link VARCHAR(255) UNIQUE,
            inviter_id INTEGER REFERENCES nodeon_users(id),
            created_at TIMESTAMP DEFAULT NOW(),
            updated_at TIMESTAMP DEFAULT NOW()
        );

        -- Создание таблицы транзакций NodeOn
        CREATE TABLE IF NOT EXISTS nodeon_transactions (
            id SERIAL PRIMARY KEY,
            user_id INTEGER NOT NULL REFERENCES nodeon_users(id),
            type VARCHAR(50) NOT NULL,
            amount_ndn DECIMAL(10,2) NOT NULL,
            amount_stars DECIMAL(10,2),
            description TEXT,
            referral_level INTEGER,
            created_at TIMESTAMP DEFAULT NOW()
        );

        -- Создание таблицы статистики рефералов NodeOn
        CREATE TABLE IF NOT EXISTS nodeon_referral_stats (
            id SERIAL PRIMARY KEY,
            user_id INTEGER NOT NULL REFERENCES nodeon_users(id),
            level INTEGER NOT NULL,
            total_referrals INTEGER DEFAULT 0,
            total_earnings DECIMAL(10,2) DEFAULT 0,
            updated_at TIMESTAMP DEFAULT NOW()
        );

        -- Создание таблицы заявок на вывод NodeOn
        CREATE TABLE IF NOT EXISTS nodeon_payment_requests (
            id SERIAL PRIMARY KEY,
            user_id INTEGER NOT NULL REFERENCES nodeon_users(id),
            amount_ndn DECIMAL(10,2) NOT NULL,
            amount_stars DECIMAL(10,2) NOT NULL,
            status VARCHAR(20) DEFAULT 'pending',
            created_at TIMESTAMP DEFAULT NOW(),
            processed_at TIMESTAMP
        );

        -- Создание индексов для производительности
        CREATE INDEX IF NOT EXISTS idx_nodeon_users_telegram_id ON nodeon_users(telegram_id);
        CREATE INDEX IF NOT EXISTS idx_nodeon_users_referral_link ON nodeon_users(referral_link);
        CREATE INDEX IF NOT EXISTS idx_nodeon_users_inviter_id ON nodeon_users(inviter_id);
        CREATE INDEX IF NOT EXISTS idx_nodeon_transactions_user_id ON nodeon_transactions(user_id);
        CREATE INDEX IF NOT EXISTS idx_nodeon_transactions_created_at ON nodeon_transactions(created_at);
        CREATE INDEX IF NOT EXISTS idx_nodeon_transactions_type ON nodeon_transactions(type);
        CREATE INDEX IF NOT EXISTS idx_nodeon_referral_stats_user_id ON nodeon_referral_stats(user_id);
        CREATE INDEX IF NOT EXISTS idx_nodeon_referral_stats_level ON nodeon_referral_stats(level);
        CREATE INDEX IF NOT EXISTS idx_nodeon_payment_requests_user_id ON nodeon_payment_requests(user_id);
        CREATE INDEX IF NOT EXISTS idx_nodeon_payment_requests_status ON nodeon_payment_requests(status);
        """
        
        with engine.connect() as conn:
            conn.execute(text(create_tables_sql))
            conn.commit()
        
        print("✅ Таблицы NodeOn созданы успешно!")
        
        # Проверяем созданные таблицы
        result = conn.execute(text("""
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public' 
            AND table_name LIKE 'nodeon_%'
            ORDER BY table_name
        """))
        
        tables = [row[0] for row in result]
        print(f"📋 Созданные таблицы: {', '.join(tables)}")
        
        return True
        
    except Exception as e:
        print(f"❌ Ошибка при создании таблиц: {e}")
        return False

def main():
    """Основная функция"""
    
    print("🚀 Создание таблиц NodeOn Pyramid в Supabase...")
    print()
    
    if create_tables():
        print()
        print("✅ База данных NodeOn готова к использованию!")
        print("   Теперь можно развертывать приложение на Vercel")
    else:
        print()
        print("❌ Ошибка создания таблиц")

if __name__ == "__main__":
    main()
