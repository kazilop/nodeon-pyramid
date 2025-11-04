#!/usr/bin/env python3
"""
Скрипт для создания таблицы локализации в Supabase
"""

import os
import json
from supabase import create_client, Client
from dotenv import load_dotenv

def create_localization_table():
    """Создает таблицу локализации в Supabase"""
    
    load_dotenv()
    
    url = os.getenv('SUPABASE_URL')
    key = os.getenv('SUPABASE_ANON_KEY')
    
    if not url or not key:
        print("Ошибка: Не найдены переменные окружения")
        return False
    
    try:
        supabase: Client = create_client(url, key)
        print("Подключение к Supabase установлено")
        
        # Создаем таблицу через SQL
        create_sql = """
        CREATE TABLE IF NOT EXISTS nodeon_localization (
            id SERIAL PRIMARY KEY,
            text_id VARCHAR(100) NOT NULL UNIQUE,
            ru TEXT NOT NULL,
            en TEXT,
            es TEXT,
            de TEXT,
            fr TEXT,
            it TEXT,
            pt TEXT,
            ar TEXT,
            hi TEXT,
            ja TEXT,
            ko TEXT,
            zh TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );
        """
        
        # Пытаемся выполнить через RPC
        try:
            result = supabase.rpc('exec_sql', {'sql': create_sql}).execute()
            print("Таблица nodeon_localization создана через RPC")
        except Exception as e:
            print(f"RPC не доступен: {e}")
            print("Создайте таблицу вручную в Supabase Dashboard:")
            print(create_sql)
            return False
        
        # Создаем индексы
        indexes = [
            "CREATE INDEX IF NOT EXISTS idx_localization_text_id ON nodeon_localization(text_id);",
            "CREATE INDEX IF NOT EXISTS idx_localization_updated_at ON nodeon_localization(updated_at);"
        ]
        
        for index_sql in indexes:
            try:
                supabase.rpc('exec_sql', {'sql': index_sql}).execute()
                print(f"Индекс создан: {index_sql.split()[5]}")
            except Exception as e:
                print(f"Ошибка создания индекса: {e}")
        
        print("Таблица локализации готова!")
        return True
        
    except Exception as e:
        print(f"Ошибка: {e}")
        return False

