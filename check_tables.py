#!/usr/bin/env python3
"""
Проверка существующих таблиц в Supabase
"""

import os
from sqlalchemy import create_engine, text
from dotenv import load_dotenv

# Загружаем переменные окружения
load_dotenv()

def check_tables():
    """Проверка существующих таблиц"""
    
    database_url = os.getenv("DATABASE_URL")
    
    if not database_url:
        print("❌ DATABASE_URL не найден в .env файле")
        return False
    
    try:
        engine = create_engine(database_url)
        
        with engine.connect() as conn:
            # Получаем список таблиц
            result = conn.execute(text("""
                SELECT table_name, column_name, data_type 
                FROM information_schema.columns 
                WHERE table_schema = 'public'
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
            
            print("📊 Существующие таблицы в базе данных:")
            print()
            
            for table_name, columns in tables.items():
                print(f"🔹 {table_name}:")
                for col in columns:
                    print(f"   - {col['column']}: {col['type']}")
                print()
            
            return True
        
    except Exception as e:
        print(f"❌ Ошибка при проверке таблиц: {e}")
        return False

def main():
    """Основная функция"""
    
    print("🔍 Проверка таблиц в Supabase...")
    print()
    
    check_tables()

if __name__ == "__main__":
    main()
