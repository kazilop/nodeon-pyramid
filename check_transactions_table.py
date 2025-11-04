#!/usr/bin/env python3
"""
Проверка таблицы транзакций в Supabase
"""

import os
from supabase import create_client, Client
from dotenv import load_dotenv

def check_transactions_table():
    """Проверяет таблицу транзакций"""
    
    load_dotenv()
    
    url = os.getenv('SUPABASE_URL')
    key = os.getenv('SUPABASE_ANON_KEY')
    
    if not url or not key:
        print("Ошибка: Не найдены переменные окружения")
        return False
    
    try:
        supabase: Client = create_client(url, key)
        
        # Проверяем, существует ли таблица транзакций
        try:
            result = supabase.table('nodeon_transactions').select('*').limit(1).execute()
            print("Таблица nodeon_transactions существует")
            print(f"Количество записей: {len(result.data) if result.data else 0}")
        except Exception as e:
            print(f"Таблица nodeon_transactions не найдена: {e}")
            return False
        
        # Проверяем структуру таблицы
        try:
            result = supabase.table('nodeon_transactions').select('id, user_id, type, amount_ndn, amount_stars, description, status, created_at').limit(1).execute()
            print("Структура таблицы корректна")
        except Exception as e:
            print(f"Ошибка структуры таблицы: {e}")
            return False
        
        # Проверяем пользователя с ID 5
        try:
            result = supabase.table('nodeon_users').select('id, telegram_id').eq('id', 5).execute()
            if result.data:
                print(f"Пользователь ID=5 найден: {result.data[0]}")
            else:
                print("Пользователь ID=5 не найден")
                return False
        except Exception as e:
            print(f"Ошибка поиска пользователя: {e}")
            return False
        
        return True
        
    except Exception as e:
        print(f"Ошибка: {e}")
        return False

def create_test_transaction():
    """Создает тестовую транзакцию"""
    
    load_dotenv()
    
    url = os.getenv('SUPABASE_URL')
    key = os.getenv('SUPABASE_ANON_KEY')
    
    if not url or not key:
        return False
    
    try:
        supabase: Client = create_client(url, key)
        
        # Создаем тестовую транзакцию
        result = supabase.table('nodeon_transactions').insert({
            'user_id': 5,
            'type': 'buy_ndn_for_stars',
            'amount_ndn': 100,
            'amount_stars': 100,
            'description': 'Test transaction',
            'status': 'pending',
            'created_at': '2025-10-23T22:30:00.000Z'
        }).execute()
        
        if result.data:
            print(f"Тестовая транзакция создана: {result.data[0]['id']}")
            return True
        else:
            print("Не удалось создать тестовую транзакцию")
            return False
            
    except Exception as e:
        print(f"Ошибка создания транзакции: {e}")
        return False

def main():
    """Основная функция"""
    print("Проверка таблицы транзакций...")
    
    if check_transactions_table():
        print("\nСоздание тестовой транзакции...")
        create_test_transaction()
    else:
        print("\nТаблица транзакций не готова")

if __name__ == "__main__":
    main()
