#!/usr/bin/env python3
"""
Скрипт для проверки системы после деплоя
"""

import os
import requests
import json
from dotenv import load_dotenv

# Загружаем переменные окружения
load_dotenv()

def check_environment_variables():
    """Проверка переменных окружения"""
    
    required_vars = [
        'SUPABASE_URL',
        'SUPABASE_ANON_KEY',
        'TELEGRAM_BOT_TOKEN',
        'DEVELOPER_TELEGRAM_ID'
    ]
    
    print("🔍 Проверка переменных окружения...")
    
    missing_vars = []
    for var in required_vars:
        value = os.getenv(var)
        if value:
            # Скрываем токены для безопасности
            if 'TOKEN' in var or 'KEY' in var:
                display_value = f"{value[:10]}...{value[-5:]}"
            else:
                display_value = value
            print(f"✅ {var}: {display_value}")
        else:
            print(f"❌ {var}: НЕ УСТАНОВЛЕНА")
            missing_vars.append(var)
    
    if missing_vars:
        print(f"\n⚠️ Отсутствуют переменные: {', '.join(missing_vars)}")
        return False
    
    print("✅ Все переменные окружения установлены")
    return True

def check_supabase_connection():
    """Проверка подключения к Supabase"""
    
    supabase_url = os.getenv('SUPABASE_URL')
    supabase_key = os.getenv('SUPABASE_ANON_KEY')
    
    if not supabase_url or not supabase_key:
        print("❌ Переменные Supabase не установлены")
        return False
    
    print("🔍 Проверка подключения к Supabase...")
    
    try:
        headers = {
            "apikey": supabase_key,
            "Authorization": f"Bearer {supabase_key}"
        }
        
        # Проверяем таблицу пользователей
        url = f"{supabase_url}/rest/v1/nodeon_users?select=count"
        response = requests.get(url, headers=headers)
        
        if response.status_code == 200:
            print("✅ Подключение к Supabase работает")
            return True
        else:
            print(f"❌ Ошибка подключения к Supabase: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка подключения к Supabase: {e}")
        return False

def check_telegram_bot():
    """Проверка Telegram Bot"""
    
    bot_token = os.getenv('TELEGRAM_BOT_TOKEN')
    
    if not bot_token:
        print("❌ TELEGRAM_BOT_TOKEN не установлен")
        return False
    
    print("🔍 Проверка Telegram Bot...")
    
    try:
        url = f"https://api.telegram.org/bot{bot_token}/getMe"
        response = requests.get(url)
        
        if response.status_code == 200:
            result = response.json()
            if result.get("ok"):
                bot_info = result.get("result", {})
                print(f"✅ Bot работает: @{bot_info.get('username')}")
                return True
            else:
                print(f"❌ Ошибка Bot API: {result.get('description')}")
                return False
        else:
            print(f"❌ Ошибка запроса к Bot API: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка проверки Bot: {e}")
        return False

def check_railway_app():
    """Проверка приложения на Railway"""
    
    railway_url = os.getenv('RAILWAY_URL')
    
    if not railway_url:
        print("⚠️ RAILWAY_URL не установлен, пропускаем проверку")
        return True
    
    print(f"🔍 Проверка приложения на Railway: {railway_url}")
    
    try:
        # Проверяем главную страницу
        response = requests.get(railway_url, timeout=10)
        
        if response.status_code == 200:
            print("✅ Приложение на Railway работает")
            return True
        else:
            print(f"❌ Ошибка приложения: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка проверки приложения: {e}")
        return False

def check_api_endpoints():
    """Проверка API endpoints"""
    
    railway_url = os.getenv('RAILWAY_URL')
    
    if not railway_url:
        print("⚠️ RAILWAY_URL не установлен, пропускаем проверку API")
        return True
    
    print("🔍 Проверка API endpoints...")
    
    endpoints = [
        "/",
        "/api/auth/me",
        "/api/miner/check-tables"
    ]
    
    for endpoint in endpoints:
        try:
            url = f"{railway_url}{endpoint}"
            response = requests.get(url, timeout=10)
            
            if response.status_code in [200, 401, 422]:  # 401/422 - нормальные ответы для защищенных endpoints
                print(f"✅ {endpoint}: {response.status_code}")
            else:
                print(f"⚠️ {endpoint}: {response.status_code}")
                
        except Exception as e:
            print(f"❌ {endpoint}: {e}")

def main():
    """Основная функция проверки"""
    
    print("🚀 Проверка системы NodeOn Pyramid")
    print("=" * 60)
    
    checks = [
        ("Переменные окружения", check_environment_variables),
        ("Supabase", check_supabase_connection),
        ("Telegram Bot", check_telegram_bot),
        ("Railway App", check_railway_app)
    ]
    
    results = []
    
    for name, check_func in checks:
        print(f"\n📋 {name}:")
        result = check_func()
        results.append((name, result))
    
    print("\n" + "=" * 60)
    print("📊 Результаты проверки:")
    
    all_passed = True
    for name, result in results:
        status = "✅ ПРОЙДЕНО" if result else "❌ ОШИБКА"
        print(f"   {name}: {status}")
        if not result:
            all_passed = False
    
    print("\n" + "=" * 60)
    
    if all_passed:
        print("🎉 Все проверки пройдены! Система готова к работе.")
    else:
        print("⚠️ Есть проблемы, требующие внимания.")
    
    print("\n📝 Следующие шаги:")
    print("   1. Запустите setup_database.py для создания таблиц")
    print("   2. Запустите setup_telegram_bot.py для настройки бота")
    print("   3. Протестируйте бота командой /start")

if __name__ == "__main__":
    main()
