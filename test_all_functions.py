#!/usr/bin/env python3
"""
Полное тестирование всех API функций
"""

import requests
import json

def test_endpoint(url, name, method='GET', data=None, expected_status=200):
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
        
        if response.status_code == expected_status:
            try:
                data = response.json()
                print(f"✅ Успешно: {json.dumps(data, indent=2, ensure_ascii=False)[:300]}...")
                return True
            except:
                print(f"✅ Успешно (не JSON): {response.text[:300]}...")
                return True
        else:
            print(f"❌ Ошибка: {response.text[:300]}...")
            return False
            
    except Exception as e:
        print(f"❌ Исключение: {e}")
        return False

def main():
    """Основная функция тестирования"""
    
    base_url = "https://nodeon-pyramid.netlify.app"
    
    print("🧪 Полное тестирование всех API функций")
    print("=" * 60)
    
    # Список всех endpoints для тестирования
    endpoints = [
        # Основные функции
        (f"{base_url}/api/users/find-by-id/5", "Поиск пользователя по ID 5", "GET"),
        (f"{base_url}/api/referrals/5", "Рефералы пользователя ID 5", "GET"),
        (f"{base_url}/api/stats/leaderboard", "Лидерборд", "GET"),
        (f"{base_url}/api/game-rules", "Правила игры", "GET"),
        (f"{base_url}/api/translations/ru", "Переводы на русском", "GET"),
        (f"{base_url}/api/translations/en", "Переводы на английском", "GET"),
        
        # Функции майнера
        (f"{base_url}/api/miner/data/5", "Данные майнера для пользователя 5", "GET"),
        (f"{base_url}/api/miner/leaderboard", "Лидерборд майнера", "GET"),
        (f"{base_url}/api/miner/stats/5", "Статистика майнера для пользователя 5", "GET"),
        (f"{base_url}/api/miner/check-tables", "Проверка таблиц майнера", "GET"),
        
        # Игровые функции
        (f"{base_url}/api/game/data/5", "Игровые данные для пользователя 5", "GET"),
        (f"{base_url}/api/game/achievements/5", "Достижения для пользователя 5", "GET"),
        
        # Pro функции
        (f"{base_url}/api/pro/buy", "Покупка Pro статуса", "POST", {"telegram_id": 207940967}),
        
        # Переводы
        (f"{base_url}/api/transfers/ndn", "Перевод NDN", "POST", {
            "from_telegram_id": 207940967,
            "to_user_id": 5,
            "amount": 1,
            "description": "Тестовый перевод"
        }),
        
        # Ежедневные награды
        (f"{base_url}/api/game/claim-daily-reward", "Ежедневная награда", "POST", {
            "telegram_id": 207940967,
            "day": 1
        }),
    ]
    
    results = []
    
    for endpoint in endpoints:
        if len(endpoint) == 3:
            url, name, method = endpoint
            data = None
        else:
            url, name, method, data = endpoint
            
        success = test_endpoint(url, name, method, data)
        results.append((name, success))
    
    print("\n" + "=" * 60)
    print("📊 ИТОГОВЫЕ РЕЗУЛЬТАТЫ:")
    print("=" * 60)
    
    working = 0
    broken = 0
    
    for name, success in results:
        status = "✅ РАБОТАЕТ" if success else "❌ НЕ РАБОТАЕТ"
        print(f"{status}: {name}")
        if success:
            working += 1
        else:
            broken += 1
    
    print(f"\n📈 Статистика:")
    print(f"   ✅ Работает: {working}")
    print(f"   ❌ Не работает: {broken}")
    print(f"   📊 Всего: {len(results)}")
    print(f"   🎯 Процент успеха: {(working/len(results)*100):.1f}%")
    
    if broken > 0:
        print(f"\n⚠️  Требуется исправление {broken} функций")
    else:
        print(f"\n🎉 Все функции работают корректно!")

if __name__ == "__main__":
    main()




