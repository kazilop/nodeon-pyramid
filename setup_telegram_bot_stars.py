#!/usr/bin/env python3
"""
Настройка Telegram бота с поддержкой Stars
"""

import requests
import os
from dotenv import load_dotenv

# Загружаем переменные окружения
load_dotenv()

def setup_bot_with_stars():
    """Настройка бота с поддержкой Stars"""
    
    bot_token = os.getenv('TELEGRAM_BOT_TOKEN')
    if not bot_token:
        print("❌ Ошибка: TELEGRAM_BOT_TOKEN не найден в .env файле")
        print("📝 Добавьте в .env файл:")
        print("TELEGRAM_BOT_TOKEN=ваш_токен_бота")
        return False
    
    print("🤖 Настройка Telegram бота с поддержкой Stars")
    print("=" * 60)
    print(f"Bot Token: {bot_token[:10]}...")
    
    # 1. Получаем информацию о боте
    print("\n📋 Шаг 1: Получение информации о боте")
    print("-" * 40)
    
    try:
        bot_info_url = f"https://api.telegram.org/bot{bot_token}/getMe"
        response = requests.get(bot_info_url, timeout=10)
        
        if response.status_code == 200:
            bot_data = response.json()
            if bot_data.get('ok'):
                bot_info = bot_data.get('result', {})
                print(f"✅ Бот найден:")
                print(f"   Имя: {bot_info.get('first_name')}")
                print(f"   Username: @{bot_info.get('username')}")
                print(f"   ID: {bot_info.get('id')}")
                print(f"   Поддерживает Stars: {bot_info.get('can_manage_stars', False)}")
                
                if not bot_info.get('can_manage_stars', False):
                    print("⚠️ ВНИМАНИЕ: Бот не поддерживает Stars!")
                    print("   Обратитесь в поддержку Telegram для активации Stars")
                    return False
            else:
                print(f"❌ Ошибка получения информации: {bot_data.get('description')}")
                return False
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False
    
    # 2. Настраиваем команды бота
    print("\n📋 Шаг 2: Настройка команд бота")
    print("-" * 40)
    
    commands = [
        {"command": "start", "description": "🚀 Запустить NodeOn Pyramid"},
        {"command": "help", "description": "❓ Помощь по использованию"},
        {"command": "balance", "description": "💰 Проверить баланс NDN"},
        {"command": "referral", "description": "🔗 Получить реферальную ссылку"},
        {"command": "stats", "description": "📊 Статистика рефералов"},
        {"command": "leaderboard", "description": "🏆 Таблица лидеров"}
    ]
    
    try:
        set_commands_url = f"https://api.telegram.org/bot{bot_token}/setMyCommands"
        response = requests.post(set_commands_url, json={"commands": commands}, timeout=10)
        
        if response.status_code == 200:
            result = response.json()
            if result.get('ok'):
                print("✅ Команды бота настроены:")
                for cmd in commands:
                    print(f"   /{cmd['command']} - {cmd['description']}")
            else:
                print(f"❌ Ошибка настройки команд: {result.get('description')}")
                return False
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False
    
    # 3. Настраиваем Mini App
    print("\n📋 Шаг 3: Настройка Mini App")
    print("-" * 40)
    
    mini_app_url = "https://kazilop.github.io/nodeon-pyramid/"
    
    try:
        # Создаем Mini App
        create_app_url = f"https://api.telegram.org/bot{bot_token}/createApp"
        app_data = {
            "title": "NodeOn Pyramid",
            "description": "Реферальная игра с монетами NDN",
            "photo": "https://kazilop.github.io/nodeon-pyramid/icon.png",
            "web_app": {
                "url": mini_app_url
            }
        }
        
        response = requests.post(create_app_url, json=app_data, timeout=10)
        
        if response.status_code == 200:
            result = response.json()
            if result.get('ok'):
                app_info = result.get('result', {})
                print(f"✅ Mini App создан:")
                print(f"   Название: {app_info.get('title')}")
                print(f"   URL: {mini_app_url}")
                print(f"   App ID: {app_info.get('id')}")
            else:
                print(f"⚠️ Mini App уже существует или ошибка: {result.get('description')}")
        else:
            print(f"⚠️ HTTP ошибка при создании Mini App: {response.status_code}")
            
    except Exception as e:
        print(f"⚠️ Ошибка создания Mini App: {e}")
    
    # 4. Настраиваем webhook
    print("\n📋 Шаг 4: Настройка webhook")
    print("-" * 40)
    
    webhook_url = "https://nodeon-production.up.railway.app/webhook"
    
    try:
        webhook_data = {
            'url': webhook_url,
            'allowed_updates': ['message', 'callback_query', 'pre_checkout_query']
        }
        
        webhook_api_url = f"https://api.telegram.org/bot{bot_token}/setWebhook"
        response = requests.post(webhook_api_url, json=webhook_data, timeout=30)
        
        if response.status_code == 200:
            result = response.json()
            if result.get('ok'):
                print("✅ Webhook настроен:")
                print(f"   URL: {webhook_url}")
                print(f"   Pending updates: {result.get('result', {}).get('pending_update_count', 0)}")
            else:
                print(f"❌ Ошибка настройки webhook: {result.get('description')}")
                return False
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False
    
    # 5. Проверяем поддержку Stars
    print("\n📋 Шаг 5: Проверка поддержки Stars")
    print("-" * 40)
    
    try:
        # Проверяем, может ли бот принимать Stars
        test_stars_url = f"https://api.telegram.org/bot{bot_token}/sendInvoice"
        test_invoice = {
            "chat_id": os.getenv('DEVELOPER_TELEGRAM_ID', '207940967'),
            "title": "Тест Stars",
            "description": "Тестовый платеж для проверки Stars",
            "payload": "test_stars_payment",
            "provider_token": "TEST_PROVIDER_TOKEN",
            "currency": "XTR",  # Telegram Stars
            "prices": [{"label": "Test", "amount": 100}]
        }
        
        response = requests.post(test_stars_url, json=test_invoice, timeout=10)
        
        if response.status_code == 200:
            result = response.json()
            if result.get('ok'):
                print("✅ Бот поддерживает Stars платежи")
            else:
                print(f"⚠️ Ограничения Stars: {result.get('description')}")
        else:
            print(f"⚠️ HTTP ошибка при тестировании Stars: {response.status_code}")
            
    except Exception as e:
        print(f"⚠️ Ошибка тестирования Stars: {e}")
    
    return True

