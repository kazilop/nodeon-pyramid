-- NodeOn Pyramid Database Schema
-- Supabase PostgreSQL

-- Создание таблицы пользователей
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    telegram_id INTEGER UNIQUE NOT NULL,
    username VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    balance_ndn DECIMAL(10,2) DEFAULT 0,
    is_pro BOOLEAN DEFAULT FALSE,
    referral_link VARCHAR(255) UNIQUE,
    inviter_id INTEGER REFERENCES users(id),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Создание таблицы транзакций
CREATE TABLE IF NOT EXISTS transactions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id),
    type VARCHAR(50) NOT NULL,
    amount_ndn DECIMAL(10,2) NOT NULL,
    amount_stars DECIMAL(10,2),
    description TEXT,
    referral_level INTEGER,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Создание таблицы статистики рефералов
CREATE TABLE IF NOT EXISTS referral_stats (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id),
    level INTEGER NOT NULL,
    total_referrals INTEGER DEFAULT 0,
    total_earnings DECIMAL(10,2) DEFAULT 0,
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Создание таблицы заявок на вывод
CREATE TABLE IF NOT EXISTS payment_requests (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id),
    amount_ndn DECIMAL(10,2) NOT NULL,
    amount_stars DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT NOW(),
    processed_at TIMESTAMP
);

-- Создание индексов для производительности
CREATE INDEX IF NOT EXISTS idx_users_telegram_id ON users(telegram_id);
CREATE INDEX IF NOT EXISTS idx_users_referral_link ON users(referral_link);
CREATE INDEX IF NOT EXISTS idx_users_inviter_id ON users(inviter_id);
CREATE INDEX IF NOT EXISTS idx_transactions_user_id ON transactions(user_id);
CREATE INDEX IF NOT EXISTS idx_transactions_created_at ON transactions(created_at);
CREATE INDEX IF NOT EXISTS idx_transactions_type ON transactions(type);
CREATE INDEX IF NOT EXISTS idx_referral_stats_user_id ON referral_stats(user_id);
CREATE INDEX IF NOT EXISTS idx_referral_stats_level ON referral_stats(level);
CREATE INDEX IF NOT EXISTS idx_payment_requests_user_id ON payment_requests(user_id);
CREATE INDEX IF NOT EXISTS idx_payment_requests_status ON payment_requests(status);

-- Создание функции для обновления updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Создание триггеров для автоматического обновления updated_at
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_referral_stats_updated_at BEFORE UPDATE ON referral_stats
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Включение Row Level Security (RLS)
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE referral_stats ENABLE ROW LEVEL SECURITY;
ALTER TABLE payment_requests ENABLE ROW LEVEL SECURITY;

-- Создание политик безопасности
-- Пользователи могут видеть только свои данные
CREATE POLICY "Users can view own data" ON users
    FOR SELECT USING (true);

CREATE POLICY "Users can view own transactions" ON transactions
    FOR SELECT USING (true);

CREATE POLICY "Users can view own referral stats" ON referral_stats
    FOR SELECT USING (true);

CREATE POLICY "Users can view own payment requests" ON payment_requests
    FOR SELECT USING (true);

-- Пользователи могут обновлять только свои данные
CREATE POLICY "Users can update own data" ON users
    FOR UPDATE USING (true);

-- Вставка данных разрешена для всех (регистрация)
CREATE POLICY "Users can insert data" ON users
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Transactions can be inserted" ON transactions
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Referral stats can be inserted" ON referral_stats
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Payment requests can be inserted" ON payment_requests
    FOR INSERT WITH CHECK (true);

