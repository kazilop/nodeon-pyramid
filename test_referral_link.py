#!/usr/bin/env python3
"""
Тестирование реферальной ссылки
"""

import requests
import json

def test_referral_link():
    """Тестирование реферальной ссылки"""
    print("🔗 Тестирование реферальной ссылки")
    print("=" * 50)
    
    # Тестируем API для получения данных пользователя
    url = "https://nodeon-pyramid.netlify.app/api/users/find-by-id/5"
    
    try:
        response = requests.get(url, timeout=10)
        print(f"📡 Запрос: {url}")
        print(f"📊 Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success') and data.get('user'):
                user = data['user']
                print(f"✅ Пользователь найден:")
                print(f"   ID: {user.get('id')}")
                print(f"   Telegram ID: {user.get('telegram_id')}")
                print(f"   Username: {user.get('username')}")
                print(f"   First Name: {user.get('first_name')}")
                print(f"   Is Pro: {user.get('is_pro')}")
                
                # Проверяем реферальную ссылку
                referral_link = user.get('referral_link', '')
                print(f"\n🔗 Реферальная ссылка: {referral_link}")
                
                if referral_link:
                    if 'pro_stars_bot' in referral_link:
                        print("✅ Использует правильное имя бота: pro_stars_bot")
                    else:
                        print("❌ Неправильное имя бота")
                    
                    if 'startapp=' in referral_link:
                        print("✅ Использует правильный параметр: startapp=")
                    else:
                        print("❌ Неправильный параметр (должен быть startapp=)")
                    
                    if f"ref_{user.get('id')}" in referral_link:
                        print(f"✅ Содержит правильный ID: ref_{user.get('id')}")
                    else:
                        print(f"❌ Неправильный ID в ссылке")
                        
                    # Проверяем, что ссылка полная
                    if referral_link.startswith('https://t.me/'):
                        print("✅ Полная ссылка с протоколом")
                    else:
                        print("❌ Неполная ссылка")
                else:
                    print("❌ Реферальная ссылка отсутствует")
            else:
                print("❌ Пользователь не найден в ответе")
        else:
            print(f"❌ Ошибка API: {response.text}")
            
    except Exception as e:
        print(f"❌ Исключение: {e}")
    
    print("\n" + "=" * 50)
    print("✅ Тестирование завершено!")

if __name__ == "__main__":
    test_referral_link()




