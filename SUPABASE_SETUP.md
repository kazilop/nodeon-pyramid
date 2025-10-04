# 🗄️ Настройка Supabase для NodeOn Pyramid

## 1. Получение пароля от базы данных

### В Supabase Dashboard:
1. Откройте ваш проект: https://ahxwpzgltlzlvrtrbanm.supabase.co
2. Перейдите в **Settings** → **Database**
3. Найдите секцию **Connection string**
4. Скопируйте пароль из connection string

### Или создайте новый пароль:
1. В **Settings** → **Database**
2. Найдите **Database password**
3. Нажмите **Reset database password**
4. Сохраните новый пароль

## 2. Обновление .env файла

Замените `[PASSWORD]` в `DATABASE_URL` на реальный пароль:

```env
DATABASE_URL=postgresql://postgres:[REAL_PASSWORD]@ahxwpzgltlzlvrtrbanm.supabase.co:5432/postgres
```

## 3. Инициализация базы данных

### Автоматическая инициализация:
```bash
# Установите зависимости
pip install -r scripts/requirements.txt
pip install sqlalchemy psycopg2-binary

# Инициализируйте базу данных
python scripts/init_database.py
```

### Ручная инициализация:
1. Откройте **SQL Editor** в Supabase Dashboard
2. Выполните SQL скрипт из `database_schema.sql`

## 4. Проверка подключения

### Тест подключения:
```bash
# Запустите скрипт проверки
python scripts/get_supabase_connection.py
```

### Проверка в Supabase Dashboard:
1. Перейдите в **Table Editor**
2. Должны появиться таблицы:
   - `users`
   - `transactions`
   - `referral_stats`
   - `payment_requests`

## 5. Настройка переменных для Vercel

Добавьте в Vercel Environment Variables:

```
DATABASE_URL=postgresql://postgres:[REAL_PASSWORD]@ahxwpzgltlzlvrtrbanm.supabase.co:5432/postgres
SUPABASE_URL=https://ahxwpzgltlzlvrtrbanm.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoeHdwemdsdGx6bHZydHJiYW5tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1MDMxNDksImV4cCI6MjA3NTA3OTE0OX0.h4sMVhVwvRUiHgbevDgv9W1G2S__uDWPUSCiXdrEy4E
```

## 6. Схема базы данных

### Таблица `users`:
```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    telegram_id INTEGER UNIQUE NOT NULL,
    username VARCHAR,
    first_name VARCHAR,
    last_name VARCHAR,
    balance_ndn DECIMAL(10,2) DEFAULT 0,
    is_pro BOOLEAN DEFAULT FALSE,
    referral_link VARCHAR UNIQUE,
    inviter_id INTEGER REFERENCES users(id),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
```

### Таблица `transactions`:
```sql
CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id),
    type VARCHAR NOT NULL,
    amount_ndn DECIMAL(10,2) NOT NULL,
    amount_stars DECIMAL(10,2),
    description TEXT,
    referral_level INTEGER,
    created_at TIMESTAMP DEFAULT NOW()
);
```

### Таблица `referral_stats`:
```sql
CREATE TABLE referral_stats (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id),
    level INTEGER NOT NULL,
    total_referrals INTEGER DEFAULT 0,
    total_earnings DECIMAL(10,2) DEFAULT 0,
    updated_at TIMESTAMP DEFAULT NOW()
);
```

### Таблица `payment_requests`:
```sql
CREATE TABLE payment_requests (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id),
    amount_ndn DECIMAL(10,2) NOT NULL,
    amount_stars DECIMAL(10,2) NOT NULL,
    status VARCHAR DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT NOW(),
    processed_at TIMESTAMP
);
```

## 7. Индексы для производительности

```sql
-- Индексы для быстрого поиска
CREATE INDEX idx_users_telegram_id ON users(telegram_id);
CREATE INDEX idx_users_referral_link ON users(referral_link);
CREATE INDEX idx_transactions_user_id ON transactions(user_id);
CREATE INDEX idx_transactions_created_at ON transactions(created_at);
CREATE INDEX idx_referral_stats_user_id ON referral_stats(user_id);
```

## 8. Row Level Security (RLS)

### Включение RLS:
```sql
-- Включить RLS для всех таблиц
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE referral_stats ENABLE ROW LEVEL SECURITY;
ALTER TABLE payment_requests ENABLE ROW LEVEL SECURITY;
```

### Политики безопасности:
```sql
-- Пользователи могут видеть только свои данные
CREATE POLICY "Users can view own data" ON users
    FOR SELECT USING (telegram_id = current_setting('app.current_user_id')::integer);

CREATE POLICY "Users can view own transactions" ON transactions
    FOR SELECT USING (user_id = current_setting('app.current_user_id')::integer);
```

## 9. Мониторинг и аналитика

### Supabase Dashboard:
- **Table Editor** - просмотр данных
- **SQL Editor** - выполнение запросов
- **Logs** - мониторинг запросов
- **Metrics** - статистика использования

### Полезные запросы:
```sql
-- Количество пользователей
SELECT COUNT(*) FROM users;

-- Количество Pro пользователей
SELECT COUNT(*) FROM users WHERE is_pro = true;

-- Общий объем транзакций
SELECT SUM(amount_ndn) FROM transactions WHERE amount_ndn > 0;

-- Топ рефералов
SELECT u.username, COUNT(r.id) as referrals_count
FROM users u
LEFT JOIN users r ON r.inviter_id = u.id
WHERE u.is_pro = true
GROUP BY u.id, u.username
ORDER BY referrals_count DESC
LIMIT 10;
```

## 10. Troubleshooting

### Ошибка подключения:
- Проверьте пароль в DATABASE_URL
- Убедитесь, что проект активен в Supabase
- Проверьте firewall настройки

### Ошибка создания таблиц:
- Проверьте права доступа
- Убедитесь, что RLS не блокирует создание
- Проверьте логи в Supabase Dashboard

### Медленные запросы:
- Добавьте индексы
- Оптимизируйте запросы
- Используйте EXPLAIN для анализа

## 📞 Поддержка

Если возникли проблемы:
1. Проверьте логи в Supabase Dashboard
2. Обратитесь в поддержку Supabase
3. Создайте issue в GitHub репозитории

---

**База данных готова! 🚀**