def insert_basic_translations():
    """Вставляет базовые переводы"""
    
    load_dotenv()
    
    url = os.getenv('SUPABASE_URL')
    key = os.getenv('SUPABASE_ANON_KEY')
    
    if not url or not key:
        return False
    
    try:
        supabase: Client = create_client(url, key)
        
        # Базовые переводы
        translations = [
            {
                'text_id': 'app.name',
                'ru': '🚀 NodeOn Crypto',
                'en': '🚀 NodeOn Crypto',
                'es': '🚀 NodeOn Crypto'
            },
            {
                'text_id': 'app.description',
                'ru': 'Крипто игра с монетами NDN',
                'en': 'Crypto game with NDN coins',
                'es': 'Juego de cripto con monedas NDN'
            },
            {
                'text_id': 'tabs.core',
                'ru': '🏠 Основное',
                'en': '🏠 Main',
                'es': '🏠 Principal'
            },
            {
                'text_id': 'tabs.game',
                'ru': '🎮 Игра',
                'en': '🎮 Game',
                'es': '🎮 Juego'
            },
            {
                'text_id': 'tabs.miner',
                'ru': '⛏️ NDN Miner',
                'en': '⛏️ NDN Miner',
                'es': '⛏️ NDN Miner'
            },
            {
                'text_id': 'user.balance_ndn',
                'ru': 'NDN Баланс',
                'en': 'NDN Balance',
                'es': 'Saldo NDN'
            },
            {
                'text_id': 'user.balance_stars',
                'ru': 'Stars Баланс',
                'en': 'Stars Balance',
                'es': 'Saldo Stars'
            },
            {
                'text_id': 'buttons.buy_pro',
                'ru': '💎 Купить Pro статус',
                'en': '💎 Buy Pro Status',
                'es': '💎 Comprar Estado Pro'
            },
            {
                'text_id': 'buttons.buy_ndn',
                'ru': '⭐ Купить NDN за Telegram Stars',
                'en': '⭐ Buy NDN for Telegram Stars',
                'es': '⭐ Comprar NDN por Telegram Stars'
            },
            {
                'text_id': 'buttons.exchange',
                'ru': '⭐ Обменять NDN на Stars',
                'en': '⭐ Exchange NDN for Stars',
                'es': '⭐ Intercambiar NDN por Stars'
            },
            {
                'text_id': 'buttons.transfer_ndn',
                'ru': '💸 Перевести NDN',
                'en': '💸 Transfer NDN',
                'es': '💸 Transferir NDN'
            },
            {
                'text_id': 'buttons.referrals',
                'ru': '👥 Мои рефералы',
                'en': '👥 My Referrals',
                'es': '👥 Mis Referidos'
            },
            {
                'text_id': 'buttons.leaderboard',
                'ru': '🏆 Таблица лидеров',
                'en': '🏆 Leaderboard',
                'es': '🏆 Tabla de Lideres'
            },
            {
                'text_id': 'buttons.rules',
                'ru': '📋 Правила игры',
                'en': '📋 Game Rules',
                'es': '📋 Reglas del Juego'
            },
            {
                'text_id': 'pro.title',
                'ru': 'Pro Статус',
                'en': 'Pro Status',
                'es': 'Estado Pro'
            },
            {
                'text_id': 'pro.cost',
                'ru': 'Стоимость: 1000 NDN',
                'en': 'Cost: 1000 NDN',
                'es': 'Costo: 1000 NDN'
            },
            {
                'text_id': 'miner.title',
                'ru': 'NDN Майнер',
                'en': 'NDN Miner',
                'es': 'NDN Miner'
            },
            {
                'text_id': 'miner.energy',
                'ru': 'Энергия',
                'en': 'Energy',
                'es': 'Energia'
            },
            {
                'text_id': 'miner.gas',
                'ru': 'Газ',
                'en': 'Gas',
                'es': 'Gas'
            },
            {
                'text_id': 'game.title',
                'ru': 'Игра',
                'en': 'Game',
                'es': 'Juego'
            },
            {
                'text_id': 'game.achievements',
                'ru': 'Достижения',
                'en': 'Achievements',
                'es': 'Logros'
            },
            {
                'text_id': 'game.daily_reward',
                'ru': 'Ежедневная награда',
                'en': 'Daily Reward',
                'es': 'Recompensa Diaria'
            },
            {
                'text_id': 'referrals.title',
                'ru': 'Мои рефералы',
                'en': 'My Referrals',
                'es': 'Mis Referidos'
            },
            {
                'text_id': 'referrals.total',
                'ru': 'Всего рефералов',
                'en': 'Total Referrals',
                'es': 'Total Referidos'
            },
            {
                'text_id': 'leaderboard.title',
                'ru': '🏆 Таблица лидеров',
                'en': '🏆 Leaderboard',
                'es': '🏆 Tabla de Lideres'
            },
            {
                'text_id': 'leaderboard.subtitle',
                'ru': 'Топ игроков по балансу NDN',
                'en': 'Top players by NDN balance',
                'es': 'Mejores jugadores por saldo NDN'
            },
            {
                'text_id': 'rules.title',
                'ru': '📋 Правила игры',
                'en': '📋 Game Rules',
                'es': '📋 Reglas del Juego'
            },
            {
                'text_id': 'admin.title',
                'ru': 'Админ панель',
                'en': 'Admin Panel',
                'es': 'Panel de Admin'
            },
            {
                'text_id': 'admin.users',
                'ru': 'Всего пользователей',
                'en': 'Total Users',
                'es': 'Total Usuarios'
            },
            {
                'text_id': 'admin.pro_users',
                'ru': 'Pro пользователей',
                'en': 'Pro Users',
                'es': 'Usuarios Pro'
            },
            {
                'text_id': 'admin.wallet',
                'ru': 'Серверный кошелек',
                'en': 'Server Wallet',
                'es': 'Billetera del Servidor'
            }
        ]
        
        # Вставляем данные
        result = supabase.table('nodeon_localization').upsert(translations).execute()
        print(f"Вставлено {len(translations)} базовых переводов")
        
        return True
        
    except Exception as e:
        print(f"Ошибка вставки данных: {e}")
        return False

def main():
    """Основная функция"""
    print("Создание таблицы локализации...")
    
    if create_localization_table():
        print("\nВставка базовых переводов...")
        insert_basic_translations()
        print("\nГотово! Таблица локализации создана и заполнена.")
    else:
        print("\nНе удалось создать таблицу локализации")

if __name__ == "__main__":
    main()













