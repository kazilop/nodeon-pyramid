#!/usr/bin/env python3
"""
Скрипт для пополнения баланса Stars бота
"""

import requests
import os

# Настройки
TELEGRAM_BOT_TOKEN = os.getenv("TELEGRAM_BOT_TOKEN", "7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ")

def get_bot_stars_balance():
    """Получает текущий баланс Stars бота"""
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/getMyStarsBalance"
    
    try:
        response = requests.post(url)
        result = response.json()
        
        if result.get('ok'):
            star_count = result.get('result', {}).get('star_count', 0)
            print(f"💰 Текущий баланс Stars бота: {star_count}")
            return star_count
        else:
            print(f"❌ Ошибка получения баланса: {result}")
            return 0
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return 0

def check_bot_info():
    """Проверяет информацию о боте"""
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/getMe"
    
    try:
        response = requests.get(url)
        result = response.json()
        
        if result.get('ok'):
            bot_info = result['result']
            print(f"🤖 Бот: @{bot_info.get('username')} ({bot_info.get('first_name')})")
            print(f"🆔 ID: {bot_info.get('id')}")
            return True
        else:
            print(f"❌ Ошибка получения информации о боте: {result}")
            return False
            
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

def send_stars_to_bot(amount):
    """Отправляет Stars боту (только для тестирования)"""
    print(f"\n⚠️ ВНИМАНИЕ: Боты не могут получать Stars от пользователей!")
    print("Для пополнения баланса Stars бота нужно:")
    print("1. Купить Stars в Telegram")
    print("2. Отправить Stars боту через @BotFather")
    print("3. Или использовать другие методы пополнения")
    
    return False

if __name__ == "__main__":
    print("🤖 Проверка баланса Stars бота NodeOn")
    print("=" * 50)
    
    # Проверяем информацию о боте
    if check_bot_info():
        # Получаем баланс Stars
        balance = get_bot_stars_balance()
        
        if balance == 0:
            print("\n⚠️ У бота нет Stars!")
            print("\n📋 Для пополнения баланса:")
            print("1. Откройте Telegram")
            print("2. Найдите бота @NodeOnCryptoBot")
            print("3. Отправьте ему Stars через @BotFather")
            print("4. Или купите Stars и отправьте боту")
            
            print(f"\n🔗 Ссылка на бота: https://t.me/NodeOnCryptoBot")
        else:
            print(f"\n✅ У бота есть {balance} Stars для обмена")
            print("🔄 Обмен NDN на Stars доступен!")
    else:
        print("\n❌ Не удается получить информацию о боте")


