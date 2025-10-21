#!/usr/bin/env python3
"""
Скрипт для создания бэкапа базы данных Supabase
Создает JSON файлы с данными всех таблиц
"""

import os
import json
import requests
from datetime import datetime
from dotenv import load_dotenv

# Загружаем переменные окружения
load_dotenv()

SUPABASE_URL = os.getenv('SUPABASE_URL')
SUPABASE_ANON_KEY = os.getenv('SUPABASE_ANON_KEY')

def create_backup_directory():
    """Создание директории для бэкапа"""
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_dir = f"backup_{timestamp}"
    os.makedirs(backup_dir, exist_ok=True)
    return backup_dir

def get_table_data(table_name, backup_dir):
    """Получение данных из таблицы"""
    
    if not SUPABASE_URL or not SUPABASE_ANON_KEY:
        print(f"❌ Переменные Supabase не установлены для таблицы {table_name}")
        return False
    
    headers = {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }
    
    try:
        # Получаем все данные из таблицы
        url = f"{SUPABASE_URL}/rest/v1/{table_name}?select=*"
        response = requests.get(url, headers=headers)
        
        if response.status_code == 200:
            data = response.json()
            
            # Сохраняем в файл
            filename = os.path.join(backup_dir, f"{table_name}.json")
            with open(filename, 'w', encoding='utf-8') as f:
                json.dump(data, f, indent=2, ensure_ascii=False, default=str)
            
            print(f"✅ Таблица {table_name}: {len(data)} записей сохранено")
            return True
        else:
            print(f"❌ Ошибка получения данных из {table_name}: {response.status_code} - {response.text}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка при работе с таблицей {table_name}: {e}")
        return False

def get_table_schema(table_name, backup_dir):
    """Получение схемы таблицы"""
    
    if not SUPABASE_URL or not SUPABASE_ANON_KEY:
        return False
    
    headers = {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }
    
    try:
        # Получаем информацию о таблице
        url = f"{SUPABASE_URL}/rest/v1/{table_name}?select=*&limit=1"
        response = requests.get(url, headers=headers)
        
        if response.status_code == 200:
            # Сохраняем пример структуры
            filename = os.path.join(backup_dir, f"{table_name}_schema.json")
            with open(filename, 'w', encoding='utf-8') as f:
                json.dump({
                    "table_name": table_name,
                    "backup_date": datetime.now().isoformat(),
                    "sample_record": response.json()[0] if response.json() else None
                }, f, indent=2, ensure_ascii=False, default=str)
            
            return True
        else:
            return False
            
    except Exception as e:
        print(f"⚠️ Не удалось получить схему для {table_name}: {e}")
        return False

def create_backup_info(backup_dir, tables_status):
    """Создание файла с информацией о бэкапе"""
    
    info = {
        "backup_date": datetime.now().isoformat(),
        "supabase_url": SUPABASE_URL,
        "tables": tables_status,
        "total_tables": len(tables_status),
        "successful_backups": sum(1 for status in tables_status.values() if status),
        "failed_backups": sum(1 for status in tables_status.values() if not status)
    }
    
    filename = os.path.join(backup_dir, "backup_info.json")
    with open(filename, 'w', encoding='utf-8') as f:
        json.dump(info, f, indent=2, ensure_ascii=False, default=str)
    
    print(f"📋 Информация о бэкапе сохранена: {filename}")

def create_restore_script(backup_dir, tables_status):
    """Создание скрипта для восстановления данных"""
    
    script_content = '''#!/usr/bin/env python3
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
    
    print("\\n🔄 Начинаем восстановление...")
    
    for table in tables:
        restore_table_data(table, latest_backup)
    
    print("\\n✅ Восстановление завершено!")

if __name__ == "__main__":
    main()
'''
    
    filename = os.path.join(backup_dir, "restore_backup.py")
    with open(filename, 'w', encoding='utf-8') as f:
        f.write(script_content)
    
    print(f"📜 Скрипт восстановления создан: {filename}")

def main():
    """Основная функция создания бэкапа"""
    
    print("💾 Создание бэкапа базы данных Supabase")
    print("=" * 50)
    
    if not SUPABASE_URL or not SUPABASE_ANON_KEY:
        print("❌ Переменные SUPABASE_URL и SUPABASE_ANON_KEY должны быть установлены")
        return
    
    # Создаем директорию для бэкапа
    backup_dir = create_backup_directory()
    print(f"📁 Директория бэкапа: {backup_dir}")
    
    # Список таблиц для бэкапа
    tables = [
        "nodeon_users",
        "nodeon_transactions", 
        "nodeon_referral_stats",
        "nodeon_miner_data",
        "nodeon_miner_stats",
        "nodeon_miner_farms",
        "nodeon_miner_upgrades",
        "nodeon_miner_transactions",
        "nodeon_achievements",
        "nodeon_shops"
    ]
    
    print(f"\\n📊 Создание бэкапа {len(tables)} таблиц...")
    
    tables_status = {}
    
    for table in tables:
        print(f"\\n🔄 Обработка таблицы: {table}")
        
        # Получаем данные таблицы
        success = get_table_data(table, backup_dir)
        tables_status[table] = success
        
        # Получаем схему таблицы
        get_table_schema(table, backup_dir)
    
    # Создаем информацию о бэкапе
    create_backup_info(backup_dir, tables_status)
    
    # Создаем скрипт восстановления
    create_restore_script(backup_dir, tables_status)
    
    print("\\n" + "=" * 50)
    print("✅ Бэкап завершен!")
    
    successful = sum(1 for status in tables_status.values() if status)
    total = len(tables_status)
    
    print(f"📊 Результат: {successful}/{total} таблиц успешно сохранено")
    
    if successful < total:
        print("\\n⚠️ Некоторые таблицы не удалось сохранить:")
        for table, status in tables_status.items():
            if not status:
                print(f"   ❌ {table}")
    
    print(f"\\n📁 Все файлы сохранены в директории: {backup_dir}")
    print("\\n📝 Следующие шаги:")
    print("   1. Проверьте файлы в директории бэкапа")
    print("   2. Сохраните директорию в безопасном месте")
    print("   3. Для восстановления используйте: python restore_backup.py")

if __name__ == "__main__":
    main()
