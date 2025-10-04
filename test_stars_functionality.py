#!/usr/bin/env python3
"""
Тестирование функционала Telegram Stars
"""

import requests
import json
import time

# Конфигурация
RAILWAY_URL = "https://nodeon-production.up.railway.app"
API_BASE = f"{RAILWAY_URL}/api"

def test_stars_config():
    """Тест получения конфигурации Stars"""
    print("🧪 Тестирование конфигурации Stars")
    print("=" * 50)
    
    try:
        response = requests.get(f"{API_BASE}/stars/config")
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print("✅ Конфигурация Stars получена:")
            for key, value in data['config'].items():
                print(f"   {key}: {value}")
        else:
            print(f"❌ Ошибка: {response.text}")
            
    except Exception as e:
        print(f"❌ Ошибка подключения: {e}")

def test_stars_purchase():
    """Тест покупки NDN за Stars"""
    print("\n🧪 Тестирование покупки NDN за Stars")
    print("=" * 50)
    
    try:
        # Тестовые данные
        test_data = {
            "stars_amount": 100,
            "payment_id": f"test_stars_{int(time.time())}"
        }
        
        response = requests.post(
            f"{API_BASE}/stars/buy-ndn?init_data=test_data",
            headers={'Content-Type': 'application/json'},
            json=test_data
        )
        
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print("✅ Покупка NDN за Stars успешна:")
            print(f"   Stars: {data.get('stars_amount')}")
            print(f"   NDN: {data.get('ndn_amount')}")
            print(f"   Новый баланс NDN: {data.get('new_ndn_balance')}")
            print(f"   Новый баланс Stars: {data.get('new_stars_balance')}")
        else:
            print(f"❌ Ошибка: {response.text}")
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")

def test_stars_withdraw():
    """Тест вывода NDN в Stars"""
    print("\n🧪 Тестирование вывода NDN в Stars")
    print("=" * 50)
    
    try:
        # Тестовые данные
        test_data = {
            "ndn_amount": 50
        }
        
        response = requests.post(
            f"{API_BASE}/stars/withdraw?init_data=test_data",
            headers={'Content-Type': 'application/json'},
            json=test_data
        )
        
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print("✅ Вывод NDN в Stars успешен:")
            print(f"   NDN: {data.get('ndn_amount')}")
            print(f"   Stars: {data.get('stars_amount')}")
            print(f"   Комиссия: {data.get('withdrawal_fee')}")
            print(f"   Новый баланс NDN: {data.get('new_ndn_balance')}")
            print(f"   Новый баланс Stars: {data.get('new_stars_balance')}")
        else:
            print(f"❌ Ошибка: {response.text}")
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")

def test_referral_stats():
    """Тест реферальной статистики"""
    print("\n🧪 Тестирование реферальной статистики")
    print("=" * 50)
    
    try:
        response = requests.get(f"{API_BASE}/stats/referrals?init_data=test_data")
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print("✅ Реферальная статистика получена:")
            print(f"   Всего рефералов: {data.get('total_referrals')}")
            
            referrals_by_level = data.get('referrals_by_level', {})
            for level, referrals in referrals_by_level.items():
                print(f"   Уровень {level}: {len(referrals)} рефералов")
        else:
            print(f"❌ Ошибка: {response.text}")
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")

def test_user_profile():
    """Тест профиля пользователя"""
    print("\n🧪 Тестирование профиля пользователя")
    print("=" * 50)
    
    try:
        response = requests.get(f"{API_BASE}/user/profile?init_data=test_data")
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print("✅ Профиль пользователя получен:")
            print(f"   Имя: {data.get('first_name')}")
            print(f"   Баланс NDN: {data.get('balance_ndn')}")
            print(f"   Pro статус: {data.get('is_pro')}")
            print(f"   Реферальная ссылка: {data.get('referral_link', 'Нет')}")
        else:
            print(f"❌ Ошибка: {response.text}")
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")

def main():
    """Основная функция тестирования"""
    print("🚀 Тестирование функционала Telegram Stars")
    print("=" * 60)
    
    # Тестируем все функции
    test_stars_config()
    test_user_profile()
    test_stars_purchase()
    test_stars_withdraw()
    test_referral_stats()
    
    print("\n✅ Тестирование завершено!")
    print("\n📝 Для полного тестирования:")
    print("1. Выполните SQL скрипты в Supabase")
    print("2. Откройте приложение в Telegram")
    print("3. Протестируйте покупку и вывод Stars")

if __name__ == "__main__":
    main()
