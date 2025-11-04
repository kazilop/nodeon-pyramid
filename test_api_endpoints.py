#!/usr/bin/env python3
"""
Тестирование API endpoints
"""

import requests
import json

def test_endpoint(url, name, method='GET', data=None):
    """Тестирование одного endpoint"""
    try:
        print(f"\n🔍 Тестирование: {name}")
        print(f"URL: {url}")
        print(f"Method: {method}")
        
        if method == 'GET':
            response = requests.get(url, timeout=10)
        elif method == 'POST':
            response = requests.post(url, json=data, timeout=10)
        
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
    
    print("🧪 Тестирование API endpoints")
    print("=" * 50)
    
    # Список endpoints для тестирования
    endpoints = [
        (f"{base_url}/api/users/find-by-id/5", "Поиск пользователя по ID 5", "GET"),
        (f"{base_url}/api/referrals/5", "Рефералы пользователя ID 5", "GET"),
        (f"{base_url}/api/stats/leaderboard", "Лидерборд", "GET"),
        (f"{base_url}/api/game-rules", "Правила игры", "GET"),
        (f"{base_url}/api/translations/ru", "Переводы на русском", "GET"),
        (f"{base_url}/api/translations/en", "Переводы на английском", "GET"),
    ]
    
    for url, name, method in endpoints:
        test_endpoint(url, name, method)
    
    print("\n" + "=" * 50)
    print("✅ Тестирование завершено!")

if __name__ == "__main__":
    main()




