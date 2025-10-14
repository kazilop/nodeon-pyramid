#!/usr/bin/env python3
"""
Скрипт для настройки базы данных майнера
"""

import os
import requests
import json
from datetime import datetime

# Конфигурация Supabase
SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_ANON_KEY")

if not SUPABASE_URL or not SUPABASE_KEY:
    print("ERROR: SUPABASE_URL and SUPABASE_ANON_KEY environment variables not found")
    exit(1)

def execute_sql_file(sql_file_path):
    """Выполнить SQL из файла"""
    try:
        with open(sql_file_path, 'r', encoding='utf-8') as file:
            sql_content = file.read()
        
        # Разделяем SQL на отдельные запросы
        sql_queries = [query.strip() for query in sql_content.split(';') if query.strip()]
        
        print(f"Found {len(sql_queries)} SQL queries to execute")
        
        success_count = 0
        error_count = 0
        
        for i, query in enumerate(sql_queries, 1):
            if not query:
                continue
                
            print(f"[{i}/{len(sql_queries)}] Executing query...")
            
            try:
                # Выполняем через Supabase REST API
                url = f"{SUPABASE_URL}/rest/v1/rpc/exec"
                headers = {
                    "apikey": SUPABASE_KEY,
                    "Authorization": f"Bearer {SUPABASE_KEY}",
                    "Content-Type": "application/json"
                }
                
                data = {
                    "sql": query
                }
                
                response = requests.post(url, headers=headers, json=data, timeout=30)
                
                if response.status_code in [200, 201, 204]:
                    success_count += 1
                    print(f"  Query {i} executed successfully")
                else:
                    error_count += 1
                    print(f"  Query {i} failed: {response.status_code}")
                    print(f"  Response: {response.text[:200]}...")
                    
            except Exception as e:
                error_count += 1
                print(f"  Query {i} error: {e}")
        
        return success_count, error_count
        
    except Exception as e:
        print(f"Error reading SQL file: {e}")
        return 0, 1

def test_miner_tables():
    """Проверить создание таблиц"""
    try:
        # Проверяем таблицу miner_data
        url = f"{SUPABASE_URL}/rest/v1/nodeon_miner_data?select=count"
        headers = {
            "apikey": SUPABASE_KEY,
            "Authorization": f"Bearer {SUPABASE_KEY}",
            "Content-Type": "application/json"
        }
        
        response = requests.get(url, headers=headers)
        
        if response.status_code == 200:
            print("✅ nodeon_miner_data table exists")
            data = response.json()
            print(f"   Records count: {len(data)}")
        else:
            print(f"❌ nodeon_miner_data table error: {response.status_code}")
            return False
        
        # Проверяем таблицу miner_stats
        url = f"{SUPABASE_URL}/rest/v1/nodeon_miner_stats?select=count"
        response = requests.get(url, headers=headers)
        
        if response.status_code == 200:
            print("✅ nodeon_miner_stats table exists")
            data = response.json()
            print(f"   Records count: {len(data)}")
        else:
            print(f"❌ nodeon_miner_stats table error: {response.status_code}")
            return False
        
        return True
        
    except Exception as e:
        print(f"Error testing tables: {e}")
        return False

def main():
    print("Setting up miner database tables...")
    print(f"Time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("=" * 60)
    
    # Выполняем SQL файл
    sql_file = "create_miner_table.sql"
    if not os.path.exists(sql_file):
        print(f"ERROR: SQL file {sql_file} not found")
        return
    
    print(f"Executing SQL from {sql_file}...")
    success_count, error_count = execute_sql_file(sql_file)
    
    print("=" * 60)
    print("SQL EXECUTION RESULTS:")
    print(f"  Successful queries: {success_count}")
    print(f"  Failed queries: {error_count}")
    
    if error_count == 0:
        print("\n✅ All SQL queries executed successfully!")
    else:
        print(f"\n⚠️  {error_count} queries failed")
    
    # Проверяем создание таблиц
    print("\nTesting created tables...")
    if test_miner_tables():
        print("\n🎉 Miner database setup completed successfully!")
    else:
        print("\n❌ Some tables were not created properly")
    
    print(f"Completed: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")

if __name__ == "__main__":
    main()
