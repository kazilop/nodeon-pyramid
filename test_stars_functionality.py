#!/usr/bin/env python3
"""
Тестирование функциональности Stars
"""

import requests
import json

# Конфигурация
RAILWAY_URL = "https://nodeon-production.up.railway.app"
API_BASE = f"{RAILWAY_URL}/api"

def test_stars_config():
    """Тест конфигурации Stars"""
    print("⭐ Тест конфигурации Stars")
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
            try:
                error_data = response.json()
                print(f"   Детали: {error_data.get('detail', 'Нет деталей')}")
            except:
                print(f"   Ответ: {response.text}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def test_stars_purchase():
    """Тест покупки NDN за Stars"""
    print("\n💰 Тест покупки NDN за Stars")
    print("-" * 40)
    
    # Реальные данные Telegram
    real_telegram_data = "query_id%3DAAFn7WQMAAAAAGftZAynMETx%26user%3D%257B%2522id%2522%253A207940967%252C%2522first_name%2522%253A%2522Fish%2522%252C%2522last_name%2522%253A%2522%2522%252C%2522username%2522%253A%2522NobodyYety%2522%252C%2522language_code%2522%253A%2522ru%2522%252C%2522is_premium%2522%253Atrue%252C%2522allows_write_to_pm%2522%253Atrue%252C%2522photo_url%2522%253A%2522https%253A%255C%252F%255C%252Ft.me%255C%252Fi%255C%252Fuserpic%255C%252F320%255C%252F6ZhmPb8VHMum-L3NuklXZIDjzwG5z3nmsPstk-j-X0Q.svg%2522%257D%26auth_date%3D1759595069%26signature%3DzaTxfsbclaZwvnfSR1fy86Yr9_TDYfYKlbdlIDCI0CZHOte_WZ8DHcUuIxv7RVqoiuiux-yZqP-ZMMNLSnefDQ%26hash%3D5bd316b59632460d35963101eac62a76f2538fb18b5958ad6f9114f0931e29f9"
    
    try:
        # Тестируем покупку 100 Stars
        response = requests.post(
            f"{API_BASE}/stars/buy-ndn",
            params={"init_data": real_telegram_data, "stars_amount": 100},
            timeout=10
        )
        
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                print("✅ Покупка NDN за Stars работает:")
                print(f"   Куплено: {data.get('ndn_amount')} NDN")
                print(f"   За: {data.get('stars_amount')} Stars")
                print(f"   Новый баланс: {data.get('new_balance')} NDN")
                return True
            else:
                print(f"❌ Ошибка покупки: {data.get('message')}")
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

def test_stars_withdrawal():
    """Тест вывода NDN в Stars"""
    print("\n💸 Тест вывода NDN в Stars")
    print("-" * 40)
    
    # Реальные данные Telegram
    real_telegram_data = "query_id%3DAAFn7WQMAAAAAGftZAynMETx%26user%3D%257B%2522id%2522%253A207940967%252C%2522first_name%2522%253A%2522Fish%2522%252C%2522last_name%2522%253A%2522%2522%252C%2522username%2522%253A%2522NobodyYety%2522%252C%2522language_code%2522%253A%2522ru%2522%252C%2522is_premium%2522%253Atrue%252C%2522allows_write_to_pm%2522%253Atrue%252C%2522photo_url%2522%253A%2522https%253A%255C%252F%255C%252Ft.me%255C%252Fi%255C%252Fuserpic%255C%252F320%255C%252F6ZhmPb8VHMum-L3NuklXZIDjzwG5z3nmsPstk-j-X0Q.svg%2522%257D%26auth_date%3D1759595069%26signature%3DzaTxfsbclaZwvnfSR1fy86Yr9_TDYfYKlbdlIDCI0CZHOte_WZ8DHcUuIxv7RVqoiuiux-yZqP-ZMMNLSnefDQ%26hash%3D5bd316b59632460d35963101eac62a76f2538fb18b5958ad6f9114f0931e29f9"
    
    try:
        # Тестируем вывод 50 NDN
        response = requests.post(
            f"{API_BASE}/stars/withdraw",
            params={"init_data": real_telegram_data, "ndn_amount": 50},
            timeout=10
        )
        
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                print("✅ Вывод NDN в Stars работает:")
                print(f"   Выведено: {data.get('stars_amount')} Stars")
                print(f"   Из: {data.get('ndn_amount')} NDN")
                print(f"   Комиссия: {data.get('withdrawal_fee')} NDN")
                print(f"   Новый баланс: {data.get('new_balance')} NDN")
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

def test_yookassa_config():
    """Тест конфигурации ЮКассы"""
    print("\n💳 Тест конфигурации ЮКассы")
    print("-" * 40)
    
    try:
        response = requests.get(f"{API_BASE}/yookassa/config", timeout=10)
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                config = data.get('config', {})
                print("✅ Конфигурация ЮКассы работает:")
                print(f"   Курс: 1 RUB = {config.get('rub_to_ndn_rate')} NDN")
                print(f"   Минимум: {config.get('min_rub_purchase')} RUB")
                print(f"   Максимум: {config.get('max_rub_purchase')} RUB")
                print(f"   Shop ID: {config.get('yookassa_shop_id')}")
                return True
            else:
                print(f"❌ Ошибка конфигурации: {data.get('error')}")
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

def test_yookassa_payment():
    """Тест создания платежа через ЮКассу"""
    print("\n💳 Тест создания платежа через ЮКассу")
    print("-" * 40)
    
    # Реальные данные Telegram
    real_telegram_data = "query_id%3DAAFn7WQMAAAAAGftZAynMETx%26user%3D%257B%2522id%2522%253A207940967%252C%2522first_name%2522%253A%2522Fish%2522%252C%2522last_name%2522%253A%2522%2522%252C%2522username%2522%253A%2522NobodyYety%2522%252C%2522language_code%2522%253A%2522ru%2522%252C%2522is_premium%2522%253Atrue%252C%2522allows_write_to_pm%2522%253Atrue%252C%2522photo_url%2522%253A%2522https%253A%255C%252F%255C%252Ft.me%255C%252Fi%255C%252Fuserpic%255C%252F320%255C%252F6ZhmPb8VHMum-L3NuklXZIDjzwG5z3nmsPstk-j-X0Q.svg%2522%257D%26auth_date%3D1759595069%26signature%3DzaTxfsbclaZwvnfSR1fy86Yr9_TDYfYKlbdlIDCI0CZHOte_WZ8DHcUuIxv7RVqoiuiux-yZqP-ZMMNLSnefDQ%26hash%3D5bd316b59632460d35963101eac62a76f2538fb18b5958ad6f9114f0931e29f9"
    
    try:
        # Тестируем создание платежа на 1000 рублей
        response = requests.post(
            f"{API_BASE}/yookassa/create-payment",
            params={"init_data": real_telegram_data, "amount_rub": 1000},
            timeout=10
        )
        
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                print("✅ Создание платежа через ЮКассу работает:")
                print(f"   Payment ID: {data.get('payment_id')}")
                print(f"   Сумма: {data.get('amount_rub')} RUB")
                print(f"   NDN: {data.get('ndn_amount')} NDN")
                print(f"   URL: {data.get('payment_url')}")
                return True
            else:
                print(f"❌ Ошибка создания платежа: {data.get('message')}")
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

def main():
    """Основная функция тестирования"""
    print("🧪 ТЕСТИРОВАНИЕ ФУНКЦИОНАЛЬНОСТИ STARS И ЮКАССЫ")
    print("=" * 60)
    
    results = []
    
    # Тестируем все компоненты
    results.append(("Stars Config", test_stars_config()))
    results.append(("Stars Purchase", test_stars_purchase()))
    results.append(("Stars Withdrawal", test_stars_withdrawal()))
    results.append(("YooKassa Config", test_yookassa_config()))
    results.append(("YooKassa Payment", test_yookassa_payment()))
    
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
        print("✅ Stars и ЮКасса работают корректно")
        print("✅ Система готова к использованию")
    else:
        print(f"\n⚠️ {total_tests - passed_tests} тестов не прошли")
        print("🔧 Проверьте настройки базы данных и API")
    
    print("\n📝 Следующие шаги:")
    print("1. Выполните SQL скрипт в Supabase")
    print("2. Обновите API с поддержкой Stars")
    print("3. Настройте Telegram бота")
    print("4. Протестируйте в Telegram Mini App")

if __name__ == "__main__":
    main()