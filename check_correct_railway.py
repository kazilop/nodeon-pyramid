#!/usr/bin/env python3
"""
Проверка правильного Railway URL и настройка аккаунта разработчика
"""

import requests
import json
import time

def check_railway_status():
    """Проверка статуса Railway с правильным URL"""
    correct_url = "https://nodeon-production.up.railway.app"
    
    try:
        print(f"🔍 Проверяем Railway: {correct_url}")
        response = requests.get(correct_url, timeout=10)
        print(f"   Статус: {response.status_code}")
        if response.status_code == 200:
            print("   Ответ:", response.text)
            return True
        else:
            print("   Ошибка:", response.text)
            return False
    except Exception as e:
        print(f"   Ошибка подключения: {e}")
        return False

def check_api_endpoints():
    """Проверка API endpoints"""
    base_url = "https://nodeon-production.up.railway.app"
    
    endpoints = [
        "/",
        "/test",
        "/api/test",
        "/health"
    ]
    
    for endpoint in endpoints:
        try:
            print(f"🔍 Проверяем {endpoint}...")
            response = requests.get(f"{base_url}{endpoint}", timeout=10)
            print(f"   Статус: {response.status_code}")
            if response.status_code == 200:
                print(f"   Ответ: {response.text[:100]}...")
            else:
                print(f"   Ошибка: {response.text[:100]}...")
        except Exception as e:
            print(f"   Ошибка: {e}")

def create_developer_via_api():
    """Создание разработчика через API"""
    try:
        print("\n👤 Создаем пользователя разработчика...")
        
        # Используем простые данные для тестирования
        response = requests.get(
            "https://nodeon-production.up.railway.app/api/user/profile",
            params={"init_data": "test_data"},
            timeout=30
        )
        
        print(f"   Статус: {response.status_code}")
        if response.status_code == 200:
            data = response.json()
            print("   ✅ Пользователь создан/найден")
            print(f"   ID: {data['user']['id']}")
            print(f"   Имя: {data['user']['first_name']} {data['user']['last_name']}")
            print(f"   Баланс: {data['user']['balance_ndn']} NDN")
            print(f"   Pro: {'Да' if data['user']['is_pro'] else 'Нет'}")
            return True
        else:
            print(f"   ❌ Ошибка: {response.text}")
            return False
            
    except Exception as e:
        print(f"   ❌ Ошибка: {e}")
        return False

def test_telegram_app():
    """Тест Telegram приложения"""
    print("\n📱 Тестируем Telegram приложение...")
    print("   GitHub Pages: https://kazilop.github.io/nodeon-pyramid/")
    print("   Railway API: https://nodeon-production.up.railway.app/")
    print("\n   Для тестирования:")
    print("   1. Откройте приложение в браузере")
    print("   2. Войдите через Telegram")
    print("   3. Проверьте загрузку данных")

def main():
    print("🚀 NodeOn Pyramid - Проверка правильного Railway")
    print("=" * 60)
    
    # Проверяем Railway
    if check_railway_status():
        print("✅ Railway работает!")
    else:
        print("❌ Railway не работает")
        return
    
    # Проверяем API endpoints
    print("\n🔍 Проверяем API endpoints...")
    check_api_endpoints()
    
    # Пытаемся создать пользователя
    if create_developer_via_api():
        print("✅ Пользователь создан через API")
    else:
        print("❌ Не удалось создать пользователя через API")
        print("   Нужно настроить через Supabase SQL")
    
    # Инструкции для Telegram
    test_telegram_app()
    
    print("\n📋 Следующие шаги:")
    print("1. Откройте https://kazilop.github.io/nodeon-pyramid/")
    print("2. Обновите API URL в коде на правильный")
    print("3. Войдите через Telegram")
    print("4. Настройте Pro статус через Supabase")

if __name__ == "__main__":
    main()
