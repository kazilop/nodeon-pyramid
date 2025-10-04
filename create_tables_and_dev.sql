-- Создание таблиц и настройка аккаунта разработчика
-- Выполните этот скрипт в Supabase SQL Editor

-- 1. Создаем таблицу пользователей
CREATE TABLE IF NOT EXISTS nodeon_users (
    id SERIAL PRIMARY KEY,
    telegram_id BIGINT UNIQUE NOT NULL,
    username VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    balance_ndn DECIMAL(10,2) DEFAULT 0,
    is_pro BOOLEAN DEFAULT FALSE,
    referral_link TEXT,
    inviter_id INTEGER REFERENCES nodeon_users(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Создаем таблицу транзакций
CREATE TABLE IF NOT EXISTS nodeon_transactions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES nodeon_users(id),
    type VARCHAR(50) NOT NULL,
    amount_ndn DECIMAL(10,2) NOT NULL,
    amount_stars DECIMAL(10,2),
    description TEXT,
    referral_level INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Создаем таблицу статистики рефералов
CREATE TABLE IF NOT EXISTS nodeon_referral_stats (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES nodeon_users(id),
    level INTEGER NOT NULL,
    total_referrals INTEGER DEFAULT 0,
    total_earnings DECIMAL(10,2) DEFAULT 0,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Создаем таблицу запросов на платежи
CREATE TABLE IF NOT EXISTS nodeon_payment_requests (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES nodeon_users(id),
    amount_ndn DECIMAL(10,2) NOT NULL,
    amount_stars DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    processed_at TIMESTAMP WITH TIME ZONE
);

-- 5. Создаем индексы
CREATE INDEX IF NOT EXISTS idx_nodeon_users_telegram_id ON nodeon_users(telegram_id);
CREATE INDEX IF NOT EXISTS idx_nodeon_users_referral_link ON nodeon_users(referral_link);
CREATE INDEX IF NOT EXISTS idx_nodeon_transactions_user_id ON nodeon_transactions(user_id);
CREATE INDEX IF NOT EXISTS idx_nodeon_transactions_created_at ON nodeon_transactions(created_at);
CREATE INDEX IF NOT EXISTS idx_nodeon_referral_stats_user_id ON nodeon_referral_stats(user_id);

-- 6. Создаем или обновляем пользователя разработчика
INSERT INTO nodeon_users (
    telegram_id, 
    username, 
    first_name, 
    last_name, 
    balance_ndn, 
    is_pro, 
    referral_link, 
    inviter_id, 
    created_at, 
    updated_at
) VALUES (
    207940967,
    'developer',
    'Разработчик',
    'NodeOn',
    10000.00,
    true,
    'https://t.me/pro_stars_bot?startapp=dev_207940967',
    NULL,
    NOW(),
    NOW()
) ON CONFLICT (telegram_id) DO UPDATE SET
    username = EXCLUDED.username,
    first_name = EXCLUDED.first_name,
    last_name = EXCLUDED.last_name,
    balance_ndn = EXCLUDED.balance_ndn,
    is_pro = EXCLUDED.is_pro,
    referral_link = EXCLUDED.referral_link,
    updated_at = NOW();

-- 7. Создаем транзакцию для бонуса
INSERT INTO nodeon_transactions (
    user_id,
    type,
    amount_ndn,
    description,
    created_at
) VALUES (
    (SELECT id FROM nodeon_users WHERE telegram_id = 207940967),
    'developer_bonus',
    10000.00,
    'Бонус разработчику - 10,000 NDN',
    NOW()
);

-- 8. Создаем статистику рефералов
INSERT INTO nodeon_referral_stats (user_id, level, total_referrals, total_earnings, updated_at)
SELECT 
    (SELECT id FROM nodeon_users WHERE telegram_id = 207940967),
    level, 
    0, 
    0, 
    NOW()
FROM generate_series(1, 7) AS level
WHERE NOT EXISTS (
    SELECT 1 FROM nodeon_referral_stats 
    WHERE user_id = (SELECT id FROM nodeon_users WHERE telegram_id = 207940967)
);

-- 9. Проверяем результат
SELECT 
    u.id,
    u.telegram_id,
    u.first_name,
    u.last_name,
    u.balance_ndn,
    u.is_pro,
    u.referral_link,
    COUNT(t.id) as transaction_count
FROM nodeon_users u
LEFT JOIN nodeon_transactions t ON u.id = t.user_id
WHERE u.telegram_id = 207940967
GROUP BY u.id, u.telegram_id, u.first_name, u.last_name, u.balance_ndn, u.is_pro, u.referral_link;
