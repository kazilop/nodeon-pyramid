-- Настройка продакшн базы данных для NodeOn Pyramid
-- Выполните этот скрипт в Supabase SQL Editor

-- 1. Создаем таблицы с префиксом nodeon_
CREATE TABLE IF NOT EXISTS nodeon_users (
    id SERIAL PRIMARY KEY,
    telegram_id BIGINT UNIQUE NOT NULL,
    username VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    balance_ndn DECIMAL(10,2) DEFAULT 0.0,
    balance_stars DECIMAL(10,2) DEFAULT 0.0,
    total_stars_earned DECIMAL(10,2) DEFAULT 0.0,
    total_stars_spent DECIMAL(10,2) DEFAULT 0.0,
    is_pro BOOLEAN DEFAULT FALSE,
    referral_link VARCHAR(500),
    inviter_id INTEGER REFERENCES nodeon_users(id),
    referral_path TEXT,
    referral_level INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS nodeon_transactions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES nodeon_users(id) ON DELETE CASCADE,
    type VARCHAR(50) NOT NULL,
    amount_ndn DECIMAL(10,2) DEFAULT 0.0,
    amount_stars DECIMAL(10,2) DEFAULT 0.0,
    stars_amount DECIMAL(10,2) DEFAULT 0.0,
    stars_balance_after DECIMAL(10,2) DEFAULT 0.0,
    description TEXT,
    referral_level INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS nodeon_referral_stats (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES nodeon_users(id) ON DELETE CASCADE,
    level INTEGER NOT NULL,
    total_referrals INTEGER DEFAULT 0,
    total_earnings DECIMAL(10,2) DEFAULT 0.0,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, level)
);

