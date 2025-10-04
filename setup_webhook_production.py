#!/usr/bin/env python3
"""
Настройка webhook для продакшн Telegram бота
"""

import requests
import os
from dotenv import load_dotenv

# Загружаем переменные окружения
load_dotenv()

def setup_webhook():
    """Настройка webhook для Telegram бота"""
    
    # Получаем переменные из .env файла
    bot_token = os.getenv('TELEGRAM_BOT_TOKEN')
    webhook_url = os.getenv('TELEGRAM_WEBHOOK_URL', 'https://nodeon-production.up.railway.app/webhook')
    
    if not bot_token:
        print("❌ Ошибка: TELEGRAM_BOT_TOKEN не найден в .env файле")
        print("📝 Добавьте в .env файл:")
        print("TELEGRAM_BOT_TOKEN=ваш_токен_бота")
        return False
    
    print("🤖 Настройка webhook для Telegram бота")
    print("=" * 50)
    print(f"Bot Token: {bot_token[:10]}...")
    print(f"Webhook URL: {webhook_url}")
    
    # URL для настройки webhook
    webhook_api_url = f"https://api.telegram.org/bot{bot_token}/setWebhook"
    
    # Параметры webhook
    webhook_data = {
        'url': webhook_url,
        'allowed_updates': ['message', 'callback_query']
    }
    
    try:
        print("\n📡 Отправка запроса на настройку webhook...")
        response = requests.post(webhook_api_url, json=webhook_data, timeout=30)
        
        if response.status_code == 200:
            result = response.json()
            if result.get('ok'):
                print("✅ Webhook успешно настроен!")
                print(f"   URL: {result.get('result', {}).get('url')}")
                print(f"   Pending updates: {result.get('result', {}).get('pending_update_count', 0)}")
                
                # Проверяем информацию о webhook
                check_webhook_info(bot_token)
                return True
            else:
                print(f"❌ Ошибка настройки webhook: {result.get('description')}")
                return False
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
            print(f"   Ответ: {response.text}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def check_webhook_info(bot_token):
    """Проверка информации о webhook"""
    print("\n🔍 Проверка информации о webhook...")
    
    try:
        info_url = f"https://api.telegram.org/bot{bot_token}/getWebhookInfo"
        response = requests.get(info_url, timeout=10)
        
        if response.status_code == 200:
            result = response.json()
            if result.get('ok'):
                webhook_info = result.get('result', {})
                print("✅ Информация о webhook:")
                print(f"   URL: {webhook_info.get('url', 'Не настроен')}")
                print(f"   Pending updates: {webhook_info.get('pending_update_count', 0)}")
                print(f"   Last error date: {webhook_info.get('last_error_date', 'Нет ошибок')}")
                print(f"   Last error message: {webhook_info.get('last_error_message', 'Нет ошибок')}")
            else:
                print(f"❌ Ошибка получения информации: {result.get('description')}")
        else:
            print(f"❌ HTTP ошибка при проверке: {response.status_code}")
            
    except Exception as e:
        print(f"❌ Ошибка проверки: {e}")

def test_webhook():
    """Тест webhook"""
    print("\n🧪 Тестирование webhook...")
    
    bot_token = os.getenv('TELEGRAM_BOT_TOKEN')
    if not bot_token:
        print("❌ Bot token не найден")
        return False
    
    try:
        # Отправляем тестовое сообщение боту
        test_url = f"https://api.telegram.org/bot{bot_token}/sendMessage"
        test_data = {
            'chat_id': os.getenv('DEVELOPER_TELEGRAM_ID', '207940967'),
            'text': '🤖 Webhook настроен успешно!\n\n✅ NodeOn Pyramid готов к работе!'
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
    print("🚀 НАСТРОЙКА ПРОДАКШН WEBHOOK")
    print("=" * 50)
    
    # Настраиваем webhook
    if setup_webhook():
        # Тестируем webhook
        test_webhook()
        
        print("\n✅ Настройка завершена!")
        print("\n📝 Следующие шаги:")
        print("1. Выполните SQL скрипт в Supabase")
        print("2. Протестируйте приложение в Telegram")
        print("3. Запустите: python check_production_system.py")
    else:
        print("\n❌ Настройка не удалась")
        print("🔧 Проверьте настройки в .env файле")

if __name__ == "__main__":
    main()
