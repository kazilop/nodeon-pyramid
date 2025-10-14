#!/usr/bin/env python3
"""
Простая проверка существующих таблиц в Supabase
"""

import os
from supabase import create_client, Client

# Загружаем переменные окружения
SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_ANON_KEY = os.getenv("SUPABASE_ANON_KEY")

if not SUPABASE_URL or not SUPABASE_ANON_KEY:
    print("Ошибка: SUPABASE_URL и SUPABASE_ANON_KEY должны быть установлены")
    exit(1)

# Создаем клиент Supabase
supabase: Client = create_client(SUPABASE_URL, SUPABASE_ANON_KEY)

def check_tables():
    """Проверяем существующие таблицы"""
    try:
        print("Проверяем существующие таблицы...")
        
        # Проверяем основные таблицы
        tables_to_check = [
            "nodeon_users",
            "nodeon_transactions", 
            "nodeon_referral_stats",
            "nodeon_miner_data",
            "nodeon_miner_stats",
            "nodeon_miner_farms",
            "nodeon_miner_upgrades",
            "nodeon_miner_transactions"
        ]
        
        existing_tables = []
        missing_tables = []
        
        for table in tables_to_check:
            try:
                # Пробуем сделать простой запрос к таблице
                response = supabase.table(table).select("*").limit(1).execute()
                existing_tables.append(table)
                print(f"OK Таблица {table} существует")
            except Exception as e:
                if "Could not find the table" in str(e):
                    missing_tables.append(table)
                    print(f"NO Таблица {table} не существует")
                else:
                    print(f"? Таблица {table} - ошибка: {e}")
        
        print(f"\nИтого:")
        print(f"Существующие таблицы: {len(existing_tables)}")
        print(f"Отсутствующие таблицы: {len(missing_tables)}")
        
        if missing_tables:
            print(f"\nОтсутствующие таблицы: {', '.join(missing_tables)}")
        
        return existing_tables, missing_tables
        
    except Exception as e:
        print(f"Ошибка при проверке таблиц: {e}")
        return [], []

if __name__ == "__main__":
    check_tables()
