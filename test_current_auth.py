#!/usr/bin/env python3
"""
Быстрый тест текущего состояния авторизации
"""

import requests
import json

# Конфигурация
RAILWAY_URL = "https://nodeon-production.up.railway.app"
API_BASE = f"{RAILWAY_URL}/api"

def test_simple():
    """Простой тест без авторизации"""
    print("🧪 Тест без авторизации")
    try:
        response = requests.get(f"{API_BASE}/user/profile")
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 401:
            print("✅ Правильно: 401 Unauthorized")
            data = response.json()
            print(f"Сообщение: {data.get('detail')}")
        elif response.status_code == 500:
            print("⚠️ Получаем 500 вместо 401")
            try:
                data = response.json()
                print(f"Ошибка: {data.get('detail')}")
            except:
                print("Не удалось распарсить JSON")
        else:
            print(f"❌ Неожиданный статус: {response.status_code}")
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")

def test_with_test_data():
    """Тест с тестовыми данными"""
    print("\n🧪 Тест с тестовыми данными")
    try:
        response = requests.get(f"{API_BASE}/user/profile?init_data=test_data")
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 401:
            print("✅ Правильно: 401 Unauthorized")
            data = response.json()
            print(f"Сообщение: {data.get('detail')}")
        elif response.status_code == 500:
            print("⚠️ Получаем 500 вместо 401")
            try:
                data = response.json()
                print(f"Ошибка: {data.get('detail')}")
            except:
                print("Не удалось распарсить JSON")
        else:
            print(f"❌ Неожиданный статус: {response.status_code}")
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")

def test_api_health():
    """Тест здоровья API"""
    print("\n🧪 Тест здоровья API")
    try:
        response = requests.get(f"{API_BASE}/test")
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print(f"✅ API работает: {data.get('message')}")
        else:
            print(f"❌ API не работает: {response.status_code}")
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")

if __name__ == "__main__":
    print("🔍 Быстрая проверка авторизации")
    print("=" * 40)
    
    test_api_health()
    test_simple()
    test_with_test_data()
    
    print("\n📝 Вывод:")
    print("   - Если получаем 401 - авторизация работает правильно")
    print("   - Если получаем 500 - Railway еще не обновился")
    print("   - Если получаем 200 - авторизация не работает")
