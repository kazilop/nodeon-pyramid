#!/usr/bin/env python3
"""
Скрипт для тестирования API на Netlify
"""

import requests
import json

def test_netlify_api():
    """Тестирование API на Netlify"""
    
    base_url = "https://nodeon-pyramid.netlify.app"
    
    print("🔍 Тестирование API на Netlify...")
    print(f"URL: {base_url}")
    
    # Тестируем проверку таблиц
    print("\n📋 Тестирование /api/miner/check-tables...")
    try:
        response = requests.get(f"{base_url}/api/miner/check-tables", timeout=10)
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print("✅ API работает!")
            print(f"Ответ: {json.dumps(data, indent=2, ensure_ascii=False)}")
        else:
            print(f"❌ Ошибка API: {response.text}")
            
    except Exception as e:
        print(f"❌ Ошибка подключения: {e}")
    
    # Тестируем получение данных майнера для пользователя 5
    print("\n⛏️ Тестирование /api/miner/data/5...")
    try:
        response = requests.get(f"{base_url}/api/miner/data/5", timeout=10)
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print("✅ Данные майнера получены!")
            if data.get('success') and data.get('miner_data'):
                miner_data = data['miner_data']
                print(f"Gas: {miner_data.get('ndnGas', 'N/A')}")
                print(f"Energy: {miner_data.get('energy', 'N/A')}")
                print(f"Farms: {len(miner_data.get('farms', []))}")
            else:
                print(f"Ответ: {json.dumps(data, indent=2, ensure_ascii=False)}")
        else:
            print(f"❌ Ошибка получения данных: {response.text}")
            
    except Exception as e:
        print(f"❌ Ошибка подключения: {e}")
    
    # Тестируем главную страницу
    print("\n🌐 Тестирование главной страницы...")
    try:
        response = requests.get(base_url, timeout=10)
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            print("✅ Главная страница загружается!")
            if "NodeOn Pyramid" in response.text:
                print("✅ Содержимое корректное")
            else:
                print("⚠️ Содержимое может быть некорректным")
        else:
            print(f"❌ Ошибка загрузки страницы: {response.text}")
            
    except Exception as e:
        print(f"❌ Ошибка подключения: {e}")

def test_telegram_auth():
    """Тестирование аутентификации Telegram"""
    
    print("\n🔐 Тестирование аутентификации...")
    
    # Моковые данные для тестирования
    test_init_data = "user=%7B%22id%22%3A207940967%2C%22first_name%22%3A%22Fish%22%2C%22username%22%3A%22NobodyYety%22%7D&auth_date=1699123456&hash=test_hash"
    
    try:
        response = requests.post(
            "https://nodeon-pyramid.netlify.app/api/auth/login",
            json={"initData": test_init_data},
            headers={"Content-Type": "application/json"},
            timeout=10
        )
        
        print(f"Статус: {response.status_code}")
        print(f"Ответ: {response.text}")
        
    except Exception as e:
        print(f"❌ Ошибка тестирования аутентификации: {e}")

def main():
    """Основная функция"""
    
    print("🧪 Тестирование NodeOn Pyramid на Netlify")
    print("=" * 50)
    
    test_netlify_api()
    test_telegram_auth()
    
    print("\n" + "=" * 50)
    print("✅ Тестирование завершено!")
    print("\n💡 Если API не работает:")
    print("   1. Проверьте переменные окружения в Netlify Dashboard")
    print("   2. Убедитесь, что деплой завершился успешно")
    print("   3. Проверьте логи функций в Netlify Dashboard")

if __name__ == "__main__":
    main()




