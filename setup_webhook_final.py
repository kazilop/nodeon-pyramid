#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Скрипт для настройки webhook в Telegram Bot для обработки платежей
"""

import requests
import os
import sys

# Fix Unicode encoding for Windows
if sys.platform == 'win32':
    import io
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

# Настройки
TELEGRAM_BOT_TOKEN = os.getenv("TELEGRAM_BOT_TOKEN", "7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ")
WEBHOOK_URL = "https://sistemypro.ru/webhook/telegram"

def set_webhook():
    """Устанавливает webhook для Telegram Bot"""
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/setWebhook"
    
    data = {
        "url": WEBHOOK_URL,
        "allowed_updates": ["pre_checkout_query", "message"]
    }
    
    print(f"🔗 Устанавливаю webhook: {WEBHOOK_URL}")
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
        print(f"Last error date: {webhook_info.get('last_error_date', 'Нет')}")
        if webhook_info.get('last_error_message'):
            print(f"❌ Последняя ошибка: {webhook_info.get('last_error_message')}")
    else:
        print("❌ Ошибка получения информации о webhook:")
        print(result)
    
    return result

if __name__ == "__main__":
    print("Setup Telegram Bot Webhook for payments")
    print("=" * 50)
    
    # Получаем текущую информацию
    print("\n1. Current webhook info:")
    get_webhook_info()
    
    # Устанавливаем webhook
    print("\n2. Setting webhook:")
    set_webhook()
    
    # Проверяем результат
    print("\n3. Checking webhook:")
    get_webhook_info()
    
    print("\nSetup completed!")
