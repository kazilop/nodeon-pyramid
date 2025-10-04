#!/usr/bin/env python3
"""
Скрипт для настройки аккаунта разработчика
- Устанавливает Pro статус
- Зачисляет 10,000 NDN
- Создает реферальную ссылку
"""

import os
import sys
from decimal import Decimal
from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker
from datetime import datetime

# Добавляем путь к модулям
sys.path.append('.')

try:
    from backend.config import settings
    from backend.database import User, Transaction, ReferralStats, Base
except ImportError:
    # Альтернативный способ импорта
    import os
    os.chdir('..')
    from backend.config import settings
    from backend.database import User, Transaction, ReferralStats, Base

def setup_developer_account():
    """Настройка аккаунта разработчика"""
    
    # Создаем подключение к базе данных
    engine = create_engine(settings.database_url)
    SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
    
    # Создаем таблицы если их нет
    Base.metadata.create_all(bind=engine)
    
    db = SessionLocal()
    
    try:
        developer_telegram_id = 207940967
        
        print(f"🔧 Настраиваем аккаунт разработчика (ID: {developer_telegram_id})...")
        
        # Ищем пользователя
        user = db.query(User).filter(User.telegram_id == developer_telegram_id).first()
        
        if not user:
            print("👤 Создаем нового пользователя...")
            # Создаем пользователя
            user = User(
                telegram_id=developer_telegram_id,
                username="developer",
                first_name="Разработчик",
                last_name="NodeOn",
                balance_ndn=Decimal('0'),
                is_pro=False,
                referral_link="",
                inviter_id=None
            )
            db.add(user)
            db.commit()
            db.refresh(user)
            print(f"✅ Пользователь создан с ID: {user.id}")
        else:
            print(f"👤 Пользователь найден с ID: {user.id}")
        
        # Устанавливаем Pro статус
        if not user.is_pro:
            print("👑 Устанавливаем Pro статус...")
            user.is_pro = True
            
            # Генерируем реферальную ссылку
            from api.ndn_api import generate_referral_token
            referral_token = generate_referral_token(user.id)
            user.referral_link = f"https://t.me/{settings.telegram_bot_username}?startapp={referral_token}"
            
            print(f"✅ Pro статус активирован")
            print(f"🔗 Реферальная ссылка: {user.referral_link}")
        else:
            print("👑 Pro статус уже активирован")
        
        # Зачисляем 10,000 NDN
        current_balance = user.balance_ndn
        bonus_amount = Decimal('10000')
        user.balance_ndn += bonus_amount
        
        print(f"💰 Зачисляем {bonus_amount} NDN...")
        print(f"   Было: {current_balance} NDN")
        print(f"   Стало: {user.balance_ndn} NDN")
        
        # Создаем транзакцию
        transaction = Transaction(
            user_id=user.id,
            type="developer_bonus",
            amount_ndn=bonus_amount,
            description="Бонус разработчику - 10,000 NDN"
        )
        db.add(transaction)
        
        # Создаем статистику рефералов если её нет
        existing_stats = db.query(ReferralStats).filter(ReferralStats.user_id == user.id).first()
        if not existing_stats:
            print("📊 Создаем статистику рефералов...")
            for level in range(1, 8):
                stats = ReferralStats(
                    user_id=user.id,
                    level=level,
                    total_referrals=0,
                    total_earnings=Decimal('0')
                )
                db.add(stats)
        
        # Сохраняем изменения
        db.commit()
        
        print("\n🎉 Настройка завершена успешно!")
        print(f"👤 Пользователь: {user.first_name} {user.last_name}")
        print(f"🆔 Telegram ID: {user.telegram_id}")
        print(f"👑 Pro статус: {'✅ Да' if user.is_pro else '❌ Нет'}")
        print(f"💰 Баланс NDN: {user.balance_ndn}")
        print(f"🔗 Реферальная ссылка: {user.referral_link}")
        
        return True
        
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        db.rollback()
        return False
    finally:
        db.close()

def check_account_status():
    """Проверка статуса аккаунта"""
    
    engine = create_engine(settings.database_url)
    SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
    db = SessionLocal()
    
    try:
        developer_telegram_id = 207940967
        user = db.query(User).filter(User.telegram_id == developer_telegram_id).first()
        
        if user:
            print(f"\n📊 Статус аккаунта разработчика:")
            print(f"👤 Имя: {user.first_name} {user.last_name}")
            print(f"🆔 Telegram ID: {user.telegram_id}")
            print(f"👑 Pro статус: {'✅ Да' if user.is_pro else '❌ Нет'}")
            print(f"💰 Баланс NDN: {user.balance_ndn}")
            print(f"🔗 Реферальная ссылка: {user.referral_link}")
            
            # Проверяем транзакции
            transactions = db.query(Transaction).filter(Transaction.user_id == user.id).all()
            print(f"📝 Транзакций: {len(transactions)}")
            
            for tx in transactions[-3:]:  # Показываем последние 3
                print(f"   - {tx.type}: {tx.amount_ndn} NDN ({tx.description})")
        else:
            print("❌ Пользователь не найден")
            
    except Exception as e:
        print(f"❌ Ошибка проверки: {e}")
    finally:
        db.close()

if __name__ == "__main__":
    print("🚀 NodeOn Pyramid - Настройка аккаунта разработчика")
    print("=" * 60)
    
    # Проверяем текущий статус
    print("\n1️⃣ Проверяем текущий статус...")
    check_account_status()
    
    # Настраиваем аккаунт
    print("\n2️⃣ Настраиваем аккаунт...")
    if setup_developer_account():
        print("\n3️⃣ Проверяем результат...")
        check_account_status()
        print("\n✅ Готово! Аккаунт разработчика настроен.")
    else:
        print("\n❌ Настройка не удалась.")
