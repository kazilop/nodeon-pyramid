#!/usr/bin/env python3
"""
Исправление ошибки авторизации - failed to load user data
"""

import requests
import json

# Конфигурация
RAILWAY_URL = "https://nodeon-production.up.railway.app"
API_BASE = f"{RAILWAY_URL}/api"

def check_current_error():
    """Проверка текущей ошибки"""
    print("🔍 Проверка текущей ошибки авторизации")
    print("-" * 50)
    
    # Реальные данные Telegram из логов
    real_telegram_data = "query_id%3DAAH6z9s5AgAAAPrP2zmCJWf0%26user%3D%257B%2522id%2522%253A5265674234%252C%2522first_name%2522%253A%2522%25D0%259C%25D0%25B0%25D0%25B9%25D1%258F%2522%252C%2522last_name%2522%253A%2522%2522%252C%2522username%2522%253A%2522mai_ryd%2522%252C%2522language_code%2522%253A%2522ru%2522%252C%2522allows_write_to_pm%2522%253Atrue%252C%2522photo_url%2522%253A%2522https%253A%255C%252F%255C%252Ft.me%255C%252Fi%255C%252Fuserpic%255C%252F320%255C%252FOXwbOMueYZ5veQLSz0ygjfcgU-4yhnHeMKOSuAhAi9gMZXI6XwIliSn9-WV0AREK.svg%2522%257D%26auth_date%3D1759609132%26signature%3D-Z9w-IkHM3au52cQwfPSfbP2_GHAZWxc9fhaqCQ0mFR8WwAnbqQNLKTQ2I3C3_5shPl_0Abr89sVUym0jjsmBw%26hash%3D130f4fea4aad862c2578c4ceae5ea05622ee78be051d5a29f969905c9647f8f0"
    
    try:
        response = requests.get(f"{API_BASE}/user/profile?init_data={real_telegram_data}")
        print(f"Статус: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print("✅ Авторизация работает!")
            user = data.get('user', {})
            print(f"   Пользователь: {user.get('first_name')}")
            print(f"   Баланс: {user.get('balance_ndn')} NDN")
            print(f"   Pro статус: {user.get('is_pro')}")
            return True
        else:
            print(f"❌ Ошибка авторизации: {response.status_code}")
            try:
                error_data = response.json()
                print(f"   Детали: {error_data.get('detail', 'Нет деталей')}")
            except:
                print(f"   Ответ: {response.text}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def check_api_health():
    """Проверка здоровья API"""
    print("\n🏥 Проверка здоровья API")
    print("-" * 30)
    
    try:
        response = requests.get(f"{API_BASE}/test")
        if response.status_code == 200:
            data = response.json()
            print(f"✅ API работает: {data.get('message')}")
            return True
        else:
            print(f"❌ API не работает: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def show_fix_instructions():
    """Показать инструкции по исправлению"""
    print("\n🔧 ИНСТРУКЦИИ ПО ИСПРАВЛЕНИЮ")
    print("=" * 50)
    
    print("""
❌ ПРОБЛЕМА: Отсутствует колонка 'is_active' в таблице 'nodeon_users'

✅ РЕШЕНИЕ: Выполните SQL скрипт в Supabase

📋 Шаги исправления:

1. 🔧 Откройте Supabase:
   - Перейдите на https://supabase.com/dashboard
   - Войдите в проект ahxwpzgltlzlvrtrbanm
   - Откройте SQL Editor

2. 📝 Выполните SQL скрипт:
   - Скопируйте содержимое файла FIX_DATABASE_SCHEMA.sql
   - Вставьте в SQL Editor
   - Нажмите "Run" для выполнения

3. ✅ Проверьте результат:
   - Запустите: python fix_auth_error.py
   - Должно показать: "Авторизация работает!"

📊 Что исправляет скрипт:
   - Удаляет старые таблицы с неправильной структурой
   - Создает новые таблицы с правильными колонками
   - Добавляет все необходимые индексы
   - Создает функции для Stars и ЮКассы
   - Настраивает конфигурацию
   - Создает разработчика

⏱️ Время исправления: ~2 минуты
""")

def main():
    """Основная функция"""
    print("🚀 ИСПРАВЛЕНИЕ ОШИБКИ АВТОРИЗАЦИИ")
    print("=" * 50)
    
    # Проверяем API
    api_ok = check_api_health()
    
    if not api_ok:
        print("\n❌ API не работает. Проверьте Railway.")
        return
    
    # Проверяем текущую ошибку
    auth_ok = check_current_error()
    
    if auth_ok:
        print("\n🎉 ПРОБЛЕМА УЖЕ ИСПРАВЛЕНА!")
        print("✅ Авторизация работает корректно")
        print("✅ Пользователи могут загружать данные")
    else:
        print("\n⚠️ ПРОБЛЕМА НЕ ИСПРАВЛЕНА")
        show_fix_instructions()
        
        print("\n📝 После выполнения SQL скрипта:")
        print("1. Подождите 1-2 минуты")
        print("2. Запустите: python fix_auth_error.py")
        print("3. Проверьте в Telegram Mini App")

if __name__ == "__main__":
    main()
