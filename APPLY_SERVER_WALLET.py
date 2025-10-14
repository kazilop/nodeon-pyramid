#!/usr/bin/env python3
"""
Скрипт для создания серверного кошелька NodeOn с 1 млрд NDN
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

def execute_sql(sql_content):
    """Выполняет SQL через Supabase RPC"""
    try:
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/exec_sql",
            headers=get_supabase_headers(),
            json={"sql": sql_content}
        )
        
        if response.status_code == 200:
            return True, response.json()
        else:
            return False, f"Ошибка выполнения SQL: {response.status_code} - {response.text}"
    except Exception as e:
        return False, f"Ошибка подключения: {e}"

def create_server_wallet():
    """Создает серверный кошелек"""
    print("🏦 Создание серверного кошелька NodeOn...")
    
    # Читаем SQL файл
    try:
        with open('CREATE_SERVER_WALLET.sql', 'r', encoding='utf-8') as f:
            sql_content = f.read()
    except FileNotFoundError:
        print("❌ Файл CREATE_SERVER_WALLET.sql не найден")
        return False
    
    # Выполняем SQL
    success, result = execute_sql(sql_content)
    
    if success:
        print("✅ Серверный кошелек создан успешно!")
        print(f"📊 Результат: {result}")
        return True
    else:
        print(f"❌ Ошибка создания кошелька: {result}")
        return False

def check_wallet_status():
    """Проверяет статус кошелька"""
    print("\n📊 Проверка статуса кошелька...")
    
    try:
        # Проверяем таблицу кошелька
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

def test_wallet_functions():
    """Тестирует функции кошелька"""
    print("\n🧪 Тестирование функций кошелька...")
    
    try:
        # Тестируем функцию get_wallet_stats
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/get_wallet_stats",
            headers=get_supabase_headers()
        )
        
        if response.status_code == 200:
            stats = response.json()
            print("✅ Функция get_wallet_stats работает:")
            print(f"   Баланс: {stats['wallet_balance']:,.2f} NDN")
            print(f"   Продано: {stats['total_sold']:,.2f} NDN")
            print(f"   Stars: {stats['total_earned_stars']:,.2f}")
            return True
        else:
            print(f"❌ Ошибка тестирования: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка тестирования: {e}")
        return False

if __name__ == "__main__":
    print("🚀 NodeOn Server Wallet Setup")
    print("=" * 50)
    
    # Создаем кошелек
    if create_server_wallet():
        # Проверяем статус
        if check_wallet_status():
            # Тестируем функции
            test_wallet_functions()
            
            print("\n✅ Серверный кошелек готов к работе!")
            print("💰 В кошельке: 1,000,000,000 NDN")
            print("🔄 Готов к продаже NDN за Telegram Stars")
        else:
            print("\n❌ Ошибка проверки кошелька")
    else:
        print("\n❌ Ошибка создания кошелька")

