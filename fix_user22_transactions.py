import os
from supabase import create_client, Client
from dotenv import load_dotenv
import sys
import io
from datetime import datetime

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

def add_transaction(user_id, txn_type, amount_ndn, amount_stars, description):
    """Добавить транзакцию"""
    try:
        result = supabase.table('nodeon_transactions').insert({
            'user_id': user_id,
            'type': txn_type,
            'amount_ndn': amount_ndn,
            'amount_stars': amount_stars,
            'description': description,
            'created_at': datetime.utcnow().isoformat()
        }).execute()
        
        if result.data:
            print(f"✅ Транзакция добавлена: {description}")
            return True
        return False
    except Exception as e:
        print(f"❌ Ошибка добавления транзакции: {e}")
        return False

def add_wallet_transaction(user_id, stars_amount, ndn_amount, description):
    """Добавить wallet транзакцию"""
    try:
        # Получаем активный кошелек
        wallet_result = supabase.table('nodeon_server_wallet').select('id').eq('is_active', True).limit(1).execute()
        
        if not wallet_result.data:
            print("⚠️ Активный кошелек не найден")
            return False
        
        wallet_id = wallet_result.data[0]['id']
        
        result = supabase.table('nodeon_wallet_transactions').insert({
            'wallet_id': wallet_id,
            'user_id': user_id,
            'type': 'stars_purchase',
            'stars_amount': stars_amount,
            'ndn_amount': ndn_amount,
            'balance_before': 0,
            'balance_after': 0,
            'description': description,
            'created_at': datetime.utcnow().isoformat()
        }).execute()
        
        if result.data:
            print(f"✅ Wallet транзакция добавлена: {description}")
            return True
        return False
    except Exception as e:
        print(f"❌ Ошибка добавления wallet транзакции: {e}")
        return False

def check_and_fix_user22():
    """Проверить и исправить транзакции пользователя ID=22"""
    
    print("🔍 Проверяем транзакции пользователя ID=22\n")
    
    try:
        # Получаем пользователя
        user_result = supabase.table('nodeon_users').select('*').eq('id', 22).execute()
        
        if not user_result.data:
            print("❌ Пользователь ID=22 не найден")
            return
        
        user = user_result.data[0]
        print(f"👤 Пользователь: {user['first_name']} (@{user['username']})")
        print(f"💰 Текущий баланс: {user['balance_ndn']} NDN")
        print()
        
        # Получаем транзакции
        txn_result = supabase.table('nodeon_transactions').select('*').eq('user_id', 22).order('created_at', desc=True).execute()
        
        print(f"📊 Найдено транзакций: {len(txn_result.data)}\n")
        
        buy_ndn_count = sum(1 for t in txn_result.data if t['type'] == 'buy_ndn_for_stars')
        
        print(f"🛒 Транзакций покупки NDN за Stars: {buy_ndn_count}")
        
        # Проверяем wallet транзакции
        wallet_result = supabase.table('nodeon_wallet_transactions').select('*').eq('user_id', 22).execute()
        
        print(f"💰 Wallet транзакций: {len(wallet_result.data)}\n")
        
        # Если нет wallet транзакций - создаем их для каждой покупки
        if buy_ndn_count > 0 and len(wallet_result.data) == 0:
            print("⚠️ Wallet транзакции отсутствуют. Создаем...\n")
            
            for txn in txn_result.data:
                if txn['type'] == 'buy_ndn_for_stars':
                    stars_amount = txn.get('amount_stars', 0)
                    ndn_amount = txn.get('amount_ndn', 0)
                    
                    if stars_amount > 0 and ndn_amount > 0:
                        add_wallet_transaction(
                            user_id=22,
                            stars_amount=stars_amount,
                            ndn_amount=ndn_amount,
                            description=f"Получено {stars_amount} Stars от пользователя {user['telegram_id']} за {ndn_amount} NDN"
                        )
        
        print("\n✅ Проверка завершена")
        
    except Exception as e:
        print(f"❌ Ошибка: {e}")

if __name__ == "__main__":
    check_and_fix_user22()











