import os
from supabase import create_client, Client
from dotenv import load_dotenv
import sys
import io

# Fix для Windows
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

# Загрузка переменных окружения
load_dotenv()

SUPABASE_URL = os.getenv('SUPABASE_URL')
SUPABASE_KEY = os.getenv('SUPABASE_ANON_KEY')

if not SUPABASE_URL or not SUPABASE_KEY:
    print("❌ Необходимо настроить SUPABASE_URL и SUPABASE_KEY")
    exit(1)

supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

def check_transactions_for_user():
    """Проверить транзакции для пользователя ID=22"""
    
    print("🔍 Проверяем транзакции для пользователя ID=22\n")
    
    try:
        # Получаем пользователя
        result = supabase.table('nodeon_users').select('*').eq('id', 22).execute()
        
        if not result.data or len(result.data) == 0:
            print("❌ Пользователь ID=22 не найден")
            return
        
        user = result.data[0]
        print(f"👤 Пользователь: {user['first_name']} (@{user['username']})")
        print(f"💰 Баланс: {user['balance_ndn']} NDN")
        print(f"💎 Pro статус: {'✅' if user['is_pro'] else '❌'}")
        print()
        
        # Получаем транзакции
        transactions = supabase.table('nodeon_transactions').select('*').eq('user_id', 22).order('created_at', desc=True).limit(10).execute()
        
        if not transactions.data or len(transactions.data) == 0:
            print("❌ Транзакции не найдены")
            return
        
        print(f"📊 Найдено транзакций: {len(transactions.data)}\n")
        
        for i, txn in enumerate(transactions.data, 1):
            print(f"Транзакция #{i}:")
            print(f"  ID: {txn['id']}")
            print(f"  Тип: {txn['type']}")
            print(f"  NDN: {txn.get('amount_ndn', 'N/A')}")
            print(f"  Stars: {txn.get('amount_stars', 'N/A')}")
            print(f"  Описание: {txn.get('description', 'N/A')}")
            print(f"  Дата: {txn.get('created_at', 'N/A')}")
            print()
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")

def check_wallet_transactions():
    """Проверить wallet транзакции для пользователя ID=22"""
    
    print("\n🔍 Проверяем wallet транзакции для пользователя ID=22\n")
    
    try:
        # Получаем wallet транзакции
        transactions = supabase.table('nodeon_wallet_transactions').select('*').eq('user_id', 22).order('created_at', desc=True).limit(10).execute()
        
        if not transactions.data or len(transactions.data) == 0:
            print("❌ Wallet транзакции не найдены")
            return
        
        print(f"💰 Найдено wallet транзакций: {len(transactions.data)}\n")
        
        for i, txn in enumerate(transactions.data, 1):
            print(f"Wallet Транзакция #{i}:")
            print(f"  ID: {txn['id']}")
            print(f"  Тип: {txn['type']}")
            print(f"  Stars: {txn.get('stars_amount', 'N/A')}")
            print(f"  NDN: {txn.get('ndn_amount', 'N/A')}")
            print(f"  Описание: {txn.get('description', 'N/A')}")
            print(f"  Дата: {txn.get('created_at', 'N/A')}")
            print()
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")

if __name__ == "__main__":
    check_transactions_for_user()
    check_wallet_transactions()











