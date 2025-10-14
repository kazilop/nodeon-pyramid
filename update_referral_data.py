#!/usr/bin/env python3
"""
Скрипт для обновления реферальных данных в базе
Заполняет новые колонки на основе существующих referral_path
"""

import os
import requests
import json
from typing import Dict, List, Any

# Настройки Supabase
SUPABASE_URL = os.getenv('SUPABASE_URL')
SUPABASE_KEY = os.getenv('SUPABASE_KEY')

if not SUPABASE_URL or not SUPABASE_KEY:
    print("❌ Ошибка: Не найдены переменные окружения SUPABASE_URL и SUPABASE_KEY")
    exit(1)

def get_supabase_headers():
    return {
        "apikey": SUPABASE_KEY,
        "Authorization": f"Bearer {SUPABASE_KEY}",
        "Content-Type": "application/json"
    }

def get_all_users():
    """Получить всех пользователей"""
    response = requests.get(
        f"{SUPABASE_URL}/rest/v1/nodeon_users?select=id,referral_path,is_pro",
        headers=get_supabase_headers()
    )
    
    if response.status_code == 200:
        return response.json()
    else:
        print(f"❌ Ошибка получения пользователей: {response.status_code}")
        return []

def calculate_referrals_for_user(user_id: int, all_users: List[Dict]) -> Dict[str, Any]:
    """Вычислить рефералов для пользователя"""
    referrals_by_level = {}
    all_referrals = []
    total_referrals = 0
    pro_referrals = 0
    regular_referrals = 0
    
    for user in all_users:
        referral_path = user.get('referral_path', '')
        if not referral_path:
            continue
            
        # Разбиваем путь
        path_parts = [int(x) for x in referral_path.rstrip(',').split(',') if x.isdigit()]
        
        # Ищем позицию нашего ID в пути
        if user_id in path_parts:
            user_position = path_parts.index(user_id)
            ref_id = user['id']
            
            if ref_id in path_parts:
                ref_position = path_parts.index(ref_id)
                level = ref_position - user_position
                
                if level > 0:  # Реферал должен быть после нас в пути
                    if level not in referrals_by_level:
                        referrals_by_level[level] = []
                    
                    referrals_by_level[level].append(ref_id)
                    all_referrals.append(ref_id)
                    total_referrals += 1
                    
                    if user.get('is_pro', False):
                        pro_referrals += 1
                    else:
                        regular_referrals += 1
    
    return {
        'all_referrals': all_referrals,
        'referrals_by_level': referrals_by_level,
        'total_referrals_count': total_referrals,
        'pro_referrals_count': pro_referrals,
        'regular_referrals_count': regular_referrals,
        'total_referral_earnings': 0  # Будет обновлено отдельно
    }

def update_user_referrals(user_id: int, referral_data: Dict[str, Any]):
    """Обновить реферальные данные пользователя"""
    update_data = {
        'all_referrals': referral_data['all_referrals'],
        'referrals_by_level': referral_data['referrals_by_level'],
        'total_referrals_count': referral_data['total_referrals_count'],
        'pro_referrals_count': referral_data['pro_referrals_count'],
        'regular_referrals_count': referral_data['regular_referrals_count'],
        'total_referral_earnings': referral_data['total_referral_earnings']
    }
    
    response = requests.patch(
        f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user_id}",
        headers=get_supabase_headers(),
        json=update_data
    )
    
    if response.status_code == 200:
        print(f"✅ Обновлен пользователь ID {user_id}: {referral_data['total_referrals_count']} рефералов")
        return True
    else:
        print(f"❌ Ошибка обновления пользователя ID {user_id}: {response.status_code}")
        return False

def main():
    print("🔄 Начинаем обновление реферальных данных...")
    
    # Получаем всех пользователей
    all_users = get_all_users()
    if not all_users:
        print("❌ Не удалось получить пользователей")
        return
    
    print(f"📊 Найдено {len(all_users)} пользователей")
    
    # Обрабатываем каждого пользователя
    updated_count = 0
    for user in all_users:
        user_id = user['id']
        referral_data = calculate_referrals_for_user(user_id, all_users)
        
        if update_user_referrals(user_id, referral_data):
            updated_count += 1
    
    print(f"\n✅ Обновлено {updated_count} пользователей")
    print("🎉 Реферальные данные успешно обновлены!")

if __name__ == "__main__":
    main()

