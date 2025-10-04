#!/usr/bin/env python3
"""
Полная проверка всех компонентов системы NodeOn Pyramid
"""

import requests
import json
import time

# Настройки
RAILWAY_URL = "https://nodeon-production.up.railway.app"
GITHUB_PAGES_URL = "https://kazilop.github.io/nodeon-pyramid"
SUPABASE_URL = "https://ahxwpzgltlzlvrtrbanm.supabase.co"
SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoeHdwemdsdGx6bHZydHJiYW5tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1MDMxNDksImV4cCI6MjA3NTA3OTE0OX0.h4sMVhVwvRUiHgbevDgv9W1G2S__uDWPUSCiXdrEy4E"

def check_railway_backend():
    """Проверка Railway backend"""
    print("🔍 Проверяем Railway Backend...")
    
    endpoints = [
        "/",
        "/test", 
        "/api/test",
        "/health"
    ]
    
    for endpoint in endpoints:
        try:
            response = requests.get(f"{RAILWAY_URL}{endpoint}", timeout=10)
            print(f"   {endpoint}: {response.status_code}")
            if response.status_code == 200:
                print(f"      Ответ: {response.text[:100]}...")
            else:
                print(f"      Ошибка: {response.text[:100]}...")
        except Exception as e:
            print(f"   {endpoint}: ❌ {e}")
    
    return True

def check_github_pages():
    """Проверка GitHub Pages frontend"""
    print("\n🌐 Проверяем GitHub Pages Frontend...")
    
    try:
        response = requests.get(GITHUB_PAGES_URL, timeout=10)
        print(f"   Статус: {response.status_code}")
        if response.status_code == 200:
            print("   ✅ Frontend доступен")
            return True
        else:
            print(f"   ❌ Ошибка: {response.text[:100]}...")
            return False
    except Exception as e:
        print(f"   ❌ Ошибка: {e}")
        return False

def check_supabase_connection():
    """Проверка подключения к Supabase"""
    print("\n🗄️ Проверяем Supabase Database...")
    
    headers = {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }
    
    try:
        # Проверяем таблицы
        tables = ["nodeon_users", "nodeon_transactions", "nodeon_referral_stats"]
        
        for table in tables:
            response = requests.get(
                f"{SUPABASE_URL}/rest/v1/{table}?select=count",
                headers=headers
            )
            print(f"   {table}: {response.status_code}")
            if response.status_code == 200:
                print(f"      ✅ Таблица доступна")
            else:
                print(f"      ❌ Ошибка: {response.text[:100]}...")
        
        return True
        
    except Exception as e:
        print(f"   ❌ Ошибка подключения: {e}")
        return False

def test_api_endpoints():
    """Тестирование API endpoints"""
    print("\n🧪 Тестируем API endpoints...")
    
    # Тест создания пользователя
    try:
        print("   Тест создания пользователя...")
        response = requests.get(
            f"{RAILWAY_URL}/api/user/profile",
            params={"init_data": "test_data"},
            timeout=10
        )
        print(f"      Статус: {response.status_code}")
        if response.status_code == 200:
            data = response.json()
            print(f"      ✅ Пользователь: {data['user']['first_name']}")
        else:
            print(f"      ❌ Ошибка: {response.text[:100]}...")
    except Exception as e:
        print(f"      ❌ Ошибка: {e}")
    
    # Тест покупки Pro
    try:
        print("   Тест покупки Pro статуса...")
        response = requests.post(
            f"{RAILWAY_URL}/api/pro/buy",
            params={"init_data": "test_data"},
            timeout=10
        )
        print(f"      Статус: {response.status_code}")
        if response.status_code == 200:
            data = response.json()
            print(f"      ✅ Результат: {data.get('message', 'OK')}")
        else:
            print(f"      ❌ Ошибка: {response.text[:100]}...")
    except Exception as e:
        print(f"      ❌ Ошибка: {e}")

def setup_developer_account():
    """Настройка аккаунта разработчика"""
    print("\n👤 Настраиваем аккаунт разработчика...")
    
    headers = {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }
    
    try:
        # Проверяем существование пользователя
        response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?telegram_id=eq.207940967",
            headers=headers
        )
        
        if response.status_code == 200:
            users = response.json()
            if users:
                user = users[0]
                print(f"   ✅ Пользователь найден:")
                print(f"      ID: {user['id']}")
                print(f"      Имя: {user['first_name']} {user['last_name']}")
                print(f"      Баланс: {user['balance_ndn']} NDN")
                print(f"      Pro: {'Да' if user['is_pro'] else 'Нет'}")
                return True
            else:
                print("   ❌ Пользователь не найден")
                return False
        else:
            print(f"   ❌ Ошибка: {response.text}")
            return False
            
    except Exception as e:
        print(f"   ❌ Ошибка: {e}")
        return False

def main():
    print("🚀 NodeOn Pyramid - Полная проверка системы")
    print("=" * 60)
    
    # 1. Проверяем Railway Backend
    check_railway_backend()
    
    # 2. Проверяем GitHub Pages
    check_github_pages()
    
    # 3. Проверяем Supabase
    check_supabase_connection()
    
    # 4. Тестируем API
    test_api_endpoints()
    
    # 5. Настраиваем разработчика
    setup_developer_account()
    
    print("\n📋 Следующие шаги:")
    print("1. Если все компоненты работают - откройте приложение в Telegram")
    print("2. Если есть проблемы - исправьте их согласно выводу выше")
    print("3. Для настройки базы данных выполните SQL скрипт в Supabase")
    
    print(f"\n🔗 Ссылки:")
    print(f"   Frontend: {GITHUB_PAGES_URL}")
    print(f"   Backend: {RAILWAY_URL}")
    print(f"   Database: {SUPABASE_URL}")

if __name__ == "__main__":
    main()
