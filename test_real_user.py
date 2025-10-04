#!/usr/bin/env python3
"""
Тестирование с реальными данными пользователя
"""

import requests
import json

RAILWAY_URL = "https://nodeon-production.up.railway.app"

# Реальные данные Telegram из логов
real_init_data = "query_id=AAFn7WQMAAAAAGftZAym8xM1&user=%7B%22id%22%3A207940967%2C%22first_name%22%3A%22Fish%22%2C%22last_name%22%3A%22%22%2C%22username%22%3A%22NobodyYety%22%2C%22language_code%22%3A%22ru%22%2C%22is_premium%22%3Atrue%2C%22allows_write_to_pm%22%3Atrue%2C%22photo_url%22%3A%22https%253A%2F%2Ft.me%2Fi%2Fuserpic%2F320%2F6ZhmPb8VHMum-L3NuklXZIDjzwG5z3nmsPstk-j-X0Q.svg%22%7D&auth_date=1759589048&signature=IqcrTmc5udIux2TmYoFNRRGldsGj5cEgCzErhV9F9P8Em2Ep0QjsA6Er_CisvlqQhud44DH32KCjkadeiQ9EBQ&hash=f84de7979f9569a5d320a66bea2ae7682d39b2e9d7fadc1026a4f7c66c7c313f"

def test_user_profile():
    """Тестирование профиля пользователя с реальными данными"""
    print("🧪 Тестирование профиля пользователя с реальными данными")
    print("=" * 60)
    
    try:
        response = requests.get(
            f"{RAILWAY_URL}/api/user/profile",
            params={"init_data": real_init_data},
            timeout=10
        )
        
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            user = data.get('user', {})
            print(f"✅ Пользователь найден:")
            print(f"   ID: {user.get('id')}")
            print(f"   Telegram ID: {user.get('telegram_id')}")
            print(f"   Имя: {user.get('first_name')} {user.get('last_name')}")
            print(f"   Username: @{user.get('username')}")
            print(f"   Баланс: {user.get('balance_ndn')} NDN")
            print(f"   Pro статус: {'Да' if user.get('is_pro') else 'Нет'}")
            print(f"   Реферальная ссылка: {user.get('referral_link', 'Нет')}")
            
            return user
        else:
            print(f"❌ Ошибка: {response.text}")
            return None
            
    except Exception as e:
        print(f"❌ Исключение: {e}")
        return None

def test_buy_ndn(user_id):
    """Тестирование покупки NDN"""
    print("\n💰 Тестирование покупки NDN")
    print("=" * 40)
    
    try:
        # Тест с query параметрами
        print("Тест с query параметрами:")
        response = requests.post(
            f"{RAILWAY_URL}/api/ndn/buy",
            params={
                "init_data": real_init_data,
                "amount_ndn": 100
            },
            timeout=10
        )
        
        print(f"   Статус: {response.status_code}")
        if response.status_code == 200:
            data = response.json()
            print(f"   ✅ Успех: {data.get('message')}")
        else:
            print(f"   ❌ Ошибка: {response.text}")
        
        # Тест с body данными
        print("\nТест с body данными:")
        response = requests.post(
            f"{RAILWAY_URL}/api/ndn/buy",
            json={
                "init_data": real_init_data,
                "amount_ndn": 100
            },
            timeout=10
        )
        
        print(f"   Статус: {response.status_code}")
        if response.status_code == 200:
            data = response.json()
            print(f"   ✅ Успех: {data.get('message')}")
        else:
            print(f"   ❌ Ошибка: {response.text}")
            
    except Exception as e:
        print(f"❌ Исключение: {e}")

def test_buy_pro(user_id):
    """Тестирование покупки Pro статуса"""
    print("\n👑 Тестирование покупки Pro статуса")
    print("=" * 45)
    
    try:
        response = requests.post(
            f"{RAILWAY_URL}/api/pro/buy",
            params={"init_data": real_init_data},
            timeout=10
        )
        
        print(f"Статус: {response.status_code}")
        if response.status_code == 200:
            data = response.json()
            print(f"✅ Успех: {data.get('message')}")
        else:
            print(f"❌ Ошибка: {response.text}")
            
    except Exception as e:
        print(f"❌ Исключение: {e}")

def main():
    print("🚀 Тестирование с реальными данными Telegram")
    print("=" * 60)
    
    # Тестируем профиль пользователя
    user = test_user_profile()
    
    if user:
        user_id = user.get('id')
        
        # Тестируем покупку NDN
        test_buy_ndn(user_id)
        
        # Тестируем покупку Pro (если есть достаточно NDN)
        if user.get('balance_ndn', 0) >= 1000:
            test_buy_pro(user_id)
        else:
            print(f"\n⚠️  Недостаточно NDN для покупки Pro статуса (нужно 1000, есть {user.get('balance_ndn', 0)})")

if __name__ == "__main__":
    main()
