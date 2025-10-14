#!/usr/bin/env python3
"""
Скрипт для сброса данных майнинга пользователя ID 5
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

def reset_user_miner_data(user_id: int):
    """Сбросить данные майнинга для пользователя"""
    try:
        print(f"Сбрасываем данные майнинга для пользователя ID {user_id}...")
        
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
        
        # Проверяем, существует ли пользователь
        user_response = supabase.table("nodeon_users").select("telegram_id").eq("id", user_id).execute()
        
        if not user_response.data:
            print(f"Пользователь с ID {user_id} не найден")
            return False
        
        telegram_id = user_response.data[0]["telegram_id"]
        print(f"Найден пользователь: Telegram ID {telegram_id}")
        
        # Обновляем данные майнинга в таблице nodeon_miner_data
        miner_response = supabase.table("nodeon_miner_data").upsert({
            "user_id": user_id,
            "miner_data": json.dumps(initial_miner_data),
            "last_update": current_time
        }).execute()
        
        if miner_response.data:
            print(f"Данные майнинга обновлены в nodeon_miner_data")
        else:
            print(f"Не удалось обновить nodeon_miner_data, возможно таблица не существует")
        
        # Обновляем статистику майнинга в таблице nodeon_miner_stats
        stats_response = supabase.table("nodeon_miner_stats").upsert({
            "user_id": user_id,
            "level": 1,
            "total_gas_earned": 100.0,
            "total_farms": 0,
            "total_upgrades": 0,
            "last_update": current_time
        }).execute()
        
        if stats_response.data:
            print(f"Статистика майнинга обновлена в nodeon_miner_stats")
        else:
            print(f"Не удалось обновить nodeon_miner_stats, возможно таблица не существует")
        
        print(f"Данные майнинга для пользователя ID {user_id} успешно сброшены!")
        print(f"Начальные параметры:")
        print(f"   - NDN Gas: {initial_miner_data['ndn_gas']}")
        print(f"   - Энергия: {initial_miner_data['energy']}/{initial_miner_data['max_energy']}")
        print(f"   - Фермы: {len(initial_miner_data['farms'])}")
        print(f"   - Улучшения: {initial_miner_data['upgrades']}")
        
        return True
        
    except Exception as e:
        print(f"Ошибка при сбросе данных майнинга: {e}")
        return False

if __name__ == "__main__":
    print("Запуск сброса данных майнинга для пользователя ID 5...")
    
    success = reset_user_miner_data(5)
    
    if success:
        print("\nСброс данных майнинга завершен успешно!")
    else:
        print("\nОшибка при сбросе данных майнинга!")
