-- Исправление таблицы nodeon_stars_config
-- Выполните этот скрипт в Supabase SQL Editor

-- 1. Удаляем существующую таблицу (если есть)
DROP TABLE IF EXISTS nodeon_stars_config CASCADE;

-- 2. Создаем таблицу конфигурации Stars с правильными колонками
CREATE TABLE nodeon_stars_config (
    id SERIAL PRIMARY KEY,
    stars_to_ndn_rate DECIMAL(10,4) DEFAULT 1.0000 NOT NULL, -- 1 Star = 1 NDN
    ndn_to_stars_rate DECIMAL(10,4) DEFAULT 1.0000 NOT NULL, -- 1 NDN = 1 Star
    min_stars_purchase DECIMAL(10,2) DEFAULT 10.0 NOT NULL, -- Минимум 10 Stars
    max_stars_purchase DECIMAL(10,2) DEFAULT 100000.0 NOT NULL, -- Максимум 100,000 Stars
    stars_withdrawal_fee_percent DECIMAL(5,2) DEFAULT 5.0 NOT NULL, -- Комиссия 5%
    is_active BOOLEAN DEFAULT TRUE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Инициализируем конфигурацию Stars
INSERT INTO nodeon_stars_config (
    stars_to_ndn_rate, 
    ndn_to_stars_rate, 
    min_stars_purchase, 
    max_stars_purchase, 
    stars_withdrawal_fee_percent
) VALUES (
    1.0000,  -- 1 Star = 1 NDN
    1.0000,  -- 1 NDN = 1 Star
    10.0,    -- Минимум 10 Stars
    100000.0, -- Максимум 100,000 Stars
    5.0      -- Комиссия 5%
);

-- 4. Проверяем создание
SELECT 'Stars config table created successfully!' as message;
SELECT * FROM nodeon_stars_config;
