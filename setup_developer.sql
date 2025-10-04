-- SQL скрипт для настройки аккаунта разработчика
-- Выполните этот скрипт в Supabase SQL Editor

-- 1. Создаем или обновляем пользователя разработчика
INSERT INTO nodeon_users (
    telegram_id, 
    username, 
    first_name, 
    last_name, 
    balance_ndn, 
    is_pro, 
    referral_link, 
    inviter_id, 
    created_at, 
    updated_at
) VALUES (
    207940967,
    'developer',
    'Разработчик',
    'NodeOn',
    10000.00,
    true,
    'https://t.me/pro_stars_bot?startapp=dev_207940967',
    NULL,
    NOW(),
    NOW()
) ON CONFLICT (telegram_id) DO UPDATE SET
    username = EXCLUDED.username,
    first_name = EXCLUDED.first_name,
    last_name = EXCLUDED.last_name,
    balance_ndn = EXCLUDED.balance_ndn,
    is_pro = EXCLUDED.is_pro,
    referral_link = EXCLUDED.referral_link,
    updated_at = NOW();

-- 2. Получаем ID пользователя
-- (Этот запрос покажет ID созданного/обновленного пользователя)
SELECT id, telegram_id, first_name, last_name, balance_ndn, is_pro, referral_link 
FROM nodeon_users 
WHERE telegram_id = 207940967;

-- 3. Создаем транзакцию для бонуса
-- (Замените :user_id на реальный ID из предыдущего запроса)
INSERT INTO nodeon_transactions (
    user_id,
    type,
    amount_ndn,
    description,
    created_at
) VALUES (
    (SELECT id FROM nodeon_users WHERE telegram_id = 207940967),
    'developer_bonus',
    10000.00,
    'Бонус разработчику - 10,000 NDN',
    NOW()
);

-- 4. Создаем статистику рефералов если её нет
INSERT INTO nodeon_referral_stats (user_id, level, total_referrals, total_earnings, updated_at)
SELECT 
    (SELECT id FROM nodeon_users WHERE telegram_id = 207940967),
    level, 
    0, 
    0, 
    NOW()
FROM generate_series(1, 7) AS level
WHERE NOT EXISTS (
    SELECT 1 FROM nodeon_referral_stats 
    WHERE user_id = (SELECT id FROM nodeon_users WHERE telegram_id = 207940967)
);

-- 5. Проверяем результат
SELECT 
    u.id,
    u.telegram_id,
    u.first_name,
    u.last_name,
    u.balance_ndn,
    u.is_pro,
    u.referral_link,
    COUNT(t.id) as transaction_count
FROM nodeon_users u
LEFT JOIN nodeon_transactions t ON u.id = t.user_id
WHERE u.telegram_id = 207940967
GROUP BY u.id, u.telegram_id, u.first_name, u.last_name, u.balance_ndn, u.is_pro, u.referral_link;
