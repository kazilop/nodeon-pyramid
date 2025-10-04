#!/usr/bin/env python3
"""
Тестирование системы Stars в NodeOn Pyramid
"""

import requests
import json
import time

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
                print(f"   Комиссия за покупку: {config.get('stars_purchase_fee_percent')}%")
                print(f"   Комиссия за вывод: {config.get('stars_withdrawal_fee_percent')}%")
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

def test_user_profile_with_stars():
    """Тест профиля пользователя с Stars"""
    print("\n👤 Тест профиля пользователя с Stars")
    print("-" * 50)
    
    # Реальные данные Telegram из логов
    real_telegram_data = "query_id%3DAAH6z9s5AgAAAPrP2zmCJWf0%26user%3D%257B%2522id%2522%253A5265674234%252C%2522first_name%2522%253A%2522%25D0%259C%25D0%25B0%25D0%25B9%25D1%258F%2522%252C%2522last_name%2522%253A%2522%2522%252C%2522username%2522%253A%2522mai_ryd%2522%252C%2522language_code%2522%253A%2522ru%2522%252C%2522allows_write_to_pm%2522%253Atrue%252C%2522photo_url%2522%253A%2522https%253A%255C%252F%255C%252Ft.me%255C%252Fi%255C%252Fuserpic%255C%252F320%255C%252FOXwbOMueYZ5veQLSz0ygjfcgU-4yhnHeMKOSuAhAi9gMZXI6XwIliSn9-WV0AREK.svg%2522%257D%26auth_date%3D1759609132%26signature%3D-Z9w-IkHM3au52cQwfPSfbP2_GHAZWxc9fhaqCQ0mFR8WwAnbqQNLKTQ2I3C3_5shPl_0Abr89sVUym0jjsmBw%26hash%3D130f4fea4aad862c2578c4ceae5ea05622ee78be051d5a29f969905c9647f8f0"
    
    try:
        response = requests.get(f"{API_BASE}/user/profile?init_data={real_telegram_data}")
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                user = data.get('user', {})
                print("✅ Профиль пользователя с Stars работает:")
                print(f"   Пользователь: {user.get('first_name')}")
                print(f"   Username: @{user.get('username')}")
                print(f"   Баланс NDN: {user.get('balance_ndn')} NDN")
                print(f"   Баланс Stars: {user.get('balance_stars')} Stars")
                print(f"   Всего заработано Stars: {user.get('total_stars_earned')} Stars")
                print(f"   Всего потрачено Stars: {user.get('total_stars_spent')} Stars")
                print(f"   Pro статус: {user.get('is_pro')}")
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

def test_create_stars_payment():
    """Тест создания платежа за Stars"""
    print("\n💳 Тест создания платежа за Stars")
    print("-" * 50)
    
    real_telegram_data = "query_id%3DAAH6z9s5AgAAAPrP2zmCJWf0%26user%3D%257B%2522id%2522%253A5265674234%252C%2522first_name%2522%253A%2522%25D0%259C%25D0%25B0%25D0%25B9%25D1%258F%2522%252C%2522last_name%2522%253A%2522%2522%252C%2522username%2522%253A%2522mai_ryd%2522%252C%2522language_code%2522%253A%2522ru%2522%252C%2522allows_write_to_pm%2522%253Atrue%252C%2522photo_url%2522%253A%2522https%253A%255C%252F%255C%252Ft.me%255C%252Fi%255C%252Fuserpic%255C%252F320%255C%252FOXwbOMueYZ5veQLSz0ygjfcgU-4yhnHeMKOSuAhAi9gMZXI6XwIliSn9-WV0AREK.svg%2522%257D%26auth_date%3D1759609132%26signature%3D-Z9w-IkHM3au52cQwfPSfbP2_GHAZWxc9fhaqCQ0mFR8WwAnbqQNLKTQ2I3C3_5shPl_0Abr89sVUym0jjsmBw%26hash%3D130f4fea4aad862c2578c4ceae5ea05622ee78be051d5a29f969905c9647f8f0"
    
    try:
        response = requests.post(f"{API_BASE}/stars/create-payment", 
            json={
                "init_data": real_telegram_data,
                "stars_amount": 100.0
            },
            headers={'Content-Type': 'application/json'}
        )
        
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                print("✅ Создание платежа за Stars работает:")
                print(f"   ID платежа: {data.get('payment_id')}")
                print(f"   Сумма Stars: {data.get('stars_amount')}")
                print(f"   Сумма NDN: {data.get('ndn_amount')}")
                print(f"   URL платежа: {data.get('payment_url')}")
                return data.get('payment_id')
            else:
                print(f"❌ Ошибка создания платежа: {data.get('message')}")
                return None
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
            try:
                error_data = response.json()
                print(f"   Детали: {error_data.get('detail', 'Нет деталей')}")
            except:
                print(f"   Ответ: {response.text}")
            return None
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return None

def test_confirm_stars_payment(payment_id):
    """Тест подтверждения платежа за Stars"""
    print("\n✅ Тест подтверждения платежа за Stars")
    print("-" * 50)
    
    if not payment_id:
        print("❌ Нет ID платежа для тестирования")
        return False
    
    try:
        response = requests.post(f"{API_BASE}/stars/confirm-payment", 
            json={
                "payment_id": payment_id,
                "telegram_payment_id": f"test_payment_{int(time.time())}"
            },
            headers={'Content-Type': 'application/json'}
        )
        
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                print("✅ Подтверждение платежа за Stars работает:")
                print(f"   Сообщение: {data.get('message')}")
                print(f"   Сумма NDN: {data.get('ndn_amount')}")
                print(f"   Сумма Stars: {data.get('stars_amount')}")
                print(f"   Новый баланс: {data.get('new_balance')}")
                return True
            else:
                print(f"❌ Ошибка подтверждения: {data.get('message')}")
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

