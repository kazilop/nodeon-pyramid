-- Добавление поддержки Telegram Stars
-- Выполните этот скрипт в Supabase SQL Editor

-- 1. Добавляем поля для Stars в таблицу пользователей
ALTER TABLE nodeon_users ADD COLUMN IF NOT EXISTS balance_stars DECIMAL(10,2) DEFAULT 0.0;
ALTER TABLE nodeon_users ADD COLUMN IF NOT EXISTS total_stars_earned DECIMAL(10,2) DEFAULT 0.0;
ALTER TABLE nodeon_users ADD COLUMN IF NOT EXISTS total_stars_spent DECIMAL(10,2) DEFAULT 0.0;

-- 2. Обновляем таблицу транзакций для поддержки Stars
ALTER TABLE nodeon_transactions ADD COLUMN IF NOT EXISTS stars_amount DECIMAL(10,2) DEFAULT 0.0;
ALTER TABLE nodeon_transactions ADD COLUMN IF NOT EXISTS stars_balance_after DECIMAL(10,2) DEFAULT 0.0;

-- 3. Создаем таблицу для Stars платежей
CREATE TABLE IF NOT EXISTS nodeon_stars_payments (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES nodeon_users(id) ON DELETE CASCADE,
    payment_id VARCHAR(255) UNIQUE NOT NULL,
    stars_amount DECIMAL(10,2) NOT NULL,
    ndn_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'pending', -- pending, completed, failed, refunded
    telegram_payment_id VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    completed_at TIMESTAMP WITH TIME ZONE
);

-- 4. Создаем индексы для быстрого поиска
CREATE INDEX IF NOT EXISTS idx_stars_payments_user_id ON nodeon_stars_payments(user_id);
CREATE INDEX IF NOT EXISTS idx_stars_payments_payment_id ON nodeon_stars_payments(payment_id);
CREATE INDEX IF NOT EXISTS idx_stars_payments_status ON nodeon_stars_payments(status);
CREATE INDEX IF NOT EXISTS idx_stars_payments_created_at ON nodeon_stars_payments(created_at);

-- 5. Создаем таблицу для конфигурации Stars
CREATE TABLE IF NOT EXISTS nodeon_stars_config (
    id SERIAL PRIMARY KEY,
    config_key VARCHAR(100) UNIQUE NOT NULL,
    config_value TEXT NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 6. Добавляем конфигурацию Stars
INSERT INTO nodeon_stars_config (config_key, config_value, description) VALUES
('stars_to_ndn_rate', '1.0', 'Курс обмена: 1 Star = 1 NDN'),
('min_stars_purchase', '10', 'Минимальная покупка в Stars'),
('max_stars_purchase', '10000', 'Максимальная покупка в Stars'),
('stars_purchase_fee_percent', '0', 'Комиссия за покупку NDN за Stars (%)'),
('stars_withdrawal_fee_percent', '5', 'Комиссия за вывод NDN в Stars (%)')
ON CONFLICT (config_key) DO NOTHING;

-- 7. Создаем функцию для обработки Stars платежей
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
    -- Получаем данные пользователя
    SELECT * INTO user_record FROM nodeon_users WHERE id = p_user_id;
    
    IF NOT FOUND THEN
        RETURN json_build_object('success', false, 'error', 'User not found');
    END IF;
    
    -- Проверяем, не существует ли уже такой платеж
    SELECT * INTO payment_record FROM nodeon_stars_payments WHERE payment_id = p_payment_id;
    
    IF FOUND THEN
        RETURN json_build_object('success', false, 'error', 'Payment already exists');
    END IF;
    
    -- Создаем запись о платеже
    INSERT INTO nodeon_stars_payments (
        user_id, payment_id, stars_amount, ndn_amount, 
        telegram_payment_id, status, completed_at
    ) VALUES (
        p_user_id, p_payment_id, p_stars_amount, p_ndn_amount,
        p_telegram_payment_id, 'completed', NOW()
    );
    
    -- Обновляем баланс пользователя
    UPDATE nodeon_users SET
        balance_ndn = balance_ndn + p_ndn_amount,
        balance_stars = balance_stars + p_stars_amount,
        total_stars_earned = total_stars_earned + p_stars_amount,
        updated_at = NOW()
    WHERE id = p_user_id;
    
    -- Создаем транзакцию
    INSERT INTO nodeon_transactions (
        user_id, type, amount_ndn, stars_amount, description, 
        stars_balance_after, created_at
    ) VALUES (
        p_user_id, 'stars_purchase', p_ndn_amount, p_stars_amount,
        'Покупка NDN за Telegram Stars', 
        (SELECT balance_stars FROM nodeon_users WHERE id = p_user_id),
        NOW()
    );
    
    -- Возвращаем результат
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

-- 8. Создаем функцию для вывода NDN в Stars
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
    -- Получаем данные пользователя
    SELECT * INTO user_record FROM nodeon_users WHERE id = p_user_id;
    
    IF NOT FOUND THEN
        RETURN json_build_object('success', false, 'error', 'User not found');
    END IF;
    
    -- Проверяем достаточность средств
    IF user_record.balance_ndn < p_ndn_amount THEN
        RETURN json_build_object('success', false, 'error', 'Insufficient NDN balance');
    END IF;
    
    -- Получаем комиссию за вывод
    SELECT config_value::DECIMAL(5,2) INTO withdrawal_fee_percent 
    FROM nodeon_stars_config WHERE config_key = 'stars_withdrawal_fee_percent';
    
    withdrawal_fee := p_ndn_amount * (withdrawal_fee_percent / 100);
    stars_amount := p_ndn_amount - withdrawal_fee;
    
    -- Обновляем баланс пользователя
    UPDATE nodeon_users SET
        balance_ndn = balance_ndn - p_ndn_amount,
        balance_stars = balance_stars - stars_amount,
        total_stars_spent = total_stars_spent + stars_amount,
        updated_at = NOW()
    WHERE id = p_user_id;
    
    -- Создаем транзакцию
    INSERT INTO nodeon_transactions (
        user_id, type, amount_ndn, stars_amount, description, 
        stars_balance_after, created_at
    ) VALUES (
        p_user_id, 'stars_withdrawal', -p_ndn_amount, -stars_amount,
        'Вывод NDN в Telegram Stars (комиссия: ' || withdrawal_fee || ' NDN)', 
        (SELECT balance_stars FROM nodeon_users WHERE id = p_user_id),
        NOW()
    );
    
    -- Возвращаем результат
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

-- 9. Создаем функцию для получения конфигурации Stars
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

-- 10. Проверяем результат
SELECT 'Stars support added successfully' as status;
