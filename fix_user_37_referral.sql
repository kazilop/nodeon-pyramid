-- Скрипт для исправления реферальной привязки пользователя ID=37
-- Проблема: пользователь перешел по ссылке ref_5, но не привязался к ID=5

-- 1. Показать текущее состояние пользователя 37
SELECT 
    id,
    telegram_id,
    first_name,
    username,
    inviter_id,
    referral_path,
    referral_level,
    created_at
FROM nodeon_users
WHERE id = 37;

-- 2. Показать пользователя 5 (инвайтер)
SELECT 
    id,
    telegram_id,
    first_name,
    username,
    is_pro,
    referral_link
FROM nodeon_users
WHERE id = 5;

-- 3. Обновить реферальную привязку для пользователя 37
UPDATE nodeon_users
SET 
    inviter_id = 5,
    referral_path = '5,37',
    referral_level = 1,
    updated_at = NOW()
WHERE id = 37;

-- 4. Проверить результат
SELECT 
    id,
    telegram_id,
    first_name,
    username,
    inviter_id,
    referral_path,
    referral_level,
    created_at,
    updated_at
FROM nodeon_users
WHERE id = 37;

-- 5. Проверить всех рефералов пользователя 5
SELECT 
    id,
    telegram_id,
    first_name,
    username,
    inviter_id,
    referral_level,
    created_at
FROM nodeon_users
WHERE inviter_id = 5
ORDER BY created_at DESC;




