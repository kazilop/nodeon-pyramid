#!/usr/bin/env python3
"""
Скрипт для настройки Telegram webhook
"""

import requests
import json
import sys
import os
from dotenv import load_dotenv

# Загружаем переменные окружения
load_dotenv()

def set_webhook(webhook_url, bot_token):
    """Установка webhook для Telegram бота"""
    
    url = f"https://api.telegram.org/bot{bot_token}/setWebhook"
    
    data = {
        "url": webhook_url,
        "allowed_updates": ["message", "callback_query"]
    }
    
    try:
        response = requests.post(url, json=data)
        result = response.json()
        
        if result.get("ok"):
            print(f"✅ Webhook успешно установлен: {webhook_url}")
            return True
        else:
            print(f"❌ Ошибка установки webhook: {result.get('description')}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка при установке webhook: {e}")
        return False

def get_webhook_info(bot_token):
    """Получение информации о текущем webhook"""
    
    url = f"https://api.telegram.org/bot{bot_token}/getWebhookInfo"
    
    try:
        response = requests.get(url)
        result = response.json()
        
        if result.get("ok"):
            webhook_info = result.get("result", {})
            print(f"📊 Информация о webhook:")
            print(f"   URL: {webhook_info.get('url', 'Не установлен')}")
            print(f"   Pending updates: {webhook_info.get('pending_update_count', 0)}")
            print(f"   Last error: {webhook_info.get('last_error_message', 'Нет')}")
            return webhook_info
        else:
            print(f"❌ Ошибка получения информации: {result.get('description')}")
            return None
            
    except Exception as e:
        print(f"❌ Ошибка при получении информации: {e}")
        return None

def delete_webhook(bot_token):
    """Удаление webhook"""
    
    url = f"https://api.telegram.org/bot{bot_token}/deleteWebhook"
    
    try:
        response = requests.post(url)
        result = response.json()
        
        if result.get("ok"):
            print("✅ Webhook удален")
            return True
        else:
            print(f"❌ Ошибка удаления webhook: {result.get('description')}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка при удалении webhook: {e}")
        return False

def main():
    """Основная функция"""
    
    # Получаем переменные из .env
    bot_token = os.getenv("TELEGRAM_BOT_TOKEN")
    webhook_url = os.getenv("TELEGRAM_WEBHOOK_URL")
    
    if not bot_token:
        print("❌ TELEGRAM_BOT_TOKEN не найден в .env файле")
        sys.exit(1)
    
    if not webhook_url:
        print("❌ TELEGRAM_WEBHOOK_URL не найден в .env файле")
        print("   Установите URL вашего Vercel приложения")
        sys.exit(1)
    
    print(f"🤖 Настройка webhook для бота: {bot_token[:10]}...")
    print(f"🌐 Webhook URL: {webhook_url}")
    print()
    
    # Показываем текущую информацию
    print("📊 Текущее состояние webhook:")
    get_webhook_info(bot_token)
    print()
    
    # Спрашиваем подтверждение
    confirm = input("❓ Установить новый webhook? (y/N): ").lower()
    
    if confirm in ['y', 'yes', 'да']:
        if set_webhook(webhook_url, bot_token):
            print()
            print("📊 Новое состояние webhook:")
            get_webhook_info(bot_token)
        else:
            sys.exit(1)
    else:
        print("❌ Отменено")
        sys.exit(0)

if __name__ == "__main__":
    main()
