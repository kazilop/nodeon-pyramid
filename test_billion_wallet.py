#!/usr/bin/env python3
"""
Тестирование серверного кошелька с 1 миллиардом NDN
"""

import requests
import json
import time

# Конфигурация
RAILWAY_URL = "https://nodeon-production.up.railway.app"
API_BASE = f"{RAILWAY_URL}/api"
SUPABASE_URL = "https://ahxwpzgltlzlvrtrbanm.supabase.co"
SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoeHdwemdsdGx6bHZydHJiYW5tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1MDMxNDksImV4cCI6MjA3NTA3OTE0OX0.h4sMVhVwvRUiHgbevDgv9W1G2S__uDWPUSCiXdrEy4E"

def get_supabase_headers():
    """Получение заголовков для Supabase API"""
    return {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }

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

def test_billion_wallet_balance():
    """Тест баланса миллиардного кошелька"""
    print("\n💰 Тест баланса серверного кошелька (1 млрд NDN)")
    print("-" * 60)
    
    try:
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/get_server_wallet_balance",
            headers=get_supabase_headers(),
            json={}
        )
        
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                wallet = data.get('wallet', {})
                balance = float(wallet.get('balance_ndn', 0))
                
                print("✅ Баланс серверного кошелька работает:")
                print(f"   ID кошелька: {wallet.get('id')}")
                print(f"   Название: {wallet.get('wallet_name')}")
                print(f"   💰 Резерв NDN: {balance:,.2f} NDN")
                print(f"   📤 Выдано NDN: {wallet.get('total_ndn_issued'):,.2f} NDN")
                print(f"   📥 Получено NDN: {wallet.get('total_ndn_received'):,.2f} NDN")
                print(f"   💎 Доступно NDN: {balance:,.2f} NDN")
                
                # Проверяем, что баланс равен 1 миллиарду
                if balance >= 1000000000:
                    print("🎉 УСПЕХ: Серверный кошелек содержит 1+ миллиард NDN!")
                    return True
                else:
                    print(f"⚠️ ВНИМАНИЕ: Баланс меньше 1 миллиарда: {balance:,.2f} NDN")
                    return False
            else:
                print(f"❌ Ошибка кошелька: {data.get('error')}")
                return False
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
            print(f"Ответ: {response.text[:200]}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def test_stars_config():
    """Тест конфигурации Stars"""
    print("\n⭐ Тест конфигурации Stars")
    print("-" * 40)
    
    try:
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/get_stars_config",
            headers=get_supabase_headers(),
            json={}
        )
        
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                config = data.get('config', {})
                print("✅ Конфигурация Stars работает:")
                print(f"   Курс Stars → NDN: {config.get('stars_to_ndn_rate')}")
                print(f"   Курс NDN → Stars: {config.get('ndn_to_stars_rate')}")
                print(f"   Минимум покупки: {config.get('min_stars_purchase')} Stars")
                print(f"   Максимум покупки: {config.get('max_stars_purchase')} Stars")
                print(f"   Комиссия вывода: {config.get('stars_withdrawal_fee_percent')}%")
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

def test_tables_exist():
    """Тест существования таблиц"""
    print("\n🗄️ Тест существования таблиц")
    print("-" * 40)
    
    tables = [
        "nodeon_server_wallet",
        "nodeon_wallet_transactions", 
        "nodeon_stars_config",
        "nodeon_stars_payments"
    ]
    
    results = []
    
    for table in tables:
        try:
            response = requests.get(
                f"{SUPABASE_URL}/rest/v1/{table}?select=*&limit=1",
                headers=get_supabase_headers()
            )
            
            if response.status_code == 200:
                print(f"✅ Таблица {table} существует")
                results.append(True)
            else:
                print(f"❌ Таблица {table} не найдена: {response.status_code}")
                results.append(False)
                
        except Exception as e:
            print(f"❌ Ошибка проверки таблицы {table}: {e}")
            results.append(False)
    
    return all(results)

