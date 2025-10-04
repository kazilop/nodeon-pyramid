-- Создание серверного кошелька для NodeOn Pyramid
-- Выполните этот скрипт в Supabase SQL Editor

-- 1. Создаем таблицу серверного кошелька
CREATE TABLE IF NOT EXISTS nodeon_server_wallet (
    id SERIAL PRIMARY KEY,
    wallet_name VARCHAR(100) DEFAULT 'main_wallet' NOT NULL,
    balance_ndn DECIMAL(18,2) DEFAULT 0.0 NOT NULL,
    total_ndn_issued DECIMAL(18,2) DEFAULT 0.0 NOT NULL,
    total_ndn_received DECIMAL(18,2) DEFAULT 0.0 NOT NULL,
    is_active BOOLEAN DEFAULT TRUE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Создаем таблицу транзакций кошелька
CREATE TABLE IF NOT EXISTS nodeon_wallet_transactions (
    id SERIAL PRIMARY KEY,
    wallet_id INTEGER NOT NULL REFERENCES nodeon_server_wallet(id) ON DELETE CASCADE,
    user_id INTEGER REFERENCES nodeon_users(id) ON DELETE SET NULL,
    type VARCHAR(50) NOT NULL, -- 'stars_purchase', 'ndn_issue', 'ndn_receive', 'stars_withdrawal'
    stars_amount DECIMAL(10,2) DEFAULT 0.0,
    ndn_amount DECIMAL(18,2) NOT NULL,
    balance_before DECIMAL(18,2) NOT NULL,
    balance_after DECIMAL(18,2) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Добавляем колонки в таблицу Stars платежей
ALTER TABLE nodeon_stars_payments 
ADD COLUMN IF NOT EXISTS wallet_transaction_id INTEGER REFERENCES nodeon_wallet_transactions(id),
ADD COLUMN IF NOT EXISTS server_ndn_balance_before DECIMAL(18,2),
ADD COLUMN IF NOT EXISTS server_ndn_balance_after DECIMAL(18,2);

-- 4. Создаем функции для работы с серверным кошельком
CREATE OR REPLACE FUNCTION get_server_wallet_balance()
RETURNS JSON AS $$
DECLARE
    wallet_record RECORD;
BEGIN
    SELECT * INTO wallet_record FROM nodeon_server_wallet WHERE is_active = TRUE LIMIT 1;
    
    IF wallet_record IS NULL THEN
        RETURN '{"error": "Server wallet not found"}'::JSON;
    END IF;
    
    RETURN json_build_object(
        'success', true,
        'wallet', json_build_object(
            'id', wallet_record.id,
            'wallet_name', wallet_record.wallet_name,
            'balance_ndn', wallet_record.balance_ndn,
            'total_ndn_issued', wallet_record.total_ndn_issued,
            'total_ndn_received', wallet_record.total_ndn_received,
            'available_ndn', wallet_record.balance_ndn,
            'created_at', wallet_record.created_at,
            'updated_at', wallet_record.updated_at
        )
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION process_stars_purchase(
    p_user_id INTEGER,
    p_stars_amount DECIMAL(10,2),
    p_ndn_amount DECIMAL(18,2)
)
RETURNS JSON AS $$
DECLARE
    v_wallet_id INTEGER;
    v_wallet_balance DECIMAL(18,2);
    v_new_balance DECIMAL(18,2);
    v_user_balance DECIMAL(18,2);
    v_new_user_balance DECIMAL(18,2);
    v_transaction_id INTEGER;
BEGIN
    -- Получаем ID и баланс активного кошелька
    SELECT id, balance_ndn INTO v_wallet_id, v_wallet_balance 
    FROM nodeon_server_wallet WHERE is_active = TRUE LIMIT 1;
    
    IF v_wallet_id IS NULL THEN
        RETURN '{"success": false, "error": "Server wallet not found"}'::JSON;
    END IF;
    
    IF v_wallet_balance < p_ndn_amount THEN
        RETURN '{"success": false, "error": "Insufficient NDN in server wallet", "available": ' || v_wallet_balance || '}'::JSON;
    END IF;
    
    -- Получаем текущий баланс пользователя
    SELECT balance_ndn INTO v_user_balance FROM nodeon_users WHERE id = p_user_id;
    IF v_user_balance IS NULL THEN
        RETURN '{"success": false, "error": "User not found"}'::JSON;
    END IF;
    
    -- Обновляем баланс кошелька
    v_new_balance := v_wallet_balance - p_ndn_amount;
    UPDATE nodeon_server_wallet 
    SET 
        balance_ndn = v_new_balance,
        total_ndn_issued = total_ndn_issued + p_ndn_amount,
        updated_at = NOW()
    WHERE id = v_wallet_id;
    
    -- Обновляем баланс пользователя
    v_new_user_balance := v_user_balance + p_ndn_amount;
    UPDATE nodeon_users 
    SET balance_ndn = v_new_user_balance 
    WHERE id = p_user_id;
    
    -- Записываем транзакцию кошелька
    INSERT INTO nodeon_wallet_transactions (
        wallet_id, user_id, type, stars_amount, ndn_amount, 
        balance_before, balance_after, description
    ) VALUES (
        v_wallet_id, p_user_id, 'stars_purchase', p_stars_amount, p_ndn_amount,
        v_wallet_balance, v_new_balance, 
        'Покупка NDN за Stars пользователем ' || p_user_id
    ) RETURNING id INTO v_transaction_id;
    
    -- Записываем транзакцию пользователя
    INSERT INTO nodeon_transactions (
        user_id, type, amount_ndn, description
    ) VALUES (
        p_user_id, 'stars_purchase', p_ndn_amount,
        'Покупка NDN за ' || p_stars_amount || ' Stars'
    );
    
    RETURN json_build_object(
        'success', true,
        'message', 'NDN successfully purchased',
        'stars_amount', p_stars_amount,
        'ndn_amount', p_ndn_amount,
        'server_balance_before', v_wallet_balance,
        'server_balance_after', v_new_balance,
        'user_balance', v_new_user_balance,
        'transaction_id', v_transaction_id
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION process_ndn_withdrawal(
    p_user_id INTEGER,
    p_ndn_amount DECIMAL(18,2),
    p_stars_amount DECIMAL(10,2)
)
RETURNS JSON AS $$
DECLARE
    v_wallet_id INTEGER;
    v_wallet_balance DECIMAL(18,2);
    v_new_balance DECIMAL(18,2);
    v_user_balance DECIMAL(18,2);
    v_new_user_balance DECIMAL(18,2);
    v_transaction_id INTEGER;
BEGIN
    -- Получаем ID и баланс активного кошелька
    SELECT id, balance_ndn INTO v_wallet_id, v_wallet_balance 
    FROM nodeon_server_wallet WHERE is_active = TRUE LIMIT 1;
    
    IF v_wallet_id IS NULL THEN
        RETURN '{"success": false, "error": "Server wallet not found"}'::JSON;
    END IF;
    
    -- Получаем текущий баланс пользователя
    SELECT balance_ndn INTO v_user_balance FROM nodeon_users WHERE id = p_user_id;
    IF v_user_balance IS NULL THEN
        RETURN '{"success": false, "error": "User not found"}'::JSON;
    END IF;
    
    IF v_user_balance < p_ndn_amount THEN
        RETURN '{"success": false, "error": "Insufficient NDN balance"}'::JSON;
    END IF;
    
    -- Обновляем баланс кошелька (возвращаем NDN)
    v_new_balance := v_wallet_balance + p_ndn_amount;
    UPDATE nodeon_server_wallet 
    SET 
        balance_ndn = v_new_balance,
        total_ndn_received = total_ndn_received + p_ndn_amount,
        updated_at = NOW()
    WHERE id = v_wallet_id;
    
    -- Обновляем баланс пользователя
    v_new_user_balance := v_user_balance - p_ndn_amount;
    UPDATE nodeon_users 
    SET balance_ndn = v_new_user_balance 
    WHERE id = p_user_id;
    
    -- Записываем транзакцию кошелька
    INSERT INTO nodeon_wallet_transactions (
        wallet_id, user_id, type, stars_amount, ndn_amount, 
        balance_before, balance_after, description
    ) VALUES (
        v_wallet_id, p_user_id, 'stars_withdrawal', p_stars_amount, p_ndn_amount,
        v_wallet_balance, v_new_balance, 
        'Вывод NDN в Stars пользователем ' || p_user_id
    ) RETURNING id INTO v_transaction_id;
    
    -- Записываем транзакцию пользователя
    INSERT INTO nodeon_transactions (
        user_id, type, amount_ndn, description
    ) VALUES (
        p_user_id, 'stars_withdrawal', -p_ndn_amount,
        'Вывод NDN в Stars (получено ' || p_stars_amount || ' Stars)'
    );
    
    RETURN json_build_object(
        'success', true,
        'message', 'NDN successfully withdrawn',
        'ndn_amount', p_ndn_amount,
        'stars_amount', p_stars_amount,
        'server_balance_before', v_wallet_balance,
        'server_balance_after', v_new_balance,
        'user_balance', v_new_user_balance,
        'transaction_id', v_transaction_id
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_wallet_transactions(
    p_limit INTEGER DEFAULT 50,
    p_offset INTEGER DEFAULT 0
)
RETURNS JSON AS $$
DECLARE
    v_transactions JSON;
BEGIN
    SELECT json_agg(
        json_build_object(
            'id', wt.id,
            'type', wt.type,
            'user_name', COALESCE(u.first_name, 'Unknown'),
            'stars_amount', wt.stars_amount,
            'ndn_amount', wt.ndn_amount,
            'balance_before', wt.balance_before,
            'balance_after', wt.balance_after,
            'description', wt.description,
            'created_at', wt.created_at
        )
    ) INTO v_transactions
    FROM nodeon_wallet_transactions wt
    LEFT JOIN nodeon_users u ON wt.user_id = u.id
    ORDER BY wt.created_at DESC
    LIMIT p_limit OFFSET p_offset;
    
    RETURN json_build_object(
        'success', true,
        'transactions', COALESCE(v_transactions, '[]'::JSON)
    );
END;
$$ LANGUAGE plpgsql;

-- 5. Инициализируем серверный кошелек с начальным резервом
INSERT INTO nodeon_server_wallet (wallet_name, balance_ndn, total_ndn_issued, total_ndn_received)
VALUES ('main_wallet', 1000000.00, 0.00, 0.00)
ON CONFLICT (id) DO UPDATE SET
    balance_ndn = EXCLUDED.balance_ndn,
    total_ndn_issued = EXCLUDED.total_ndn_issued,
    total_ndn_received = EXCLUDED.total_ndn_received,
    updated_at = NOW();

-- 6. Создаем индексы для оптимизации
CREATE INDEX IF NOT EXISTS idx_wallet_transactions_wallet_id ON nodeon_wallet_transactions(wallet_id);
CREATE INDEX IF NOT EXISTS idx_wallet_transactions_user_id ON nodeon_wallet_transactions(user_id);
CREATE INDEX IF NOT EXISTS idx_wallet_transactions_type ON nodeon_wallet_transactions(type);
CREATE INDEX IF NOT EXISTS idx_wallet_transactions_created_at ON nodeon_wallet_transactions(created_at);

-- 7. Создаем представление для статистики кошелька
CREATE OR REPLACE VIEW wallet_statistics AS
SELECT 
    sw.id,
    sw.wallet_name,
    sw.balance_ndn,
    sw.total_ndn_issued,
    sw.total_ndn_received,
    (sw.total_ndn_issued - sw.total_ndn_received) as net_issued,
    COUNT(wt.id) as total_transactions,
    COALESCE(SUM(CASE WHEN wt.type = 'stars_purchase' THEN wt.stars_amount ELSE 0 END), 0) as total_stars_received,
    COALESCE(SUM(CASE WHEN wt.type = 'stars_withdrawal' THEN wt.stars_amount ELSE 0 END), 0) as total_stars_paid,
    (COALESCE(SUM(CASE WHEN wt.type = 'stars_purchase' THEN wt.stars_amount ELSE 0 END), 0) - 
     COALESCE(SUM(CASE WHEN wt.type = 'stars_withdrawal' THEN wt.stars_amount ELSE 0 END), 0)) as net_stars_balance
FROM nodeon_server_wallet sw
LEFT JOIN nodeon_wallet_transactions wt ON sw.id = wt.wallet_id
WHERE sw.is_active = TRUE
GROUP BY sw.id, sw.wallet_name, sw.balance_ndn, sw.total_ndn_issued, sw.total_ndn_received;

-- Готово! Серверный кошелек создан
SELECT 'Server wallet created successfully!' as message;
