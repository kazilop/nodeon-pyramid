-- Создание серверного кошелька NodeOn Crypto
-- Серверный кошелек содержит 1 млрд NDN для продажи за Telegram Stars

-- Создаем таблицу серверного кошелька
CREATE TABLE IF NOT EXISTS nodeon_server_wallet (
    id SERIAL PRIMARY KEY,
    wallet_name VARCHAR(100) NOT NULL DEFAULT 'NodeOn Server Wallet',
    balance_ndn DECIMAL(20,2) NOT NULL DEFAULT 0,
    total_sold_ndn DECIMAL(20,2) NOT NULL DEFAULT 0,
    total_earned_stars DECIMAL(20,2) NOT NULL DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Создаем таблицу для отслеживания продаж
CREATE TABLE IF NOT EXISTS nodeon_sales (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES nodeon_users(id),
    amount_ndn DECIMAL(20,2) NOT NULL,
    amount_stars DECIMAL(20,2) NOT NULL,
    telegram_payment_charge_id VARCHAR(255) UNIQUE,
    status VARCHAR(50) DEFAULT 'pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    processed_at TIMESTAMP WITH TIME ZONE
);

-- Создаем индекс для быстрого поиска по payment_charge_id
CREATE INDEX IF NOT EXISTS idx_sales_payment_charge_id ON nodeon_sales(telegram_payment_charge_id);

-- Создаем индекс для поиска по пользователю
CREATE INDEX IF NOT EXISTS idx_sales_user_id ON nodeon_sales(user_id);

-- Инициализируем серверный кошелек с 1 млрд NDN
INSERT INTO nodeon_server_wallet (wallet_name, balance_ndn, total_sold_ndn, total_earned_stars)
VALUES ('NodeOn Server Wallet', 1000000000.00, 0.00, 0.00)
ON CONFLICT DO NOTHING;

-- Создаем функцию для продажи NDN с серверного кошелька
CREATE OR REPLACE FUNCTION sell_ndn_from_wallet(
    p_user_id INTEGER,
    p_amount_ndn DECIMAL(20,2),
    p_amount_stars DECIMAL(20,2),
    p_telegram_payment_charge_id VARCHAR(255)
) RETURNS JSON AS $$
DECLARE
    v_wallet_balance DECIMAL(20,2);
    v_user_balance DECIMAL(20,2);
    v_new_wallet_balance DECIMAL(20,2);
    v_new_user_balance DECIMAL(20,2);
    v_sale_id INTEGER;
BEGIN
    -- Проверяем баланс серверного кошелька
    SELECT balance_ndn INTO v_wallet_balance 
    FROM nodeon_server_wallet 
    WHERE id = 1;
    
    -- Проверяем, достаточно ли NDN в кошельке
    IF v_wallet_balance < p_amount_ndn THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Недостаточно NDN в серверном кошельке'
        );
    END IF;
    
    -- Получаем текущий баланс пользователя
    SELECT balance_ndn INTO v_user_balance 
    FROM nodeon_users 
    WHERE id = p_user_id;
    
    -- Вычисляем новые балансы
    v_new_wallet_balance := v_wallet_balance - p_amount_ndn;
    v_new_user_balance := COALESCE(v_user_balance, 0) + p_amount_ndn;
    
    -- Создаем запись о продаже
    INSERT INTO nodeon_sales (
        user_id, 
        amount_ndn, 
        amount_stars, 
        telegram_payment_charge_id,
        status
    ) VALUES (
        p_user_id, 
        p_amount_ndn, 
        p_amount_stars, 
        p_telegram_payment_charge_id,
        'completed'
    ) RETURNING id INTO v_sale_id;
    
    -- Обновляем баланс серверного кошелька
    UPDATE nodeon_server_wallet 
    SET 
        balance_ndn = v_new_wallet_balance,
        total_sold_ndn = total_sold_ndn + p_amount_ndn,
        total_earned_stars = total_earned_stars + p_amount_stars,
        updated_at = NOW()
    WHERE id = 1;
    
    -- Обновляем баланс пользователя
    UPDATE nodeon_users 
    SET 
        balance_ndn = v_new_user_balance,
        updated_at = NOW()
    WHERE id = p_user_id;
    
    -- Создаем транзакцию для пользователя
    INSERT INTO nodeon_transactions (
        user_id,
        type,
        amount_ndn,
        amount_stars,
        description,
        telegram_payment_charge_id
    ) VALUES (
        p_user_id,
        'buy_ndn',
        p_amount_ndn,
        p_amount_stars,
        'Покупка ' || p_amount_ndn || ' NDN за ' || p_amount_stars || ' Telegram Stars',
        p_telegram_payment_charge_id
    );
    
    RETURN json_build_object(
        'success', true,
        'message', 'NDN успешно переведены с серверного кошелька',
        'sale_id', v_sale_id,
        'new_user_balance', v_new_user_balance,
        'new_wallet_balance', v_new_wallet_balance
    );
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'success', false,
            'message', 'Ошибка при продаже NDN: ' || SQLERRM
        );
END;
$$ LANGUAGE plpgsql;

-- Создаем функцию для получения статистики кошелька
CREATE OR REPLACE FUNCTION get_wallet_stats() RETURNS JSON AS $$
DECLARE
    v_wallet RECORD;
    v_total_sales INTEGER;
    v_today_sales DECIMAL(20,2);
BEGIN
    -- Получаем данные кошелька
    SELECT * INTO v_wallet FROM nodeon_server_wallet WHERE id = 1;
    
    -- Считаем общее количество продаж
    SELECT COUNT(*) INTO v_total_sales FROM nodeon_sales WHERE status = 'completed';
    
    -- Считаем продажи за сегодня
    SELECT COALESCE(SUM(amount_ndn), 0) INTO v_today_sales 
    FROM nodeon_sales 
    WHERE status = 'completed' AND DATE(created_at) = CURRENT_DATE;
    
    RETURN json_build_object(
        'wallet_balance', v_wallet.balance_ndn,
        'total_sold', v_wallet.total_sold_ndn,
        'total_earned_stars', v_wallet.total_earned_stars,
        'total_sales_count', v_total_sales,
        'today_sales', v_today_sales,
        'last_updated', v_wallet.updated_at
    );
END;
$$ LANGUAGE plpgsql;

-- Создаем функцию для проверки дублирования платежей
CREATE OR REPLACE FUNCTION check_payment_duplicate(
    p_telegram_payment_charge_id VARCHAR(255)
) RETURNS BOOLEAN AS $$
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count 
    FROM nodeon_sales 
    WHERE telegram_payment_charge_id = p_telegram_payment_charge_id;
    
    RETURN v_count > 0;
END;
$$ LANGUAGE plpgsql;

-- Добавляем комментарии к таблицам
COMMENT ON TABLE nodeon_server_wallet IS 'Серверный кошелек NodeOn с 1 млрд NDN для продажи за Telegram Stars';
COMMENT ON TABLE nodeon_sales IS 'Записи о продажах NDN за Telegram Stars';
COMMENT ON COLUMN nodeon_server_wallet.balance_ndn IS 'Текущий баланс NDN в серверном кошельке';
COMMENT ON COLUMN nodeon_server_wallet.total_sold_ndn IS 'Общее количество проданных NDN';
COMMENT ON COLUMN nodeon_server_wallet.total_earned_stars IS 'Общее количество заработанных Telegram Stars';