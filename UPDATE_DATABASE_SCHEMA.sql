-- Обновление схемы базы данных для улучшенного отслеживания рефералов
-- Выполните этот скрипт в Supabase SQL Editor

-- 1. Добавляем индексы для лучшей производительности
CREATE INDEX IF NOT EXISTS idx_nodeon_users_inviter_id ON nodeon_users(inviter_id);
CREATE INDEX IF NOT EXISTS idx_nodeon_users_created_at ON nodeon_users(created_at);

-- 2. Добавляем поле для отслеживания реферальной цепочки
ALTER TABLE nodeon_users ADD COLUMN IF NOT EXISTS referral_path TEXT;
ALTER TABLE nodeon_users ADD COLUMN IF NOT EXISTS referral_level INTEGER DEFAULT 0;
ALTER TABLE nodeon_users ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT TRUE;

-- 3. Создаем функцию для обновления реферальной цепочки
CREATE OR REPLACE FUNCTION update_referral_path()
RETURNS TRIGGER AS $$
DECLARE
    parent_path TEXT;
    parent_level INTEGER;
BEGIN
    -- Если есть пригласивший
    IF NEW.inviter_id IS NOT NULL THEN
        -- Получаем путь и уровень родителя
        SELECT referral_path, referral_level INTO parent_path, parent_level
        FROM nodeon_users 
        WHERE id = NEW.inviter_id;
        
        -- Обновляем путь и уровень
        NEW.referral_path = COALESCE(parent_path || ',', '') || NEW.id::TEXT;
        NEW.referral_level = COALESCE(parent_level, 0) + 1;
    ELSE
        -- Если нет пригласившего, это корневой пользователь
        NEW.referral_path = NEW.id::TEXT;
        NEW.referral_level = 0;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 4. Создаем триггер для автоматического обновления пути
DROP TRIGGER IF EXISTS trigger_update_referral_path ON nodeon_users;
CREATE TRIGGER trigger_update_referral_path
    BEFORE INSERT OR UPDATE ON nodeon_users
    FOR EACH ROW
    EXECUTE FUNCTION update_referral_path();

-- 5. Обновляем существующих пользователей
UPDATE nodeon_users 
SET referral_path = id::TEXT, 
    referral_level = 0,
    is_active = TRUE
WHERE inviter_id IS NULL;

-- 6. Создаем функцию для получения всех рефералов пользователя
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
        -- Находим корневого пользователя
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
        
        -- Находим всех рефералов
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
    WHERE rt.level > 0  -- Исключаем самого пользователя
    ORDER BY rt.level, rt.created_at;
END;
$$ LANGUAGE plpgsql;

-- 7. Создаем функцию для проверки валидности реферальной ссылки
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
    -- Пытаемся извлечь user_id из токена
    BEGIN
        user_id_from_token := (referral_token ~ '^ref_(\d+)$')::INTEGER;
        IF user_id_from_token IS NULL THEN
            user_id_from_token := (referral_token ~ '^(\d+)$')::INTEGER;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            user_id_from_token := NULL;
    END;
    
    -- Если не удалось извлечь ID, возвращаем невалидный результат
    IF user_id_from_token IS NULL THEN
        RETURN QUERY SELECT FALSE, NULL::INTEGER, NULL::BIGINT, NULL::VARCHAR(255), NULL::BOOLEAN;
        RETURN;
    END IF;
    
    -- Проверяем, существует ли пользователь и имеет ли Pro статус
    RETURN QUERY
    SELECT 
        u.is_pro AND u.is_active,
        u.id,
        u.telegram_id,
        u.first_name,
        u.is_pro
    FROM nodeon_users u
    WHERE u.id = user_id_from_token;
    
    -- Если пользователь не найден
    IF NOT FOUND THEN
        RETURN QUERY SELECT FALSE, NULL::INTEGER, NULL::BIGINT, NULL::VARCHAR(255), NULL::BOOLEAN;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- 8. Обновляем существующих пользователей с правильными путями
UPDATE nodeon_users 
SET referral_path = id::TEXT,
    referral_level = 0
WHERE referral_path IS NULL;

-- 9. Проверяем результат
SELECT 
    id,
    telegram_id,
    first_name,
    referral_path,
    referral_level,
    inviter_id,
    is_pro,
    is_active
FROM nodeon_users
ORDER BY created_at;
