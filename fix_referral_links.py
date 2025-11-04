import os
import requests
import json
from supabase import create_client, Client

# Настройки Supabase
SUPABASE_URL = "https://your-project.supabase.co"  # Замените на ваш URL
SUPABASE_KEY = "your-anon-key"  # Замените на ваш ключ

def fix_referral_links():
    """Исправляет referral_link в базе данных - убирает полный URL, оставляет только ref_ID"""
    
    print("🔧 Исправление referral_link в базе данных...")
    
    try:
        # Подключение к Supabase
        supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)
        
        # Получаем всех пользователей
        response = supabase.table('nodeon_users').select('id, referral_link').execute()
        users = response.data
        
        print(f"📊 Найдено {len(users)} пользователей")
        
        updated_count = 0
        
        for user in users:
            current_link = user.get('referral_link', '')
            user_id = user['id']
            
            # Проверяем, нужно ли исправить ссылку
            if current_link and current_link.startswith('https://t.me/'):
                # Извлекаем ref_ID из полной ссылки
                if 'ref_' in current_link:
                    ref_part = current_link.split('ref_')[-1]
                    new_link = f"ref_{ref_part}"
                else:
                    new_link = f"ref_{user_id}"
                
                # Обновляем в базе данных
                update_response = supabase.table('nodeon_users').update({
                    'referral_link': new_link
                }).eq('id', user_id).execute()
                
                if update_response.data:
                    print(f"✅ Пользователь {user_id}: {current_link} → {new_link}")
                    updated_count += 1
                else:
                    print(f"❌ Ошибка обновления пользователя {user_id}")
                    
            elif not current_link or current_link == '':
                # Создаем новую ссылку для пользователей без ссылки
                new_link = f"ref_{user_id}"
                
                update_response = supabase.table('nodeon_users').update({
                    'referral_link': new_link
                }).eq('id', user_id).execute()
                
                if update_response.data:
                    print(f"✅ Пользователь {user_id}: создана ссылка {new_link}")
                    updated_count += 1
        
        print(f"\n🎉 Обновлено {updated_count} пользователей")
        
        # Проверяем результат
        print("\n📋 Проверка результата:")
        response = supabase.table('nodeon_users').select('id, referral_link').limit(5).execute()
        for user in response.data:
            print(f"ID {user['id']}: {user['referral_link']}")
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")

if __name__ == "__main__":
    fix_referral_links()











