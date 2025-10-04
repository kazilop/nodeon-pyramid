#!/usr/bin/env python3
"""
Тест парсинга Telegram данных
"""

import json
import urllib.parse

def test_telegram_parsing():
    # Реальные данные из логов
    init_data = "query_id=AAFn7WQMAAAAAGftZAzxEfAo&user=%7B%22id%22%3A207940967%2C%22first_name%22%3A%22Fish%22%2C%22last_name%22%3A%22%22%2C%22username%22%3A%22NobodyYety%22%2C%22language_code%22%3A%22ru%22%2C%22is_premium%22%3Atrue%2C%22allows_write_to_pm%22%3Atrue%2C%22photo_url%22%3A%22https%253A%2F%2Ft.me%2Fi%2Fuserpic%2F320%2F6ZhmPb8VHMum-L3NuklXZIDjzwG5z3nmsPstk-j-X0Q.svg%22%7D&auth_date=1759590292&signature=0O-LauY4Fp4So4AqHPBEKqJ8XSwe6wuOCbq-w73xkCoYCHU3y3FtArUxprq93dc8FSQAUgr475hxTwbUDdFpAw&hash=e15fde1ad1585488f460af03915f1af2308c70b96361edae84e28a131617c154"
    
    print("🧪 Тестирование парсинга Telegram данных")
    print("=" * 50)
    print(f"Исходные данные: {init_data[:100]}...")
    print()
    
    # URL декодируем данные
    decoded_data = urllib.parse.unquote(init_data)
    print(f"Декодированные данные: {decoded_data[:200]}...")
    print()
    
    # Парсим данные
    data = {}
    for item in decoded_data.split('&'):
        if '=' in item:
            key, value = item.split('=', 1)
            data[key] = value
    
    print(f"Парсированные данные:")
    for key, value in data.items():
        print(f"  {key}: {value[:100]}{'...' if len(value) > 100 else ''}")
    print()
    
    # Парсим user данные
    user_data_str = data.get('user', '{}')
    print(f"User data string: {user_data_str}")
    print()
    
    if user_data_str and user_data_str != '{}':
        try:
            user_data = json.loads(user_data_str)
            print(f"✅ Успешно распарсили пользователя:")
            print(f"  ID: {user_data.get('id')}")
            print(f"  Имя: {user_data.get('first_name')}")
            print(f"  Фамилия: {user_data.get('last_name')}")
            print(f"  Username: @{user_data.get('username')}")
            print(f"  Язык: {user_data.get('language_code')}")
            print(f"  Premium: {user_data.get('is_premium')}")
            return user_data
        except json.JSONDecodeError as e:
            print(f"❌ JSON decode error: {e}")
            print(f"Raw user data: {user_data_str}")
            return None
    else:
        print("❌ No user data found")
        return None

if __name__ == "__main__":
    test_telegram_parsing()
