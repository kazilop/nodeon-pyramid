#!/usr/bin/env python3
"""
Настройка аккаунта разработчика через Supabase API
"""

import requests
import json
import time

# Настройки Supabase
SUPABASE_URL = "https://ahxwpzgltlzlvrtrbanm.supabase.co"
SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoeHdwemdsdGx6bHZydHJiYW5tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1MDMxNDksImV4cCI6MjA3NTA3OTE0OX0.h4sMVhVwvRUiHgbevDgv9W1G2S__uDWPUSCiXdrEy4E"

DEVELOPER_TELEGRAM_ID = 207940967

def setup_developer_via_supabase():
    """Настройка разработчика через Supabase API"""
    
    headers = {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }
    
    try:
        print("🔧 Настраиваем аккаунт разработчика через Supabase...")
        
        # 1. Создаем или обновляем пользователя
        print("👤 Создаем/обновляем пользователя...")
        
        user_data = {
            "telegram_id": DEVELOPER_TELEGRAM_ID,
            "username": "developer",
            "first_name": "Разработчик",
            "last_name": "NodeOn",
            "balance_ndn": 10000.00,
            "is_pro": True,
            "referral_link": f"https://t.me/pro_stars_bot?startapp=dev_{DEVELOPER_TELEGRAM_ID}",
            "inviter_id": None,
            "created_at": "2024-01-01T00:00:00Z",
            "updated_at": "2024-01-01T00:00:00Z"
        }
        
        # Пытаемся создать пользователя
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/nodeon_users",
            headers=headers,
            json=user_data
        )
        
        if response.status_code == 201:
            print("✅ Пользователь создан")
            user_id = response.json()[0]["id"]
        elif response.status_code == 409:  # Конфликт - пользователь уже существует
            print("👤 Пользователь уже существует, обновляем...")
            
            # Получаем существующего пользователя
            response = requests.get(
                f"{SUPABASE_URL}/rest/v1/nodeon_users?telegram_id=eq.{DEVELOPER_TELEGRAM_ID}",
                headers=headers
            )
            
            if response.status_code == 200:
                user_id = response.json()[0]["id"]
                
                # Обновляем пользователя
                update_data = {
                    "balance_ndn": 10000.00,
                    "is_pro": True,
                    "referral_link": f"https://t.me/pro_stars_bot?startapp=dev_{DEVELOPER_TELEGRAM_ID}",
                    "updated_at": "2024-01-01T00:00:00Z"
                }
                
                response = requests.patch(
                    f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user_id}",
                    headers=headers,
                    json=update_data
                )
                
                if response.status_code == 200:
                    print("✅ Пользователь обновлен")
                else:
                    print(f"❌ Ошибка обновления: {response.text}")
                    return False
            else:
                print(f"❌ Ошибка получения пользователя: {response.text}")
                return False
        else:
            print(f"❌ Ошибка создания пользователя: {response.text}")
            return False
        
        # 2. Создаем транзакцию
        print("💰 Создаем транзакцию бонуса...")
        
        transaction_data = {
            "user_id": user_id,
            "type": "developer_bonus",
            "amount_ndn": 10000.00,
            "description": "Бонус разработчику - 10,000 NDN",
            "created_at": "2024-01-01T00:00:00Z"
        }
        
        response = requests.post(
            f"{SUPABASE_URL}/rest/v1/nodeon_transactions",
            headers=headers,
            json=transaction_data
        )
        
        if response.status_code == 201:
            print("✅ Транзакция создана")
        else:
            print(f"❌ Ошибка создания транзакции: {response.text}")
        
        # 3. Создаем статистику рефералов
        print("📊 Создаем статистику рефералов...")
        
        for level in range(1, 8):
            stats_data = {
                "user_id": user_id,
                "level": level,
                "total_referrals": 0,
                "total_earnings": 0.00,
                "updated_at": "2024-01-01T00:00:00Z"
            }
            
            response = requests.post(
                f"{SUPABASE_URL}/rest/v1/nodeon_referral_stats",
                headers=headers,
                json=stats_data
            )
            
            if response.status_code == 201:
                print(f"   Уровень {level}: ✅")
            else:
                print(f"   Уровень {level}: ❌ {response.text}")
        
        print("\n🎉 Настройка завершена!")
        print(f"👤 Пользователь: Разработчик NodeOn")
        print(f"🆔 Telegram ID: {DEVELOPER_TELEGRAM_ID}")
        print(f"👑 Pro статус: ✅ Да")
        print(f"💰 Баланс: 10,000 NDN")
        print(f"🔗 Реферальная ссылка: https://t.me/pro_stars_bot?startapp=dev_{DEVELOPER_TELEGRAM_ID}")
        
        return True
        
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def check_developer_status():
    """Проверка статуса разработчика"""
    
    headers = {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }
    
    try:
        print("🔍 Проверяем статус разработчика...")
        
        response = requests.get(
            f"{SUPABASE_URL}/rest/v1/nodeon_users?telegram_id=eq.{DEVELOPER_TELEGRAM_ID}",
            headers=headers
        )
        
        if response.status_code == 200:
            users = response.json()
            if users:
                user = users[0]
                print(f"✅ Пользователь найден:")
                print(f"   ID: {user['id']}")
                print(f"   Имя: {user['first_name']} {user['last_name']}")
                print(f"   Баланс: {user['balance_ndn']} NDN")
                print(f"   Pro: {'Да' if user['is_pro'] else 'Нет'}")
                print(f"   Реферальная ссылка: {user['referral_link']}")
                return True
            else:
                print("❌ Пользователь не найден")
                return False
        else:
            print(f"❌ Ошибка: {response.text}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка проверки: {e}")
        return False

def main():
    print("🚀 NodeOn Pyramid - Настройка через Supabase")
    print("=" * 50)
    
    # Проверяем текущий статус
    print("\n1️⃣ Проверяем текущий статус...")
    check_developer_status()
    
    # Настраиваем аккаунт
    print("\n2️⃣ Настраиваем аккаунт...")
    if setup_developer_via_supabase():
        print("\n3️⃣ Проверяем результат...")
        check_developer_status()
        print("\n✅ Готово! Теперь можно тестировать в Telegram!")
    else:
        print("\n❌ Настройка не удалась.")

if __name__ == "__main__":
    main()
