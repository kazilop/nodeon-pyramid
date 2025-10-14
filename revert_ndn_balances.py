#!/usr/bin/env python3
"""
Скрипт для восстановления исходных балансов NDN пользователей
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

# Исходные балансы пользователей (до обновления)
ORIGINAL_BALANCES = {
    "Artem (@SeledkinStar)": 200.0,
    "Ser (@teplo_vizor_sergey)": 100.0,
    "Mariya (@MariyaRybka)": 200.0,
    "mahnev (@mahnev_87)": 150.0,
    "Fish (@NobodyYety)": 9303.0,
    "Oleg (@Oleg_Cherkalin)": 100.0,
    "smotritel (@smotritel1849)": 0.0,
    "amigofet (@amigofet)": 0.0
}

def get_all_users():
    """Получить всех пользователей из базы данных"""
    try:
        url = f"{SUPABASE_URL}/rest/v1/nodeon_users?select=id,telegram_id,first_name,username,balance_ndn"
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

def update_user_balance(user_id, new_balance):
    """Обновить баланс пользователя"""
    try:
        url = f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user_id}"
        headers = {
            "apikey": SUPABASE_KEY,
            "Authorization": f"Bearer {SUPABASE_KEY}",
            "Content-Type": "application/json",
            "Prefer": "return=minimal"
        }
        
        data = {
            "balance_ndn": new_balance
        }
        
        response = requests.patch(url, headers=headers, json=data)
        
        if response.status_code in [200, 204]:
            return True
        else:
            print(f"Error updating user {user_id}: {response.status_code}")
            print(f"Response: {response.text}")
            return False
    except Exception as e:
        print(f"Error updating user {user_id}: {e}")
        return False

def main():
    print("Starting NDN balance reversion to original values...")
    print(f"Time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("=" * 60)
    
    # Get all users
    users = get_all_users()
    if not users:
        print("ERROR: Could not get users")
        return
    
    # Statistics
    total_users = len(users)
    updated_count = 0
    error_count = 0
    
    print(f"Current balances:")
    for user in users:
        balance = user.get('balance_ndn', 0)
        first_name = user.get('first_name', 'Unknown')
        username = user.get('username', 'no_username')
        print(f"  User: {first_name} (@{username}) - {balance} NDN")
    
    print("=" * 60)
    
    # Update each user to original balance
    for i, user in enumerate(users, 1):
        user_id = user['id']
        current_balance = user.get('balance_ndn', 0)
        first_name = user.get('first_name', 'Unknown')
        username = user.get('username', 'no_username')
        user_key = f"{first_name} (@{username})"
        
        # Get original balance
        original_balance = ORIGINAL_BALANCES.get(user_key, 0.0)
        
        print(f"[{i}/{total_users}] Reverting {first_name} (@{username}) - was {current_balance} NDN, reverting to {original_balance} NDN...")
        
        if current_balance == original_balance:
            print(f"  Already has original balance, skipping")
            continue
        
        if update_user_balance(user_id, original_balance):
            updated_count += 1
            print(f"  Reverted to {original_balance} NDN")
        else:
            error_count += 1
            print(f"  Revert error")
    
    print("=" * 60)
    print("FINAL STATISTICS:")
    print(f"  Total users: {total_users}")
    print(f"  Successfully reverted: {updated_count}")
    print(f"  Errors: {error_count}")
    
    if error_count == 0:
        print("\nSUCCESS: All users reverted to original balances!")
    else:
        print(f"\nWARNING: Reverted with errors: {error_count} users")
    
    print(f"Completed: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")

if __name__ == "__main__":
    main()
