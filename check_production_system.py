#!/usr/bin/env python3
"""
Проверка продакшн системы NodeOn Pyramid
"""

import requests
import json
import time

# Конфигурация
RAILWAY_URL = "https://nodeon-production.up.railway.app"
API_BASE = f"{RAILWAY_URL}/api"
GITHUB_PAGES_URL = "https://kazilop.github.io/nodeon-pyramid/"

def check_railway_backend():
    """Проверка Railway бэкенда"""
    print("🔧 Проверка Railway бэкенда")
    print("-" * 40)
    
    try:
        # Проверяем здоровье API
        response = requests.get(f"{API_BASE}/test", timeout=10)
        if response.status_code == 200:
            data = response.json()
            print(f"✅ API работает: {data.get('message')}")
            return True
        else:
            print(f"❌ API не работает: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ Ошибка подключения к API: {e}")
        return False

def check_github_pages():
    """Проверка GitHub Pages фронтенда"""
    print("\n🌐 Проверка GitHub Pages фронтенда")
    print("-" * 40)
    
    try:
        response = requests.get(GITHUB_PAGES_URL, timeout=10)
        if response.status_code == 200:
            content = response.text
            if "NodeOn Pyramid" in content and "Telegram" in content:
                print("✅ Фронтенд работает и содержит нужный контент")
                return True
            else:
                print("⚠️ Фронтенд работает, но контент неполный")
                return False
        else:
            print(f"❌ Фронтенд не работает: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ Ошибка подключения к фронтенду: {e}")
        return False

def check_telegram_auth():
    """Проверка авторизации через Telegram"""
    print("\n🔐 Проверка авторизации через Telegram")
    print("-" * 40)
    
    # Реальные данные Telegram из логов
    real_telegram_data = "query_id%3DAAFn7WQMAAAAAGftZAynMETx%26user%3D%257B%2522id%2522%253A207940967%252C%2522first_name%2522%253A%2522Fish%2522%252C%2522last_name%2522%253A%2522%2522%252C%2522username%2522%253A%2522NobodyYety%2522%252C%2522language_code%2522%253A%2522ru%2522%252C%2522is_premium%2522%253Atrue%252C%2522allows_write_to_pm%2522%253Atrue%252C%2522photo_url%2522%253A%2522https%253A%255C%252F%255C%252Ft.me%255C%252Fi%255C%252Fuserpic%255C%252F320%255C%252F6ZhmPb8VHMum-L3NuklXZIDjzwG5z3nmsPstk-j-X0Q.svg%2522%257D%26auth_date%3D1759595069%26signature%3DzaTxfsbclaZwvnfSR1fy86Yr9_TDYfYKlbdlIDCI0CZHOte_WZ8DHcUuIxv7RVqoiuiux-yZqP-ZMMNLSnefDQ%26hash%3D5bd316b59632460d35963101eac62a76f2538fb18b5958ad6f9114f0931e29f9"
    
    try:
        # Тест с реальными данными
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

