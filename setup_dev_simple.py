#!/usr/bin/env python3
"""
Простой скрипт для настройки аккаунта разработчика
"""

import os
import sys
from decimal import Decimal
from sqlalchemy import create_engine, text
from datetime import datetime

# Настройки базы данных
DATABASE_URL = "postgresql://postgres.nodeon:G-Gje9!Jr4B9-$C@ahxwpzgltlzlvrtrbanm.supabase.co:5432/postgres"
TELEGRAM_BOT_USERNAME = "pro_stars_bot"

def setup_developer_account():
    """Настройка аккаунта разработчика"""
    
    # Создаем подключение к базе данных
    engine = create_engine(DATABASE_URL)
    
    try:
        developer_telegram_id = 207940967
        
        print(f"🔧 Настраиваем аккаунт разработчика (ID: {developer_telegram_id})...")
        
        with engine.connect() as conn:
            # Проверяем существование пользователя
            result = conn.execute(text("""
                SELECT id, telegram_id, first_name, last_name, balance_ndn, is_pro, referral_link 
                FROM nodeon_users 
                WHERE telegram_id = :telegram_id
            """), {"telegram_id": developer_telegram_id})
            
            user_data = result.fetchone()
            
            if not user_data:
                print("👤 Создаем нового пользователя...")
                # Создаем пользователя
                conn.execute(text("""
                    INSERT INTO nodeon_users 
                    (telegram_id, username, first_name, last_name, balance_ndn, is_pro, referral_link, inviter_id, created_at, updated_at)
                    VALUES 
                    (:telegram_id, :username, :first_name, :last_name, :balance_ndn, :is_pro, :referral_link, :inviter_id, :created_at, :updated_at)
                """), {
                    "telegram_id": developer_telegram_id,
                    "username": "developer",
                    "first_name": "Разработчик",
                    "last_name": "NodeOn",
                    "balance_ndn": 0,
                    "is_pro": False,
                    "referral_link": "",
                    "inviter_id": None,
                    "created_at": datetime.utcnow(),
                    "updated_at": datetime.utcnow()
                })
                
                # Получаем ID созданного пользователя
                result = conn.execute(text("""
                    SELECT id FROM nodeon_users WHERE telegram_id = :telegram_id
                """), {"telegram_id": developer_telegram_id})
                user_id = result.fetchone()[0]
                print(f"✅ Пользователь создан с ID: {user_id}")
            else:
                user_id = user_data[0]
                print(f"👤 Пользователь найден с ID: {user_id}")
                print(f"   Имя: {user_data[2]} {user_data[3]}")
                print(f"   Баланс: {user_data[4]} NDN")
                print(f"   Pro статус: {'Да' if user_data[5] else 'Нет'}")
            
            # Устанавливаем Pro статус и зачисляем NDN
            print("👑 Устанавливаем Pro статус и зачисляем 10,000 NDN...")
            
            # Генерируем простую реферальную ссылку
            referral_link = f"https://t.me/{TELEGRAM_BOT_USERNAME}?startapp=dev_{user_id}_{int(datetime.utcnow().timestamp())}"
            
            # Обновляем пользователя
            conn.execute(text("""
                UPDATE nodeon_users 
                SET is_pro = true, 
                    balance_ndn = balance_ndn + :bonus_amount,
                    referral_link = :referral_link,
                    updated_at = :updated_at
                WHERE id = :user_id
            """), {
                "user_id": user_id,
                "bonus_amount": 10000,
                "referral_link": referral_link,
                "updated_at": datetime.utcnow()
            })
            
            # Создаем транзакцию
            conn.execute(text("""
                INSERT INTO nodeon_transactions 
                (user_id, type, amount_ndn, description, created_at)
                VALUES 
                (:user_id, :type, :amount_ndn, :description, :created_at)
            """), {
                "user_id": user_id,
                "type": "developer_bonus",
                "amount_ndn": 10000,
                "description": "Бонус разработчику - 10,000 NDN",
                "created_at": datetime.utcnow()
            })
            
            # Создаем статистику рефералов если её нет
            conn.execute(text("""
                INSERT INTO nodeon_referral_stats (user_id, level, total_referrals, total_earnings, updated_at)
                SELECT :user_id, level, 0, 0, :updated_at
                FROM generate_series(1, 7) AS level
                WHERE NOT EXISTS (
                    SELECT 1 FROM nodeon_referral_stats WHERE user_id = :user_id
                )
            """), {
                "user_id": user_id,
                "updated_at": datetime.utcnow()
            })
            
            conn.commit()
            
            # Проверяем результат
            result = conn.execute(text("""
                SELECT first_name, last_name, balance_ndn, is_pro, referral_link 
                FROM nodeon_users 
                WHERE id = :user_id
            """), {"user_id": user_id})
            
            final_data = result.fetchone()
            
            print("\n🎉 Настройка завершена успешно!")
            print(f"👤 Пользователь: {final_data[0]} {final_data[1]}")
            print(f"🆔 Telegram ID: {developer_telegram_id}")
            print(f"👑 Pro статус: {'✅ Да' if final_data[3] else '❌ Нет'}")
            print(f"💰 Баланс NDN: {final_data[2]}")
            print(f"🔗 Реферальная ссылка: {final_data[4]}")
            
            return True
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def check_account_status():
    """Проверка статуса аккаунта"""
    
    engine = create_engine(DATABASE_URL)
    
    try:
        developer_telegram_id = 207940967
        
        with engine.connect() as conn:
            result = conn.execute(text("""
                SELECT id, first_name, last_name, balance_ndn, is_pro, referral_link,
                       (SELECT COUNT(*) FROM nodeon_transactions WHERE user_id = nodeon_users.id) as transaction_count
                FROM nodeon_users 
                WHERE telegram_id = :telegram_id
            """), {"telegram_id": developer_telegram_id})
            
            user_data = result.fetchone()
            
            if user_data:
                print(f"\n📊 Статус аккаунта разработчика:")
                print(f"👤 Имя: {user_data[1]} {user_data[2]}")
                print(f"🆔 Telegram ID: {developer_telegram_id}")
                print(f"👑 Pro статус: {'✅ Да' if user_data[4] else '❌ Нет'}")
                print(f"💰 Баланс NDN: {user_data[3]}")
                print(f"🔗 Реферальная ссылка: {user_data[5]}")
                print(f"📝 Транзакций: {user_data[6]}")
            else:
                print("❌ Пользователь не найден")
                
    except Exception as e:
        print(f"❌ Ошибка проверки: {e}")

if __name__ == "__main__":
    print("🚀 NodeOn Pyramid - Настройка аккаунта разработчика")
    print("=" * 60)
    
    # Проверяем текущий статус
    print("\n1️⃣ Проверяем текущий статус...")
    check_account_status()
    
    # Настраиваем аккаунт
    print("\n2️⃣ Настраиваем аккаунт...")
    if setup_developer_account():
        print("\n3️⃣ Проверяем результат...")
        check_account_status()
        print("\n✅ Готово! Аккаунт разработчика настроен.")
    else:
        print("\n❌ Настройка не удалась.")
