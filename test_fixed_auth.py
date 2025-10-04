#!/usr/bin/env python3
"""
Тестирование исправленной авторизации через Telegram
"""

import requests
import json

# Конфигурация
RAILWAY_URL = "https://nodeon-production.up.railway.app"
API_BASE = f"{RAILWAY_URL}/api"

def test_api_health():
    """Тест здоровья API"""
    print("🏥 Тест здоровья API")
    print("-" * 30)
    
    try:
        response = requests.get(f"{API_BASE}/test", timeout=10)
        if response.status_code == 200:
            data = response.json()
            print(f"✅ API работает: {data.get('message')}")
            return True
        else:
            print(f"❌ API не работает: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def test_telegram_auth():
    """Тест авторизации через Telegram"""
    print("\n🔐 Тест авторизации через Telegram")
    print("-" * 40)
    
    # Реальные данные Telegram из логов
    real_telegram_data = "query_id%3DAAH6z9s5AgAAAPrP2zmCJWf0%26user%3D%257B%2522id%2522%253A5265674234%252C%2522first_name%2522%253A%2522%25D0%259C%25D0%25B0%25D0%25B9%25D1%258F%2522%252C%2522last_name%2522%253A%2522%2522%252C%2522username%2522%253A%2522mai_ryd%2522%252C%2522language_code%2522%253A%2522ru%2522%252C%2522allows_write_to_pm%2522%253Atrue%252C%2522photo_url%2522%253A%2522https%253A%255C%252F%255C%252Ft.me%255C%252Fi%255C%252Fuserpic%255C%252F320%255C%252FOXwbOMueYZ5veQLSz0ygjfcgU-4yhnHeMKOSuAhAi9gMZXI6XwIliSn9-WV0AREK.svg%2522%257D%26auth_date%3D1759609132%26signature%3D-Z9w-IkHM3au52cQwfPSfbP2_GHAZWxc9fhaqCQ0mFR8WwAnbqQNLKTQ2I3C3_5shPl_0Abr89sVUym0jjsmBw%26hash%3D130f4fea4aad862c2578c4ceae5ea05622ee78be051d5a29f969905c9647f8f0"
    
    try:
        response = requests.get(f"{API_BASE}/user/profile?init_data={real_telegram_data}")
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                user = data.get('user', {})
                print("✅ Авторизация работает:")
                print(f"   Пользователь: {user.get('first_name')}")
                print(f"   Username: @{user.get('username')}")
                print(f"   Баланс: {user.get('balance_ndn')} NDN")
                print(f"   Pro статус: {user.get('is_pro')}")
                print(f"   Реферальная ссылка: {user.get('referral_link', 'Нет')}")
                return True
            else:
                print(f"❌ Ошибка в ответе: {data.get('message')}")
                return False
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
            try:
                error_data = response.json()
                print(f"   Детали: {error_data.get('detail', 'Нет деталей')}")
            except:
                print(f"   Ответ: {response.text}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def test_invalid_auth():
    """Тест невалидной авторизации"""
    print("\n🚫 Тест невалидной авторизации")
    print("-" * 40)
    
    test_cases = [
        ("Без авторизации", None),
        ("Пустые данные", ""),
        ("Тестовые данные", "test_data"),
        ("Невалидные данные", "invalid_data"),
        ("Неполные данные", "user=%7B%22id%22%3A123%7D")
    ]
    
    for name, init_data in test_cases:
        try:
            if init_data is None:
                response = requests.get(f"{API_BASE}/user/profile")
            else:
                response = requests.get(f"{API_BASE}/user/profile?init_data={init_data}")
            
            if response.status_code == 401:
                print(f"✅ {name}: Правильно заблокирован (401)")
            else:
                print(f"❌ {name}: Получен статус {response.status_code} вместо 401")
                
        except Exception as e:
            print(f"❌ {name}: Ошибка {e}")

def test_stars_config():
    """Тест конфигурации Stars"""
    print("\n⭐ Тест конфигурации Stars")
    print("-" * 40)
    
    try:
        response = requests.get(f"{API_BASE}/stars/config", timeout=10)
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                config = data.get('config', {})
                print("✅ Конфигурация Stars работает:")
                print(f"   Курс: 1 Star = {config.get('stars_to_ndn_rate')} NDN")
                print(f"   Минимум: {config.get('min_stars_purchase')} Stars")
                print(f"   Максимум: {config.get('max_stars_purchase')} Stars")
                return True
            else:
                print(f"❌ Ошибка конфигурации: {data.get('error')}")
                return False
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def test_leaderboard():
    """Тест таблицы лидеров"""
    print("\n🏆 Тест таблицы лидеров")
    print("-" * 40)
    
    try:
        response = requests.get(f"{API_BASE}/stats/leaderboard", timeout=10)
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                leaders = data.get('leaders', [])
                print(f"✅ Таблица лидеров работает:")
                print(f"   Количество лидеров: {len(leaders)}")
                if leaders:
                    top_leader = leaders[0]
                    print(f"   Топ-1: {top_leader.get('first_name')} - {top_leader.get('balance_ndn')} NDN")
                return True
            else:
                print(f"❌ Ошибка лидеров: {data.get('message')}")
                return False
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def main():
    """Основная функция тестирования"""
    print("🧪 ТЕСТИРОВАНИЕ ИСПРАВЛЕННОЙ АВТОРИЗАЦИИ")
    print("=" * 60)
    
    results = []
    
    # Тестируем все компоненты
    results.append(("API Health", test_api_health()))
    results.append(("Telegram Auth", test_telegram_auth()))
    results.append(("Stars Config", test_stars_config()))
    results.append(("Leaderboard", test_leaderboard()))
    
    # Тестируем невалидную авторизацию
    test_invalid_auth()
    
    # Подсчитываем результаты
    total_tests = len(results)
    passed_tests = sum(1 for _, status in results if status)
    
    print("\n" + "=" * 60)
    print("📊 РЕЗУЛЬТАТЫ ТЕСТИРОВАНИЯ")
    print("=" * 60)
    
    for name, status in results:
        status_icon = "✅" if status else "❌"
        print(f"{status_icon} {name}")
    
    print(f"\n📈 Общий результат: {passed_tests}/{total_tests} тестов пройдено")
    
    if passed_tests == total_tests:
        print("\n🎉 ВСЕ ТЕСТЫ ПРОЙДЕНЫ!")
        print("✅ Авторизация через Telegram работает корректно")
        print("✅ Система готова к использованию")
    else:
        print(f"\n⚠️ {total_tests - passed_tests} тестов не прошли")
        print("🔧 Проверьте настройки базы данных и API")
    
    print("\n📝 Следующие шаги:")
    print("1. Выполните SQL скрипт в Supabase")
    print("2. Замените main.py на main_fixed_auth.py")
    print("3. Перезапустите Railway")
    print("4. Протестируйте в Telegram Mini App")

if __name__ == "__main__":
    main()