def check_stars_functionality():
    """Проверка функционала Stars"""
    print("\n⭐ Проверка функционала Stars")
    print("-" * 40)
    
    try:
        # Проверяем конфигурацию Stars
        response = requests.get(f"{API_BASE}/stars/config")
        if response.status_code == 200:
            data = response.json()
            config = data.get('config', {})
            print("✅ Конфигурация Stars доступна:")
            print(f"   Курс: 1 Star = {config.get('stars_to_ndn_rate')} NDN")
            print(f"   Минимум: {config.get('min_stars_purchase')} Stars")
            print(f"   Максимум: {config.get('max_stars_purchase')} Stars")
            return True
        else:
            print(f"❌ Конфигурация Stars недоступна: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def check_referral_system():
    """Проверка реферальной системы"""
    print("\n🔗 Проверка реферальной системы")
    print("-" * 40)
    
    real_telegram_data = "query_id%3DAAFn7WQMAAAAAGftZAynMETx%26user%3D%257B%2522id%2522%253A207940967%252C%2522first_name%2522%253A%2522Fish%2522%252C%2522last_name%2522%253A%2522%2522%252C%2522username%2522%253A%2522NobodyYety%2522%252C%2522language_code%2522%253A%2522ru%2522%252C%2522is_premium%2522%253Atrue%252C%2522allows_write_to_pm%2522%253Atrue%252C%2522photo_url%2522%253A%2522https%253A%255C%252F%255C%252Ft.me%255C%252Fi%255C%252Fuserpic%255C%252F320%255C%252F6ZhmPb8VHMum-L3NuklXZIDjzwG5z3nmsPstk-j-X0Q.svg%2522%257D%26auth_date%3D1759595069%26signature%3DzaTxfsbclaZwvnfSR1fy86Yr9_TDYfYKlbdlIDCI0CZHOte_WZ8DHcUuIxv7RVqoiuiux-yZqP-ZMMNLSnefDQ%26hash%3D5bd316b59632460d35963101eac62a76f2538fb18b5958ad6f9114f0931e29f9"
    
    try:
        # Проверяем реферальную статистику
        response = requests.get(f"{API_BASE}/stats/referrals?init_data={real_telegram_data}")
        if response.status_code == 200:
            data = response.json()
            print(f"✅ Реферальная система работает:")
            print(f"   Всего рефералов: {data.get('total_referrals')}")
            return True
        else:
            print(f"❌ Реферальная система не работает: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def check_leaderboard():
    """Проверка таблицы лидеров"""
    print("\n🏆 Проверка таблицы лидеров")
    print("-" * 40)
    
    try:
        response = requests.get(f"{API_BASE}/stats/leaderboard")
        if response.status_code == 200:
            data = response.json()
            leaders = data.get('leaders', [])
            print(f"✅ Таблица лидеров работает:")
            print(f"   Количество лидеров: {len(leaders)}")
            if leaders:
                top_leader = leaders[0]
                print(f"   Топ-1: {top_leader.get('first_name')} - {top_leader.get('balance_ndn')} NDN")
            return True
        else:
            print(f"❌ Таблица лидеров не работает: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def main():
    """Основная функция проверки"""
    print("🚀 ПРОВЕРКА ПРОДАКШН СИСТЕМЫ NODEON PYRAMID")
    print("=" * 60)
    
    results = []
    
    # Проверяем все компоненты
    results.append(("Railway Backend", check_railway_backend()))
    results.append(("GitHub Pages Frontend", check_github_pages()))
    results.append(("Telegram Auth", check_telegram_auth()))
    results.append(("Stars Functionality", check_stars_functionality()))
    results.append(("Referral System", check_referral_system()))
    results.append(("Leaderboard", check_leaderboard()))
    
    # Подсчитываем результаты
    total_checks = len(results)
    passed_checks = sum(1 for _, status in results if status)
    
    print("\n" + "=" * 60)
    print("📊 РЕЗУЛЬТАТЫ ПРОВЕРКИ")
    print("=" * 60)
    
    for name, status in results:
        status_icon = "✅" if status else "❌"
        print(f"{status_icon} {name}")
    
    print(f"\n📈 Общий результат: {passed_checks}/{total_checks} компонентов работают")
    
    if passed_checks == total_checks:
        print("\n🎉 ВСЕ КОМПОНЕНТЫ РАБОТАЮТ!")
        print("✅ Система готова к использованию")
        print(f"🌐 Фронтенд: {GITHUB_PAGES_URL}")
        print(f"🔧 API: {RAILWAY_URL}")
    else:
        print(f"\n⚠️ {total_checks - passed_checks} компонентов требуют внимания")
        print("🔧 Проверьте логи и настройки")
    
    print("\n📝 Следующие шаги:")
    print("1. Настройте Telegram бота")
    print("2. Выполните SQL скрипт в Supabase")
    print("3. Протестируйте приложение в Telegram")

if __name__ == "__main__":
    main()
