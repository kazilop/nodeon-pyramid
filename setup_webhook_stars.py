#!/usr/bin/env python3
"""
Настройка webhook для Telegram бота с поддержкой Stars
"""

import requests
import json

# Конфигурация
TELEGRAM_BOT_TOKEN = "7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ"
WEBHOOK_URL = "https://nodeon-production.up.railway.app/webhook"

def setup_webhook():
    """Настройка webhook для Telegram бота"""
    print("🔧 Настройка webhook для Telegram бота...")
    
    try:
        # Устанавливаем webhook
        response = requests.post(
            f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/setWebhook",
            json={
                "url": WEBHOOK_URL,
                "allowed_updates": [
                    "message",
                    "callback_query",
                    "pre_checkout_query",
                    "successful_payment"
                ]
            }
        )
        
        if response.status_code == 200:
            data = response.json()
            if data.get('ok'):
                print("✅ Webhook успешно установлен!")
                print(f"   URL: {WEBHOOK_URL}")
                print(f"   Результат: {data.get('description')}")
                return True
            else:
                print(f"❌ Ошибка установки webhook: {data.get('description')}")
                return False
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def check_webhook():
    """Проверка текущего webhook"""
    print("\n🔍 Проверка текущего webhook...")
    
    try:
        response = requests.get(
            f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/getWebhookInfo"
        )
        
        if response.status_code == 200:
            data = response.json()
            if data.get('ok'):
                webhook_info = data.get('result')
                print("📊 Информация о webhook:")
                print(f"   URL: {webhook_info.get('url')}")
                print(f"   Статус: {'Активен' if webhook_info.get('url') else 'Не установлен'}")
                print(f"   Ошибки: {webhook_info.get('last_error_message', 'Нет')}")
                print(f"   Последняя ошибка: {webhook_info.get('last_error_date', 'Нет')}")
                return webhook_info
            else:
                print(f"❌ Ошибка получения информации: {data.get('description')}")
                return None
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
            return None
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return None

def set_bot_commands():
    """Установка команд бота"""
    print("\n⚙️ Установка команд бота...")
    
    commands = [
        {"command": "start", "description": "Запустить бота"},
        {"command": "terms", "description": "Условия использования"},
        {"command": "support", "description": "Поддержка"},
        {"command": "paysupport", "description": "Поддержка по платежам"}
    ]
    
    try:
        response = requests.post(
            f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/setMyCommands",
            json={"commands": commands}
        )
        
        if response.status_code == 200:
            data = response.json()
            if data.get('ok'):
                print("✅ Команды бота установлены!")
                for cmd in commands:
                    print(f"   /{cmd['command']} - {cmd['description']}")
                return True
            else:
                print(f"❌ Ошибка установки команд: {data.get('description')}")
                return False
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def test_bot():
    """Тестирование бота"""
    print("\n🧪 Тестирование бота...")
    
    try:
        response = requests.get(
            f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/getMe"
        )
        
        if response.status_code == 200:
            data = response.json()
            if data.get('ok'):
                bot_info = data.get('result')
                print("✅ Бот работает!")
                print(f"   Имя: {bot_info.get('first_name')}")
                print(f"   Username: @{bot_info.get('username')}")
                print(f"   ID: {bot_info.get('id')}")
                print(f"   Поддерживает inline: {bot_info.get('supports_inline_queries')}")
                return True
            else:
                print(f"❌ Ошибка получения информации о боте: {data.get('description')}")
                return False
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def main():
    """Основная функция"""
    print("🚀 НАСТРОЙКА TELEGRAM БОТА ДЛЯ STARS")
    print("=" * 50)
    
    # Тестируем бота
    if not test_bot():
        print("❌ Бот не работает. Проверьте токен.")
        return
    
    # Устанавливаем команды
    if not set_bot_commands():
        print("❌ Не удалось установить команды бота.")
        return
    
    # Проверяем текущий webhook
    check_webhook()
    
    # Устанавливаем webhook
    if setup_webhook():
        print("\n🎉 Настройка завершена!")
        print("\n📝 Следующие шаги:")
        print("1. Убедитесь, что ваш сервер доступен по URL webhook")
        print("2. Протестируйте бота, отправив /start")
        print("3. Проверьте обработку платежей")
        print("4. Обратитесь в @BotSupport для активации Stars")
    else:
        print("\n❌ Настройка не завершена. Проверьте ошибки выше.")

if __name__ == "__main__":
    main()
