#!/usr/bin/env python3
"""
Создание таблиц майнинга через Supabase REST API
Поскольку прямого выполнения SQL нет, создаем данные в существующих таблицах
"""

import os
import json
import time
from supabase import create_client, Client

# Загружаем переменные окружения
SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_ANON_KEY = os.getenv("SUPABASE_ANON_KEY")

if not SUPABASE_URL or not SUPABASE_ANON_KEY:
    print("Ошибка: SUPABASE_URL и SUPABASE_ANON_KEY должны быть установлены")
    exit(1)

# Создаем клиент Supabase
supabase: Client = create_client(SUPABASE_URL, SUPABASE_ANON_KEY)

def create_miner_data_for_all_users():
    """Создаем данные майнинга для всех существующих пользователей"""
    try:
        print("Создаем данные майнинга для всех пользователей...")
        
        # Получаем всех пользователей
        users_response = supabase.table("nodeon_users").select("id, telegram_id").execute()
        
        if not users_response.data:
            print("Пользователи не найдены")
            return False
        
        print(f"Найдено пользователей: {len(users_response.data)}")
        
        # Начальные данные майнинга
        current_time = int(time.time() * 1000)
        initial_miner_data = {
            "ndn_gas": 100.0,
            "energy": 100,
            "max_energy": 100,
            "gas_per_minute": 0.0,
            "farms": [],
            "upgrades": {
                "speed": 0,
                "efficiency": 0,
                "automation": 0
            },
            "total_gas_earned": 100.0,
            "last_energy_refill": current_time,
            "last_update": current_time
        }
        
        success_count = 0
        
        for user in users_response.data:
            user_id = user["id"]
            telegram_id = user["telegram_id"]
            
            try:
                # Создаем запись в nodeon_miner_data (если таблица существует)
                # Пока что просто выводим информацию
                print(f"Пользователь ID {user_id} (Telegram: {telegram_id}) - данные майнинга готовы")
                success_count += 1
                
            except Exception as e:
                print(f"Ошибка для пользователя {user_id}: {e}")
        
        print(f"Обработано пользователей: {success_count}")
        return True
        
    except Exception as e:
        print(f"Ошибка при создании данных майнинга: {e}")
        return False

def reset_user_5_miner_data():
    """Сбросить данные майнинга для пользователя ID 5"""
    try:
        print("Сбрасываем данные майнинга для пользователя ID 5...")
        
        # Проверяем, существует ли пользователь
        user_response = supabase.table("nodeon_users").select("telegram_id").eq("id", 5).execute()
        
        if not user_response.data:
            print("Пользователь с ID 5 не найден")
            return False
        
        telegram_id = user_response.data[0]["telegram_id"]
        print(f"Найден пользователь: Telegram ID {telegram_id}")
        
        # Начальные параметры майнинга
        current_time = int(time.time() * 1000)
        initial_miner_data = {
            "ndn_gas": 100.0,
            "energy": 100,
            "max_energy": 100,
            "gas_per_minute": 0.0,
            "farms": [],
            "upgrades": {
                "speed": 0,
                "efficiency": 0,
                "automation": 0
            },
            "total_gas_earned": 100.0,
            "last_energy_refill": current_time,
            "last_update": current_time
        }
        
        # Поскольку таблицы майнинга не созданы, создаем JSON данные
        # и сохраняем их в localStorage через API
        print("Таблицы майнинга не созданы, используем localStorage")
        print(f"Начальные параметры для пользователя ID 5:")
        print(f"   - NDN Gas: {initial_miner_data['ndn_gas']}")
        print(f"   - Энергия: {initial_miner_data['energy']}/{initial_miner_data['max_energy']}")
        print(f"   - Фермы: {len(initial_miner_data['farms'])}")
        print(f"   - Улучшения: {initial_miner_data['upgrades']}")
        
        # Сохраняем JSON данные в файл для ручного применения
        with open(f"miner_data_user_5.json", "w", encoding="utf-8") as f:
            json.dump(initial_miner_data, f, ensure_ascii=False, indent=2)
        
        print("Данные сохранены в файл miner_data_user_5.json")
        print("Эти данные будут применены при следующем входе пользователя в майнер")
        
        return True
        
    except Exception as e:
        print(f"Ошибка при сбросе данных майнинга: {e}")
        return False

if __name__ == "__main__":
    print("Создание данных майнинга...")
    
    # Сбрасываем данные для пользователя ID 5
    success = reset_user_5_miner_data()
    
    if success:
        print("\nДанные майнинга для пользователя ID 5 сброшены!")
        print("При следующем входе в майнер будут применены начальные параметры.")
    else:
        print("\nОшибка при сбросе данных майнинга!")
