#!/usr/bin/env python3
"""
Тест подключения приложения к базе данных
"""

import os
import sys
from dotenv import load_dotenv

# Добавляем путь к backend
sys.path.append('./backend')

# Загружаем переменные окружения
load_dotenv()

def test_app_connection():
    """Тест подключения приложения"""
    
    try:
        from backend.database import engine, User, Transaction, ReferralStats, PaymentRequest
        from backend.config import settings
        
        print("✅ Модули приложения загружены успешно!")
        print(f"🔗 DATABASE_URL: {settings.database_url[:50]}...")
        
        # Тестируем подключение
        from sqlalchemy import text
        with engine.connect() as conn:
            result = conn.execute(text("SELECT 1 as test"))
            test_value = result.fetchone()[0]
            
            if test_value == 1:
                print("✅ Подключение к базе данных успешно!")
                
                # Проверяем таблицы
                result = conn.execute(text("""
                    SELECT table_name 
                    FROM information_schema.tables 
                    WHERE table_schema = 'public' 
                    AND table_name LIKE 'nodeon_%'
                    ORDER BY table_name
                """))
                
                tables = [row[0] for row in result]
                print(f"📋 Найдено таблиц NodeOn: {len(tables)}")
                for table in tables:
                    print(f"   - {table}")
                
                return True
            else:
                print("❌ Неожиданный результат теста")
                return False
        
    except Exception as e:
        print(f"❌ Ошибка при тестировании: {e}")
        return False

def main():
    """Основная функция"""
    
    print("🧪 Тест подключения приложения NodeOn Pyramid...")
    print()
    
    if test_app_connection():
        print()
        print("🎉 Приложение готово к развертыванию!")
        print("   Можно запускать на Vercel")
    else:
        print()
        print("❌ Ошибка подключения приложения")

if __name__ == "__main__":
    main()
