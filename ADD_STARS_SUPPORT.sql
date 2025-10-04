-- Добавление поддержки Telegram Stars в NodeOn Pyramid
-- Выполните этот скрипт в Supabase SQL Editor

-- 1. Добавляем колонки Stars в таблицу пользователей
ALTER TABLE nodeon_users 
ADD COLUMN IF NOT EXISTS balance_stars DECIMAL(10,2) DEFAULT 0.0,
ADD COLUMN IF NOT EXISTS total_stars_earned DECIMAL(10,2) DEFAULT 0.0,
ADD COLUMN IF NOT EXISTS total_stars_spent DECIMAL(10,2) DEFAULT 0.0;

-- 2. Создаем таблицу для платежей Stars
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

-- 3. Создаем таблицу конфигурации Stars
CREATE TABLE IF NOT EXISTS nodeon_stars_config (
    id SERIAL PRIMARY KEY,
    stars_to_ndn_rate DECIMAL(5,2) DEFAULT 1.0 NOT NULL,
    min_stars_purchase DECIMAL(10,2) DEFAULT 10.0 NOT NULL,
    max_stars_purchase DECIMAL(10,2) DEFAULT 10000.0 NOT NULL,
    stars_purchase_fee_percent DECIMAL(5,2) DEFAULT 0.0 NOT NULL,
    stars_withdrawal_fee_percent DECIMAL(5,2) DEFAULT 5.0 NOT NULL,
    developer_telegram_id BIGINT NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Создаем функции для работы со Stars
CREATE OR REPLACE FUNCTION get_stars_config()
RETURNS SETOF nodeon_stars_config AS $$
BEGIN
    RETURN QUERY SELECT * FROM nodeon_stars_config LIMIT 1;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION process_stars_payment(
    p_user_id INTEGER,
    p_stars_amount DECIMAL(10,2),
    p_payment_id VARCHAR(255)
)
RETURNS JSON AS $$
DECLARE
    v_ndn_amount DECIMAL(10,2);
    v_rate DECIMAL(5,2);
    v_user_exists BOOLEAN;
    v_current_balance DECIMAL(10,2);
BEGIN
    -- Получаем курс Stars к NDN
    SELECT stars_to_ndn_rate INTO v_rate FROM nodeon_stars_config LIMIT 1;
    IF v_rate IS NULL THEN
        RETURN '{"status": "error", "message": "Stars configuration not found"}'::JSON;
    END IF;

    v_ndn_amount := p_stars_amount * v_rate;

    -- Проверяем существование пользователя
    SELECT EXISTS (SELECT 1 FROM nodeon_users WHERE id = p_user_id) INTO v_user_exists;
    IF NOT v_user_exists THEN
        RETURN '{"status": "error", "message": "User not found"}'::JSON;
    END IF;

    -- Получаем текущий баланс
    SELECT balance_ndn INTO v_current_balance FROM nodeon_users WHERE id = p_user_id;

    -- Обновляем баланс пользователя
    UPDATE nodeon_users
    SET 
        balance_ndn = balance_ndn + v_ndn_amount,
        balance_stars = balance_stars + p_stars_amount,
        total_stars_earned = total_stars_earned + p_stars_amount
    WHERE id = p_user_id;

    -- Записываем транзакцию
    INSERT INTO nodeon_transactions (user_id, type, amount_ndn, stars_amount, description)
    VALUES (p_user_id, 'stars_purchase', v_ndn_amount, p_stars_amount, 'Покупка NDN за Stars');

    -- Записываем платежный запрос
    INSERT INTO nodeon_stars_payments (user_id, payment_id, stars_amount, ndn_amount, status)
    VALUES (p_user_id, p_payment_id, p_stars_amount, v_ndn_amount, 'completed');

    RETURN '{"status": "success", "message": "NDN purchased successfully", "ndn_amount": ' || v_ndn_amount || ', "new_balance": ' || (v_current_balance + v_ndn_amount) || '}'::JSON;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION withdraw_ndn_to_stars(
    p_user_id INTEGER,
    p_ndn_amount DECIMAL(10,2)
)
RETURNS JSON AS $$
DECLARE
    v_current_ndn_balance DECIMAL(10,2);
    v_stars_amount DECIMAL(10,2);
    v_rate DECIMAL(5,2);
    v_fee_percent DECIMAL(5,2);
    v_fee_amount_ndn DECIMAL(10,2);
    v_developer_id BIGINT;
    v_user_exists BOOLEAN;
BEGIN
    -- Проверяем существование пользователя
    SELECT EXISTS (SELECT 1 FROM nodeon_users WHERE id = p_user_id) INTO v_user_exists;
    IF NOT v_user_exists THEN
        RETURN '{"status": "error", "message": "User not found"}'::JSON;
    END IF;

    -- Получаем текущий баланс пользователя
    SELECT balance_ndn INTO v_current_ndn_balance FROM nodeon_users WHERE id = p_user_id;

    IF v_current_ndn_balance < p_ndn_amount THEN
        RETURN '{"status": "error", "message": "Недостаточно NDN для вывода"}'::JSON;
    END IF;

    -- Получаем конфигурацию Stars
    SELECT stars_to_ndn_rate, stars_withdrawal_fee_percent, developer_telegram_id
    INTO v_rate, v_fee_percent, v_developer_id
    FROM nodeon_stars_config LIMIT 1;

    IF v_rate IS NULL THEN
        RETURN '{"status": "error", "message": "Stars configuration not found"}'::JSON;
    END IF;

    -- Рассчитываем комиссию
    v_fee_amount_ndn := p_ndn_amount * (v_fee_percent / 100.00);
    v_ndn_amount := p_ndn_amount - v_fee_amount_ndn;

    -- Конвертируем NDN в Stars
    v_stars_amount := v_ndn_amount * v_rate;

    IF v_stars_amount <= 0 THEN
        RETURN '{"status": "error", "message": "Слишком мало NDN для вывода в Stars"}'::JSON;
    END IF;

    -- Обновляем баланс пользователя (вычитаем NDN)
    UPDATE nodeon_users
    SET 
        balance_ndn = balance_ndn - p_ndn_amount,
        balance_stars = balance_stars - v_stars_amount,
        total_stars_spent = total_stars_spent + v_stars_amount
    WHERE id = p_user_id;

    -- Записываем транзакцию вывода
    INSERT INTO nodeon_transactions (user_id, type, amount_ndn, stars_amount, description)
    VALUES (p_user_id, 'stars_withdrawal', -p_ndn_amount, -v_stars_amount, 'Вывод NDN в Stars (включая комиссию)');

    -- Записываем транзакцию комиссии (если есть разработчик)
    IF v_developer_id IS NOT NULL THEN
        UPDATE nodeon_users
        SET balance_ndn = balance_ndn + v_fee_amount_ndn
        WHERE telegram_id = v_developer_id;

        INSERT INTO nodeon_transactions (user_id, type, amount_ndn, description)
        VALUES ((SELECT id FROM nodeon_users WHERE telegram_id = v_developer_id), 'stars_withdrawal_fee', v_fee_amount_ndn, 'Комиссия за вывод NDN в Stars');
    END IF;

    RETURN '{"status": "success", "message": "Вывод NDN в Stars обработан", "stars_amount": ' || v_stars_amount || ', "fee": ' || v_fee_amount_ndn || '}'::JSON;
END;
$$ LANGUAGE plpgsql;

-- 5. Инициализация конфигурации Stars
INSERT INTO nodeon_stars_config (
    stars_to_ndn_rate, 
    min_stars_purchase, 
    max_stars_purchase, 
    stars_purchase_fee_percent, 
    stars_withdrawal_fee_percent, 
    developer_telegram_id
)
VALUES (1.0, 10.0, 10000.0, 0.0, 5.0, 207940967)
ON CONFLICT (id) DO UPDATE SET
    stars_to_ndn_rate = EXCLUDED.stars_to_ndn_rate,
    min_stars_purchase = EXCLUDED.min_stars_purchase,
    max_stars_purchase = EXCLUDED.max_stars_purchase,
    stars_purchase_fee_percent = EXCLUDED.stars_purchase_fee_percent,
    stars_withdrawal_fee_percent = EXCLUDED.stars_withdrawal_fee_percent,
    developer_telegram_id = EXCLUDED.developer_telegram_id,
    updated_at = NOW();

-- 6. Обновляем существующих пользователей (добавляем колонки Stars)
UPDATE nodeon_users 
SET 
    balance_stars = 0.0,
    total_stars_earned = 0.0,
    total_stars_spent = 0.0
WHERE balance_stars IS NULL;

-- 7. Создаем индексы для оптимизации
CREATE INDEX IF NOT EXISTS idx_stars_payments_user_id ON nodeon_stars_payments(user_id);
CREATE INDEX IF NOT EXISTS idx_stars_payments_payment_id ON nodeon_stars_payments(payment_id);
CREATE INDEX IF NOT EXISTS idx_stars_payments_status ON nodeon_stars_payments(status);
CREATE INDEX IF NOT EXISTS idx_users_balance_stars ON nodeon_users(balance_stars);

-- 8. Добавляем колонку stars_amount в транзакции (если не существует)
ALTER TABLE nodeon_transactions 
ADD COLUMN IF NOT EXISTS stars_amount DECIMAL(10,2) DEFAULT 0.0;

-- 9. Обновляем существующие транзакции
UPDATE nodeon_transactions 
SET stars_amount = 0.0 
WHERE stars_amount IS NULL;

-- 10. Создаем представление для статистики Stars
CREATE OR REPLACE VIEW stars_statistics AS
SELECT 
    u.id,
    u.first_name,
    u.username,
    u.balance_stars,
    u.total_stars_earned,
    u.total_stars_spent,
    COUNT(sp.id) as total_purchases,
    COALESCE(SUM(sp.stars_amount), 0) as total_purchased_stars,
    COALESCE(SUM(sp.ndn_amount), 0) as total_purchased_ndn
FROM nodeon_users u
LEFT JOIN nodeon_stars_payments sp ON u.id = sp.user_id AND sp.status = 'completed'
GROUP BY u.id, u.first_name, u.username, u.balance_stars, u.total_stars_earned, u.total_stars_spent;

-- Готово! Stars поддержка добавлена
SELECT 'Stars support added successfully!' as message;