#!/usr/bin/env python3
"""
Скрипт для получения connection string Supabase
"""

import requests
import json
import os
from dotenv import load_dotenv

# Загружаем переменные окружения
load_dotenv()

def get_supabase_connection():
    """Получение connection string из Supabase"""
    
    supabase_url = os.getenv("SUPABASE_URL")
    supabase_key = os.getenv("SUPABASE_ANON_KEY")
    
    if not supabase_url or not supabase_key:
        print("❌ SUPABASE_URL или SUPABASE_ANON_KEY не найдены в .env файле")
        return None
    
    print(f"🔗 Supabase URL: {supabase_url}")
    print(f"🔑 API Key: {supabase_key[:20]}...")
    print()
    
    # Получаем информацию о проекте
    try:
        headers = {
            "apikey": supabase_key,
            "Authorization": f"Bearer {supabase_key}"
        }
        
        # Получаем информацию о проекте
        response = requests.get(f"{supabase_url}/rest/v1/", headers=headers)
        
        if response.status_code == 200:
            print("✅ Подключение к Supabase успешно!")
            
            # Формируем connection string
            # Извлекаем host из URL
            host = supabase_url.replace("https://", "").replace("http://", "")
            
            # Правильный connection string для Supabase
            connection_string = f"postgresql://postgres.nodeon:G-Gje9!Jr4B9-$C@{host}:5432/postgres"
            
            print(f"📊 Connection string:")
            print(f"   {connection_string}")
            print()
            print("✅ Connection string готов к использованию!")
            print("   Скопируйте его в .env файл")
            
            return connection_string
            
        else:
            print(f"❌ Ошибка подключения к Supabase: {response.status_code}")
            print(f"   Ответ: {response.text}")
            return None
            
    except Exception as e:
        print(f"❌ Ошибка при подключении к Supabase: {e}")
        return None

def main():
    """Основная функция"""
    
    print("🔍 Получение connection string для Supabase...")
    print()
    
    connection_string = get_supabase_connection()
    
    if connection_string:
        print("✅ Готово! Скопируйте connection string в .env файл")
    else:
        print("❌ Не удалось получить connection string")
        print("   Проверьте SUPABASE_URL и SUPABASE_ANON_KEY в .env файле")

if __name__ == "__main__":
    main()
