-- Добавляем колонку user_status в таблицу nodeon_users
ALTER TABLE nodeon_users 
ADD COLUMN IF NOT EXISTS user_status VARCHAR(20) DEFAULT 'user' NOT NULL;

-- Добавляем индексы для быстрого поиска по статусу
CREATE INDEX IF NOT EXISTS idx_nodeon_users_user_status ON nodeon_users(user_status);

-- Обновляем существующих пользователей
UPDATE nodeon_users SET user_status = 'developer' WHERE id = 5; -- Fish
UPDATE nodeon_users SET user_status = 'user' WHERE id IN (3, 4, 7, 14); -- Остальные

-- Создаем таблицу для заявок на обмен NDN на Stars
CREATE TABLE IF NOT EXISTS exchange_requests (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES nodeon_users(id),
    amount_ndn DECIMAL(15,2) NOT NULL,
    amount_stars INTEGER NOT NULL,
    telegram_username VARCHAR(255) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending' NOT NULL, -- pending, approved, rejected, completed
    description TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    processed_at TIMESTAMP,
    processed_by INTEGER REFERENCES nodeon_users(id),
    notes TEXT
);

-- Добавляем индексы для заявок на обмен
CREATE INDEX IF NOT EXISTS idx_exchange_requests_user_id ON exchange_requests(user_id);
CREATE INDEX IF NOT EXISTS idx_exchange_requests_status ON exchange_requests(status);
CREATE INDEX IF NOT EXISTS idx_exchange_requests_created_at ON exchange_requests(created_at);

-- Создаем таблицу для админских действий
CREATE TABLE IF NOT EXISTS admin_actions (
    id SERIAL PRIMARY KEY,
    admin_id INTEGER NOT NULL REFERENCES nodeon_users(id),
    action_type VARCHAR(50) NOT NULL, -- exchange_approve, exchange_reject, user_ban, etc.
    target_user_id INTEGER REFERENCES nodeon_users(id),
    target_id INTEGER, -- ID заявки или другого объекта
    description TEXT NOT NULL,
    data JSONB, -- Дополнительные данные в JSON
    created_at TIMESTAMP DEFAULT NOW()
);

-- Добавляем индексы для админских действий
CREATE INDEX IF NOT EXISTS idx_admin_actions_admin_id ON admin_actions(admin_id);
CREATE INDEX IF NOT EXISTS idx_admin_actions_action_type ON admin_actions(action_type);
CREATE INDEX IF NOT EXISTS idx_admin_actions_created_at ON admin_actions(created_at);

-- Создаем таблицу для серверного кошелька
CREATE TABLE IF NOT EXISTS server_wallet (
    id SERIAL PRIMARY KEY,
    balance_ndn DECIMAL(20,2) DEFAULT 1000000000.0 NOT NULL, -- 1 млрд NDN
    total_ndn_sold DECIMAL(20,2) DEFAULT 0.0 NOT NULL, -- Всего продано NDN
    total_stars_received DECIMAL(20,2) DEFAULT 0.0 NOT NULL, -- Всего получено Stars
    total_ndn_exchanged DECIMAL(20,2) DEFAULT 0.0 NOT NULL, -- Всего обменено NDN на Stars
    total_stars_sent DECIMAL(20,2) DEFAULT 0.0 NOT NULL, -- Всего отправлено Stars
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Создаем единственную запись серверного кошелька
INSERT INTO server_wallet (balance_ndn, total_ndn_sold, total_stars_received, total_ndn_exchanged, total_stars_sent)
VALUES (1000000000.0, 0.0, 0.0, 0.0, 0.0)
ON CONFLICT DO NOTHING;

-- Создаем таблицу для статистики системы
CREATE TABLE IF NOT EXISTS system_stats (
    id SERIAL PRIMARY KEY,
    total_users INTEGER DEFAULT 0,
    total_pro_users INTEGER DEFAULT 0,
    total_ndn_in_circulation DECIMAL(20,2) DEFAULT 0.0,
    total_stars_earned DECIMAL(20,2) DEFAULT 0.0,
    total_referrals INTEGER DEFAULT 0,
    total_exchanges INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Создаем единственную запись статистики
INSERT INTO system_stats (total_users, total_pro_users, total_ndn_in_circulation, total_stars_earned, total_referrals, total_exchanges)
VALUES (0, 0, 0.0, 0.0, 0, 0)
ON CONFLICT DO NOTHING;

-- Создаем таблицу для логов транзакций
CREATE TABLE IF NOT EXISTS transaction_logs (
    id SERIAL PRIMARY KEY,
    transaction_type VARCHAR(50) NOT NULL, -- buy_ndn, sell_ndn, exchange_ndn, referral_reward, etc.
    user_id INTEGER REFERENCES nodeon_users(id),
    amount_ndn DECIMAL(15,2),
    amount_stars DECIMAL(15,2),
    description TEXT,
    metadata JSONB,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Добавляем индексы для логов транзакций
CREATE INDEX IF NOT EXISTS idx_transaction_logs_type ON transaction_logs(transaction_type);
CREATE INDEX IF NOT EXISTS idx_transaction_logs_user_id ON transaction_logs(user_id);
CREATE INDEX IF NOT EXISTS idx_transaction_logs_created_at ON transaction_logs(created_at);

-- Создаем функцию для обновления статистики системы
CREATE OR REPLACE FUNCTION update_system_stats()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE system_stats SET
        total_users = (SELECT COUNT(*) FROM nodeon_users),
        total_pro_users = (SELECT COUNT(*) FROM nodeon_users WHERE is_pro = true),
        total_ndn_in_circulation = (SELECT COALESCE(SUM(balance_ndn), 0) FROM nodeon_users),
        total_referrals = (SELECT COUNT(*) FROM nodeon_users WHERE inviter_id IS NOT NULL),
        updated_at = NOW()
    WHERE id = 1;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Создаем триггеры для автоматического обновления статистики
CREATE TRIGGER trigger_update_stats_on_user_insert
    AFTER INSERT ON nodeon_users
    FOR EACH ROW
    EXECUTE FUNCTION update_system_stats();

CREATE TRIGGER trigger_update_stats_on_user_update
    AFTER UPDATE ON nodeon_users
    FOR EACH ROW
    EXECUTE FUNCTION update_system_stats();

-- Создаем функцию для обновления времени в server_wallet
CREATE OR REPLACE FUNCTION update_server_wallet_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Создаем триггер для обновления времени в server_wallet
CREATE TRIGGER trigger_update_server_wallet_timestamp
    BEFORE UPDATE ON server_wallet
    FOR EACH ROW
    EXECUTE FUNCTION update_server_wallet_timestamp();

