-- Скрипт для исправления реферальных ссылок у PRO пользователей
-- Преобразует "ref_5" в "https://t.me/pro_stars_bot?startapp=ref_5"

-- 1. Показать текущие реферальные ссылки PRO пользователей
SELECT 
    id,
    telegram_id,
    first_name,
    username,
    is_pro,
    referral_link,
    CASE 
        WHEN referral_link LIKE 'ref_%' AND referral_link NOT LIKE 'https://%' 
        THEN CONCAT('https://t.me/pro_stars_bot?startapp=', referral_link)
        ELSE referral_link
    END as new_referral_link
FROM nodeon_users
WHERE is_pro = true;

-- 2. Обновить реферальные ссылки для PRO пользователей
-- Заменяем короткие ссылки "ref_X" на полные "https://t.me/pro_stars_bot?startapp=ref_X"
UPDATE nodeon_users
SET 
    referral_link = CONCAT('https://t.me/pro_stars_bot?startapp=', referral_link),
    updated_at = NOW()
WHERE 
    is_pro = true 
    AND referral_link LIKE 'ref_%' 
    AND referral_link NOT LIKE 'https://%';

-- 3. Проверить результат
SELECT 
    id,
    telegram_id,
    first_name,
    username,
    is_pro,
    referral_link
FROM nodeon_users
WHERE is_pro = true
ORDER BY id;

-- 4. Подсчитать сколько ссылок было обновлено
SELECT 
    COUNT(*) as updated_count
FROM nodeon_users
WHERE 
    is_pro = true 
    AND referral_link LIKE 'https://t.me/%';