def test_large_purchase():
    """Тест большой покупки (100,000 Stars)"""
    print("\n💎 Тест большой покупки (100,000 Stars)")
    print("-" * 50)
    
    real_telegram_data = "query_id%3DAAH6z9s5AgAAAPrP2zmCJWf0%26user%3D%257B%2522id%2522%253A5265674234%252C%2522first_name%2522%253A%2522%25D0%259C%25D0%25B0%25D0%25B9%25D1%258F%2522%252C%2522last_name%2522%253A%2522%2522%252C%2522username%2522%253A%2522mai_ryd%2522%252C%2522language_code%2522%253A%2522ru%2522%252C%2522allows_write_to_pm%2522%253Atrue%252C%2522photo_url%2522%253A%2522https%253A%255C%252F%255C%252Ft.me%255C%252Fi%255C%252Fuserpic%255C%252F320%255C%252FOXwbOMueYZ5veQLSz0ygjfcgU-4yhnHeMKOSuAhAi9gMZXI6XwIliSn9-WV0AREK.svg%2522%257D%26auth_date%3D1759609132%26signature%3D-Z9w-IkHM3au52cQwfPSfbP2_GHAZWxc9fhaqCQ0mFR8WwAnbqQNLKTQ2I3C3_5shPl_0Abr89sVUym0jjsmBw%26hash%3D130f4fea4aad862c2578c4ceae5ea05622ee78be051d5a29f969905c9647f8f0"
    
    try:
        # Тестируем покупку 100,000 Stars (100,000 NDN)
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/process_stars_purchase",
            headers=get_supabase_headers(),
            json={
                "p_user_id": 5265674234,
                "p_stars_amount": 100000.0,
                "p_ndn_amount": 100000.0,
                "p_payment_id": "test_large_purchase_" + str(int(time.time()))
            }
        )
        
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                print("✅ Большая покупка работает:")
                print(f"   Сообщение: {data.get('message')}")
                print(f"   Сумма Stars: {data.get('stars_amount'):,.2f}")
                print(f"   Сумма NDN: {data.get('ndn_amount'):,.2f}")
                print(f"   Баланс сервера до: {data.get('server_balance_before'):,.2f} NDN")
                print(f"   Баланс сервера после: {data.get('server_balance_after'):,.2f} NDN")
                print(f"   Баланс пользователя: {data.get('user_balance'):,.2f} NDN")
                return True
            else:
                print(f"❌ Ошибка покупки: {data.get('error')}")
                return False
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def test_wallet_transactions():
    """Тест истории транзакций кошелька"""
    print("\n📊 Тест истории транзакций кошелька")
    print("-" * 50)
    
    try:
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/get_wallet_transactions",
            headers=get_supabase_headers(),
            json={
                "p_limit": 10,
                "p_offset": 0
            }
        )
        
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
                    print(f"     Баланс до: {latest.get('balance_before'):,.2f}")
                    print(f"     Баланс после: {latest.get('balance_after'):,.2f}")
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

def main():
    """Основная функция тестирования миллиардного кошелька"""
    print("🧪 ТЕСТИРОВАНИЕ СЕРВЕРНОГО КОШЕЛЬКА С 1 МИЛЛИАРДОМ NDN")
    print("=" * 70)
    
    results = []
    
    # Тестируем все компоненты
    results.append(("API Health", test_api_health()))
    results.append(("Tables Exist", test_tables_exist()))
    results.append(("Stars Config", test_stars_config()))
    results.append(("Billion Wallet Balance", test_billion_wallet_balance()))
    results.append(("Large Purchase", test_large_purchase()))
    results.append(("Wallet Transactions", test_wallet_transactions()))
    
    # Подсчитываем результаты
    total_tests = len(results)
    passed_tests = sum(1 for _, status in results if status)
    
    print("\n" + "=" * 70)
    print("📊 РЕЗУЛЬТАТЫ ТЕСТИРОВАНИЯ МИЛЛИАРДНОГО КОШЕЛЬКА")
    print("=" * 70)
    
    for name, status in results:
        status_icon = "✅" if status else "❌"
        print(f"{status_icon} {name}")
    
    print(f"\n📈 Общий результат: {passed_tests}/{total_tests} тестов пройдено")
    
    if passed_tests == total_tests:
        print("\n🎉 ВСЕ ТЕСТЫ МИЛЛИАРДНОГО КОШЕЛЬКА ПРОЙДЕНЫ!")
        print("✅ Серверный кошелек с 1 млрд NDN работает корректно")
        print("✅ Все таблицы Stars созданы")
        print("✅ RPC функции работают")
        print("✅ Большие покупки обрабатываются")
        print("✅ История транзакций ведется")
        print("🚀 СИСТЕМА ГОТОВА К ПРОДАЖЕ NDN ЗА TELEGRAM STARS!")
    else:
        print(f"\n⚠️ {total_tests - passed_tests} тестов не прошли")
        print("🔧 Проверьте выполнение SQL скрипта в Supabase")
    
    print("\n📝 Следующие шаги:")
    print("1. Выполните CREATE_BILLION_NDN_WALLET.sql в Supabase")
    print("2. Обновите API на Railway")
    print("3. Настройте Telegram бота")
    print("4. Активируйте Stars через @BotSupport")
    print("5. Протестируйте в Telegram Mini App")

if __name__ == "__main__":
    main()
