#!/usr/bin/env python3
"""
Скрипт для выполнения SQL по добавлению колонки miner_data
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

def execute_sql(sql_query):
    """Выполнить SQL запрос"""
    try:
        url = f"{SUPABASE_URL}/rest/v1/rpc/exec_sql"
        headers = {
            "apikey": SUPABASE_KEY,
            "Authorization": f"Bearer {SUPABASE_KEY}",
            "Content-Type": "application/json"
        }
        
        data = {
            "sql": sql_query
        }
        
        response = requests.post(url, headers=headers, json=data)
        
        if response.status_code == 200:
            return True, response.json()
        else:
            print(f"SQL execution error: {response.status_code}")
            print(f"Response: {response.text}")
            return False, None
    except Exception as e:
        print(f"SQL execution error: {e}")
        return False, None

def main():
    print("Adding miner_data column to nodeon_users table...")
    print(f"Time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("=" * 60)
    
    # SQL для добавления колонки
    sql_query = """
    ALTER TABLE nodeon_users 
    ADD COLUMN IF NOT EXISTS miner_data JSONB DEFAULT '{
        "ndn_gas": 100,
        "energy": 100,
        "max_energy": 100,
        "gas_per_minute": 0,
        "farms": [],
        "upgrades": {
            "speed": 0,
            "efficiency": 0,
            "automation": 0
        },
        "total_gas_earned": 100,
        "last_energy_refill": 0,
        "last_update": 0
    }'::jsonb;
    """
    
    print("Executing SQL to add miner_data column...")
    success, result = execute_sql(sql_query)
    
    if success:
        print("✅ Column added successfully!")
        
        # Обновляем существующих пользователей
        update_sql = """
        UPDATE nodeon_users 
        SET miner_data = '{
            "ndn_gas": 100,
            "energy": 100,
            "max_energy": 100,
            "gas_per_minute": 0,
            "farms": [],
            "upgrades": {
                "speed": 0,
                "efficiency": 0,
                "automation": 0
            },
            "total_gas_earned": 100,
            "last_energy_refill": 0,
            "last_update": 0
        }'::jsonb
        WHERE miner_data IS NULL;
        """
        
        print("Updating existing users with miner data...")
        success, result = execute_sql(update_sql)
        
        if success:
            print("✅ All users updated with miner data!")
        else:
            print("❌ Error updating users")
    else:
        print("❌ Error adding column")
    
    print(f"Completed: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")

if __name__ == "__main__":
    main()
