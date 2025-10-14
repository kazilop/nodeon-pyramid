-- Создание таблицы для данных майнера
CREATE TABLE IF NOT EXISTS nodeon_miner_data (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES nodeon_users(id) ON DELETE CASCADE,
    telegram_id BIGINT NOT NULL,
    
    -- Основные ресурсы
    ndn_gas DECIMAL(15,2) DEFAULT 100.0,
    energy INTEGER DEFAULT 100,
    max_energy INTEGER DEFAULT 100,
    gas_per_minute DECIMAL(10,2) DEFAULT 0.0,
    
    -- Статистика
    total_gas_earned DECIMAL(15,2) DEFAULT 100.0,
    total_gas_spent DECIMAL(15,2) DEFAULT 0.0,
    total_farms_bought INTEGER DEFAULT 0,
    total_upgrades_bought INTEGER DEFAULT 0,
    
    -- Улучшения
    speed_upgrades INTEGER DEFAULT 0,
    efficiency_upgrades INTEGER DEFAULT 0,
    automation_upgrades INTEGER DEFAULT 0,
    
    -- Время
    last_energy_refill BIGINT DEFAULT 0,
    last_update BIGINT DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Индексы для быстрого поиска
    UNIQUE(user_id),
    UNIQUE(telegram_id)
);

-- Создание таблицы для ферм майнера
CREATE TABLE IF NOT EXISTS nodeon_miner_farms (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES nodeon_users(id) ON DELETE CASCADE,
    farm_type VARCHAR(50) NOT NULL, -- cpu_miner, gpu_farm, asic_rig, data_center
    farm_level INTEGER DEFAULT 1,
    gas_per_minute DECIMAL(10,2) NOT NULL,
    energy_cost INTEGER NOT NULL,
    is_premium BOOLEAN DEFAULT FALSE,
    purchased_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Индексы
    INDEX idx_miner_farms_user_id (user_id),
    INDEX idx_miner_farms_type (farm_type)
);

-- Создание таблицы для улучшений майнера
CREATE TABLE IF NOT EXISTS nodeon_miner_upgrades (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES nodeon_users(id) ON DELETE CASCADE,
    upgrade_type VARCHAR(50) NOT NULL, -- speed, efficiency, automation
    upgrade_level INTEGER NOT NULL,
    effect_value DECIMAL(10,4) NOT NULL, -- значение эффекта
    cost_gas DECIMAL(15,2) NOT NULL,
    purchased_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Индексы
    INDEX idx_miner_upgrades_user_id (user_id),
    INDEX idx_miner_upgrades_type (upgrade_type)
);

-- Создание таблицы для транзакций майнера
CREATE TABLE IF NOT EXISTS nodeon_miner_transactions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES nodeon_users(id) ON DELETE CASCADE,
    transaction_type VARCHAR(50) NOT NULL, -- farm_purchase, upgrade_purchase, gas_earned, energy_refill
    amount_gas DECIMAL(15,2) NOT NULL,
    farm_type VARCHAR(50), -- если покупка фермы
    upgrade_type VARCHAR(50), -- если покупка улучшения
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Индексы
    INDEX idx_miner_transactions_user_id (user_id),
    INDEX idx_miner_transactions_type (transaction_type),
    INDEX idx_miner_transactions_created_at (created_at)
);

-- Создание таблицы для статистики майнера (для лидерборда)
CREATE TABLE IF NOT EXISTS nodeon_miner_stats (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES nodeon_users(id) ON DELETE CASCADE,
    telegram_id BIGINT NOT NULL,
    username VARCHAR(100),
    first_name VARCHAR(100),
    
    -- Статистика
    total_gas_earned DECIMAL(15,2) DEFAULT 0.0,
    total_farms INTEGER DEFAULT 0,
    total_upgrades INTEGER DEFAULT 0,
    current_gas_per_minute DECIMAL(10,2) DEFAULT 0.0,
    miner_level INTEGER DEFAULT 1,
    
    -- Рейтинг
    rank_position INTEGER DEFAULT 0,
    last_activity TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Индексы
    UNIQUE(user_id),
    INDEX idx_miner_stats_rank (rank_position),
    INDEX idx_miner_stats_gas_earned (total_gas_earned DESC),
    INDEX idx_miner_stats_level (miner_level DESC)
);

