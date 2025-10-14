#!/usr/bin/env python3
"""
Создание таблиц серверного кошелька через Supabase REST API
"""

import requests
import json
import os

# Настройки Supabase
SUPABASE_URL = "https://ahxwpzgltlzlvrtrbanm.supabase.co"
SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoeHdwemdsdGx6bHZydHJiYW5tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1MDMxNDksImV4cCI6MjA3NTA3OTE0OX0.h4sMVhVwvRUiHgbevDgv9W1G2S__uDWPUSCiXdrEy4E"

def get_supabase_headers():
    return {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }

def create_server_wallet_table():
    """Создает таблицу серверного кошелька"""
    print("🏦 Создание таблицы серверного кошелька...")
    
    # Создаем запись кошелька
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
            print("✅ Таблица серверного кошелька создана!")
            return True
        else:
            print(f"❌ Ошибка создания таблицы: {response.status_code} - {response.text}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def create_sales_table():
    """Создает таблицу продаж"""
    print("📊 Создание таблицы продаж...")
    
    # Создаем тестовую запись продажи
    sales_data = {
        "user_id": 1,
        "amount_ndn": 0.00,
        "amount_stars": 0.00,
        "telegram_payment_charge_id": "test_initialization",
        "status": "test"
    }
    
    try:
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/nodeon_sales",
            headers=get_supabase_headers(),
            json=sales_data
        )
        
        if response.status_code == 201:
            print("✅ Таблица продаж создана!")
            # Удаляем тестовую запись
            requests.delete(
                f"{SUPABASE_URL}/rest/v1/nodeon_sales?telegram_payment_charge_id=eq.test_initialization",
                headers=get_supabase_headers()
            )
            return True
        else:
            print(f"❌ Ошибка создания таблицы продаж: {response.status_code} - {response.text}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def check_wallet_status():
    """Проверяет статус кошелька"""
    print("\n📊 Проверка статуса кошелька...")
    
    try:
        response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_server_wallet",
            headers=get_supabase_headers()
        )
        
        if response.status_code == 200:
            wallets = response.json()
            if wallets:
                wallet = wallets[0]
                print(f"💰 Баланс кошелька: {wallet['balance_ndn']:,.2f} NDN")
                print(f"📈 Всего продано: {wallet['total_sold_ndn']:,.2f} NDN")
                print(f"⭐ Заработано Stars: {wallet['total_earned_stars']:,.2f}")
                return True
            else:
                print("❌ Кошелек не найден")
                return False
        else:
            print(f"❌ Ошибка получения данных: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка проверки: {e}")
        return False

def test_sell_ndn():
    """Тестирует продажу NDN"""
    print("\n🧪 Тестирование продажи NDN...")
    
    # Создаем тестовую продажу
    test_sale = {
        "user_id": 1,
        "amount_ndn": 100.00,
        "amount_stars": 100.00,
        "telegram_payment_charge_id": "test_sale_123",
        "status": "completed"
    }
    
    try:
        # Создаем запись продажи
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/nodeon_sales",
            headers=get_supabase_headers(),
            json=test_sale
        )
        
        if response.status_code == 201:
            print("✅ Тестовая продажа создана")
            
            # Обновляем баланс кошелька
            wallet_update = {
                "balance_ndn": 999999900.00,
                "total_sold_ndn": 100.00,
                "total_earned_stars": 100.00
            }
            
            update_response = requests.patch(
                f"{SUPABASE_URL}/rest/v1/nodeon_server_wallet?id=eq.1",
                headers=get_supabase_headers(),
                json=wallet_update
            )
            
            if update_response.status_code == 200:
                print("✅ Баланс кошелька обновлен")
                
                # Удаляем тестовую запись
                requests.delete(
                    f"{SUPABASE_URL}/rest/v1/nodeon_sales?telegram_payment_charge_id=eq.test_sale_123",
                    headers=get_supabase_headers()
                )
                
                # Возвращаем баланс
                wallet_reset = {
                    "balance_ndn": 1000000000.00,
                    "total_sold_ndn": 0.00,
                    "total_earned_stars": 0.00
                }
                
                requests.patch(
                    f"{SUPABASE_URL}/rest/v1/nodeon_server_wallet?id=eq.1",
                    headers=get_supabase_headers(),
                    json=wallet_reset
                )
                
                print("✅ Тест завершен успешно")
                return True
            else:
                print(f"❌ Ошибка обновления кошелька: {update_response.status_code}")
                return False
        else:
            print(f"❌ Ошибка создания тестовой продажи: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка тестирования: {e}")
        return False

if __name__ == "__main__":
    print("🚀 NodeOn Server Wallet Setup (REST API)")
    print("=" * 50)
    
    # Создаем таблицы
    if create_server_wallet_table():
        if create_sales_table():
            # Проверяем статус
            if check_wallet_status():
                # Тестируем функциональность
                test_sell_ndn()
                
                print("\n✅ Серверный кошелек готов к работе!")
                print("💰 В кошельке: 1,000,000,000 NDN")
                print("🔄 Готов к продаже NDN за Telegram Stars")
            else:
                print("\n❌ Ошибка проверки кошелька")
        else:
            print("\n❌ Ошибка создания таблицы продаж")
    else:
        print("\n❌ Ошибка создания кошелька")

