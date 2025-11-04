#!/usr/bin/env python3
"""
Скрипт для проверки английских переводов в БД
"""

import os
import json
from supabase import create_client, Client
from dotenv import load_dotenv

def check_english_translations():
    """Проверяет английские переводы в БД"""
    
    load_dotenv()
    
    url = os.getenv('SUPABASE_URL')
    key = os.getenv('SUPABASE_ANON_KEY')
    
    if not url or not key:
        print("Ошибка: Не найдены переменные окружения")
        return False
    
    try:
        supabase: Client = create_client(url, key)
        
        # Получаем все записи с английскими переводами
        result = supabase.table('nodeon_localization').select('text_id, ru, en').execute()
        
        if not result.data:
            print("Нет данных в таблице локализации")
            return False
        
        print(f"Всего записей в БД: {len(result.data)}")
        
        # Считаем статистику
        total_records = len(result.data)
        with_english = sum(1 for item in result.data if item.get('en'))
        without_english = total_records - with_english
        
        print(f"С английским переводом: {with_english}")
        print(f"Без английского перевода: {without_english}")
        
        # Показываем записи без английского перевода
        if without_english > 0:
            print(f"\nЗаписи без английского перевода:")
            for item in result.data:
                if not item.get('en'):
                    print(f"  {item['text_id']}: {item['ru']}")
        
        # Показываем примеры с английским переводом
        print(f"\nПримеры с английским переводом:")
        count = 0
        for item in result.data:
            if item.get('en') and count < 5:
                print(f"  {item['text_id']}: {item['ru']} -> {item['en']}")
                count += 1
        
        return True
        
    except Exception as e:
        print(f"Ошибка: {e}")
        return False

def create_english_translations():
    """Создает недостающие английские переводы"""
    
    load_dotenv()
    
    url = os.getenv('SUPABASE_URL')
    key = os.getenv('SUPABASE_ANON_KEY')
    
    if not url or not key:
        return False
    
    try:
        supabase: Client = create_client(url, key)
        
        # Словарь переводов
        translations = {
            'app.name': '🚀 NodeOn Crypto',
            'app.description': 'Crypto game with NDN coins',
            'tabs.core': '🏠 Main',
            'tabs.game': '🎮 Game',
            'tabs.miner': '⛏️ NDN Miner',
            'user.balance_ndn': 'NDN Balance',
            'user.balance_stars': 'Stars Balance',
            'buttons.buy_pro': '💎 Buy Pro Status',
            'buttons.buy_ndn': '⭐ Buy NDN for Telegram Stars',
            'buttons.exchange': '⭐ Exchange NDN for Stars',
            'buttons.transfer_ndn': '💸 Transfer NDN',
            'buttons.referrals': '👥 My Referrals',
            'buttons.leaderboard': '🏆 Leaderboard',
            'buttons.rules': '📋 Game Rules',
            'buttons.withdraw': '💰 Withdraw',
            'buttons.deposit': '💳 Deposit',
            'pro.title': 'Pro Status',
            'pro.benefits': 'Pro Benefits',
            'pro.cost': 'Cost: 1000 NDN',
            'pro.activated': 'Pro Status Activated',
            'miner.title': 'NDN Miner',
            'miner.energy': 'Energy',
            'miner.gas': 'Gas',
            'miner.farms': 'Farms',
            'miner.buy_farm': 'Buy Farm',
            'game.title': 'Game',
            'game.achievements': 'Achievements',
            'game.daily_reward': 'Daily Reward',
            'game.quests': 'Quests',
            'referrals.title': 'My Referrals',
            'referrals.total': 'Total Referrals',
            'referrals.earnings': 'Total Earnings',
            'leaderboard.title': '🏆 Leaderboard',
            'leaderboard.subtitle': 'Top players by NDN balance',
            'rules.title': '📋 Game Rules',
            'rules.how_to_play': 'How to Play',
            'rules.rewards': 'Referral Rewards',
            'rules.features': 'Pro Features',
            'rules.tips': 'Tips',
            'admin.title': 'Admin Panel',
            'admin.users': 'Total Users',
            'admin.pro_users': 'Pro Users',
            'admin.wallet': 'Server Wallet',
            'notifications.success': 'Success',
            'notifications.error': 'Error',
            'notifications.info': 'Info',
            'notifications.warning': 'Warning'
        }
        
        # Обновляем переводы
        updated_count = 0
        for text_id, english_text in translations.items():
            try:
                result = supabase.table('nodeon_localization').update({
                    'en': english_text
                }).eq('text_id', text_id).execute()
                
                if result.data:
                    updated_count += 1
                    print(f"Обновлено {text_id}: {english_text}")
                    
            except Exception as e:
                print(f"Ошибка обновления {text_id}: {e}")
        
        print(f"\nОбновлено {updated_count} английских переводов")
        return True
        
    except Exception as e:
        print(f"Ошибка создания переводов: {e}")
        return False

def main():
    """Основная функция"""
    print("Проверка английских переводов...")
    
    if check_english_translations():
        print("\nСоздание недостающих английских переводов...")
        create_english_translations()
        
        print("\nПовторная проверка...")
        check_english_translations()

if __name__ == "__main__":
    main()
