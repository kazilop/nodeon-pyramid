#!/usr/bin/env python3
"""
Скрипт для создания таблицы локализации в Supabase
"""

import os
import sys
from supabase import create_client, Client

def setup_localization_table():
    """Создает таблицу локализации в Supabase"""
    
    # Получаем переменные окружения
    url = os.getenv('SUPABASE_URL')
    key = os.getenv('SUPABASE_ANON_KEY')
    
    if not url or not key:
        print("Ошибка: Не найдены переменные окружения SUPABASE_URL и SUPABASE_ANON_KEY")
        return False
    
    try:
        # Создаем клиент Supabase
        supabase: Client = create_client(url, key)
        print("✅ Подключение к Supabase установлено")
        
        # SQL для создания таблицы
        create_table_sql = """
        CREATE TABLE IF NOT EXISTS nodeon_localization (
            id SERIAL PRIMARY KEY,
            text_id VARCHAR(100) NOT NULL UNIQUE,
            ru TEXT NOT NULL,
            en TEXT,
            es TEXT,
            de TEXT,
            fr TEXT,
            it TEXT,
            pt TEXT,
            ar TEXT,
            hi TEXT,
            ja TEXT,
            ko TEXT,
            zh TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );
        """
        
        # Выполняем SQL через RPC (если доступно) или через прямой запрос
        try:
            result = supabase.rpc('exec_sql', {'sql': create_table_sql}).execute()
            print("✅ Таблица nodeon_localization создана через RPC")
        except Exception as e:
            print(f"⚠️ RPC не доступен: {e}")
            print("📝 Создайте таблицу вручную в Supabase Dashboard:")
            print(create_table_sql)
            return False
        
        # Создаем индексы
        indexes_sql = [
            "CREATE INDEX IF NOT EXISTS idx_localization_text_id ON nodeon_localization(text_id);",
            "CREATE INDEX IF NOT EXISTS idx_localization_updated_at ON nodeon_localization(updated_at);"
        ]
        
        for index_sql in indexes_sql:
            try:
                supabase.rpc('exec_sql', {'sql': index_sql}).execute()
                print(f"✅ Индекс создан: {index_sql.split()[5]}")
            except Exception as e:
                print(f"⚠️ Ошибка создания индекса: {e}")
        
        print("🎉 Таблица локализации готова к использованию!")
        return True
        
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def insert_sample_data():
    """Вставляет примеры данных локализации"""
    
    url = os.getenv('SUPABASE_URL')
    key = os.getenv('SUPABASE_ANON_KEY')
    
    if not url or not key:
        return False
    
    try:
        supabase: Client = create_client(url, key)
        
        # Примеры данных
        sample_data = [
            {
                'text_id': 'app.name',
                'ru': '🚀 NodeOn Crypto',
                'en': '🚀 NodeOn Crypto',
                'es': '🚀 NodeOn Crypto'
            },
            {
                'text_id': 'app.description',
                'ru': 'Крипто игра с монетами NDN',
                'en': 'Crypto game with NDN coins',
                'es': 'Juego de cripto con monedas NDN'
            },
            {
                'text_id': 'buttons.buy_pro',
                'ru': '💎 Купить Pro статус',
                'en': '💎 Buy Pro Status',
                'es': '💎 Comprar Estado Pro'
            }
        ]
        
        # Вставляем данные
        result = supabase.table('nodeon_localization').upsert(sample_data).execute()
        print(f"✅ Вставлено {len(sample_data)} примеров данных")
        
        return True
        
    except Exception as e:
        print(f"❌ Ошибка вставки данных: {e}")
        return False

def main():
    """Основная функция"""
    print("🌐 Настройка системы локализации...")
    
    # Загружаем переменные окружения
    from dotenv import load_dotenv
    load_dotenv()
    
    # Создаем таблицу
    if setup_localization_table():
        # Вставляем примеры данных
        insert_sample_data()
        print("\n📋 Следующие шаги:")
        print("1. Загрузите SQL файл insert_localization_from_json.sql в Supabase")
        print("2. Обновите фронтенд для использования API локализации")
        print("3. Протестируйте переключение языков")
    else:
        print("\n❌ Не удалось создать таблицу локализации")
        print("Создайте таблицу вручную в Supabase Dashboard")

if __name__ == "__main__":
    main()













