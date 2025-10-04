#!/usr/bin/env python3
"""
Финальная настройка webhook для NodeOn Pyramid
"""

import requests
import json

def set_webhook():
    """Установка webhook для Telegram бота"""
    
    bot_token = "7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ"
    webhook_url = "https://nodeon-er6grb7ea-artems-projects-f7d0f2aa.vercel.app/webhook"
    
    url = f"https://api.telegram.org/bot{bot_token}/setWebhook"
    
    data = {
        "url": webhook_url,
        "allowed_updates": ["message", "callback_query"]
    }
    
    try:
        response = requests.post(url, json=data)
        result = response.json()
        
        if result.get("ok"):
            print(f"✅ Webhook успешно установлен!")
            print(f"   URL: {webhook_url}")
            return True
        else:
            print(f"❌ Ошибка установки webhook: {result.get('description')}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка при установке webhook: {e}")
        return False

def get_webhook_info():
    """Получение информации о webhook"""
    
    bot_token = "7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ"
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

def main():
    """Основная функция"""
    
    print("🚀 Финальная настройка webhook для NodeOn Pyramid...")
    print()
    
    # Показываем текущее состояние
    print("📊 Текущее состояние webhook:")
    get_webhook_info()
    print()
    
    # Устанавливаем webhook
    if set_webhook():
        print()
        print("📊 Новое состояние webhook:")
        get_webhook_info()
        print()
        print("🎉 Webhook настроен успешно!")
        print("   Теперь можно тестировать бота: @pro_stars_bot")
    else:
        print()
        print("❌ Ошибка настройки webhook")

if __name__ == "__main__":
    main()
