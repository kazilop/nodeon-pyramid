-- Очистка базы данных от неправильных пользователей

-- 1. Удаляем пользователей с неправильными данными
DELETE FROM nodeon_users 
WHERE 
    username = 'developer' OR 
    username = 'без_username' OR 
    username IS NULL OR 
    username = '' OR
    first_name = 'Пользователь' OR
    first_name IS NULL OR
    first_name = '';

-- 2. Удаляем связанные данные
DELETE FROM nodeon_transactions 
WHERE user_id NOT IN (SELECT id FROM nodeon_users);

DELETE FROM nodeon_referral_stats 
WHERE user_id NOT IN (SELECT id FROM nodeon_users);

DELETE FROM nodeon_user_achievements 
WHERE user_id NOT IN (SELECT id FROM nodeon_users);

DELETE FROM nodeon_shops 
WHERE owner_id NOT IN (SELECT id FROM nodeon_users);

DELETE FROM nodeon_shop_items 
WHERE shop_id NOT IN (SELECT id FROM nodeon_shops);

DELETE FROM nodeon_orders 
WHERE buyer_id NOT IN (SELECT id FROM nodeon_users);

DELETE FROM nodeon_item_reviews 
WHERE buyer_id NOT IN (SELECT id FROM nodeon_users);

-- 3. Сбрасываем автоинкремент для чистоты
-- (Это не обязательно, но помогает для чистоты)

-- 4. Проверяем результат
SELECT 
    id, 
    telegram_id, 
    username, 
    first_name, 
    last_name, 
    balance_ndn,
    created_at
FROM nodeon_users 
ORDER BY created_at DESC;

-- 5. Проверяем количество записей
SELECT 
    'users' as table_name, 
    COUNT(*) as count 
FROM nodeon_users
UNION ALL
SELECT 
    'transactions' as table_name, 
    COUNT(*) as count 
FROM nodeon_transactions
UNION ALL
SELECT 
    'referral_stats' as table_name, 
    COUNT(*) as count 
FROM nodeon_referral_stats
UNION ALL
SELECT 
    'user_achievements' as table_name, 
    COUNT(*) as count 
FROM nodeon_user_achievements
UNION ALL
SELECT 
    'shops' as table_name, 
    COUNT(*) as count 
FROM nodeon_shops
UNION ALL
SELECT 
    'shop_items' as table_name, 
    COUNT(*) as count 
FROM nodeon_shop_items;

