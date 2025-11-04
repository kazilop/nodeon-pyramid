#!/usr/bin/env python3
"""
Скрипт для загрузки данных локализации в Supabase
"""

import os
import json
from supabase import create_client, Client
from dotenv import load_dotenv

def load_localization_data():
    """Загружает данные локализации в Supabase"""
    
    # Загружаем переменные окружения
    load_dotenv()
    
    url = os.getenv('SUPABASE_URL')
    key = os.getenv('SUPABASE_ANON_KEY')
    
    if not url or not key:
        print("Ошибка: Не найдены переменные окружения SUPABASE_URL и SUPABASE_ANON_KEY")
        return False
    
    try:
        # Создаем клиент Supabase
        supabase: Client = create_client(url, key)
        print("✅ Подключение к Supabase установлено")
        
        # Читаем SQL файл с данными
        sql_file = 'insert_localization_from_json.sql'
        if not os.path.exists(sql_file):
            print(f"Файл {sql_file} не найден!")
            return False
        
        with open(sql_file, 'r', encoding='utf-8') as f:
            sql_content = f.read()
        
        # Разбиваем на отдельные запросы
        sql_queries = [q.strip() for q in sql_content.split(';') if q.strip() and not q.strip().startswith('--')]
        
        print(f"📊 Найдено {len(sql_queries)} SQL запросов")
        
        # Выполняем запросы
        success_count = 0
        error_count = 0
        
        for i, query in enumerate(sql_queries):
            if not query:
                continue
                
            try:
                # Выполняем запрос через RPC
                result = supabase.rpc('exec_sql', {'sql': query}).execute()
                success_count += 1
                
                if (i + 1) % 50 == 0:
                    print(f"✅ Обработано {i + 1} запросов...")
                    
            except Exception as e:
                error_count += 1
                print(f"❌ Ошибка в запросе {i + 1}: {e}")
                if error_count > 10:  # Останавливаемся после 10 ошибок
                    print("Слишком много ошибок, останавливаемся...")
                    break
        
        print(f"\n📈 Результат:")
        print(f"  ✅ Успешно: {success_count}")
        print(f"  ❌ Ошибок: {error_count}")
        
        if success_count > 0:
            print("🎉 Данные локализации загружены в Supabase!")
            return True
        else:
            print("❌ Не удалось загрузить данные")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def test_localization_api():
    """Тестирует API локализации"""
    
    load_dotenv()
    
    url = os.getenv('SUPABASE_URL')
    key = os.getenv('SUPABASE_ANON_KEY')
    
    if not url or not key:
        return False
    
    try:
        supabase: Client = create_client(url, key)
        
        # Тестируем получение переводов
        result = supabase.table('nodeon_localization').select('text_id, ru, en').limit(5).execute()
        
        if result.data:
            print("\n🧪 Тест API локализации:")
            for item in result.data:
                print(f"  {item['text_id']}: {item['ru']} -> {item.get('en', 'N/A')}")
            return True
        else:
            print("❌ Нет данных в таблице локализации")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка тестирования API: {e}")
        return False

def main():
    """Основная функция"""
    print("🌐 Загрузка данных локализации в Supabase...")
    
    # Загружаем данные
    if load_localization_data():
        # Тестируем API
        test_localization_api()
        
        print("\n📋 Следующие шаги:")
        print("1. Обновите сервер с новым API локализации")
        print("2. Протестируйте переключение языков")
        print("3. Проверьте работу переводов")
    else:
        print("\n❌ Не удалось загрузить данные локализации")

if __name__ == "__main__":
    main()