-- Создание представления для статистики
CREATE OR REPLACE VIEW user_stats AS
SELECT 
    u.id,
    u.telegram_id,
    u.username,
    u.first_name,
    u.last_name,
    u.balance_ndn,
    u.is_pro,
    u.referral_link,
    u.created_at,
    COUNT(r.id) as total_referrals,
    COUNT(CASE WHEN r.is_pro = true THEN 1 END) as pro_referrals,
    COALESCE(SUM(CASE WHEN t.type = 'referral_reward' THEN t.amount_ndn ELSE 0 END), 0) as total_earnings,
    COALESCE(SUM(CASE WHEN t.type = 'pro_purchase' AND t.amount_ndn < 0 THEN ABS(t.amount_ndn) ELSE 0 END), 0) as total_spent
FROM users u
LEFT JOIN users r ON r.inviter_id = u.id
LEFT JOIN transactions t ON t.user_id = u.id
GROUP BY u.id, u.telegram_id, u.username, u.first_name, u.last_name, u.balance_ndn, u.is_pro, u.referral_link, u.created_at;

-- Создание функции для распределения реферальных наград
CREATE OR REPLACE FUNCTION distribute_referral_rewards(
    p_user_id INTEGER,
    p_amount DECIMAL(10,2)
) RETURNS VOID AS $$
DECLARE
    current_user_id INTEGER;
    inviter_id INTEGER;
    level INTEGER := 1;
    reward DECIMAL(10,2);
    developer_fee DECIMAL(10,2) := 200;
    level_1_reward DECIMAL(10,2) := 200;
    level_2_7_reward DECIMAL(10,2) := 150;
BEGIN
    -- Комиссия разработчику
    INSERT INTO transactions (user_id, type, amount_ndn, description, referral_level)
    VALUES (207940967, 'developer_fee', developer_fee, 'Комиссия разработчика', 0);
    
    -- Получаем текущего пользователя
    SELECT id, inviter_id INTO current_user_id, inviter_id
    FROM users WHERE id = p_user_id;
    
    -- Распределяем награды по уровням
    WHILE inviter_id IS NOT NULL AND level <= 7 LOOP
        -- Определяем размер награды
        IF level = 1 THEN
            reward := level_1_reward;
        ELSE
            reward := level_2_7_reward;
        END IF;
        
        -- Начисляем награду
        UPDATE users SET balance_ndn = balance_ndn + reward WHERE id = inviter_id;
        
        -- Создаем транзакцию
        INSERT INTO transactions (user_id, type, amount_ndn, description, referral_level)
        VALUES (inviter_id, 'referral_reward', reward, 
                'Реферальная награда за уровень ' || level, level);
        
        -- Обновляем статистику
        INSERT INTO referral_stats (user_id, level, total_referrals, total_earnings)
        VALUES (inviter_id, level, 1, reward)
        ON CONFLICT (user_id, level) 
        DO UPDATE SET 
            total_referrals = referral_stats.total_referrals + 1,
            total_earnings = referral_stats.total_earnings + reward;
        
        -- Переходим к следующему уровню
        SELECT inviter_id INTO inviter_id FROM users WHERE id = inviter_id;
        level := level + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Создание функции для генерации реферальной ссылки
CREATE OR REPLACE FUNCTION generate_referral_link()
RETURNS TEXT AS $$
DECLARE
    link TEXT;
    exists_count INTEGER;
BEGIN
    LOOP
        -- Генерируем случайную строку
        link := encode(gen_random_bytes(8), 'base64');
        link := replace(replace(link, '+', ''), '/', '');
        link := substring(link from 1 for 12);
        
        -- Проверяем уникальность
        SELECT COUNT(*) INTO exists_count FROM users WHERE referral_link = link;
        
        EXIT WHEN exists_count = 0;
    END LOOP;
    
    RETURN link;
END;
$$ LANGUAGE plpgsql;

-- Вставка тестовых данных (опционально)
-- INSERT INTO users (telegram_id, username, first_name, balance_ndn, is_pro, referral_link)
-- VALUES 
--     (207940967, 'developer', 'Developer', 10000, true, 'dev123'),
--     (123456789, 'testuser', 'Test User', 1000, true, 'test123');

COMMIT;