def test_stars_withdraw():
    """Тест вывода NDN в Stars"""
    print("\n💸 Тест вывода NDN в Stars")
    print("-" * 50)
    
    real_telegram_data = "query_id%3DAAH6z9s5AgAAAPrP2zmCJWf0%26user%3D%257B%2522id%2522%253A5265674234%252C%2522first_name%2522%253A%2522%25D0%259C%25D0%25B0%25D0%25B9%25D1%258F%2522%252C%2522last_name%2522%253A%2522%2522%252C%2522username%2522%253A%2522mai_ryd%2522%252C%2522language_code%2522%253A%2522ru%2522%252C%2522allows_write_to_pm%2522%253Atrue%252C%2522photo_url%2522%253A%2522https%253A%255C%252F%255C%252Ft.me%255C%252Fi%255C%252Fuserpic%255C%252F320%255C%252FOXwbOMueYZ5veQLSz0ygjfcgU-4yhnHeMKOSuAhAi9gMZXI6XwIliSn9-WV0AREK.svg%2522%257D%26auth_date%3D1759609132%26signature%3D-Z9w-IkHM3au52cQwfPSfbP2_GHAZWxc9fhaqCQ0mFR8WwAnbqQNLKTQ2I3C3_5shPl_0Abr89sVUym0jjsmBw%26hash%3D130f4fea4aad862c2578c4ceae5ea05622ee78be051d5a29f969905c9647f8f0"
    
    try:
        response = requests.post(f"{API_BASE}/stars/withdraw", 
            json={
                "init_data": real_telegram_data,
                "ndn_amount": 50.0
            },
            headers={'Content-Type': 'application/json'}
        )
        
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                print("✅ Вывод NDN в Stars работает:")
                print(f"   Сообщение: {data.get('message')}")
                print(f"   Сумма NDN: {data.get('ndn_amount')}")
                print(f"   Сумма Stars: {data.get('stars_amount')}")
                print(f"   Комиссия: {data.get('withdrawal_fee')}")
                print(f"   Новый баланс: {data.get('new_balance')}")
                return True
            else:
                print(f"❌ Ошибка вывода: {data.get('message')}")
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

def test_leaderboard_with_stars():
    """Тест лидерборда с Stars"""
    print("\n🏆 Тест лидерборда с Stars")
    print("-" * 40)
    
    try:
        response = requests.get(f"{API_BASE}/stats/leaderboard", timeout=10)
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                leaders = data.get('leaders', [])
                print(f"✅ Лидерборд с Stars работает:")
                print(f"   Количество лидеров: {len(leaders)}")
                if leaders:
                    top_leader = leaders[0]
                    print(f"   Топ-1: {top_leader.get('first_name')} - {top_leader.get('balance_ndn')} NDN, {top_leader.get('balance_stars')} Stars")
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
    """Основная функция тестирования Stars системы"""
    print("🧪 ТЕСТИРОВАНИЕ СИСТЕМЫ STARS")
    print("=" * 60)
    
    results = []
    
    # Тестируем все компоненты
    results.append(("API Health", test_api_health()))
    results.append(("Stars Config", test_stars_config()))
    results.append(("User Profile with Stars", test_user_profile_with_stars()))
    
    # Тестируем создание платежа
    payment_id = test_create_stars_payment()
    results.append(("Create Stars Payment", payment_id is not None))
    
    # Тестируем подтверждение платежа
    if payment_id:
        results.append(("Confirm Stars Payment", test_confirm_stars_payment(payment_id)))
    else:
        results.append(("Confirm Stars Payment", False))
    
    # Тестируем вывод
    results.append(("Stars Withdraw", test_stars_withdraw()))
    
    # Тестируем лидерборд
    results.append(("Leaderboard with Stars", test_leaderboard_with_stars()))
    
    # Подсчитываем результаты
    total_tests = len(results)
    passed_tests = sum(1 for _, status in results if status)
    
    print("\n" + "=" * 60)
    print("📊 РЕЗУЛЬТАТЫ ТЕСТИРОВАНИЯ STARS")
    print("=" * 60)
    
    for name, status in results:
        status_icon = "✅" if status else "❌"
        print(f"{status_icon} {name}")
    
    print(f"\n📈 Общий результат: {passed_tests}/{total_tests} тестов пройдено")
    
    if passed_tests == total_tests:
        print("\n🎉 ВСЕ ТЕСТЫ STARS ПРОЙДЕНЫ!")
        print("✅ Система Stars полностью работает")
        print("✅ Пользователи могут покупать NDN за Stars")
        print("✅ Пользователи могут выводить NDN в Stars")
        print("✅ Балансы Stars отображаются корректно")
    else:
        print(f"\n⚠️ {total_tests - passed_tests} тестов не прошли")
        print("🔧 Проверьте настройки базы данных и API")
    
    print("\n📝 Следующие шаги:")
    print("1. Выполните SQL скрипт ADD_STARS_SUPPORT.sql в Supabase")
    print("2. Замените main.py на main_with_stars.py")
    print("3. Замените index.html на index_with_stars.html")
    print("4. Перезапустите Railway")
    print("5. Протестируйте в Telegram Mini App")

if __name__ == "__main__":
    main()
