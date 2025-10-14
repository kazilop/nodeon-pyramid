#!/usr/bin/env python3
"""
Проверка структуры таблицы серверного кошелька
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

def check_wallet_structure():
    """Проверяет структуру таблицы кошелька"""
    print("🏦 Структура таблицы серверного кошелька:")
    print("-" * 50)
    
    try:
        response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_server_wallet?select=*&limit=1",
            headers=get_supabase_headers()
        )
        
        if response.status_code == 200:
            wallets = response.json()
            if wallets:
                wallet = wallets[0]
                print("Доступные поля:")
                for key, value in wallet.items():
                    print(f"  - {key}: {type(value).__name__} = {value}")
            else:
                print("Таблица пуста")
        else:
            print(f"Ошибка: {response.status_code} - {response.text}")
            
    except Exception as e:
        print(f"Ошибка: {e}")

def create_wallet_entry():
    """Создает запись кошелька"""
    print("\n💰 Создание записи кошелька...")
    
    wallet_data = {
        "wallet_name": "NodeOn Server Wallet",
        "balance_ndn": 1000000000.00,
        "total_sold_ndn": 0.00,
        "total_earned_stars": 0.00
    }
    
    try:
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/nodeon_server_wallet",
            headers=get_supabase_headers(),
            json=wallet_data
        )
        
        if response.status_code == 201:
            print("✅ Запись кошелька создана!")
            return True
        else:
            print(f"❌ Ошибка создания: {response.status_code} - {response.text}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def create_sales_table():
    """Создает таблицу продаж через транзакции"""
    print("\n📊 Создание таблицы продаж...")
    
    # Используем существующую таблицу транзакций для продаж
    # Добавляем поле telegram_payment_charge_id если его нет
    
    # Создаем тестовую транзакцию продажи
    sale_transaction = {
        "user_id": 1,
        "type": "server_sale",
        "amount_ndn": 0.00,
        "amount_stars": 0.00,
        "description": "Инициализация таблицы продаж",
        "telegram_payment_charge_id": "init_sales_table"
    }
    
    try:
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/nodeon_transactions",
            headers=get_supabase_headers(),
            json=sale_transaction
        )
        
        if response.status_code == 201:
            print("✅ Таблица продаж инициализирована!")
            
            # Удаляем тестовую запись
            requests.delete(
                f"{SUPABASE_URL}/rest/v1/nodeon_transactions?telegram_payment_charge_id=eq.init_sales_table",
                headers=get_supabase_headers()
            )
            
            return True
        else:
            print(f"❌ Ошибка создания: {response.status_code} - {response.text}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

if __name__ == "__main__":
    check_wallet_structure()
    
    # Создаем запись кошелька если таблица пуста
    response = requests.get(
        f"{SUPABASE_URL}/rest/v1/nodeon_server_wallet?select=count",
        headers=get_supabase_headers()
    )
    
    if response.status_code == 200:
        count = response.json()
        if count == 0:
            create_wallet_entry()
        else:
            print(f"\n✅ В кошельке уже есть {count} записей")
    
    create_sales_table()


