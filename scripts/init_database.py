#!/usr/bin/env python3
"""
Скрипт для инициализации базы данных в Supabase
"""

import os
import sys
import asyncio
from sqlalchemy import create_engine, text
from dotenv import load_dotenv

# Добавляем путь к backend
sys.path.append('../backend')

from database import Base

# Загружаем переменные окружения
load_dotenv()

async def init_database():
    """Инициализация базы данных"""
    
    database_url = os.getenv("DATABASE_URL")
    
    if not database_url:
        print("❌ DATABASE_URL не найден в .env файле")
        return False
    
    if "[PASSWORD]" in database_url:
        print("❌ Замените [PASSWORD] в DATABASE_URL на реальный пароль от Supabase")
        print("   Пароль можно найти в Supabase Dashboard → Settings → Database")
        return False
    
    print(f"🔗 Подключение к базе данных...")
    print(f"   URL: {database_url[:50]}...")
    
    try:
        # Создаем подключение
        engine = create_engine(database_url)
        
        # Тестируем подключение
        with engine.connect() as conn:
            result = conn.execute(text("SELECT 1"))
            print("✅ Подключение к базе данных успешно!")
        
        # Создаем таблицы
        print("📊 Создание таблиц...")
        Base.metadata.create_all(bind=engine)
        print("✅ Таблицы созданы успешно!")
        
        # Проверяем созданные таблицы
        with engine.connect() as conn:
            result = conn.execute(text("""
                SELECT table_name 
                FROM information_schema.tables 
                WHERE table_schema = 'public'
                ORDER BY table_name
            """))
            
            tables = [row[0] for row in result]
            print(f"📋 Созданные таблицы: {', '.join(tables)}")
        
        return True
        
    except Exception as e:
        print(f"❌ Ошибка при инициализации базы данных: {e}")
        return False

def main():
    """Основная функция"""
    
    print("🚀 Инициализация базы данных Supabase...")
    print()
    
    success = asyncio.run(init_database())
    
    if success:
        print()
        print("✅ База данных инициализирована успешно!")
        print("   Теперь можно развертывать приложение на Vercel")
    else:
        print()
        print("❌ Ошибка инициализации базы данных")
        print("   Проверьте DATABASE_URL и пароль в .env файле")

if __name__ == "__main__":
    main()
