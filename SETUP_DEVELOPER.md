# 🔧 Настройка аккаунта разработчика

## Задача
Для пользователя с Telegram ID `207940967` нужно:
- ✅ Установить Pro статус
- ✅ Зачислить 10,000 NDN монет
- ✅ Создать реферальную ссылку

## 🚀 Способ 1: Через Supabase SQL Editor (Рекомендуется)

### 1. Откройте Supabase Dashboard
- Перейдите на https://supabase.com/dashboard
- Войдите в свой проект
- Перейдите в раздел "SQL Editor"

### 2. Выполните SQL скрипт
Скопируйте и выполните содержимое файла `setup_developer.sql`:

```sql
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

-- 2. Создаем транзакцию для бонуса
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

-- 3. Создаем статистику рефералов
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
```

### 3. Проверьте результат
Выполните этот запрос для проверки:

```sql
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
```

## 🐍 Способ 2: Через Python скрипт

Если у вас есть доступ к базе данных локально:

```bash
python setup_dev_simple.py
```

## 🌐 Способ 3: Через API (если API работает)

```bash
python setup_dev_via_api.py
```

## ✅ Ожидаемый результат

После выполнения любого из способов у пользователя должно быть:

- **👤 Имя**: Разработчик NodeOn
- **🆔 Telegram ID**: 207940967
- **👑 Pro статус**: ✅ Да
- **💰 Баланс NDN**: 10,000
- **🔗 Реферальная ссылка**: https://t.me/pro_stars_bot?startapp=dev_207940967
- **📝 Транзакций**: 1 (бонус разработчику)

## 🔍 Проверка через приложение

1. Откройте приложение: https://kazilop.github.io/nodeon-pyramid/
2. Войдите через Telegram с аккаунтом 207940967
3. Проверьте, что:
   - Отображается имя "Разработчик"
   - Баланс показывает 10,000 NDN
   - Есть Pro статус
   - Доступна реферальная ссылка

## 🆘 Если что-то не работает

1. **Проверьте подключение к Supabase**
2. **Убедитесь, что таблицы созданы**
3. **Проверьте права доступа к базе данных**
4. **Посмотрите логи в Supabase**

---

**Готово! Аккаунт разработчика настроен! 🎉**
