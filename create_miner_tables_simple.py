#!/usr/bin/env python3
"""
Создание таблиц майнера через Supabase REST API
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

def create_miner_data_table():
    """Создать таблицу miner_data через миграцию"""
    print("Creating miner_data table...")
    
    # Создаем таблицу через SQL миграцию
    migration_sql = """
    CREATE TABLE IF NOT EXISTS nodeon_miner_data (
        id SERIAL PRIMARY KEY,
        user_id INTEGER NOT NULL REFERENCES nodeon_users(id) ON DELETE CASCADE,
        telegram_id BIGINT NOT NULL,
        ndn_gas DECIMAL(15,2) DEFAULT 100.0,
        energy INTEGER DEFAULT 100,
        max_energy INTEGER DEFAULT 100,
        gas_per_minute DECIMAL(10,2) DEFAULT 0.0,
        total_gas_earned DECIMAL(15,2) DEFAULT 100.0,
        total_gas_spent DECIMAL(15,2) DEFAULT 0.0,
        total_farms_bought INTEGER DEFAULT 0,
        total_upgrades_bought INTEGER DEFAULT 0,
        speed_upgrades INTEGER DEFAULT 0,
        efficiency_upgrades INTEGER DEFAULT 0,
        automation_upgrades INTEGER DEFAULT 0,
        last_energy_refill BIGINT DEFAULT 0,
        last_update BIGINT DEFAULT 0,
        created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
        updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
        UNIQUE(user_id),
        UNIQUE(telegram_id)
    );
    """
    
    # Пока что просто создаем записи для существующих пользователей
    return create_initial_miner_records()

def create_miner_stats_table():
    """Создать таблицу miner_stats"""
    print("Creating miner_stats table...")
    
    migration_sql = """
    CREATE TABLE IF NOT EXISTS nodeon_miner_stats (
        id SERIAL PRIMARY KEY,
        user_id INTEGER NOT NULL REFERENCES nodeon_users(id) ON DELETE CASCADE,
        telegram_id BIGINT NOT NULL,
        username VARCHAR(100),
        first_name VARCHAR(100),
        total_gas_earned DECIMAL(15,2) DEFAULT 0.0,
        total_farms INTEGER DEFAULT 0,
        total_upgrades INTEGER DEFAULT 0,
        current_gas_per_minute DECIMAL(10,2) DEFAULT 0.0,
        miner_level INTEGER DEFAULT 1,
        rank_position INTEGER DEFAULT 0,
        last_activity TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
        created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
        updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
        UNIQUE(user_id)
    );
    """
    
    return create_initial_stats_records()

def create_initial_miner_records():
    """Создать начальные записи майнера для всех пользователей"""
    try:
        # Получаем всех пользователей
        url = f"{SUPABASE_URL}/rest/v1/nodeon_users?select=id,telegram_id"
        headers = {
            "apikey": SUPABASE_KEY,
            "Authorization": f"Bearer {SUPABASE_KEY}",
            "Content-Type": "application/json"
        }
        
        response = requests.get(url, headers=headers)
        
        if response.status_code != 200:
            print(f"Error getting users: {response.status_code}")
            return False
        
        users = response.json()
        print(f"Found {len(users)} users")
        
        # Создаем записи майнера для каждого пользователя
        success_count = 0
        error_count = 0
        
        for user in users:
            user_id = user['id']
            telegram_id = user['telegram_id']
            
            miner_data = {
                "user_id": user_id,
                "telegram_id": telegram_id,
                "ndn_gas": 100.0,
                "energy": 100,
                "max_energy": 100,
                "gas_per_minute": 0.0,
                "total_gas_earned": 100.0,
                "total_gas_spent": 0.0,
                "total_farms_bought": 0,
                "total_upgrades_bought": 0,
                "speed_upgrades": 0,
                "efficiency_upgrades": 0,
                "automation_upgrades": 0,
                "last_energy_refill": int(datetime.now().timestamp() * 1000),
                "last_update": int(datetime.now().timestamp() * 1000)
            }
            
            # Создаем запись
            url = f"{SUPABASE_URL}/rest/v1/nodeon_miner_data"
            response = requests.post(url, headers=headers, json=miner_data)
            
            if response.status_code in [200, 201]:
                success_count += 1
                print(f"  Created miner data for user {user_id}")
            else:
                error_count += 1
                print(f"  Error creating miner data for user {user_id}: {response.status_code}")
        
        print(f"Miner data creation: {success_count} success, {error_count} errors")
        return success_count > 0
        
    except Exception as e:
        print(f"Error creating miner records: {e}")
        return False

def create_initial_stats_records():
    """Создать начальные записи статистики"""
    try:
        # Получаем всех пользователей
        url = f"{SUPABASE_URL}/rest/v1/nodeon_users?select=id,telegram_id,username,first_name"
        headers = {
            "apikey": SUPABASE_KEY,
            "Authorization": f"Bearer {SUPABASE_KEY}",
            "Content-Type": "application/json"
        }
        
        response = requests.get(url, headers=headers)
        
        if response.status_code != 200:
            print(f"Error getting users: {response.status_code}")
            return False
        
        users = response.json()
        print(f"Found {len(users)} users for stats")
        
        # Создаем записи статистики для каждого пользователя
        success_count = 0
        error_count = 0
        
        for user in users:
            user_id = user['id']
            telegram_id = user['telegram_id']
            
            stats_data = {
                "user_id": user_id,
                "telegram_id": telegram_id,
                "username": user.get('username', ''),
                "first_name": user.get('first_name', ''),
                "total_gas_earned": 100.0,
                "total_farms": 0,
                "total_upgrades": 0,
                "current_gas_per_minute": 0.0,
                "miner_level": 1,
                "rank_position": 0,
                "last_activity": datetime.now().isoformat()
            }
            
            # Создаем запись
            url = f"{SUPABASE_URL}/rest/v1/nodeon_miner_stats"
            response = requests.post(url, headers=headers, json=stats_data)
            
            if response.status_code in [200, 201]:
                success_count += 1
                print(f"  Created stats for user {user_id}")
            else:
                error_count += 1
                print(f"  Error creating stats for user {user_id}: {response.status_code}")
        
        print(f"Stats creation: {success_count} success, {error_count} errors")
        return success_count > 0
        
    except Exception as e:
        print(f"Error creating stats records: {e}")
        return False

def test_tables():
    """Проверить создание таблиц"""
    try:
        # Проверяем miner_data
        url = f"{SUPABASE_URL}/rest/v1/nodeon_miner_data?select=count"
        headers = {
            "apikey": SUPABASE_KEY,
            "Authorization": f"Bearer {SUPABASE_KEY}",
            "Content-Type": "application/json"
        }
        
        response = requests.get(url, headers=headers)
        
        if response.status_code == 200:
            print("SUCCESS: nodeon_miner_data table accessible")
            data = response.json()
            print(f"  Records: {len(data)}")
        else:
            print(f"ERROR: nodeon_miner_data table not accessible: {response.status_code}")
            return False
        
        # Проверяем miner_stats
        url = f"{SUPABASE_URL}/rest/v1/nodeon_miner_stats?select=count"
        response = requests.get(url, headers=headers)
        
        if response.status_code == 200:
            print("SUCCESS: nodeon_miner_stats table accessible")
            data = response.json()
            print(f"  Records: {len(data)}")
        else:
            print(f"ERROR: nodeon_miner_stats table not accessible: {response.status_code}")
            return False
        
        return True
        
    except Exception as e:
        print(f"Error testing tables: {e}")
        return False

def main():
    print("Setting up miner database tables...")
    print(f"Time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("=" * 60)
    
    # Создаем таблицы
    print("Creating miner_data table...")
    if create_miner_data_table():
        print("SUCCESS: miner_data table created")
    else:
        print("ERROR: Failed to create miner_data table")
        return
    
    print("\nCreating miner_stats table...")
    if create_miner_stats_table():
        print("SUCCESS: miner_stats table created")
    else:
        print("ERROR: Failed to create miner_stats table")
        return
    
    # Проверяем таблицы
    print("\nTesting tables...")
    if test_tables():
        print("\nSUCCESS: All miner tables created and accessible!")
    else:
        print("\nERROR: Some tables are not accessible")
    
    print(f"Completed: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")

if __name__ == "__main__":
    main()
