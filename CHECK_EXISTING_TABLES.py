#!/usr/bin/env python3
"""
Проверка существующих таблиц в Supabase
"""

import requests
import json

# Настройки Supabase
SUPABASE_URL = "https://ahxwpzgltlzlvrtrbanm.supabase.co"
SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoeHdwemdsdGx6bHZydHJiYW5tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1MDMxNDksImV4cCI6MjA3NTA3OTE0OX0.h4sMVhVwvRUiHgbevDgv9W1G2S__uDWPUSCiXdrEy4E"

def get_supabase_headers():
    return {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }

def check_tables():
    """Проверяет существующие таблицы"""
    tables_to_check = [
        "nodeon_users",
        "nodeon_transactions", 
        "nodeon_referral_stats",
        "nodeon_server_wallet",
        "nodeon_sales"
    ]
    
    print("🔍 Проверка существующих таблиц...")
    print("=" * 50)
    
    for table in tables_to_check:
        try:
            response = requests.get(
                f"{SUPABASE_URL}/rest/v1/{table}?select=*&limit=1",
                headers=get_supabase_headers()
            )
            
            if response.status_code == 200:
                print(f"✅ {table} - существует")
            elif response.status_code == 404:
                print(f"❌ {table} - не существует")
            else:
                print(f"⚠️ {table} - ошибка {response.status_code}")
                
        except Exception as e:
            print(f"❌ {table} - ошибка: {e}")

def check_users_table_structure():
    """Проверяет структуру таблицы пользователей"""
    print("\n👥 Структура таблицы пользователей:")
    print("-" * 40)
    
    try:
        response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?select=*&limit=1",
            headers=get_supabase_headers()
        )
        
        if response.status_code == 200:
            users = response.json()
            if users:
                user = users[0]
                print("Доступные поля:")
                for key, value in user.items():
                    print(f"  - {key}: {type(value).__name__}")
            else:
                print("Таблица пуста")
        else:
            print(f"Ошибка: {response.status_code}")
            
    except Exception as e:
        print(f"Ошибка: {e}")

if __name__ == "__main__":
    check_tables()
    check_users_table_structure()


