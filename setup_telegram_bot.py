#!/usr/bin/env python3
"""
Скрипт для настройки Telegram Bot
"""

import os
import requests
from dotenv import load_dotenv

# Загружаем переменные окружения
load_dotenv()

TELEGRAM_BOT_TOKEN = os.getenv('TELEGRAM_BOT_TOKEN')
RAILWAY_URL = os.getenv('RAILWAY_URL', 'https://your-app.railway.app')

def setup_bot_commands():
    """Настройка команд бота"""
    
    if not TELEGRAM_BOT_TOKEN:
        print("❌ TELEGRAM_BOT_TOKEN не установлен")
        return False
    
    commands = [
        {
            "command": "start",
            "description": "🚀 Запустить игру NodeOn Pyramid"
        },
        {
            "command": "help",
            "description": "❓ Помощь и инструкции"
        },
        {
            "command": "balance",
            "description": "💰 Проверить баланс NDN и Stars"
        },
        {
            "command": "referral",
            "description": "👥 Получить реферальную ссылку"
        },
        {
            "command": "leaderboard",
            "description": "🏆 Топ игроков"
        },
        {
            "command": "miner",
            "description": "⛏️ Открыть NDN Miner"
        },
        {
            "command": "game",
            "description": "🎮 Игровые функции"
        }
    ]
    
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/setMyCommands"
    
    try:
        response = requests.post(url, json={"commands": commands})
        
        if response.status_code == 200:
            print("✅ Команды бота настроены успешно")
            return True
        else:
            print(f"❌ Ошибка настройки команд: {response.status_code} - {response.text}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка настройки команд: {e}")
        return False

def setup_webhook():
    """Настройка webhook для бота"""
    
    if not TELEGRAM_BOT_TOKEN or not RAILWAY_URL:
        print("❌ TELEGRAM_BOT_TOKEN и RAILWAY_URL должны быть установлены")
        return False
    
    webhook_url = f"{RAILWAY_URL}/api/telegram/webhook"
    
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/setWebhook"
    
    data = {
        "url": webhook_url,
        "allowed_updates": ["message", "callback_query"]
    }
    
    try:
        response = requests.post(url, json=data)
        
        if response.status_code == 200:
            result = response.json()
            if result.get("ok"):
                print(f"✅ Webhook настроен: {webhook_url}")
                return True
            else:
                print(f"❌ Ошибка webhook: {result.get('description')}")
                return False
        else:
            print(f"❌ Ошибка настройки webhook: {response.status_code} - {response.text}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка настройки webhook: {e}")
        return False

def get_bot_info():
    """Получение информации о боте"""
    
    if not TELEGRAM_BOT_TOKEN:
        print("❌ TELEGRAM_BOT_TOKEN не установлен")
        return False
    
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/getMe"
    
    try:
        response = requests.get(url)
        
        if response.status_code == 200:
            result = response.json()
            if result.get("ok"):
                bot_info = result.get("result", {})
                print("🤖 Информация о боте:")
                print(f"   Имя: {bot_info.get('first_name')}")
                print(f"   Username: @{bot_info.get('username')}")
                print(f"   ID: {bot_info.get('id')}")
                return True
            else:
                print(f"❌ Ошибка получения информации: {result.get('description')}")
                return False
        else:
            print(f"❌ Ошибка запроса: {response.status_code} - {response.text}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка получения информации о боте: {e}")
        return False

def delete_webhook():
    """Удаление webhook (для отладки)"""
    
    if not TELEGRAM_BOT_TOKEN:
        print("❌ TELEGRAM_BOT_TOKEN не установлен")
        return False
    
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/deleteWebhook"
    
    try:
        response = requests.post(url)
        
        if response.status_code == 200:
            result = response.json()
            if result.get("ok"):
                print("✅ Webhook удален")
                return True
            else:
                print(f"❌ Ошибка удаления webhook: {result.get('description')}")
                return False
        else:
            print(f"❌ Ошибка удаления webhook: {response.status_code} - {response.text}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка удаления webhook: {e}")
        return False

if __name__ == "__main__":
    print("🤖 Настройка Telegram Bot")
    print("=" * 50)
    
    # Получаем информацию о боте
    get_bot_info()
    print()
    
    # Настраиваем команды
    setup_bot_commands()
    print()
    
    # Настраиваем webhook
    setup_webhook()
    print()
    
    print("=" * 50)
    print("✅ Настройка бота завершена!")
    print("📝 Следующие шаги:")
    print("   1. Проверьте работу бота командой /start")
    print("   2. Протестируйте все команды")
    print("   3. Проверьте webhook в логах Railway")