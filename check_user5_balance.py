#!/usr/bin/env python3
"""
Скрипт для проверки баланса пользователя ID=5 и выявления рассинхронизации
"""

import os
import sys
from supabase import create_client, Client

# Инициализация Supabase
SUPABASE_URL = os.getenv("SUPABASE_URL", "https://mikziubnzbxeefxxcloz.supabase.co")
SUPABASE_KEY = os.getenv("SUPABASE_ANON_KEY", "")

if not SUPABASE_KEY:
    print("❌ Ошибка: SUPABASE_ANON_KEY не установлен")
    sys.exit(1)

supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

def check_user_balance(user_id=5):
    """Проверяет баланс пользователя и транзакции"""
    print(f"\n🔍 Проверка баланса пользователя ID={user_id}\n")
    
    # Получаем данные пользователя
    response = supabase.table('nodeon_users').select('*').eq('id', user_id).execute()
    
    if not response.data:
        print(f"❌ Пользователь с ID={user_id} не найден")
        return
    
    user = response.data[0]
    print(f"📊 Данные пользователя:")
    print(f"   Telegram ID: {user.get('telegram_id')}")
    print(f"   Username: {user.get('username', 'N/A')}")
    print(f"   Баланс NDN в БД: {user.get('balance_ndn', 0)}")
    
    # Получаем все транзакции пользователя
    transactions = supabase.table('nodeon_transactions').select('*').eq('user_id', user_id).order('created_at', desc=True).limit(20).execute()
    
    print(f"\n💸 Последние транзакции ({len(transactions.data)} шт):")
    
    total_from_transactions = 0
    daily_rewards_count = 0
    
    for tx in transactions.data:
        tx_type = tx.get('type', 'unknown')
        amount = tx.get('amount_ndn', 0)
        description = tx.get('description', '')
        created_at = tx.get('created_at', '')
        
        print(f"   [{created_at[:10]}] {tx_type}: {amount} NDN - {description}")
        
        if tx_type == 'daily_reward':
            daily_rewards_count += 1
            total_from_transactions += amount
    
    print(f"\n📈 Статистика:")
    print(f"   Количество ежедневных наград: {daily_rewards_count}")
    print(f"   Сумма ежедневных наград (из транзакций): {total_from_transactions} NDN")
    
    # Вычисляем ожидаемый баланс (если бы было только добавление через награды)
    # Это упрощенная проверка, реальный баланс может быть изменен другими операциями
    print(f"\n💡 Примечание:")
    print(f"   Если баланс в приложении ({user.get('balance_ndn', 0)} NDN) отличается от ожидаемого,")
    print(f"   это может быть связано с другими операциями (покупки, выводы и т.д.)")
    
    return user

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description='Проверка баланса пользователя')
    parser.add_argument('--user-id', type=int, default=5, help='ID пользователя для проверки')
    args = parser.parse_args()
    
    check_user_balance(args.user_id)









