#!/usr/bin/env python3
"""
Скрипт для тестирования API локализации
"""

import requests
import json

def test_localization_api():
    """Тестирует API локализации"""
    
    base_url = "https://sistemypro.ru/api/localization"
    
    print("Тестирование API локализации...")
    
    # Тест 1: Получение поддерживаемых языков
    print("\n1. Тест поддерживаемых языков:")
    try:
        response = requests.get(f"{base_url}/supported")
        print(f"Статус: {response.status_code}")
        if response.status_code == 200:
            data = response.json()
            print(f"Ответ: {json.dumps(data, indent=2, ensure_ascii=False)}")
        else:
            print(f"Ошибка: {response.text}")
    except Exception as e:
        print(f"Ошибка запроса: {e}")
    
    # Тест 2: Получение русских переводов
    print("\n2. Тест русских переводов:")
    try:
        response = requests.get(f"{base_url}/ru")
        print(f"Статус: {response.status_code}")
        if response.status_code == 200:
            data = response.json()
            print(f"Количество переводов: {data.get('count', 0)}")
            if 'translations' in data:
                print("Примеры переводов:")
                for i, (key, value) in enumerate(data['translations'].items()):
                    if i < 5:  # Показываем первые 5
                        print(f"  {key}: {value}")
        else:
            print(f"Ошибка: {response.text}")
    except Exception as e:
        print(f"Ошибка запроса: {e}")
    
    # Тест 3: Получение английских переводов
    print("\n3. Тест английских переводов:")
    try:
        response = requests.get(f"{base_url}/en")
        print(f"Статус: {response.status_code}")
        if response.status_code == 200:
            data = response.json()
            print(f"Количество переводов: {data.get('count', 0)}")
            if 'translations' in data:
                print("Примеры переводов:")
                for i, (key, value) in enumerate(data['translations'].items()):
                    if i < 5:  # Показываем первые 5
                        print(f"  {key}: {value}")
        else:
            print(f"Ошибка: {response.text}")
    except Exception as e:
        print(f"Ошибка запроса: {e}")
    
    # Тест 4: Получение конкретного перевода
    print("\n4. Тест конкретного перевода:")
    try:
        response = requests.get(f"{base_url}/en/buttons.buy_pro")
        print(f"Статус: {response.status_code}")
        if response.status_code == 200:
            data = response.json()
            print(f"Ответ: {json.dumps(data, indent=2, ensure_ascii=False)}")
        else:
            print(f"Ошибка: {response.text}")
    except Exception as e:
        print(f"Ошибка запроса: {e}")

def test_frontend_localization():
    """Тестирует фронтенд локализацию"""
    
    print("\n5. Тест фронтенд локализации:")
    
    # Проверяем, есть ли функция loadTranslations в HTML
    try:
        response = requests.get("https://sistemypro.ru/")
        if response.status_code == 200:
            html_content = response.text
            
            if 'loadTranslations' in html_content:
                print("✅ Функция loadTranslations найдена в HTML")
            else:
                print("❌ Функция loadTranslations НЕ найдена в HTML")
            
            if 'window.translations' in html_content:
                print("✅ Переменная window.translations найдена в HTML")
            else:
                print("❌ Переменная window.translations НЕ найдена в HTML")
            
            if 'data-i18n' in html_content:
                print("✅ Атрибуты data-i18n найдены в HTML")
            else:
                print("❌ Атрибуты data-i18n НЕ найдены в HTML")
                
        else:
            print(f"Ошибка загрузки HTML: {response.status_code}")
            
    except Exception as e:
        print(f"Ошибка тестирования фронтенда: {e}")

def main():
    """Основная функция"""
    test_localization_api()
    test_frontend_localization()
    
    print("\n" + "="*50)
    print("РЕЗУЛЬТАТЫ ТЕСТИРОВАНИЯ:")
    print("="*50)
    print("Если API возвращает HTML вместо JSON:")
    print("1. Таблица nodeon_localization не создана в Supabase")
    print("2. Выполните SQL из setup_localization_manual.sql в Supabase Dashboard")
    print("3. Перезапустите сервер: pm2 restart nodeon")
    print("\nЕсли API работает, но переводы не применяются:")
    print("1. Проверьте консоль браузера на ошибки")
    print("2. Убедитесь, что функция loadTranslations() вызывается")
    print("3. Проверьте, что data-i18n атрибуты есть на элементах")

if __name__ == "__main__":
    main()













