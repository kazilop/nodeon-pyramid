#!/usr/bin/env python3
"""
Тестирование покупки майнера
"""

import requests
import json

def test_buy_farm():
    """Тестирование покупки майнера"""
    print("🏭 Тестирование покупки майнера")
    print("=" * 50)
    
    # Тестируем API для покупки майнера
    url = "https://nodeon-pyramid.netlify.app/api/miner/buy-farm"
    
    # Данные для покупки
    data = {
        "user_id": 207940967,  # Telegram ID пользователя
        "farm_type": "basic"   # Тип фермы
    }
    
    try:
        print(f"📡 Запрос: {url}")
        print(f"📋 Данные: {json.dumps(data, indent=2)}")
        
        response = requests.post(url, json=data, timeout=10)
        print(f"📊 Статус: {response.status_code}")
        
        if response.status_code == 200:
            result = response.json()
            print(f"✅ Успешно: {json.dumps(result, indent=2, ensure_ascii=False)}")
        else:
            print(f"❌ Ошибка: {response.text}")
            
    except Exception as e:
        print(f"❌ Исключение: {e}")
    
    print("\n" + "=" * 50)
    print("✅ Тестирование завершено!")

if __name__ == "__main__":
    test_buy_farm()