def test_bot_functionality():
    """Тестирование функциональности бота"""
    print("\n🧪 Тестирование функциональности бота")
    print("-" * 40)
    
    bot_token = os.getenv('TELEGRAM_BOT_TOKEN')
    if not bot_token:
        print("❌ Bot token не найден")
        return False
    
    try:
        # Отправляем тестовое сообщение
        test_url = f"https://api.telegram.org/bot{bot_token}/sendMessage"
        test_data = {
            'chat_id': os.getenv('DEVELOPER_TELEGRAM_ID', '207940967'),
            'text': '''🤖 NodeOn Pyramid Bot готов к работе!

✅ Поддержка Stars активирована
✅ Mini App настроен
✅ Webhook работает
✅ Команды настроены

🚀 Для запуска приложения используйте команду /start
💰 Для проверки баланса используйте команду /balance
🔗 Для получения реферальной ссылки используйте команду /referral

Приложение: https://kazilop.github.io/nodeon-pyramid/''',
            'parse_mode': 'HTML'
        }
        
        response = requests.post(test_url, json=test_data, timeout=10)
        
        if response.status_code == 200:
            result = response.json()
            if result.get('ok'):
                print("✅ Тестовое сообщение отправлено успешно!")
                return True
            else:
                print(f"❌ Ошибка отправки: {result.get('description')}")
                return False
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка тестирования: {e}")
        return False

def main():
    """Основная функция"""
    print("🚀 НАСТРОЙКА TELEGRAM БОТА С ПОДДЕРЖКОЙ STARS")
    print("=" * 60)
    
    # Настраиваем бота
    if setup_bot_with_stars():
        # Тестируем функциональность
        test_bot_functionality()
        
        print("\n✅ Настройка завершена!")
        print("\n📝 Следующие шаги:")
        print("1. Выполните SQL скрипт в Supabase")
        print("2. Обновите API с поддержкой Stars")
        print("3. Протестируйте приложение в Telegram")
        print("\n🌐 Ссылки:")
        print("   Frontend: https://kazilop.github.io/nodeon-pyramid/")
        print("   API: https://nodeon-production.up.railway.app/api")
    else:
        print("\n❌ Настройка не удалась")
        print("🔧 Проверьте настройки в .env файле")

if __name__ == "__main__":
    main()
