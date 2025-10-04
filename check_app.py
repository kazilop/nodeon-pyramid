#!/usr/bin/env python3
"""
Проверка доступности приложения NodeOn Pyramid
"""

import requests

def check_app():
    """Проверка доступности приложения"""
    
    app_url = "https://nodeon-production.up.railway.app"
    
    try:
        print(f"🔍 Проверяем доступность приложения: {app_url}")
        
        response = requests.get(app_url, timeout=10)
        
        print(f"📊 Статус ответа: {response.status_code}")
        print(f"📋 Заголовки: {dict(response.headers)}")
        
        if response.status_code == 200:
            print("✅ Приложение доступно!")
            
            # Проверяем содержимое
            content = response.text
            if "NodeOn" in content or "React" in content:
                print("✅ Приложение загружается корректно!")
            else:
                print("⚠️  Приложение загружается, но содержимое неожиданное")
                print(f"Первые 200 символов: {content[:200]}")
        else:
            print(f"❌ Ошибка доступа: {response.status_code}")
            print(f"Ответ: {response.text[:200]}")
            
    except Exception as e:
        print(f"❌ Ошибка при проверке: {e}")

def main():
    """Основная функция"""
    
    print("🚀 Проверка приложения NodeOn Pyramid...")
    print()
    
    check_app()

if __name__ == "__main__":
    main()
