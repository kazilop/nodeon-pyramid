#!/usr/bin/env python3
"""
Обновление бота с правильной кнопкой запуска Mini App
"""

import requests
import json

# Настройки
TELEGRAM_BOT_TOKEN = "7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ"

def update_bot_commands():
    """Обновление команд бота с правильными описаниями"""
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/setMyCommands"
    
    commands = [
        {
            "command": "start",
            "description": "🚀 Запустить NodeOn Pyramid Mini App"
        },
        {
            "command": "help",
            "description": "❓ Помощь и инструкции"
        },
        {
            "command": "balance",
            "description": "💰 Проверить баланс NDN и Stars"
        },
        {
            "command": "referrals",
            "description": "👥 Мои рефералы и статистика"
        },
        {
            "command": "leaderboard",
            "description": "🏆 Таблица лидеров"
        },
        {
            "command": "buy_pro",
            "description": "⭐ Купить Pro статус за 1000 NDN"
        },
        {
            "command": "buy_ndn",
            "description": "💎 Купить NDN за Telegram Stars"
        },
        {
            "command": "withdraw",
            "description": "💸 Вывести NDN в Telegram Stars"
        },
        {
            "command": "terms",
            "description": "📋 Условия использования"
        },
        {
            "command": "support",
            "description": "🆘 Поддержка пользователей"
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
                print("✅ Команды бота обновлены!")
                for cmd in commands:
                    print(f"   /{cmd['command']} - {cmd['description']}")
            else:
                print(f"❌ Ошибка обновления команд: {result}")
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
    except Exception as e:
        print(f"❌ Ошибка: {e}")

def set_bot_description():
    """Установка описания бота"""
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/setMyDescription"
    
    description = """🎉 NodeOn Pyramid - Реферальная игра с монетами NDN

💰 Зарабатывайте NDN монеты
⭐ Покупайте Pro статус за 1000 NDN
👥 Приглашайте друзей и получайте награды
🏆 Становитесь лидером

🚀 Нажмите /start чтобы начать!"""
    
    data = {"description": description}
    
    try:
        response = requests.post(url, json=data)
        if response.status_code == 200:
            result = response.json()
            if result.get('ok'):
                print("✅ Описание бота обновлено!")
                print(f"   Описание: {description[:50]}...")
            else:
                print(f"❌ Ошибка обновления описания: {result}")
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
    except Exception as e:
        print(f"❌ Ошибка: {e}")

def set_bot_short_description():
    """Установка краткого описания бота"""
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/setMyShortDescription"
    
    short_description = "🎉 Реферальная игра с монетами NDN. Зарабатывайте, приглашайте друзей, становитесь лидером!"
    
    data = {"short_description": short_description}
    
    try:
        response = requests.post(url, json=data)
        if response.status_code == 200:
            result = response.json()
            if result.get('ok'):
                print("✅ Краткое описание бота обновлено!")
                print(f"   Описание: {short_description}")
            else:
                print(f"❌ Ошибка обновления краткого описания: {result}")
        else:
            print(f"❌ HTTP ошибка: {response.status_code}")
    except Exception as e:
        print(f"❌ Ошибка: {e}")

def main():
    """Основная функция"""
    print("🤖 Обновление Telegram бота @pro_stars_bot")
    print("=" * 50)
    
    # Обновляем команды
    print("\n1. Обновление команд:")
    update_bot_commands()
    
    # Устанавливаем описание
    print("\n2. Установка описания:")
    set_bot_description()
    
    # Устанавливаем краткое описание
    print("\n3. Установка краткого описания:")
    set_bot_short_description()
    
    print("\n" + "=" * 50)
    print("🎉 Бот обновлен!")
    print("🔗 Ссылка для запуска Mini App:")
    print("   https://t.me/pro_stars_bot?startapp=nodeon_pyramid")
    print("\n📱 Пользователи могут:")
    print("   1. Нажать /start")
    print("   2. Нажать кнопку '🚀 Запустить NodeOn Pyramid'")
    print("   3. Или перейти по прямой ссылке")

if __name__ == "__main__":
    main()
