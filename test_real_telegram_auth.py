#!/usr/bin/env python3
"""
Тест с реальными данными Telegram
"""

import requests
import json

# Конфигурация
RAILWAY_URL = "https://nodeon-production.up.railway.app"
API_BASE = f"{RAILWAY_URL}/api"

def test_real_telegram_data():
    """Тест с реальными данными Telegram (из логов Railway)"""
    print("🧪 Тест с реальными данными Telegram")
    print("=" * 50)
    
    # Реальные данные из логов Railway
    real_init_data = "query_id%3DAAFn7WQMAAAAAGftZAynMETx%26user%3D%257B%2522id%2522%253A207940967%252C%2522first_name%2522%253A%2522Fish%2522%252C%2522last_name%2522%253A%2522%2522%252C%2522username%2522%253A%2522NobodyYety%2522%252C%2522language_code%2522%253A%2522ru%2522%252C%2522is_premium%2522%253Atrue%252C%2522allows_write_to_pm%2522%253Atrue%252C%2522photo_url%2522%253A%2522https%253A%255C%252F%255C%252Ft.me%255C%252Fi%255C%252Fuserpic%255C%252F320%255C%252F6ZhmPb8VHMum-L3NuklXZIDjzwG5z3nmsPstk-j-X0Q.svg%2522%257D%26auth_date%3D1759595069%26signature%3DzaTxfsbclaZwvnfSR1fy86Yr9_TDYfYKlbdlIDCI0CZHOte_WZ8DHcUuIxv7RVqoiuiux-yZqP-ZMMNLSnefDQ%26hash%3D5bd316b59632460d35963101eac62a76f2538fb18b5958ad6f9114f0931e29f9"
    
    try:
        response = requests.get(f"{API_BASE}/user/profile?init_data={real_init_data}")
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print("✅ Успешная авторизация с реальными данными Telegram:")
            print(f"   Пользователь: {data.get('user', {}).get('first_name')}")
            print(f"   Баланс: {data.get('user', {}).get('balance_ndn')}")
            print(f"   Pro статус: {data.get('user', {}).get('is_pro')}")
        elif response.status_code == 401:
            print("❌ Ошибка авторизации с реальными данными:")
            data = response.json()
            print(f"   Сообщение: {data.get('detail')}")
        else:
            print(f"❌ Неожиданный статус: {response.status_code}")
            try:
                data = response.json()
                print(f"   Ошибка: {data.get('detail')}")
            except:
                print("   Не удалось распарсить JSON")
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")

def test_invalid_telegram_data():
    """Тест с невалидными данными Telegram"""
    print("\n🧪 Тест с невалидными данными Telegram")
    print("=" * 50)
    
    invalid_data = "invalid_telegram_data"
    
    try:
        response = requests.get(f"{API_BASE}/user/profile?init_data={invalid_data}")
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 401:
            data = response.json()
            print("✅ Правильно заблокирован невалидный запрос:")
            print(f"   Сообщение: {data.get('detail')}")
        else:
            print(f"❌ Неожиданный статус: {response.status_code}")
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")

def test_missing_required_fields():
    """Тест с отсутствующими обязательными полями"""
    print("\n🧪 Тест с отсутствующими обязательными полями")
    print("=" * 50)
    
    # Данные без обязательных полей
    incomplete_data = "user=%7B%22id%22%3A123%7D"
    
    try:
        response = requests.get(f"{API_BASE}/user/profile?init_data={incomplete_data}")
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 401:
            data = response.json()
            print("✅ Правильно заблокирован запрос без обязательных полей:")
            print(f"   Сообщение: {data.get('detail')}")
        else:
            print(f"❌ Неожиданный статус: {response.status_code}")
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")

def main():
    """Основная функция тестирования"""
    print("🔐 Тестирование авторизации через Telegram API")
    print("=" * 60)
    
    test_real_telegram_data()
    test_invalid_telegram_data()
    test_missing_required_fields()
    
    print("\n✅ Тестирование завершено!")
    print("\n📝 Результат:")
    print("   - Реальные данные Telegram должны работать (200)")
    print("   - Невалидные данные должны блокироваться (401)")
    print("   - Неполные данные должны блокироваться (401)")

if __name__ == "__main__":
    main()
