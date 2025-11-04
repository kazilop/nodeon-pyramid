import os
import sys
import io
from supabase import create_client, Client
from dotenv import load_dotenv

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

def add_user(telegram_id: str, username: str = None, first_name: str = "Пользователь", last_name: str = ""):
    """Добавить пользователя в базу данных"""
    
    print(f"👤 Добавляем пользователя: {first_name} ({telegram_id})")
    
    # Проверяем существование пользователя
    existing = supabase.table('nodeon_users').select('*').eq('telegram_id', telegram_id).execute()
    
    if existing.data and len(existing.data) > 0:
        user = existing.data[0]
        print(f"✅ Пользователь уже существует: ID={user['id']}, Balance={user['balance_ndn']}")
        return user
    
    # Создаем нового пользователя
    try:
        result = supabase.table('nodeon_users').insert({
            'telegram_id': int(telegram_id) if str(telegram_id).isdigit() else telegram_id,
            'username': username or None,
            'first_name': first_name,
            'last_name': last_name,
            'balance_ndn': 100,
            'is_pro': False,
            'referral_link': f'ref_{telegram_id}',
            'inviter_id': None
        }).execute()
        
        if result.data:
            user = result.data[0]
            print(f"✅ Пользователь создан: ID={user['id']}, Name={user['first_name']}")
            return user
        else:
            print(f"❌ Ошибка создания пользователя")
            return None
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return None

def list_all_users():
    """Список всех пользователей"""
    
    print("\n📋 Список всех пользователей:")
    
    try:
        result = supabase.table('nodeon_users').select('id, telegram_id, first_name, username, balance_ndn, is_pro').order('id', desc=False).execute()
        
        if result.data:
            print(f"\nВсего пользователей: {len(result.data)}\n")
            
            for user in result.data:
                pro_status = "✅ Pro" if user['is_pro'] else "❌ Free"
                print(f"ID: {user['id']} | Telegram: {user['telegram_id']} | Name: {user['first_name']} | Username: @{user['username']} | Balance: {user['balance_ndn']} NDN | {pro_status}")
        else:
            print("Пользователи не найдены")
            
    except Exception as e:
        print(f"❌ Ошибка получения списка: {e}")

if __name__ == "__main__":
    print("🚀 Утилита для добавления пользователей\n")
    
    # Показываем текущий список
    list_all_users()
    
    print("\n" + "="*80)
    print("Чтобы добавить пользователя, используйте:")
    print("add_user('telegram_id', 'username', 'First Name', 'Last Name')")
    print("="*80 + "\n")
    
    # Примеры использования
    # add_user('123456789', 'username', 'Имя', 'Фамилия')
    # add_user('987654321', 'user2', 'Имя2', 'Фамилия2')

