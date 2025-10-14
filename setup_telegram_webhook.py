#!/usr/bin/env python3
"""
Скрипт для настройки webhook в Telegram Bot для обработки платежей
"""

import requests
import os

# Настройки
TELEGRAM_BOT_TOKEN = os.getenv("TELEGRAM_BOT_TOKEN", "7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ")
WEBHOOK_URL = "https://nodeon-crypto-production.up.railway.app/api/payments/webhook"

def set_webhook():
    """Устанавливает webhook для Telegram Bot"""
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/setWebhook"
    
    data = {
        "url": WEBHOOK_URL,
        "allowed_updates": ["pre_checkout_query", "message"]
    }
    
    response = requests.post(url, json=data)
    result = response.json()
    
    if result.get('ok'):
        print("✅ Webhook установлен успешно!")
        print(f"URL: {WEBHOOK_URL}")
    else:
        print("❌ Ошибка установки webhook:")
        print(result)
    
    return result

def get_webhook_info():
    """Получает информацию о текущем webhook"""
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/getWebhookInfo"
    
    response = requests.get(url)
    result = response.json()
    
    if result.get('ok'):
        webhook_info = result['result']
        print("📋 Информация о webhook:")
        print(f"URL: {webhook_info.get('url', 'Не установлен')}")
        print(f"Pending updates: {webhook_info.get('pending_update_count', 0)}")
        print(f"Last error: {webhook_info.get('last_error_message', 'Нет ошибок')}")
    else:
        print("❌ Ошибка получения информации о webhook:")
        print(result)
    
    return result

if __name__ == "__main__":
    print("🔧 Настройка Telegram Bot Webhook для платежей")
    print("=" * 50)
    
    # Получаем текущую информацию
    print("\n1. Текущая информация о webhook:")
    get_webhook_info()
    
    # Устанавливаем webhook
    print("\n2. Установка webhook:")
    set_webhook()
    
    # Проверяем результат
    print("\n3. Проверка webhook:")
    get_webhook_info()
    
    print("\n✅ Настройка завершена!")
    print("\n📝 Следующие шаги:")
    print("1. Убедитесь, что ваш бот активирован для Stars через @BotSupport")
    print("2. Протестируйте платежи в Telegram Mini App")
    print("3. Проверьте логи на Railway для отладки")