-- Функция для обновления времени изменения
CREATE OR REPLACE FUNCTION update_miner_data_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Триггеры для автоматического обновления времени
CREATE TRIGGER update_miner_data_updated_at
    BEFORE UPDATE ON nodeon_miner_data
    FOR EACH ROW
    EXECUTE FUNCTION update_miner_data_updated_at();

CREATE TRIGGER update_miner_stats_updated_at
    BEFORE UPDATE ON nodeon_miner_stats
    FOR EACH ROW
    EXECUTE FUNCTION update_miner_data_updated_at();

-- Функция для расчета уровня майнера
CREATE OR REPLACE FUNCTION calculate_miner_level(total_gas_earned DECIMAL)
RETURNS INTEGER AS $$
BEGIN
    RETURN GREATEST(1, FLOOR(total_gas_earned / 1000) + 1);
END;
$$ LANGUAGE plpgsql;

-- Функция для обновления статистики майнера
CREATE OR REPLACE FUNCTION update_miner_stats(p_user_id INTEGER)
RETURNS VOID AS $$
DECLARE
    v_total_gas DECIMAL(15,2);
    v_total_farms INTEGER;
    v_total_upgrades INTEGER;
    v_gas_per_minute DECIMAL(10,2);
    v_miner_level INTEGER;
    v_user_data RECORD;
BEGIN
    -- Получаем данные пользователя
    SELECT telegram_id, username, first_name INTO v_user_data
    FROM nodeon_users WHERE id = p_user_id;
    
    -- Получаем статистику из miner_data
    SELECT 
        total_gas_earned,
        total_farms_bought,
        total_upgrades_bought,
        gas_per_minute
    INTO v_total_gas, v_total_farms, v_total_upgrades, v_gas_per_minute
    FROM nodeon_miner_data WHERE user_id = p_user_id;
    
    -- Рассчитываем уровень
    v_miner_level := calculate_miner_level(COALESCE(v_total_gas, 0));
    
    -- Обновляем или создаем запись статистики
    INSERT INTO nodeon_miner_stats (
        user_id, telegram_id, username, first_name,
        total_gas_earned, total_farms, total_upgrades,
        current_gas_per_minute, miner_level, last_activity
    ) VALUES (
        p_user_id, v_user_data.telegram_id, v_user_data.username, v_user_data.first_name,
        COALESCE(v_total_gas, 0), COALESCE(v_total_farms, 0), COALESCE(v_total_upgrades, 0),
        COALESCE(v_gas_per_minute, 0), v_miner_level, NOW()
    )
    ON CONFLICT (user_id) DO UPDATE SET
        total_gas_earned = EXCLUDED.total_gas_earned,
        total_farms = EXCLUDED.total_farms,
        total_upgrades = EXCLUDED.total_upgrades,
        current_gas_per_minute = EXCLUDED.current_gas_per_minute,
        miner_level = EXCLUDED.miner_level,
        last_activity = NOW(),
        updated_at = NOW();
END;
$$ LANGUAGE plpgsql;

-- Функция для обновления рейтинга
CREATE OR REPLACE FUNCTION update_miner_rankings()
RETURNS VOID AS $$
BEGIN
    UPDATE nodeon_miner_stats 
    SET rank_position = subquery.rank
    FROM (
        SELECT user_id, ROW_NUMBER() OVER (ORDER BY total_gas_earned DESC, miner_level DESC) as rank
        FROM nodeon_miner_stats
    ) subquery
    WHERE nodeon_miner_stats.user_id = subquery.user_id;
END;
$$ LANGUAGE plpgsql;

-- Создание начальных данных для существующих пользователей
INSERT INTO nodeon_miner_data (user_id, telegram_id, ndn_gas, energy, max_energy, total_gas_earned, last_energy_refill, last_update)
SELECT 
    id, 
    telegram_id, 
    100.0, 
    100, 
    100, 
    100.0, 
    EXTRACT(EPOCH FROM NOW()) * 1000,
    EXTRACT(EPOCH FROM NOW()) * 1000
FROM nodeon_users
ON CONFLICT (user_id) DO NOTHING;

-- Создание начальной статистики
INSERT INTO nodeon_miner_stats (user_id, telegram_id, username, first_name, total_gas_earned, miner_level)
SELECT 
    u.id, 
    u.telegram_id, 
    u.username, 
    u.first_name, 
    100.0, 
    1
FROM nodeon_users u
ON CONFLICT (user_id) DO NOTHING;

-- Обновление рейтинга
SELECT update_miner_rankings();
