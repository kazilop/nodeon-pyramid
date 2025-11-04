#!/usr/bin/env python3
"""
Тест профиля пользователя
"""

import requests
import json

def test_user_profile():
    """Тестирование профиля пользователя"""
    
    base_url = "https://nodeon-pyramid.netlify.app"
    
    print("🔍 Тестирование профиля пользователя")
    print("=" * 50)
    
    # Моковые данные Telegram для тестирования
    test_init_data = "user=%7B%22id%22%3A207940967%2C%22first_name%22%3A%22Fish%22%2C%22username%22%3A%22NobodyYety%22%7D&auth_date=1699123456&hash=test_hash"
    
    try:
        response = requests.post(
            f"{base_url}/api/user/profile",
            headers={
                "Authorization": f"tma {test_init_data}",
                "Content-Type": "application/json"
            },
            timeout=15
        )
        
        print(f"Статус: {response.status_code}")
        print(f"Ответ: {response.text}")
        
        if response.status_code == 200:
            try:
                data = response.json()
                print(f"JSON: {json.dumps(data, indent=2, ensure_ascii=False)}")
                
                if data.get('success') and data.get('user'):
                    user = data['user']
                    print(f"\n📊 Данные пользователя:")
                    print(f"   ID (внутренний): {user.get('id')}")
                    print(f"   Telegram ID: {user.get('telegram_id')}")
                    print(f"   Username: {user.get('username')}")
                    print(f"   First Name: {user.get('first_name')}")
                    print(f"   Balance NDN: {user.get('balance_ndn')}")
                    print(f"   Is Pro: {user.get('is_pro')}")
                    
            except Exception as e:
                print(f"Ошибка парсинга JSON: {e}")
        else:
            print(f"Ошибка: {response.text}")
            
    except Exception as e:
        print(f"Ошибка подключения: {e}")

if __name__ == "__main__":
    test_user_profile()




