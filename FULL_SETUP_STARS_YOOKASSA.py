#!/usr/bin/env python3
"""
Полная настройка NodeOn Pyramid с поддержкой Stars и ЮКассы
"""

import requests
import json
import time

# Конфигурация
RAILWAY_URL = "https://nodeon-production.up.railway.app"
API_BASE = f"{RAILWAY_URL}/api"
GITHUB_PAGES_URL = "https://kazilop.github.io/nodeon-pyramid/"

def print_header(title):
    """Красивый заголовок"""
    print("\n" + "=" * 60)
    print(f"🚀 {title}")
    print("=" * 60)

def print_step(step, description):
    """Шаг настройки"""
    print(f"\n📋 Шаг {step}: {description}")
    print("-" * 40)

def check_api_health():
    """Проверка здоровья API"""
    print_step(1, "Проверка API")
    
    try:
        response = requests.get(f"{API_BASE}/test", timeout=10)
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

def check_database_setup():
    """Проверка настройки базы данных"""
    print_step(2, "Проверка базы данных")
    
    try:
        # Проверяем Stars конфигурацию
        response = requests.get(f"{API_BASE}/stars/config")
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                config = data.get('config', {})
                print("✅ База данных настроена:")
                print(f"   Курс Stars: 1 Star = {config.get('stars_to_ndn_rate')} NDN")
                print(f"   Минимум: {config.get('min_stars_purchase')} Stars")
                print(f"   Максимум: {config.get('max_stars_purchase')} Stars")
                return True
            else:
                print(f"❌ Ошибка конфигурации Stars: {data.get('error')}")
                return False
        else:
            print(f"⚠️ База данных требует настройки: {response.status_code}")
            print("📝 Выполните SQL скрипт SETUP_STARS_AND_YOOKASSA.sql в Supabase")
            return False
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def check_stars_functionality():
    """Проверка функциональности Stars"""
    print_step(3, "Проверка Stars")
    
    try:
        # Проверяем конфигурацию Stars
        response = requests.get(f"{API_BASE}/stars/config")
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                print("✅ Stars функциональность работает")
                return True
            else:
                print(f"❌ Stars не работает: {data.get('error')}")
                return False
        else:
            print(f"❌ Stars недоступен: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def check_yookassa_functionality():
    """Проверка функциональности ЮКассы"""
    print_step(4, "Проверка ЮКассы")
    
    try:
        # Проверяем конфигурацию ЮКассы
        response = requests.get(f"{API_BASE}/yookassa/config")
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                config = data.get('config', {})
                print("✅ ЮКасса настроена:")
                print(f"   Курс: 1 RUB = {config.get('rub_to_ndn_rate')} NDN")
                print(f"   Минимум: {config.get('min_rub_purchase')} RUB")
                print(f"   Максимум: {config.get('max_rub_purchase')} RUB")
                return True
            else:
                print(f"❌ ЮКасса не работает: {data.get('error')}")
                return False
        else:
            print(f"❌ ЮКасса недоступна: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def check_telegram_auth():
    """Проверка авторизации через Telegram"""
    print_step(5, "Проверка авторизации через Telegram")
    
    # Реальные данные Telegram
    real_telegram_data = "query_id%3DAAFn7WQMAAAAAGftZAynMETx%26user%3D%257B%2522id%2522%253A207940967%252C%2522first_name%2522%253A%2522Fish%2522%252C%2522last_name%2522%253A%2522%2522%252C%2522username%2522%253A%2522NobodyYety%2522%252C%2522language_code%2522%253A%2522ru%2522%252C%2522is_premium%2522%253Atrue%252C%2522allows_write_to_pm%2522%253Atrue%252C%2522photo_url%2522%253A%2522https%253A%255C%252F%255C%252Ft.me%255C%252Fi%255C%252Fuserpic%255C%252F320%255C%252F6ZhmPb8VHMum-L3NuklXZIDjzwG5z3nmsPstk-j-X0Q.svg%2522%257D%26auth_date%3D1759595069%26signature%3DzaTxfsbclaZwvnfSR1fy86Yr9_TDYfYKlbdlIDCI0CZHOte_WZ8DHcUuIxv7RVqoiuiux-yZqP-ZMMNLSnefDQ%26hash%3D5bd316b59632460d35963101eac62a76f2538fb18b5958ad6f9114f0931e29f9"
    
    try:
        response = requests.get(f"{API_BASE}/user/profile?init_data={real_telegram_data}")
        if response.status_code == 200:
            data = response.json()
            user = data.get('user', {})
            print(f"✅ Авторизация работает: {user.get('first_name')}")
            print(f"   Баланс: {user.get('balance_ndn')} NDN")
            print(f"   Pro статус: {user.get('is_pro')}")
            return True
        else:
            print(f"❌ Ошибка авторизации: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def check_frontend():
    """Проверка фронтенда"""
    print_step(6, "Проверка фронтенда")
    
    try:
        response = requests.get(GITHUB_PAGES_URL, timeout=10)
        if response.status_code == 200:
            content = response.text
            if "NodeOn Pyramid" in content and "Stars" in content:
                print("✅ Фронтенд работает с поддержкой Stars")
                print(f"🌐 URL: {GITHUB_PAGES_URL}")
                return True
            else:
                print("⚠️ Фронтенд работает, но контент неполный")
                return False
        else:
            print(f"❌ Фронтенд не работает: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def show_setup_instructions():
    """Показать инструкции по настройке"""
    print_header("ИНСТРУКЦИИ ПО НАСТРОЙКЕ")
    
    print("""
📋 Для полной настройки системы выполните следующие шаги:

1. 🔧 Настройка базы данных Supabase:
   - Откройте https://supabase.com/dashboard
   - Войдите в проект ahxwpzgltlzlvrtrbanm
   - Откройте SQL Editor
   - Выполните скрипт из файла SETUP_STARS_AND_YOOKASSA.sql

2. 🤖 Настройка Telegram бота с Stars:
   - Создайте бота через @BotFather
   - Активируйте поддержку Stars (обратитесь в поддержку Telegram)
   - Настройте Mini App с URL: https://kazilop.github.io/nodeon-pyramid/
   - Выполните: python setup_telegram_bot_stars.py

3. 💳 Настройка ЮКассы:
   - Зарегистрируйтесь на https://yookassa.ru/
   - Получите Shop ID и Secret Key
   - Обновите конфигурацию в Supabase
   - Настройте webhook: https://nodeon-production.up.railway.app/api/yookassa/webhook

4. 🔄 Обновление API:
   - Замените main.py на main_with_payments.py
   - Добавьте зависимости в requirements.txt
   - Перезапустите Railway

5. 🧪 Тестирование:
   - Запустите: python test_stars_functionality.py
   - Протестируйте в Telegram Mini App
""")

def main():
    """Основная функция"""
    print_header("ПОЛНАЯ НАСТРОЙКА NODEON PYRAMID С STARS И ЮКАССОЙ")
    
    print("🔍 Проверяем текущее состояние системы...")
    
    # Проверяем все компоненты
    api_ok = check_api_health()
    db_ok = check_database_setup()
    stars_ok = check_stars_functionality()
    yookassa_ok = check_yookassa_functionality()
    auth_ok = check_telegram_auth()
    frontend_ok = check_frontend()
    
    # Подсчитываем результаты
    total_checks = 6
    passed_checks = sum([api_ok, db_ok, stars_ok, yookassa_ok, auth_ok, frontend_ok])
    
    print_header("РЕЗУЛЬТАТЫ ПРОВЕРКИ")
    
    print(f"✅ API: {'Работает' if api_ok else 'Не работает'}")
    print(f"✅ База данных: {'Настроена' if db_ok else 'Требует настройки'}")
    print(f"✅ Stars: {'Работает' if stars_ok else 'Не работает'}")
    print(f"✅ ЮКасса: {'Работает' if yookassa_ok else 'Не работает'}")
    print(f"✅ Авторизация: {'Работает' if auth_ok else 'Не работает'}")
    print(f"✅ Frontend: {'Работает' if frontend_ok else 'Не работает'}")
    
    print(f"\n📊 Общий результат: {passed_checks}/{total_checks} компонентов готовы")
    
    if passed_checks == total_checks:
        print_header("🎉 СИСТЕМА ПОЛНОСТЬЮ ГОТОВА!")
        print("""
✅ Все компоненты работают
✅ Stars интеграция активна
✅ ЮКасса настроена
✅ Система готова к использованию

🌐 URL системы:
   Frontend: https://kazilop.github.io/nodeon-pyramid/
   API: https://nodeon-production.up.railway.app/api

📱 Для тестирования:
   1. Откройте Telegram бота
   2. Нажмите "Запустить приложение"
   3. Проверьте все функции:
      - Покупка NDN за Stars
      - Покупка NDN за рубли
      - Вывод NDN в Stars
      - Реферальная система
""")
    else:
        print_header("⚠️ ТРЕБУЕТСЯ ДОНАСТРОЙКА")
        show_setup_instructions()
        
        print(f"\n🔧 Необходимо настроить {total_checks - passed_checks} компонентов")
        print("📝 Следуйте инструкциям выше для завершения настройки")
        
        if not db_ok:
            print("\n🔥 ПРИОРИТЕТ: Настройте базу данных!")
            print("   Выполните SQL скрипт SETUP_STARS_AND_YOOKASSA.sql")
        
        if not stars_ok:
            print("\n⭐ ВАЖНО: Настройте Stars!")
            print("   Обратитесь в поддержку Telegram для активации Stars")
        
        if not yookassa_ok:
            print("\n💳 РЕКОМЕНДУЕТСЯ: Настройте ЮКассу!")
            print("   Зарегистрируйтесь на https://yookassa.ru/")

if __name__ == "__main__":
    main()
