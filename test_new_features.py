#!/usr/bin/env python3
"""
Тест новых функций: рефералы, лидерборд, правила
"""

import requests

def test_game_rules():
    """Тестирование правил игры"""
    url = "https://nodeon-production.up.railway.app/api/game-rules"
    
    print("🔍 Тестирование правил игры...")
    print(f"URL: {url}")
    
    try:
        response = requests.get(url, timeout=10)
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print("✅ Правила игры работают!")
            print(f"Заголовок: {data['rules']['title']}")
            print(f"Количество разделов: {len(data['rules']['sections'])}")
            return True
        else:
            print(f"❌ Ошибка: {response.text}")
            return False
            
    except requests.exceptions.RequestException as e:
        print(f"❌ Ошибка подключения: {e}")
        return False

def test_leaderboard():
    """Тестирование лидерборда"""
    url = "https://nodeon-production.up.railway.app/api/stats/leaderboard"
    
    print("\n🔍 Тестирование лидерборда...")
    print(f"URL: {url}")
    
    try:
        response = requests.get(url, timeout=10)
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print("✅ Лидерборд работает!")
            print(f"Количество лидеров: {len(data['leaders'])}")
            if data['leaders']:
                print(f"Топ игрок: {data['leaders'][0]['first_name']} - {data['leaders'][0]['balance_ndn']} NDN")
            return True
        else:
            print(f"❌ Ошибка: {response.text}")
            return False
            
    except requests.exceptions.RequestException as e:
        print(f"❌ Ошибка подключения: {e}")
        return False

def test_referrals():
    """Тестирование рефералов"""
    url = "https://nodeon-production.up.railway.app/api/referrals/1"
    
    print("\n🔍 Тестирование рефералов...")
    print(f"URL: {url}")
    
    try:
        response = requests.get(url, timeout=10)
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print("✅ Рефералы работают!")
            print(f"Прямых рефералов: {data['total_direct']}")
            return True
        else:
            print(f"❌ Ошибка: {response.text}")
            return False
            
    except requests.exceptions.RequestException as e:
        print(f"❌ Ошибка подключения: {e}")
        return False

def main():
    """Основная функция"""
    print("🚀 Тестирование новых функций NodeOn Crypto")
    print("=" * 60)
    
    # Тест правил игры
    rules_works = test_game_rules()
    
    # Тест лидерборда
    leaderboard_works = test_leaderboard()
    
    # Тест рефералов
    referrals_works = test_referrals()
    
    print("\n" + "=" * 60)
    print("📊 РЕЗУЛЬТАТЫ ТЕСТИРОВАНИЯ:")
    print(f"Правила игры: {'✅ Работает' if rules_works else '❌ Не работает'}")
    print(f"Лидерборд: {'✅ Работает' if leaderboard_works else '❌ Не работает'}")
    print(f"Рефералы: {'✅ Работает' if referrals_works else '❌ Не работает'}")
    
    if rules_works and leaderboard_works and referrals_works:
        print("\n🎉 ВСЕ НОВЫЕ ФУНКЦИИ РАБОТАЮТ!")
    else:
        print("\n⚠️ Есть проблемы с новыми функциями.")

if __name__ == "__main__":
    main()

