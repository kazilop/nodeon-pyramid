#!/usr/bin/env python3
"""
Настройка Telegram бота для NodeOn Pyramid
"""

import requests
import json
import os

# Настройки
TELEGRAM_BOT_TOKEN = "7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ"
RAILWAY_WEBHOOK_URL = "https://nodeon-production.up.railway.app/webhook"

def setup_bot_commands():
    """Настройка команд бота"""
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/setMyCommands"
    
    commands = [
        {
            "command": "start",
            "description": "🚀 Запустить NodeOn Pyramid"
        },
        {
            "command": "help",
            "description": "❓ Помощь и инструкции"
        },
        {
            "command": "balance",
            "description": "💰 Проверить баланс NDN"
        },
        {
            "command": "referrals",
            "description": "👥 Мои рефералы"
        },
        {
            "command": "leaderboard",
            "description": "🏆 Таблица лидеров"
        },
        {
            "command": "buy_pro",
            "description": "⭐ Купить Pro статус"
        },
        {
            "command": "buy_ndn",
            "description": "💎 Купить NDN за Stars"
        },
        {
            "command": "withdraw",
            "description": "💸 Вывести NDN в Stars"
        },
        {
            "command": "terms",
            "description": "📋 Условия использования"
        },
        {
            "command": "support",
            "description": "🆘 Поддержка"
        },
        {
            "command": "paysupport",
            "description": "💳 Поддержка платежей"
        }
    ]
    
    data = {"commands": commands}
    
    try:
        response = requests.post(url, json=data)
        if response.status_code == 200:
            result = response.json()
            if result.get('ok'):
                print("✅ Команды бота настроены успешно!")
                for cmd in commands:
                    print(f"   /{cmd['command']} - {cmd['description']}")
            else:
                print(f"❌ Ошибка настройки команд: {result}")
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
    except Exception as e:
        print(f"❌ Ошибка: {e}")

def setup_webhook():
    """Настройка webhook"""
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/setWebhook"
    
    data = {
        "url": RAILWAY_WEBHOOK_URL,
        "allowed_updates": ["message", "callback_query", "pre_checkout_query"]
    }
    
    try:
        response = requests.post(url, json=data)
        if response.status_code == 200:
            result = response.json()
            if result.get('ok'):
                print(f"✅ Webhook настроен успешно!")
                print(f"   URL: {RAILWAY_WEBHOOK_URL}")
                print(f"   Описание: {result.get('description', 'OK')}")
            else:
                print(f"❌ Ошибка настройки webhook: {result}")
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
    except Exception as e:
        print(f"❌ Ошибка: {e}")

def get_webhook_info():
    """Получить информацию о webhook"""
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/getWebhookInfo"
    
    try:
        response = requests.get(url)
        if response.status_code == 200:
            result = response.json()
            if result.get('ok'):
                webhook_info = result.get('result', {})
                print("📡 Информация о webhook:")
                print(f"   URL: {webhook_info.get('url', 'Не установлен')}")
                print(f"   Статус: {'✅ Активен' if webhook_info.get('url') else '❌ Не установлен'}")
                print(f"   Ошибки: {webhook_info.get('last_error_message', 'Нет')}")
                print(f"   Последняя ошибка: {webhook_info.get('last_error_date', 'Нет')}")
                return webhook_info
            else:
                print(f"❌ Ошибка получения информации: {result}")
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
    except Exception as e:
        print(f"❌ Ошибка: {e}")
    
    return None

def get_bot_info():
    """Получить информацию о боте"""
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/getMe"
    
    try:
        response = requests.get(url)
        if response.status_code == 200:
            result = response.json()
            if result.get('ok'):
                bot_info = result.get('result', {})
                print("🤖 Информация о боте:")
                print(f"   Имя: {bot_info.get('first_name')}")
                print(f"   Username: @{bot_info.get('username')}")
                print(f"   ID: {bot_info.get('id')}")
                print(f"   Может присоединяться к группам: {bot_info.get('can_join_groups', False)}")
                print(f"   Может читать сообщения: {bot_info.get('can_read_all_group_messages', False)}")
                print(f"   Поддерживает inline: {bot_info.get('supports_inline_queries', False)}")
                return bot_info
            else:
                print(f"❌ Ошибка получения информации: {result}")
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
    except Exception as e:
        print(f"❌ Ошибка: {e}")
    
    return None

def main():
    """Основная функция"""
    print("🚀 Настройка Telegram бота для NodeOn Pyramid")
    print("=" * 50)
    
    # Получаем информацию о боте
    print("\n1. Информация о боте:")
    bot_info = get_bot_info()
    
    # Настраиваем команды
    print("\n2. Настройка команд:")
    setup_bot_commands()
    
    # Настраиваем webhook
    print("\n3. Настройка webhook:")
    setup_webhook()
    
    # Проверяем webhook
    print("\n4. Проверка webhook:")
    webhook_info = get_webhook_info()
    
    print("\n" + "=" * 50)
    print("🎉 Настройка завершена!")
    
    if webhook_info and webhook_info.get('url'):
        print("✅ Бот готов к работе с webhook")
        print(f"🔗 Mini App URL: https://t.me/{bot_info.get('username')}")
    else:
        print("❌ Webhook не настроен. Проверьте URL и повторите попытку.")

if __name__ == "__main__":
    main()
