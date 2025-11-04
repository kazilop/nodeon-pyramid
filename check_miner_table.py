#!/usr/bin/env python3
"""
Проверка таблицы miner данных в Supabase
"""

import os
from supabase import create_client, Client
from dotenv import load_dotenv

def check_miner_table():
    """Проверяет таблицу miner данных"""
    
    load_dotenv()
    
    url = os.getenv('SUPABASE_URL')
    key = os.getenv('SUPABASE_ANON_KEY')
    
    if not url or not key:
        print("Ошибка: Не найдены переменные окружения")
        return False
    
    try:
        supabase: Client = create_client(url, key)
        
        # Проверяем, существует ли таблица miner данных
        try:
            result = supabase.table('nodeon_miner_data').select('*').limit(1).execute()
            print("Таблица nodeon_miner_data существует")
            print(f"Количество записей: {len(result.data) if result.data else 0}")
        except Exception as e:
            print(f"Таблица nodeon_miner_data не найдена: {e}")
            return False
        
        # Проверяем структуру таблицы
        try:
            result = supabase.table('nodeon_miner_data').select('id, user_id, miner_data, last_update, created_at, updated_at').limit(1).execute()
            print("Структура таблицы корректна")
        except Exception as e:
            print(f"Ошибка структуры таблицы: {e}")
            return False
        
        # Проверяем данные пользователя ID=5
        try:
            result = supabase.table('nodeon_miner_data').select('*').eq('user_id', 5).execute()
            if result.data:
                print(f"Данные майнера для пользователя ID=5 найдены: {len(result.data)} записей")
                for record in result.data:
                    print(f"  ID: {record['id']}, Last Update: {record.get('last_update', 'N/A')}")
            else:
                print("Данные майнера для пользователя ID=5 не найдены")
        except Exception as e:
            print(f"Ошибка поиска данных майнера: {e}")
            return False
        
        return True
        
    except Exception as e:
        print(f"Ошибка: {e}")
        return False

def test_miner_api():
    """Тестирует API майнера"""
    
    load_dotenv()
    
    url = os.getenv('SUPABASE_URL')
    key = os.getenv('SUPABASE_ANON_KEY')
    
    if not url or not key:
        return False
    
    try:
        supabase: Client = create_client(url, key)
        
        # Получаем данные пользователя ID=5
        user_result = supabase.table('nodeon_users').select('id, telegram_id').eq('id', 5).execute()
        if not user_result.data:
            print("Пользователь ID=5 не найден")
            return False
        
        user = user_result.data[0]
        print(f"Пользователь найден: ID={user['id']}, Telegram ID={user['telegram_id']}")
        
        # Тестируем получение данных майнера
        miner_result = supabase.table('nodeon_miner_data').select('*').eq('user_id', user['id']).execute()
        if miner_result.data:
            print(f"Данные майнера найдены: {len(miner_result.data)} записей")
            for record in miner_result.data:
                try:
                    miner_data = record.get('miner_data')
                    if miner_data:
                        import json
                        parsed_data = json.loads(miner_data)
                        print(f"  Парсинг данных успешен: Gas={parsed_data.get('ndnGas', 0)}, Energy={parsed_data.get('energy', 0)}")
                    else:
                        print(f"  Данные майнера пусты")
                except Exception as e:
                    print(f"  Ошибка парсинга данных: {e}")
        else:
            print("Данные майнера не найдены")
        
        return True
        
    except Exception as e:
        print(f"Ошибка тестирования API: {e}")
        return False

def main():
    """Основная функция"""
    print("Проверка таблицы miner данных...")
    
    if check_miner_table():
        print("\nТестирование API майнера...")
        test_miner_api()
    else:
        print("\nТаблица miner данных не готова")

if __name__ == "__main__":
    main()












