#!/usr/bin/env python3
"""
Проверка таблиц NodeOn в Supabase
"""

import os
from sqlalchemy import create_engine, text
from dotenv import load_dotenv

# Загружаем переменные окружения
load_dotenv()

def check_nodeon_tables():
    """Проверка таблиц NodeOn"""
    
    database_url = os.getenv("DATABASE_URL")
    
    if not database_url:
        print("❌ DATABASE_URL не найден в .env файле")
        return False
    
    try:
        engine = create_engine(database_url)
        
        with engine.connect() as conn:
            # Получаем список таблиц NodeOn
            result = conn.execute(text("""
                SELECT table_name, column_name, data_type 
                FROM information_schema.columns 
                WHERE table_schema = 'public' 
                AND table_name LIKE 'nodeon_%'
                ORDER BY table_name, ordinal_position
            """))
            
            tables = {}
            for row in result:
                table_name = row[0]
                column_name = row[1]
                data_type = row[2]
                
                if table_name not in tables:
                    tables[table_name] = []
                
                tables[table_name].append({
                    'column': column_name,
                    'type': data_type
                })
            
            print("📊 Таблицы NodeOn в базе данных:")
            print()
            
            if tables:
                for table_name, columns in tables.items():
                    print(f"✅ {table_name}:")
                    for col in columns:
                        print(f"   - {col['column']}: {col['type']}")
                    print()
                
                print(f"🎉 Всего таблиц NodeOn: {len(tables)}")
                return True
            else:
                print("❌ Таблицы NodeOn не найдены")
                return False
        
    except Exception as e:
        print(f"❌ Ошибка при проверке таблиц: {e}")
        return False

def test_insert():
    """Тест вставки данных"""
    
    database_url = os.getenv("DATABASE_URL")
    
    if not database_url:
        print("❌ DATABASE_URL не найден в .env файле")
        return False
    
    try:
        engine = create_engine(database_url)
        
        with engine.connect() as conn:
            # Вставляем тестового пользователя
            conn.execute(text("""
                INSERT INTO nodeon_users (telegram_id, username, first_name, balance_ndn, is_pro)
                VALUES (123456789, 'testuser', 'Test User', 1000, true)
                ON CONFLICT (telegram_id) DO NOTHING
            """))
            
            # Получаем пользователя
            result = conn.execute(text("""
                SELECT * FROM nodeon_users WHERE telegram_id = 123456789
            """))
            
            user = result.fetchone()
            if user:
                print("✅ Тест вставки данных успешен!")
                print(f"   Пользователь: {user[3]} (ID: {user[0]})")
                return True
            else:
                print("❌ Пользователь не найден")
                return False
        
    except Exception as e:
        print(f"❌ Ошибка при тесте вставки: {e}")
        return False

def main():
    """Основная функция"""
    
    print("🔍 Проверка таблиц NodeOn в Supabase...")
    print()
    
    if check_nodeon_tables():
        print()
        print("🧪 Тест вставки данных...")
        if test_insert():
            print()
            print("🎉 База данных NodeOn полностью готова!")
            print("   Можно развертывать приложение на Vercel")
        else:
            print()
            print("❌ Ошибка при тесте вставки данных")
    else:
        print()
        print("❌ Таблицы NodeOn не найдены")

if __name__ == "__main__":
    main()