CREATE TABLE IF NOT EXISTS nodeon_payment_requests (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES nodeon_users(id) ON DELETE CASCADE,
    amount_ndn DECIMAL(10,2) NOT NULL,
    amount_stars DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS nodeon_stars_payments (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES nodeon_users(id) ON DELETE CASCADE,
    payment_id VARCHAR(255) UNIQUE NOT NULL,
    stars_amount DECIMAL(10,2) NOT NULL,
    ndn_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    telegram_payment_id VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    completed_at TIMESTAMP WITH TIME ZONE
);

CREATE TABLE IF NOT EXISTS nodeon_stars_config (
    id SERIAL PRIMARY KEY,
    config_key VARCHAR(100) UNIQUE NOT NULL,
    config_value TEXT NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Создаем индексы
CREATE INDEX IF NOT EXISTS idx_nodeon_users_telegram_id ON nodeon_users(telegram_id);
CREATE INDEX IF NOT EXISTS idx_nodeon_users_inviter_id ON nodeon_users(inviter_id);
CREATE INDEX IF NOT EXISTS idx_nodeon_users_created_at ON nodeon_users(created_at);
CREATE INDEX IF NOT EXISTS idx_nodeon_transactions_user_id ON nodeon_transactions(user_id);
CREATE INDEX IF NOT EXISTS idx_nodeon_transactions_created_at ON nodeon_transactions(created_at);
CREATE INDEX IF NOT EXISTS idx_nodeon_referral_stats_user_id ON nodeon_referral_stats(user_id);
CREATE INDEX IF NOT EXISTS idx_stars_payments_user_id ON nodeon_stars_payments(user_id);
CREATE INDEX IF NOT EXISTS idx_stars_payments_payment_id ON nodeon_stars_payments(payment_id);
CREATE INDEX IF NOT EXISTS idx_stars_payments_status ON nodeon_stars_payments(status);

-- 3. Добавляем конфигурацию Stars
INSERT INTO nodeon_stars_config (config_key, config_value, description) VALUES
('stars_to_ndn_rate', '1.0', 'Курс обмена: 1 Star = 1 NDN'),
('min_stars_purchase', '10', 'Минимальная покупка в Stars'),
('max_stars_purchase', '10000', 'Максимальная покупка в Stars'),
('stars_purchase_fee_percent', '0', 'Комиссия за покупку NDN за Stars (%)'),
('stars_withdrawal_fee_percent', '5', 'Комиссия за вывод NDN в Stars (%)')
ON CONFLICT (config_key) DO NOTHING;

-- 4. Создаем функции для работы с рефералами
CREATE OR REPLACE FUNCTION update_referral_path()
RETURNS TRIGGER AS $$
DECLARE
    parent_path TEXT;
    parent_level INTEGER;
BEGIN
    IF NEW.inviter_id IS NOT NULL THEN
        SELECT referral_path, referral_level INTO parent_path, parent_level
        FROM nodeon_users 
        WHERE id = NEW.inviter_id;
        
        NEW.referral_path = COALESCE(parent_path || ',', '') || NEW.id::TEXT;
        NEW.referral_level = COALESCE(parent_level, 0) + 1;
    ELSE
        NEW.referral_path = NEW.id::TEXT;
        NEW.referral_level = 0;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_referral_path
    BEFORE INSERT OR UPDATE ON nodeon_users
    FOR EACH ROW
    EXECUTE FUNCTION update_referral_path();

-- 5. Создаем функцию для получения рефералов
CREATE OR REPLACE FUNCTION get_user_referrals(user_telegram_id BIGINT)
RETURNS TABLE (
    level INTEGER,
    user_id INTEGER,
    telegram_id BIGINT,
    first_name VARCHAR(255),
    username VARCHAR(255),
    balance_ndn DECIMAL(10,2),
    is_pro BOOLEAN,
    created_at TIMESTAMP WITH TIME ZONE
) AS $$
BEGIN
    RETURN QUERY
    WITH RECURSIVE referral_tree AS (
        SELECT 
            0 as level,
            u.id as user_id,
            u.telegram_id,
            u.first_name,
            u.username,
            u.balance_ndn,
            u.is_pro,
            u.created_at,
            u.referral_path
        FROM nodeon_users u
        WHERE u.telegram_id = user_telegram_id
        
        UNION ALL
        
        SELECT 
            rt.level + 1,
            u.id,
            u.telegram_id,
            u.first_name,
            u.username,
            u.balance_ndn,
            u.is_pro,
            u.created_at,
            u.referral_path
        FROM nodeon_users u
        JOIN referral_tree rt ON u.referral_path LIKE rt.referral_path || ',%'
        WHERE u.is_active = TRUE
    )
    SELECT 
        rt.level,
        rt.user_id,
        rt.telegram_id,
        rt.first_name,
        rt.username,
        rt.balance_ndn,
        rt.is_pro,
        rt.created_at
    FROM referral_tree rt
    WHERE rt.level > 0
    ORDER BY rt.level, rt.created_at;
END;
$$ LANGUAGE plpgsql;

-- 6. Создаем функцию для валидации реферальных ссылок
CREATE OR REPLACE FUNCTION validate_referral_link(referral_token TEXT)
RETURNS TABLE (
    is_valid BOOLEAN,
    inviter_id INTEGER,
    inviter_telegram_id BIGINT,
    inviter_name VARCHAR(255),
    inviter_is_pro BOOLEAN
) AS $$
DECLARE
    user_id_from_token INTEGER;
BEGIN
    BEGIN
        user_id_from_token := (referral_token ~ '^ref_(\d+)$')::INTEGER;
        IF user_id_from_token IS NULL THEN
            user_id_from_token := (referral_token ~ '^(\d+)$')::INTEGER;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            user_id_from_token := NULL;
    END;
    
    IF user_id_from_token IS NULL THEN
        RETURN QUERY SELECT FALSE, NULL::INTEGER, NULL::BIGINT, NULL::VARCHAR(255), NULL::BOOLEAN;
        RETURN;
    END IF;
    
    RETURN QUERY
    SELECT 
        u.is_pro AND u.is_active,
        u.id,
        u.telegram_id,
        u.first_name,
        u.is_pro
    FROM nodeon_users u
    WHERE u.id = user_id_from_token;
    
    IF NOT FOUND THEN
        RETURN QUERY SELECT FALSE, NULL::INTEGER, NULL::BIGINT, NULL::VARCHAR(255), NULL::BOOLEAN;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- 7. Создаем функции для Stars
CREATE OR REPLACE FUNCTION process_stars_payment(
    p_user_id INTEGER,
    p_payment_id VARCHAR(255),
    p_stars_amount DECIMAL(10,2),
    p_ndn_amount DECIMAL(10,2),
    p_telegram_payment_id VARCHAR(255) DEFAULT NULL
)
RETURNS JSON AS $$
DECLARE
    user_record RECORD;
    payment_record RECORD;
    result JSON;
BEGIN
    SELECT * INTO user_record FROM nodeon_users WHERE id = p_user_id;
    
    IF NOT FOUND THEN
        RETURN json_build_object('success', false, 'error', 'User not found');
    END IF;
    
    SELECT * INTO payment_record FROM nodeon_stars_payments WHERE payment_id = p_payment_id;
    
    IF FOUND THEN
        RETURN json_build_object('success', false, 'error', 'Payment already exists');
    END IF;
    
    INSERT INTO nodeon_stars_payments (
        user_id, payment_id, stars_amount, ndn_amount, 
        telegram_payment_id, status, completed_at
    ) VALUES (
        p_user_id, p_payment_id, p_stars_amount, p_ndn_amount,
        p_telegram_payment_id, 'completed', NOW()
    );
    
    UPDATE nodeon_users SET
        balance_ndn = balance_ndn + p_ndn_amount,
        balance_stars = balance_stars + p_stars_amount,
        total_stars_earned = total_stars_earned + p_stars_amount,
        updated_at = NOW()
    WHERE id = p_user_id;
    
    INSERT INTO nodeon_transactions (
        user_id, type, amount_ndn, stars_amount, description, 
        stars_balance_after, created_at
    ) VALUES (
        p_user_id, 'stars_purchase', p_ndn_amount, p_stars_amount,
        'Покупка NDN за Telegram Stars', 
        (SELECT balance_stars FROM nodeon_users WHERE id = p_user_id),
        NOW()
    );
    
    SELECT * INTO user_record FROM nodeon_users WHERE id = p_user_id;
    
    result := json_build_object(
        'success', true,
        'user_id', p_user_id,
        'new_ndn_balance', user_record.balance_ndn,
        'new_stars_balance', user_record.balance_stars,
        'ndn_amount', p_ndn_amount,
        'stars_amount', p_stars_amount
    );
    
    RETURN result;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION withdraw_ndn_to_stars(
    p_user_id INTEGER,
    p_ndn_amount DECIMAL(10,2)
)
RETURNS JSON AS $$
DECLARE
    user_record RECORD;
    withdrawal_fee_percent DECIMAL(5,2);
    withdrawal_fee DECIMAL(10,2);
    stars_amount DECIMAL(10,2);
    result JSON;
BEGIN
    SELECT * INTO user_record FROM nodeon_users WHERE id = p_user_id;
    
    IF NOT FOUND THEN
        RETURN json_build_object('success', false, 'error', 'User not found');
    END IF;
    
    IF user_record.balance_ndn < p_ndn_amount THEN
        RETURN json_build_object('success', false, 'error', 'Insufficient NDN balance');
    END IF;
    
    SELECT config_value::DECIMAL(5,2) INTO withdrawal_fee_percent 
    FROM nodeon_stars_config WHERE config_key = 'stars_withdrawal_fee_percent';
    
    withdrawal_fee := p_ndn_amount * (withdrawal_fee_percent / 100);
    stars_amount := p_ndn_amount - withdrawal_fee;
    
    UPDATE nodeon_users SET
        balance_ndn = balance_ndn - p_ndn_amount,
        balance_stars = balance_stars - stars_amount,
        total_stars_spent = total_stars_spent + stars_amount,
        updated_at = NOW()
    WHERE id = p_user_id;
    
    INSERT INTO nodeon_transactions (
        user_id, type, amount_ndn, stars_amount, description, 
        stars_balance_after, created_at
    ) VALUES (
        p_user_id, 'stars_withdrawal', -p_ndn_amount, -stars_amount,
        'Вывод NDN в Telegram Stars (комиссия: ' || withdrawal_fee || ' NDN)', 
        (SELECT balance_stars FROM nodeon_users WHERE id = p_user_id),
        NOW()
    );
    
    SELECT * INTO user_record FROM nodeon_users WHERE id = p_user_id;
    
    result := json_build_object(
        'success', true,
        'user_id', p_user_id,
        'new_ndn_balance', user_record.balance_ndn,
        'new_stars_balance', user_record.balance_stars,
        'ndn_amount', p_ndn_amount,
        'stars_amount', stars_amount,
        'withdrawal_fee', withdrawal_fee
    );
    
    RETURN result;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_stars_config()
RETURNS JSON AS $$
DECLARE
    config_record RECORD;
    result JSON := '{}';
BEGIN
    FOR config_record IN 
        SELECT config_key, config_value FROM nodeon_stars_config
    LOOP
        result := result || json_build_object(config_record.config_key, config_record.config_value);
    END LOOP;
    
    RETURN result;
END;
$$ LANGUAGE plpgsql;

-- 8. Создаем разработчика (если не существует)
INSERT INTO nodeon_users (
    telegram_id, username, first_name, last_name, 
    balance_ndn, is_pro, referral_link, is_active
) VALUES (
    207940967, 'developer', 'Разработчик NodeOn', 'Admin',
    10000.0, TRUE, 'https://t.me/pro_stars_bot?startapp=dev_207940967', TRUE
) ON CONFLICT (telegram_id) DO UPDATE SET
    balance_ndn = 10000.0,
    is_pro = TRUE,
    referral_link = 'https://t.me/pro_stars_bot?startapp=dev_207940967',
    is_active = TRUE;

-- 9. Создаем статистику рефералов для разработчика
INSERT INTO nodeon_referral_stats (user_id, level, total_referrals, total_earnings)
SELECT 
    u.id, 
    level, 
    0, 
    0.0
FROM nodeon_users u
CROSS JOIN generate_series(1, 7) AS level
WHERE u.telegram_id = 207940967
ON CONFLICT (user_id, level) DO NOTHING;

-- 10. Проверяем результат
SELECT 'Database setup completed successfully' as status;
