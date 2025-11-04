#!/usr/bin/env python3
"""
Скрипт для тестирования API после деплоя
"""

import requests
import json
import time

def test_api_endpoints():
    """Тестирование всех API endpoints"""
    
    base_url = "https://nodeon-pyramid.netlify.app"
    
    print("🧪 Тестирование API после деплоя")
    print("=" * 50)
    
    # Ждем немного, чтобы деплой завершился
    print("⏳ Ожидание завершения деплоя...")
    time.sleep(5)
    
    # Тест 1: Проверка таблиц
    print("\n📋 Тест 1: Проверка таблиц")
    try:
        response = requests.get(f"{base_url}/api/miner/check-tables", timeout=15)
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print("✅ API работает!")
            print(f"Ответ: {json.dumps(data, indent=2, ensure_ascii=False)}")
        else:
            print(f"❌ Ошибка API: {response.text}")
            
    except Exception as e:
        print(f"❌ Ошибка подключения: {e}")
    
    # Тест 2: Получение данных майнера для пользователя 5 (NobodyYety)
    print("\n⛏️ Тест 2: Данные майнера для пользователя 5")
    try:
        response = requests.get(f"{base_url}/api/miner/data/5", timeout=15)
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print("✅ Данные майнера получены!")
            if data.get('success') and data.get('miner_data'):
                miner_data = data['miner_data']
                print(f"Gas: {miner_data.get('ndnGas', 'N/A')}")
                print(f"Energy: {miner_data.get('energy', 'N/A')}")
                print(f"Farms: {len(miner_data.get('farms', []))}")
                print(f"Total Gas Earned: {miner_data.get('totalGasEarned', 'N/A')}")
            else:
                print(f"Ответ: {json.dumps(data, indent=2, ensure_ascii=False)}")
        else:
            print(f"❌ Ошибка получения данных: {response.text}")
            
    except Exception as e:
        print(f"❌ Ошибка подключения: {e}")
    
    # Тест 3: Получение данных майнера для пользователя 207940967 (NobodyYety)
    print("\n⛏️ Тест 3: Данные майнера для пользователя 207940967")
    try:
        response = requests.get(f"{base_url}/api/miner/data/207940967", timeout=15)
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print("✅ Данные майнера получены!")
            if data.get('success') and data.get('miner_data'):
                miner_data = data['miner_data']
                print(f"Gas: {miner_data.get('ndnGas', 'N/A')}")
                print(f"Energy: {miner_data.get('energy', 'N/A')}")
                print(f"Farms: {len(miner_data.get('farms', []))}")
                print(f"Total Gas Earned: {miner_data.get('totalGasEarned', 'N/A')}")
            else:
                print(f"Ответ: {json.dumps(data, indent=2, ensure_ascii=False)}")
        else:
            print(f"❌ Ошибка получения данных: {response.text}")
            
    except Exception as e:
        print(f"❌ Ошибка подключения: {e}")
    
    # Тест 4: Главная страница
    print("\n🌐 Тест 4: Главная страница")
    try:
        response = requests.get(base_url, timeout=15)
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

def main():
    """Основная функция"""
    
    print("🚀 Тестирование NodeOn Pyramid API")
    print("URL: https://nodeon-pyramid.netlify.app")
    print("=" * 50)
    
    test_api_endpoints()
    
    print("\n" + "=" * 50)
    print("✅ Тестирование завершено!")
    print("\n💡 Если API работает:")
    print("   1. Откройте https://nodeon-pyramid.netlify.app в браузере")
    print("   2. Обновите webhook в BotFather")
    print("   3. Протестируйте бота командой /start")
    print("\n💡 Если API не работает:")
    print("   1. Проверьте логи в Netlify Dashboard")
    print("   2. Убедитесь, что переменные окружения установлены")
    print("   3. Проверьте статус деплоя")

if __name__ == "__main__":
    main()




