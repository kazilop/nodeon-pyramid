#!/usr/bin/env python3
"""
Скрипт для настройки webhook Telegram бота в продакшн версии
"""

import requests
import os
from dotenv import load_dotenv

# Загружаем переменные окружения
load_dotenv()

def setup_webhook():
    """Настройка webhook для Telegram бота"""
    
    # Получаем данные из переменных окружения
    bot_token = os.getenv('TELEGRAM_BOT_TOKEN')
    webhook_url = os.getenv('TELEGRAM_WEBHOOK_URL')
    
    if not bot_token:
        print("❌ Ошибка: TELEGRAM_BOT_TOKEN не найден в .env файле")
        return False
    
    if not webhook_url:
        print("❌ Ошибка: TELEGRAM_WEBHOOK_URL не найден в .env файле")
        return False
    
    # URL для настройки webhook
    webhook_setup_url = f"https://api.telegram.org/bot{bot_token}/setWebhook"
    
    # Данные для webhook
    webhook_data = {
        'url': webhook_url,
        'allowed_updates': ['message', 'callback_query']
    }
    
    try:
        print(f"🔗 Настраиваем webhook: {webhook_url}")
        
        response = requests.post(webhook_setup_url, data=webhook_data, timeout=30)
        response.raise_for_status()
        
        result = response.json()
        
        if result.get('ok'):
            print("✅ Webhook успешно настроен!")
            print(f"📡 URL: {webhook_url}")
            print(f"📊 Описание: {result.get('description', 'N/A')}")
            return True
        else:
            print(f"❌ Ошибка настройки webhook: {result.get('description', 'Unknown error')}")
            return False
            
    except requests.exceptions.RequestException as e:
        print(f"❌ Ошибка сети: {e}")
        return False
    except Exception as e:
        print(f"❌ Неожиданная ошибка: {e}")
        return False

def check_webhook():
    """Проверка текущего webhook"""
    
    bot_token = os.getenv('TELEGRAM_BOT_TOKEN')
    if not bot_token:
        print("❌ Ошибка: TELEGRAM_BOT_TOKEN не найден")
        return False
    
    try:
        webhook_info_url = f"https://api.telegram.org/bot{bot_token}/getWebhookInfo"
        response = requests.get(webhook_info_url, timeout=30)
        response.raise_for_status()
        
        result = response.json()
        
        if result.get('ok'):
            webhook_info = result.get('result', {})
            print("📊 Информация о webhook:")
            print(f"   URL: {webhook_info.get('url', 'Не настроен')}")
            print(f"   Статус: {'✅ Активен' if webhook_info.get('url') else '❌ Не настроен'}")
            print(f"   Ошибок: {webhook_info.get('pending_update_count', 0)}")
            return True
        else:
            print(f"❌ Ошибка получения информации: {result.get('description', 'Unknown error')}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка проверки webhook: {e}")
        return False

def main():
    """Основная функция"""
    print("🚀 NodeOn Pyramid - Настройка Webhook")
    print("=" * 50)
    
    # Проверяем текущий webhook
    print("\n1️⃣ Проверяем текущий webhook...")
    check_webhook()
    
    # Настраиваем новый webhook
    print("\n2️⃣ Настраиваем webhook...")
    if setup_webhook():
        print("\n3️⃣ Проверяем результат...")
        check_webhook()
        print("\n✅ Настройка завершена успешно!")
        print("\n📱 Теперь бот готов к работе в продакшн режиме!")
    else:
        print("\n❌ Настройка не удалась. Проверьте настройки в .env файле.")

if __name__ == "__main__":
    main()
