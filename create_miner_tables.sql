-- Создание таблиц для игры майнинга

-- Таблица данных майнинга пользователей
CREATE TABLE IF NOT EXISTS nodeon_miner_data (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES nodeon_users(id) ON DELETE CASCADE,
    miner_data JSONB NOT NULL DEFAULT '{}',
    last_update BIGINT NOT NULL DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id)
);

-- Таблица статистики майнинга
CREATE TABLE IF NOT EXISTS nodeon_miner_stats (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES nodeon_users(id) ON DELETE CASCADE,
    level INTEGER NOT NULL DEFAULT 1,
    total_gas_earned DECIMAL(20,2) NOT NULL DEFAULT 0,
    total_farms INTEGER NOT NULL DEFAULT 0,
    total_upgrades INTEGER NOT NULL DEFAULT 0,
    last_update BIGINT NOT NULL DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id)
);

-- Таблица ферм майнинга
CREATE TABLE IF NOT EXISTS nodeon_miner_farms (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES nodeon_users(id) ON DELETE CASCADE,
    farm_type VARCHAR(50) NOT NULL,
    farm_data JSONB NOT NULL DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, farm_type)
);

-- Таблица улучшений майнинга
CREATE TABLE IF NOT EXISTS nodeon_miner_upgrades (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES nodeon_users(id) ON DELETE CASCADE,
    upgrade_type VARCHAR(50) NOT NULL,
    upgrade_level INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, upgrade_type)
);

-- Таблица транзакций майнинга
CREATE TABLE IF NOT EXISTS nodeon_miner_transactions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES nodeon_users(id) ON DELETE CASCADE,
    transaction_type VARCHAR(50) NOT NULL,
    amount DECIMAL(20,2) NOT NULL DEFAULT 0,
    currency VARCHAR(10) NOT NULL DEFAULT 'gas',
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Создание индексов для оптимизации
CREATE INDEX IF NOT EXISTS idx_miner_data_user_id ON nodeon_miner_data(user_id);
CREATE INDEX IF NOT EXISTS idx_miner_stats_user_id ON nodeon_miner_stats(user_id);
CREATE INDEX IF NOT EXISTS idx_miner_farms_user_id ON nodeon_miner_farms(user_id);
CREATE INDEX IF NOT EXISTS idx_miner_upgrades_user_id ON nodeon_miner_upgrades(user_id);
CREATE INDEX IF NOT EXISTS idx_miner_transactions_user_id ON nodeon_miner_transactions(user_id);
CREATE INDEX IF NOT EXISTS idx_miner_transactions_type ON nodeon_miner_transactions(transaction_type);
CREATE INDEX IF NOT EXISTS idx_miner_transactions_created_at ON nodeon_miner_transactions(created_at);
