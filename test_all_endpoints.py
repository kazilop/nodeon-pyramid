#!/usr/bin/env python3
"""
Тестирование всех API endpoints
"""

import requests
import json

def test_endpoint(url, name):
    """Тестирование одного endpoint"""
    try:
        print(f"\n🔍 Тестирование: {name}")
        print(f"URL: {url}")
        
        response = requests.get(url, timeout=10)
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            try:
                data = response.json()
                print(f"✅ Успешно: {json.dumps(data, indent=2, ensure_ascii=False)[:200]}...")
            except:
                print(f"✅ Успешно (не JSON): {response.text[:200]}...")
        else:
            print(f"❌ Ошибка: {response.text[:200]}...")
            
    except Exception as e:
        print(f"❌ Исключение: {e}")

def main():
    """Основная функция тестирования"""
    
    base_url = "https://nodeon-pyramid.netlify.app"
    
    print("🧪 Тестирование всех API endpoints")
    print("=" * 50)
    
    # Список endpoints для тестирования
    endpoints = [
        (f"{base_url}/api/miner/check-tables", "Проверка таблиц"),
        (f"{base_url}/api/miner/data/207940967", "Данные майнера"),
        (f"{base_url}/api/miner/leaderboard", "Лидерборд майнера"),
        (f"{base_url}/api/miner/stats/207940967", "Статистика майнера"),
        (f"{base_url}/api/referrals/207940967", "Рефералы"),
        (f"{base_url}/api/stats/leaderboard", "Общий лидерборд"),
        (f"{base_url}/api/stats/dashboard/207940967", "Дашборд"),
        (f"{base_url}/api/users/balance/207940967", "Баланс пользователя"),
    ]
    
    for url, name in endpoints:
        test_endpoint(url, name)
    
    print("\n" + "=" * 50)
    print("✅ Тестирование завершено!")

if __name__ == "__main__":
    main()