#!/usr/bin/env python3
"""
Скрипт для восстановления базы данных из бэкапа
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

def find_latest_backup():
    """Поиск последнего бэкапа"""
    backup_dirs = [d for d in os.listdir('.') if d.startswith('backup_')]
    if not backup_dirs:
        return None
    return sorted(backup_dirs)[-1]

def restore_table_data(table_name, backup_dir, clear_existing=False):
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
        
        # Очищаем существующие данные если нужно
        if clear_existing:
            print(f"🗑️ Очистка таблицы {table_name}...")
            delete_url = f"{SUPABASE_URL}/rest/v1/{table_name}"
            delete_response = requests.delete(delete_url, headers=headers)
            if delete_response.status_code in [200, 204]:
                print(f"✅ Таблица {table_name} очищена")
            else:
                print(f"⚠️ Не удалось очистить таблицу {table_name}: {delete_response.status_code}")
        
        # Вставляем данные
        url = f"{SUPABASE_URL}/rest/v1/{table_name}"
        
        # Вставляем по одной записи для избежания ошибок
        success_count = 0
        error_count = 0
        
        for i, record in enumerate(data):
            try:
                # Удаляем id если есть, чтобы избежать конфликтов
                if 'id' in record:
                    del record['id']
                
                response = requests.post(url, headers=headers, json=record)
                if response.status_code in [200, 201]:
                    success_count += 1
                else:
                    error_count += 1
                    if error_count <= 5:  # Показываем только первые 5 ошибок
                        print(f"⚠️ Ошибка вставки записи {i+1} в {table_name}: {response.status_code} - {response.text}")
                
            except Exception as e:
                error_count += 1
                if error_count <= 5:
                    print(f"⚠️ Ошибка вставки записи {i+1} в {table_name}: {e}")
        
        print(f"✅ Таблица {table_name}: восстановлено {success_count} из {len(data)} записей")
        if error_count > 0:
            print(f"⚠️ Ошибок: {error_count}")
        
        return success_count > 0
        
    except Exception as e:
        print(f"❌ Ошибка восстановления таблицы {table_name}: {e}")
        return False

def restore_with_dependencies(backup_dir, clear_existing=False):
    """Восстановление с учетом зависимостей между таблицами"""
    
    # Порядок восстановления с учетом внешних ключей
    tables_order = [
        "nodeon_users",           # Основная таблица пользователей
        "nodeon_transactions",    # Транзакции (зависят от users)
        "nodeon_referral_stats",  # Статистика рефералов (зависят от users)
        "nodeon_miner_data",      # Данные майнера (зависят от users)
        "nodeon_miner_stats",     # Статистика майнера (зависят от users)
        "nodeon_miner_farms",     # Фермы майнера (зависят от users)
        "nodeon_miner_upgrades",  # Улучшения майнера (зависят от users)
        "nodeon_miner_transactions", # Транзакции майнера (зависят от users)
        "nodeon_achievements",    # Достижения (зависят от users)
        "nodeon_shops"           # Магазины (зависят от users)
    ]
    
    print("🔄 Восстановление с учетом зависимостей...")
    
    results = {}
    
    for table in tables_order:
        print(f"\\n📊 Восстановление таблицы: {table}")
        success = restore_table_data(table, backup_dir, clear_existing)
        results[table] = success
        
        # Очищаем флаг только для первой таблицы
        clear_existing = False
    
    return results

def validate_backup(backup_dir):
    """Проверка целостности бэкапа"""
    
    print("🔍 Проверка целостности бэкапа...")
    
    # Проверяем наличие файла информации
    info_file = os.path.join(backup_dir, "backup_info.json")
    if not os.path.exists(info_file):
        print("⚠️ Файл backup_info.json не найден")
        return False
    
    with open(info_file, 'r', encoding='utf-8') as f:
        info = json.load(f)
    
    print(f"📅 Дата бэкапа: {info.get('backup_date')}")
    print(f"📊 Таблиц в бэкапе: {info.get('total_tables')}")
    print(f"✅ Успешных бэкапов: {info.get('successful_backups')}")
    print(f"❌ Неудачных бэкапов: {info.get('failed_backups')}")
    
    # Проверяем наличие файлов данных
    required_tables = [
        "nodeon_users",
        "nodeon_transactions", 
        "nodeon_referral_stats",
        "nodeon_miner_data",
        "nodeon_miner_stats"
    ]
    
    missing_files = []
    for table in required_tables:
        filename = os.path.join(backup_dir, f"{table}.json")
        if not os.path.exists(filename):
            missing_files.append(table)
    
    if missing_files:
        print(f"⚠️ Отсутствуют файлы для таблиц: {', '.join(missing_files)}")
        return False
    
    print("✅ Бэкап прошел проверку целостности")
    return True

def main():
    """Основная функция восстановления"""
    
    print("🔄 Восстановление базы данных из бэкапа")
    print("=" * 50)
    
    if not SUPABASE_URL or not SUPABASE_ANON_KEY:
        print("❌ Переменные SUPABASE_URL и SUPABASE_ANON_KEY должны быть установлены")
        return
    
    # Находим последний бэкап
    backup_dir = find_latest_backup()
    if not backup_dir:
        print("❌ Директории бэкапа не найдены")
        print("💡 Сначала создайте бэкап с помощью: python backup_database.py")
        return
    
    print(f"📁 Используем бэкап: {backup_dir}")
    
    # Проверяем целостность бэкапа
    if not validate_backup(backup_dir):
        print("❌ Бэкап не прошел проверку целостности")
        return
    
    # Спрашиваем о очистке существующих данных
    print("\\n⚠️ ВНИМАНИЕ: Восстановление заменит существующие данные!")
    response = input("Очистить существующие данные перед восстановлением? (y/N): ")
    clear_existing = response.lower() in ['y', 'yes', 'да', 'д']
    
    if clear_existing:
        print("🗑️ Будет выполнена очистка существующих данных")
    else:
        print("📝 Данные будут добавлены к существующим")
    
    # Подтверждение
    confirm = input("\\nПродолжить восстановление? (y/N): ")
    if confirm.lower() not in ['y', 'yes', 'да', 'д']:
        print("❌ Восстановление отменено")
        return
    
    print("\\n🔄 Начинаем восстановление...")
    
    # Восстанавливаем данные
    results = restore_with_dependencies(backup_dir, clear_existing)
    
    print("\\n" + "=" * 50)
    print("✅ Восстановление завершено!")
    
    successful = sum(1 for status in results.values() if status)
    total = len(results)
    
    print(f"📊 Результат: {successful}/{total} таблиц успешно восстановлено")
    
    if successful < total:
        print("\\n⚠️ Некоторые таблицы не удалось восстановить:")
        for table, status in results.items():
            if not status:
                print(f"   ❌ {table}")
    
    print("\\n📝 Следующие шаги:")
    print("   1. Проверьте данные в Supabase Dashboard")
    print("   2. Протестируйте приложение")
    print("   3. Проверьте работу API endpoints")

if __name__ == "__main__":
    main()
