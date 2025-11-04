#!/usr/bin/env python3
"""
Диагностика API проблем
"""

import requests
import json

def test_api():
    """Тестирование API"""
    
    base_url = "https://nodeon-pyramid.netlify.app"
    
    print("🔍 Диагностика API проблем")
    print("=" * 50)
    
    # Тест 1: Проверка таблиц
    print("\n📋 Тест 1: /api/miner/check-tables")
    try:
        response = requests.get(f"{base_url}/api/miner/check-tables", timeout=10)
        print(f"Статус: {response.status_code}")
        print(f"Заголовки: {dict(response.headers)}")
        print(f"Ответ: {response.text}")
        
        if response.status_code == 200:
            try:
                data = response.json()
                print(f"JSON: {json.dumps(data, indent=2, ensure_ascii=False)}")
            except:
                print("Не удалось распарсить JSON")
        else:
            print(f"Ошибка: {response.text}")
            
    except Exception as e:
        print(f"Ошибка подключения: {e}")
    
    # Тест 2: Данные майнера
    print("\n⛏️ Тест 2: /api/miner/data/5")
    try:
        response = requests.get(f"{base_url}/api/miner/data/5", timeout=10)
        print(f"Статус: {response.status_code}")
        print(f"Ответ: {response.text}")
        
    except Exception as e:
        print(f"Ошибка подключения: {e}")
    
    # Тест 3: Главная страница
    print("\n🌐 Тест 3: Главная страница")
    try:
        response = requests.get(base_url, timeout=10)
        print(f"Статус: {response.status_code}")
        if response.status_code == 200:
            print("✅ Страница загружается")
        else:
            print(f"❌ Ошибка: {response.text}")
            
    except Exception as e:
        print(f"Ошибка подключения: {e}")

if __name__ == "__main__":
    test_api()




