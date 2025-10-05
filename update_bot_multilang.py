#!/usr/bin/env python3
"""
Обновление Telegram бота с многоязычными командами
"""

import requests
import json

# Настройки
TELEGRAM_BOT_TOKEN = "7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ"

def update_bot_commands_multilang():
    """Обновление команд бота с многоязычными описаниями"""
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/setMyCommands"
    
    # Команды на русском языке
    commands_ru = [
        {
            "command": "start",
            "description": "🚀 Запустить NodeOn Crypto"
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
    
    # Команды на английском языке
    commands_en = [
        {
            "command": "start",
            "description": "🚀 Launch NodeOn Crypto"
        },
        {
            "command": "help",
            "description": "❓ Help and instructions"
        },
        {
            "command": "balance",
            "description": "💰 Check NDN and Stars balance"
        },
        {
            "command": "referrals",
            "description": "👥 My referrals and statistics"
        },
        {
            "command": "leaderboard",
            "description": "🏆 Leaderboard"
        },
        {
            "command": "buy_pro",
            "description": "⭐ Buy Pro status for 1000 NDN"
        },
        {
            "command": "buy_ndn",
            "description": "💎 Buy NDN with Telegram Stars"
        },
        {
            "command": "withdraw",
            "description": "💸 Withdraw NDN to Telegram Stars"
        },
        {
            "command": "terms",
            "description": "📋 Terms of use"
        },
        {
            "command": "support",
            "description": "🆘 User support"
        },
        {
            "command": "paysupport",
            "description": "💳 Payment support"
        }
    ]
    
    # Команды на испанском языке
    commands_es = [
        {
            "command": "start",
            "description": "🚀 Lanzar NodeOn Crypto"
        },
        {
            "command": "help",
            "description": "❓ Ayuda e instrucciones"
        },
        {
            "command": "balance",
            "description": "💰 Verificar saldo NDN y Stars"
        },
        {
            "command": "referrals",
            "description": "👥 Mis referidos y estadísticas"
        },
        {
            "command": "leaderboard",
            "description": "🏆 Tabla de líderes"
        },
        {
            "command": "buy_pro",
            "description": "⭐ Comprar estado Pro por 1000 NDN"
        },
        {
            "command": "buy_ndn",
            "description": "💎 Comprar NDN con Telegram Stars"
        },
        {
            "command": "withdraw",
            "description": "💸 Retirar NDN a Telegram Stars"
        },
        {
            "command": "terms",
            "description": "📋 Términos de uso"
        },
        {
            "command": "support",
            "description": "🆘 Soporte de usuarios"
        },
        {
            "command": "paysupport",
            "description": "💳 Soporte de pagos"
        }
    ]
    
    # Команды на немецком языке
    commands_de = [
        {
            "command": "start",
            "description": "🚀 NodeOn Crypto starten"
        },
        {
            "command": "help",
            "description": "❓ Hilfe und Anweisungen"
        },
        {
            "command": "balance",
            "description": "💰 NDN und Stars Guthaben prüfen"
        },
        {
            "command": "referrals",
            "description": "👥 Meine Empfehlungen und Statistiken"
        },
        {
            "command": "leaderboard",
            "description": "🏆 Bestenliste"
        },
        {
            "command": "buy_pro",
            "description": "⭐ Pro Status für 1000 NDN kaufen"
        },
        {
            "command": "buy_ndn",
            "description": "💎 NDN mit Telegram Stars kaufen"
        },
        {
            "command": "withdraw",
            "description": "💸 NDN zu Telegram Stars abheben"
        },
        {
            "command": "terms",
            "description": "📋 Nutzungsbedingungen"
        },
        {
            "command": "support",
            "description": "🆘 Benutzer-Support"
        },
        {
            "command": "paysupport",
            "description": "💳 Zahlungs-Support"
        }
    ]
    
    # Устанавливаем команды для каждого языка
    languages = [
        ("ru", commands_ru),
        ("en", commands_en),
        ("es", commands_es),
        ("de", commands_de)
    ]
    
    for lang_code, commands in languages:
        data = {"commands": commands}
        
        try:
            response = requests.post(url, json=data)
            if response.status_code == 200:
                result = response.json()
                if result.get('ok'):
                    print(f"✅ Команды для языка {lang_code} настроены!")
                else:
                    print(f"❌ Ошибка настройки команд для {lang_code}: {result}")
            else:
                print(f"❌ HTTP ошибка для {lang_code}: {response.status_code}")
        except Exception as e:
            print(f"❌ Ошибка для {lang_code}: {e}")

def update_bot_descriptions():
    """Обновление описаний бота на разных языках"""
    
    # Описания на разных языках
    descriptions = {
        "ru": {
            "description": """🎉 NodeOn Crypto - Крипто игра с монетами NDN

💰 Зарабатывайте NDN монеты
⭐ Покупайте Pro статус за 1000 NDN
👥 Приглашайте друзей и получайте награды
🏆 Становитесь лидером

🚀 Нажмите /start чтобы начать!""",
            "short_description": "🎉 Крипто игра с монетами NDN. Зарабатывайте, приглашайте друзей, становитесь лидером!"
        },
        "en": {
            "description": """🎉 NodeOn Crypto - Crypto game with NDN coins

💰 Earn NDN coins
⭐ Buy Pro status for 1000 NDN
👥 Invite friends and get rewards
🏆 Become a leader

🚀 Press /start to begin!""",
            "short_description": "🎉 Crypto game with NDN coins. Earn, invite friends, become a leader!"
        },
        "es": {
            "description": """🎉 NodeOn Crypto - Juego cripto con monedas NDN

💰 Gana monedas NDN
⭐ Compra estado Pro por 1000 NDN
👥 Invita amigos y obtén recompensas
🏆 Conviértete en líder

🚀 ¡Presiona /start para comenzar!""",
            "short_description": "🎉 Juego cripto con monedas NDN. ¡Gana, invita amigos, conviértete en líder!"
        },
        "de": {
            "description": """🎉 NodeOn Crypto - Krypto-Spiel mit NDN-Münzen

💰 Verdiene NDN-Münzen
⭐ Kaufe Pro-Status für 1000 NDN
👥 Lade Freunde ein und erhalte Belohnungen
🏆 Werde ein Leader

🚀 Drücke /start um zu beginnen!""",
            "short_description": "🎉 Krypto-Spiel mit NDN-Münzen. Verdiene, lade Freunde ein, werde ein Leader!"
        }
    }
    
    # Устанавливаем описания для каждого языка
    for lang_code, desc_data in descriptions.items():
        # Полное описание
        url_desc = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/setMyDescription"
        data_desc = {"description": desc_data["description"]}
        
        try:
            response = requests.post(url_desc, json=data_desc)
            if response.status_code == 200:
                result = response.json()
                if result.get('ok'):
                    print(f"✅ Описание для {lang_code} обновлено!")
                else:
                    print(f"❌ Ошибка обновления описания для {lang_code}: {result}")
        except Exception as e:
            print(f"❌ Ошибка описания для {lang_code}: {e}")
        
        # Краткое описание
        url_short = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/setMyShortDescription"
        data_short = {"short_description": desc_data["short_description"]}
        
        try:
            response = requests.post(url_short, json=data_short)
            if response.status_code == 200:
                result = response.json()
                if result.get('ok'):
                    print(f"✅ Краткое описание для {lang_code} обновлено!")
                else:
                    print(f"❌ Ошибка обновления краткого описания для {lang_code}: {result}")
        except Exception as e:
            print(f"❌ Ошибка краткого описания для {lang_code}: {e}")

def main():
    """Основная функция"""
    print("🌍 Обновление Telegram бота @pro_stars_bot с многоязычностью")
    print("=" * 60)
    
    # Обновляем команды
    print("\n1. Обновление команд на всех языках:")
    update_bot_commands_multilang()
    
    # Обновляем описания
    print("\n2. Обновление описаний на всех языках:")
    update_bot_descriptions()
    
    print("\n" + "=" * 60)
    print("🎉 Бот обновлен с поддержкой 4 языков!")
    print("🌍 Поддерживаемые языки:")
    print("   🇷🇺 Русский (ru)")
    print("   🇺🇸 Английский (en)")
    print("   🇪🇸 Испанский (es)")
    print("   🇩🇪 Немецкий (de)")
    print("\n🔗 Ссылка для запуска Mini App:")
    print("   https://t.me/pro_stars_bot?startapp=nodeon_crypto")
    print("\n📱 Пользователи могут:")
    print("   1. Нажать /start")
    print("   2. Нажать кнопку '🚀 Запустить NodeOn Crypto'")
    print("   3. Или перейти по прямой ссылке")
    print("   4. Язык определяется автоматически по настройкам Telegram")

if __name__ == "__main__":
    main()
