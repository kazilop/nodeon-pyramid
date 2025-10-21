#!/usr/bin/env python3
"""
Скрипт для проверки состояния базы данных Supabase
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

def check_table_exists(table_name):
    """Проверка существования таблицы"""
    
    if not SUPABASE_URL or not SUPABASE_ANON_KEY:
        return False, "Переменные Supabase не установлены"
    
    headers = {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }
    
    try:
        # Пытаемся получить количество записей
        url = f"{SUPABASE_URL}/rest/v1/{table_name}?select=count"
        response = requests.get(url, headers=headers)
        
        if response.status_code == 200:
            return True, "Таблица существует"
        elif response.status_code == 404:
            return False, "Таблица не найдена"
        else:
            return False, f"Ошибка: {response.status_code} - {response.text}"
            
    except Exception as e:
        return False, f"Ошибка подключения: {e}"

def get_table_stats(table_name):
    """Получение статистики таблицы"""
    
    if not SUPABASE_URL or not SUPABASE_ANON_KEY:
        return None
    
    headers = {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }
    
    try:
        # Получаем количество записей
        url = f"{SUPABASE_URL}/rest/v1/{table_name}?select=count"
        response = requests.get(url, headers=headers)
        
        if response.status_code == 200:
            # Получаем несколько записей для анализа
            sample_url = f"{SUPABASE_URL}/rest/v1/{table_name}?select=*&limit=5"
            sample_response = requests.get(sample_url, headers=headers)
            
            stats = {
                "exists": True,
                "count": len(sample_response.json()) if sample_response.status_code == 200 else 0,
                "sample_data": sample_response.json()[:3] if sample_response.status_code == 200 else []
            }
            
            return stats
        else:
            return {"exists": False, "error": f"{response.status_code} - {response.text}"}
            
    except Exception as e:
        return {"exists": False, "error": str(e)}

def check_database_connection():
    """Проверка подключения к базе данных"""
    
    print("🔍 Проверка подключения к Supabase...")
    
    if not SUPABASE_URL or not SUPABASE_ANON_KEY:
        print("❌ Переменные SUPABASE_URL и SUPABASE_ANON_KEY не установлены")
        return False
    
    headers = {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }
    
    try:
        # Простой запрос для проверки подключения
        url = f"{SUPABASE_URL}/rest/v1/"
        response = requests.get(url, headers=headers, timeout=10)
        
        if response.status_code in [200, 404]:  # 404 тоже нормально для корневого пути
            print("✅ Подключение к Supabase работает")
            return True
        else:
            print(f"❌ Ошибка подключения: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка подключения к Supabase: {e}")
        return False

def check_all_tables():
    """Проверка всех таблиц проекта"""
    
    print("\\n📊 Проверка таблиц базы данных...")
    
    # Список всех таблиц проекта
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
    
    results = {}
    
    for table in tables:
        print(f"\\n🔍 Проверка таблицы: {table}")
        
        exists, message = check_table_exists(table)
        print(f"   Статус: {'✅' if exists else '❌'} {message}")
        
        if exists:
            stats = get_table_stats(table)
            if stats and stats.get("exists"):
                print(f"   Записей: {stats.get('count', 'неизвестно')}")
                
                # Показываем пример данных
                sample = stats.get("sample_data", [])
                if sample:
                    print(f"   Пример данных: {json.dumps(sample[0], indent=2, ensure_ascii=False, default=str)[:200]}...")
            else:
                print(f"   Ошибка получения статистики: {stats.get('error', 'неизвестно')}")
        
        results[table] = {
            "exists": exists,
            "message": message,
            "stats": get_table_stats(table) if exists else None
        }
    
    return results

def generate_report(results):
    """Генерация отчета о состоянии базы данных"""
    
    print("\\n" + "=" * 60)
    print("📋 ОТЧЕТ О СОСТОЯНИИ БАЗЫ ДАННЫХ")
    print("=" * 60)
    
    # Общая статистика
    total_tables = len(results)
    existing_tables = sum(1 for r in results.values() if r["exists"])
    missing_tables = total_tables - existing_tables
    
    print(f"📊 Общая статистика:")
    print(f"   Всего таблиц: {total_tables}")
    print(f"   Существующих: {existing_tables}")
    print(f"   Отсутствующих: {missing_tables}")
    
    # Детальная информация
    print(f"\\n📋 Детальная информация:")
    
    for table, result in results.items():
        status = "✅" if result["exists"] else "❌"
        print(f"   {status} {table}")
        
        if result["exists"] and result["stats"]:
            stats = result["stats"]
            if stats.get("exists"):
                count = stats.get("count", "неизвестно")
                print(f"      Записей: {count}")
            else:
                print(f"      Ошибка: {stats.get('error', 'неизвестно')}")
        else:
            print(f"      {result['message']}")
    
    # Рекомендации
    print(f"\\n💡 Рекомендации:")
    
    if missing_tables > 0:
        print("   ⚠️ Некоторые таблицы отсутствуют:")
        for table, result in results.items():
            if not result["exists"]:
                print(f"      - {table}")
        print("   🔧 Запустите: python setup_database.py")
    
    if existing_tables == total_tables:
        print("   ✅ Все таблицы существуют")
        print("   🔧 Для создания бэкапа: python backup_database.py")
    
    # Проверка данных
    has_data = False
    for table, result in results.items():
        if result["exists"] and result["stats"] and result["stats"].get("count", 0) > 0:
            has_data = True
            break
    
    if has_data:
        print("   📊 В базе есть данные")
        print("   💾 Рекомендуется создать бэкап: python backup_database.py")
    else:
        print("   📊 База данных пуста")
        print("   🔧 Запустите приложение для создания начальных данных")

def save_report_to_file(results):
    """Сохранение отчета в файл"""
    
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    filename = f"database_report_{timestamp}.json"
    
    report_data = {
        "timestamp": datetime.now().isoformat(),
        "supabase_url": SUPABASE_URL,
        "results": results,
        "summary": {
            "total_tables": len(results),
            "existing_tables": sum(1 for r in results.values() if r["exists"]),
            "missing_tables": sum(1 for r in results.values() if not r["exists"])
        }
    }
    
    with open(filename, 'w', encoding='utf-8') as f:
        json.dump(report_data, f, indent=2, ensure_ascii=False, default=str)
    
    print(f"\\n📄 Отчет сохранен в файл: {filename}")

def main():
    """Основная функция проверки"""
    
    print("🔍 Проверка состояния базы данных Supabase")
    print("=" * 50)
    
    # Проверяем подключение
    if not check_database_connection():
        print("\\n❌ Не удалось подключиться к базе данных")
        print("💡 Проверьте переменные окружения SUPABASE_URL и SUPABASE_ANON_KEY")
        return
    
    # Проверяем все таблицы
    results = check_all_tables()
    
    # Генерируем отчет
    generate_report(results)
    
    # Сохраняем отчет в файл
    save_report_to_file(results)
    
    print("\\n✅ Проверка завершена!")

if __name__ == "__main__":
    main()
