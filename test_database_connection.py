#!/usr/bin/env python3
"""
Скрипт для проверки подключения к базе данных Supabase
"""

import os
import requests
import json
from dotenv import load_dotenv

# Загружаем переменные окружения
load_dotenv()

SUPABASE_URL = os.getenv('SUPABASE_URL')
SUPABASE_ANON_KEY = os.getenv('SUPABASE_ANON_KEY')

def test_supabase_connection():
    """Тестирование подключения к Supabase"""
    
    print("🔍 Тестирование подключения к Supabase...")
    print(f"URL: {SUPABASE_URL}")
    print(f"Key: {SUPABASE_ANON_KEY[:20]}..." if SUPABASE_ANON_KEY else "Key: НЕ УСТАНОВЛЕН")
    
    if not SUPABASE_URL or not SUPABASE_ANON_KEY:
        print("❌ Переменные SUPABASE_URL и SUPABASE_ANON_KEY не установлены")
        return False
    
    headers = {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }
    
    try:
        # Тестируем подключение к таблице пользователей
        url = f"{SUPABASE_URL}/rest/v1/nodeon_users?select=count"
        response = requests.get(url, headers=headers, timeout=10)
        
        if response.status_code == 200:
            print("✅ Подключение к Supabase работает")
            return True
        else:
            print(f"❌ Ошибка подключения: {response.status_code}")
            print(f"Ответ: {response.text}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка подключения к Supabase: {e}")
        return False

def get_users_count():
    """Получение количества пользователей"""
    
    print("\n📊 Получение данных пользователей...")
    
    headers = {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }
    
    try:
        # Получаем всех пользователей
        url = f"{SUPABASE_URL}/rest/v1/nodeon_users?select=*"
        response = requests.get(url, headers=headers)
        
        if response.status_code == 200:
            users = response.json()
            print(f"✅ Найдено пользователей: {len(users)}")
            
            # Показываем первых 5 пользователей
            for i, user in enumerate(users[:5]):
                print(f"   {i+1}. ID: {user.get('id')}, Telegram ID: {user.get('telegram_id')}, "
                      f"Username: {user.get('username')}, Balance: {user.get('balance_ndn')}")
            
            if len(users) > 5:
                print(f"   ... и еще {len(users) - 5} пользователей")
            
            return users
        else:
            print(f"❌ Ошибка получения пользователей: {response.status_code}")
            print(f"Ответ: {response.text}")
            return []
            
    except Exception as e:
        print(f"❌ Ошибка получения пользователей: {e}")
        return []

def get_miner_data_count():
    """Получение количества записей майнера"""
    
    print("\n⛏️ Получение данных майнера...")
    
    headers = {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }
    
    try:
        # Получаем данные майнера
        url = f"{SUPABASE_URL}/rest/v1/nodeon_miner_data?select=*"
        response = requests.get(url, headers=headers)
        
        if response.status_code == 200:
            miner_data = response.json()
            print(f"✅ Найдено записей майнера: {len(miner_data)}")
            
            # Показываем первые записи
            for i, data in enumerate(miner_data[:3]):
                print(f"   {i+1}. User ID: {data.get('user_id')}, "
                      f"Gas: {json.loads(data.get('miner_data', '{}')).get('ndnGas', 'N/A')}")
            
            return miner_data
        else:
            print(f"❌ Ошибка получения данных майнера: {response.status_code}")
            print(f"Ответ: {response.text}")
            return []
            
    except Exception as e:
        print(f"❌ Ошибка получения данных майнера: {e}")
        return []

def check_tables():
    """Проверка существования таблиц"""
    
    print("\n📋 Проверка таблиц...")
    
    tables = [
        "nodeon_users",
        "nodeon_transactions", 
        "nodeon_referral_stats",
        "nodeon_miner_data",
        "nodeon_miner_stats"
    ]
    
    headers = {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }
    
    for table in tables:
        try:
            url = f"{SUPABASE_URL}/rest/v1/{table}?select=count"
            response = requests.get(url, headers=headers)
            
            if response.status_code == 200:
                print(f"   ✅ {table} - существует")
            else:
                print(f"   ❌ {table} - ошибка {response.status_code}")
                
        except Exception as e:
            print(f"   ❌ {table} - ошибка: {e}")

def main():
    """Основная функция"""
    
    print("🔍 Проверка подключения к базе данных Supabase")
    print("=" * 50)
    
    # Тестируем подключение
    if not test_supabase_connection():
        print("\n❌ Не удалось подключиться к базе данных")
        return
    
    # Проверяем таблицы
    check_tables()
    
    # Получаем данные пользователей
    users = get_users_count()
    
    # Получаем данные майнера
    miner_data = get_miner_data_count()
    
    print("\n" + "=" * 50)
    print("📊 ИТОГОВАЯ СТАТИСТИКА:")
    print(f"   👥 Пользователей: {len(users)}")
    print(f"   ⛏️ Записей майнера: {len(miner_data)}")
    
    if users:
        print("\n✅ База данных подключена и содержит данные")
        print("💡 Теперь можно настроить переменные окружения в Netlify")
    else:
        print("\n⚠️ База данных подключена, но пуста")
        print("💡 Возможно, нужно создать начальные данные")

if __name__ == "__main__":
    main()




