#!/usr/bin/env python3
"""
Скрипт для восстановления данных из бэкапа
"""

import os
import json
import requests
from dotenv import load_dotenv

# Загружаем переменные окружения
load_dotenv()

SUPABASE_URL = os.getenv('SUPABASE_URL')
SUPABASE_ANON_KEY = os.getenv('SUPABASE_ANON_KEY')

def restore_table_data(table_name, backup_dir):
    """Восстановление данных в таблицу"""
    
    if not SUPABASE_URL or not SUPABASE_ANON_KEY:
        print(f"❌ Переменные Supabase не установлены")
        return False
    
    headers = {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }
    
    try:
        # Читаем данные из файла
        filename = os.path.join(backup_dir, f"{table_name}.json")
        if not os.path.exists(filename):
            print(f"⚠️ Файл {filename} не найден")
            return False
        
        with open(filename, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        if not data:
            print(f"⚠️ Нет данных для восстановления в таблице {table_name}")
            return True
        
        # Вставляем данные
        url = f"{SUPABASE_URL}/rest/v1/{table_name}"
        
        # Вставляем по одной записи для избежания ошибок
        success_count = 0
        for record in data:
            try:
                response = requests.post(url, headers=headers, json=record)
                if response.status_code in [200, 201]:
                    success_count += 1
                else:
                    print(f"⚠️ Ошибка вставки записи в {table_name}: {response.status_code}")
            except Exception as e:
                print(f"⚠️ Ошибка вставки записи в {table_name}: {e}")
        
        print(f"✅ Таблица {table_name}: восстановлено {success_count} из {len(data)} записей")
        return True
        
    except Exception as e:
        print(f"❌ Ошибка восстановления таблицы {table_name}: {e}")
        return False

def main():
    """Основная функция восстановления"""
    
    print("🔄 Восстановление данных из бэкапа")
    print("=" * 50)
    
    # Определяем директорию бэкапа
    backup_dirs = [d for d in os.listdir('.') if d.startswith('backup_')]
    if not backup_dirs:
        print("❌ Директории бэкапа не найдены")
        return
    
    # Выбираем последний бэкап
    latest_backup = sorted(backup_dirs)[-1]
    print(f"📁 Используем бэкап: {latest_backup}")
    
    # Читаем информацию о бэкапе
    info_file = os.path.join(latest_backup, "backup_info.json")
    if os.path.exists(info_file):
        with open(info_file, 'r', encoding='utf-8') as f:
            info = json.load(f)
        print(f"📅 Дата бэкапа: {info.get('backup_date')}")
        print(f"📊 Таблиц в бэкапе: {info.get('total_tables')}")
    
    # Список таблиц для восстановления
    tables = [
        "nodeon_users",
        "nodeon_transactions", 
        "nodeon_referral_stats",
        "nodeon_miner_data",
        "nodeon_miner_stats",
        "nodeon_achievements",
        "nodeon_shops"
    ]
    
    print("\n🔄 Начинаем восстановление...")
    
    for table in tables:
        restore_table_data(table, latest_backup)
    
    print("\n✅ Восстановление завершено!")

if __name__ == "__main__":
    main()
