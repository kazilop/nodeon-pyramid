#!/usr/bin/env python3
"""
Тестирование серверного кошелька NodeOn Pyramid
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

def test_server_wallet_balance():
    """Тест баланса серверного кошелька"""
    print("\n🏦 Тест баланса серверного кошелька")
    print("-" * 50)
    
    try:
        response = requests.get(f"{API_BASE}/wallet/balance", timeout=10)
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                wallet = data.get('wallet', {})
                print("✅ Баланс серверного кошелька работает:")
                print(f"   ID кошелька: {wallet.get('id')}")
                print(f"   Название: {wallet.get('wallet_name')}")
                print(f"   Резерв NDN: {wallet.get('balance_ndn')} NDN")
                print(f"   Выдано NDN: {wallet.get('total_ndn_issued')} NDN")
                print(f"   Получено NDN: {wallet.get('total_ndn_received')} NDN")
                print(f"   Доступно NDN: {wallet.get('available_ndn')} NDN")
                return wallet
            else:
                print(f"❌ Ошибка кошелька: {data.get('error')}")
                return None
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
            return None
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return None

def test_buy_ndn_with_stars():
    """Тест покупки NDN за Stars через серверный кошелек"""
    print("\n💰 Тест покупки NDN за Stars")
    print("-" * 50)
    
    real_telegram_data = "query_id%3DAAH6z9s5AgAAAPrP2zmCJWf0%26user%3D%257B%2522id%2522%253A5265674234%252C%2522first_name%2522%253A%2522%25D0%259C%25D0%25B0%25D0%25B9%25D1%258F%2522%252C%2522last_name%2522%253A%2522%2522%252C%2522username%2522%253A%2522mai_ryd%2522%252C%2522language_code%2522%253A%2522ru%2522%252C%2522allows_write_to_pm%2522%253Atrue%252C%2522photo_url%2522%253A%2522https%253A%255C%252F%255C%252Ft.me%255C%252Fi%255C%252Fuserpic%255C%252F320%255C%252FOXwbOMueYZ5veQLSz0ygjfcgU-4yhnHeMKOSuAhAi9gMZXI6XwIliSn9-WV0AREK.svg%2522%257D%26auth_date%3D1759609132%26signature%3D-Z9w-IkHM3au52cQwfPSfbP2_GHAZWxc9fhaqCQ0mFR8WwAnbqQNLKTQ2I3C3_5shPl_0Abr89sVUym0jjsmBw%26hash%3D130f4fea4aad862c2578c4ceae5ea05622ee78be051d5a29f969905c9647f8f0"
    
    try:
        response = requests.post(f"{API_BASE}/stars/buy-ndn", 
            json={
                "init_data": real_telegram_data,
                "stars_amount": 50.0
            },
            headers={'Content-Type': 'application/json'}
        )
        
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                print("✅ Покупка NDN за Stars работает:")
                print(f"   Сообщение: {data.get('message')}")
                print(f"   Сумма Stars: {data.get('stars_amount')}")
                print(f"   Сумма NDN: {data.get('ndn_amount')}")
                print(f"   Баланс сервера до: {data.get('server_balance_before')} NDN")
                print(f"   Баланс сервера после: {data.get('server_balance_after')} NDN")
                print(f"   Баланс пользователя: {data.get('user_balance')} NDN")
                print(f"   ID транзакции: {data.get('transaction_id')}")
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

def test_sell_ndn_for_stars():
    """Тест продажи NDN за Stars через серверный кошелек"""
    print("\n⭐ Тест продажи NDN за Stars")
    print("-" * 50)
    
    real_telegram_data = "query_id%3DAAH6z9s5AgAAAPrP2zmCJWf0%26user%3D%257B%2522id%2522%253A5265674234%252C%2522first_name%2522%253A%2522%25D0%259C%25D0%25B0%25D0%25B9%25D1%258F%2522%252C%2522last_name%2522%253A%2522%2522%252C%2522username%2522%253A%2522mai_ryd%2522%252C%2522language_code%2522%253A%2522ru%2522%252C%2522allows_write_to_pm%2522%253Atrue%252C%2522photo_url%2522%253A%2522https%253A%255C%252F%255C%252Ft.me%255C%252Fi%255C%252Fuserpic%255C%252F320%255C%252FOXwbOMueYZ5veQLSz0ygjfcgU-4yhnHeMKOSuAhAi9gMZXI6XwIliSn9-WV0AREK.svg%2522%257D%26auth_date%3D1759609132%26signature%3D-Z9w-IkHM3au52cQwfPSfbP2_GHAZWxc9fhaqCQ0mFR8WwAnbqQNLKTQ2I3C3_5shPl_0Abr89sVUym0jjsmBw%26hash%3D130f4fea4aad862c2578c4ceae5ea05622ee78be051d5a29f969905c9647f8f0"
    
    try:
        response = requests.post(f"{API_BASE}/stars/sell-ndn", 
            json={
                "init_data": real_telegram_data,
                "ndn_amount": 25.0
            },
            headers={'Content-Type': 'application/json'}
        )
        
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                print("✅ Продажа NDN за Stars работает:")
                print(f"   Сообщение: {data.get('message')}")
                print(f"   Сумма NDN: {data.get('ndn_amount')}")
                print(f"   Сумма Stars: {data.get('stars_amount')}")
                print(f"   Комиссия: {data.get('withdrawal_fee')} NDN")
                print(f"   Баланс сервера до: {data.get('server_balance_before')} NDN")
                print(f"   Баланс сервера после: {data.get('server_balance_after')} NDN")
                print(f"   Баланс пользователя: {data.get('user_balance')} NDN")
                print(f"   ID транзакции: {data.get('transaction_id')}")
                return True
            else:
                print(f"❌ Ошибка продажи: {data.get('message')}")
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

def test_wallet_transactions():
    """Тест истории транзакций кошелька"""
    print("\n📊 Тест истории транзакций кошелька")
    print("-" * 50)
    
    try:
        response = requests.get(f"{API_BASE}/wallet/transactions?limit=10", timeout=10)
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                transactions = data.get('transactions', [])
                print(f"✅ История транзакций работает:")
                print(f"   Количество транзакций: {len(transactions)}")
                if transactions:
                    latest = transactions[0]
                    print(f"   Последняя транзакция:")
                    print(f"     Тип: {latest.get('type')}")
                    print(f"     Пользователь: {latest.get('user_name')}")
                    print(f"     Stars: {latest.get('stars_amount')}")
                    print(f"     NDN: {latest.get('ndn_amount')}")
                    print(f"     Баланс до: {latest.get('balance_before')}")
                    print(f"     Баланс после: {latest.get('balance_after')}")
                return True
            else:
                print(f"❌ Ошибка транзакций: {data.get('error')}")
                return False
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def test_insufficient_funds():
    """Тест недостаточных средств в кошельке"""
    print("\n🚫 Тест недостаточных средств")
    print("-" * 50)
    
    real_telegram_data = "query_id%3DAAH6z9s5AgAAAPrP2zmCJWf0%26user%3D%257B%2522id%2522%253A5265674234%252C%2522first_name%2522%253A%2522%25D0%259C%25D0%25B0%25D0%25B9%25D1%258F%2522%252C%2522last_name%2522%253A%2522%2522%252C%2522username%2522%253A%2522mai_ryd%2522%252C%2522language_code%2522%253A%2522ru%2522%252C%2522allows_write_to_pm%2522%253Atrue%252C%2522photo_url%2522%253A%2522https%253A%255C%252F%255C%252Ft.me%255C%252Fi%255C%252Fuserpic%255C%252F320%255C%252FOXwbOMueYZ5veQLSz0ygjfcgU-4yhnHeMKOSuAhAi9gMZXI6XwIliSn9-WV0AREK.svg%2522%257D%26auth_date%3D1759609132%26signature%3D-Z9w-IkHM3au52cQwfPSfbP2_GHAZWxc9fhaqCQ0mFR8WwAnbqQNLKTQ2I3C3_5shPl_0Abr89sVUym0jjsmBw%26hash%3D130f4fea4aad862c2578c4ceae5ea05622ee78be051d5a29f969905c9647f8f0"
    
    try:
        # Пытаемся купить очень много NDN
        response = requests.post(f"{API_BASE}/stars/buy-ndn", 
            json={
                "init_data": real_telegram_data,
                "stars_amount": 1000000.0  # Очень большая сумма
            },
            headers={'Content-Type': 'application/json'}
        )
        
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            if not data.get('success'):
                print("✅ Правильно заблокирована покупка при недостатке средств:")
                print(f"   Сообщение: {data.get('message')}")
                return True
            else:
                print("❌ Покупка прошла, хотя должна была быть заблокирована")
                return False
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def main():
    """Основная функция тестирования серверного кошелька"""
    print("🧪 ТЕСТИРОВАНИЕ СЕРВЕРНОГО КОШЕЛЬКА")
    print("=" * 60)
    
    results = []
    
    # Тестируем все компоненты
    results.append(("API Health", test_api_health()))
    
    # Тестируем серверный кошелек
    wallet = test_server_wallet_balance()
    results.append(("Server Wallet Balance", wallet is not None))
    
    # Тестируем покупку NDN
    results.append(("Buy NDN with Stars", test_buy_ndn_with_stars()))
    
    # Тестируем продажу NDN
    results.append(("Sell NDN for Stars", test_sell_ndn_for_stars()))
    
    # Тестируем историю транзакций
    results.append(("Wallet Transactions", test_wallet_transactions()))
    
    # Тестируем недостаточные средства
    results.append(("Insufficient Funds Check", test_insufficient_funds()))
    
    # Подсчитываем результаты
    total_tests = len(results)
    passed_tests = sum(1 for _, status in results if status)
    
    print("\n" + "=" * 60)
    print("📊 РЕЗУЛЬТАТЫ ТЕСТИРОВАНИЯ СЕРВЕРНОГО КОШЕЛЬКА")
    print("=" * 60)
    
    for name, status in results:
        status_icon = "✅" if status else "❌"
        print(f"{status_icon} {name}")
    
    print(f"\n📈 Общий результат: {passed_tests}/{total_tests} тестов пройдено")
    
    if passed_tests == total_tests:
        print("\n🎉 ВСЕ ТЕСТЫ СЕРВЕРНОГО КОШЕЛЬКА ПРОЙДЕНЫ!")
        print("✅ Серверный кошелек работает корректно")
        print("✅ NDN покупаются из реального резерва")
        print("✅ NDN продаются обратно в резерв")
        print("✅ Все транзакции записываются")
        print("✅ Проверка недостаточных средств работает")
    else:
        print(f"\n⚠️ {total_tests - passed_tests} тестов не прошли")
        print("🔧 Проверьте настройки базы данных и API")
    
    print("\n📝 Следующие шаги:")
    print("1. Выполните SQL скрипт CREATE_SERVER_WALLET.sql в Supabase")
    print("2. Замените main.py на main_with_server_wallet.py")
    print("3. Замените index.html на index_with_server_wallet.html")
    print("4. Перезапустите Railway")
    print("5. Протестируйте в Telegram Mini App")

if __name__ == "__main__":
    main()
