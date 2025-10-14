#!/usr/bin/env python3
"""
Скрипт для установки 100 Gas в майнере для всех пользователей
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

def get_all_users():
    """Получить всех пользователей из базы данных"""
    try:
        url = f"{SUPABASE_URL}/rest/v1/nodeon_users?select=id,telegram_id,first_name,username"
        headers = {
            "apikey": SUPABASE_KEY,
            "Authorization": f"Bearer {SUPABASE_KEY}",
            "Content-Type": "application/json"
        }
        
        response = requests.get(url, headers=headers)
        
        if response.status_code == 200:
            users = response.json()
            print(f"Found users: {len(users)}")
            return users
        else:
            print(f"Error getting users: {response.status_code}")
            print(f"Response: {response.text}")
            return []
    except Exception as e:
        print(f"Database connection error: {e}")
        return []

def update_user_miner_data(user_id, miner_data):
    """Обновить данные майнера пользователя"""
    try:
        url = f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user_id}"
        headers = {
            "apikey": SUPABASE_KEY,
            "Authorization": f"Bearer {SUPABASE_KEY}",
            "Content-Type": "application/json",
            "Prefer": "return=minimal"
        }
        
        data = {
            "miner_data": miner_data
        }
        
        response = requests.patch(url, headers=headers, json=data)
        
        if response.status_code in [200, 204]:
            return True
        else:
            print(f"Error updating miner data for user {user_id}: {response.status_code}")
            print(f"Response: {response.text}")
            return False
    except Exception as e:
        print(f"Error updating miner data for user {user_id}: {e}")
        return False

def main():
    print("Starting miner Gas setup to 100 for all users...")
    print(f"Time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("=" * 60)
    
    # Get all users
    users = get_all_users()
    if not users:
        print("ERROR: Could not get users")
        return
    
    # Default miner data with 100 Gas
    default_miner_data = {
        "ndn_gas": 100,  # 100 Gas для майнинга
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
        "last_energy_refill": int(datetime.now().timestamp() * 1000),
        "last_update": int(datetime.now().timestamp() * 1000)
    }
    
    # Statistics
    total_users = len(users)
    updated_count = 0
    error_count = 0
    
    print(f"Setting up miner data for {total_users} users...")
    print("=" * 60)
    
    # Update each user's miner data
    for i, user in enumerate(users, 1):
        user_id = user['id']
        first_name = user.get('first_name', 'Unknown')
        username = user.get('username', 'no_username')
        
        print(f"[{i}/{total_users}] Setting up miner for {first_name} (@{username})...")
        
        if update_user_miner_data(user_id, default_miner_data):
            updated_count += 1
            print(f"  Miner data set with 100 Gas")
        else:
            error_count += 1
            print(f"  Setup error")
    
    print("=" * 60)
    print("FINAL STATISTICS:")
    print(f"  Total users: {total_users}")
    print(f"  Successfully set up: {updated_count}")
    print(f"  Errors: {error_count}")
    
    if error_count == 0:
        print("\nSUCCESS: All users have 100 Gas in miner!")
    else:
        print(f"\nWARNING: Setup with errors: {error_count} users")
    
    print(f"Completed: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")

if __name__ == "__main__":
    main()
