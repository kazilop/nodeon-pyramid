-- Добавление колонки miner_data в таблицу nodeon_users
ALTER TABLE nodeon_users 
ADD COLUMN miner_data JSONB DEFAULT '{
    "ndn_gas": 100,
    "energy": 100,
    "max_energy": 100,
    "gas_per_minute": 0,
    "farms": [],
    "upgrades": {
        "speed": 0,
        "efficiency": 0,
        "automation": 0
    },
    "total_gas_earned": 100,
    "last_energy_refill": 0,
    "last_update": 0
}'::jsonb;

-- Обновление существующих пользователей с данными майнера
UPDATE nodeon_users 
SET miner_data = '{
    "ndn_gas": 100,
    "energy": 100,
    "max_energy": 100,
    "gas_per_minute": 0,
    "farms": [],
    "upgrades": {
        "speed": 0,
        "efficiency": 0,
        "automation": 0
    },
    "total_gas_earned": 100,
    "last_energy_refill": 0,
    "last_update": 0
}'::jsonb
WHERE miner_data IS NULL;
