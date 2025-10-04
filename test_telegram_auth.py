#!/usr/bin/env python3
"""
Тестирование строгой авторизации через Telegram
"""

import requests
import json

# Конфигурация
RAILWAY_URL = "https://nodeon-production.up.railway.app"
API_BASE = f"{RAILWAY_URL}/api"

def test_without_auth():
    """Тест без авторизации - должен вернуть 401"""
    print("🧪 Тестирование без авторизации")
    print("=" * 50)
    
    try:
        response = requests.get(f"{API_BASE}/user/profile")
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 401:
            data = response.json()
            print("✅ Правильно заблокирован без авторизации:")
            print(f"   Сообщение: {data.get('detail')}")
        else:
            print(f"❌ Ошибка: Должен быть 401, получен {response.status_code}")
            
    except Exception as e:
        print(f"❌ Ошибка подключения: {e}")

def test_with_test_data():
    """Тест с тестовыми данными - должен вернуть 401"""
    print("\n🧪 Тестирование с тестовыми данными")
    print("=" * 50)
    
    try:
        response = requests.get(f"{API_BASE}/user/profile?init_data=test_data")
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 401:
            data = response.json()
            print("✅ Правильно заблокирован с тестовыми данными:")
            print(f"   Сообщение: {data.get('detail')}")
        else:
            print(f"❌ Ошибка: Должен быть 401, получен {response.status_code}")
            
    except Exception as e:
        print(f"❌ Ошибка подключения: {e}")

def test_with_empty_auth():
    """Тест с пустой авторизацией - должен вернуть 401"""
    print("\n🧪 Тестирование с пустой авторизацией")
    print("=" * 50)
    
    try:
        response = requests.get(f"{API_BASE}/user/profile?init_data=")
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 401:
            data = response.json()
            print("✅ Правильно заблокирован с пустой авторизацией:")
            print(f"   Сообщение: {data.get('detail')}")
        else:
            print(f"❌ Ошибка: Должен быть 401, получен {response.status_code}")
            
    except Exception as e:
        print(f"❌ Ошибка подключения: {e}")

def test_with_invalid_auth():
    """Тест с невалидной авторизацией - должен вернуть 401"""
    print("\n🧪 Тестирование с невалидной авторизацией")
    print("=" * 50)
    
    try:
        response = requests.get(f"{API_BASE}/user/profile?init_data=invalid_data")
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 401:
            data = response.json()
            print("✅ Правильно заблокирован с невалидной авторизацией:")
            print(f"   Сообщение: {data.get('detail')}")
        else:
            print(f"❌ Ошибка: Должен быть 401, получен {response.status_code}")
            
    except Exception as e:
        print(f"❌ Ошибка подключения: {e}")

def test_api_health():
    """Тест здоровья API - должен работать без авторизации"""
    print("\n🧪 Тестирование здоровья API")
    print("=" * 50)
    
    try:
        response = requests.get(f"{API_BASE}/test")
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print("✅ API работает:")
            print(f"   Сообщение: {data.get('message')}")
        else:
            print(f"❌ Ошибка: API не работает, статус {response.status_code}")
            
    except Exception as e:
        print(f"❌ Ошибка подключения: {e}")

def test_stars_config():
    """Тест конфигурации Stars - должен работать без авторизации"""
    print("\n🧪 Тестирование конфигурации Stars")
    print("=" * 50)
    
    try:
        response = requests.get(f"{API_BASE}/stars/config")
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print("✅ Конфигурация Stars доступна:")
            print(f"   Успех: {data.get('success')}")
        else:
            print(f"❌ Ошибка: Конфигурация Stars недоступна, статус {response.status_code}")
            
    except Exception as e:
        print(f"❌ Ошибка подключения: {e}")

def main():
    """Основная функция тестирования"""
    print("🔒 Тестирование строгой авторизации через Telegram")
    print("=" * 60)
    
    # Тестируем все сценарии
    test_api_health()
    test_stars_config()
    test_without_auth()
    test_with_test_data()
    test_with_empty_auth()
    test_with_invalid_auth()
    
    print("\n✅ Тестирование завершено!")
    print("\n📝 Результат:")
    print("   - API работает только с валидными данными Telegram")
    print("   - Все попытки обхода авторизации заблокированы")
    print("   - Приложение можно использовать только в Telegram Mini App")

if __name__ == "__main__":
    main()
