# 🚀 БЫСТРАЯ НАСТРОЙКА NODEON PYRAMID

## ✅ Текущий статус: 3/5 компонентов готовы

### ✅ Готово:
- **API** - работает на Railway
- **Frontend** - работает на GitHub Pages  
- **Авторизация** - работает через Telegram

### ⚠️ Нужно настроить:
- **База данных** - выполнить SQL скрипт
- **Рефералы** - настроить функции

---

## 🔧 БЫСТРАЯ НАСТРОЙКА (5 минут)

### 1. 📊 Настройка базы данных

**Выполните в Supabase SQL Editor:**

```sql
-- Скопируйте и выполните весь скрипт из файла SETUP_PRODUCTION_DATABASE.sql
```

**Или выполните по частям:**

1. **Создайте таблицы:**
```sql
CREATE TABLE IF NOT EXISTS nodeon_users (
    id SERIAL PRIMARY KEY,
    telegram_id BIGINT UNIQUE NOT NULL,
    username VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    balance_ndn DECIMAL(10,2) DEFAULT 0.0,
    balance_stars DECIMAL(10,2) DEFAULT 0.0,
    is_pro BOOLEAN DEFAULT FALSE,
    referral_link VARCHAR(500),
    inviter_id INTEGER REFERENCES nodeon_users(id),
    referral_level INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

2. **Добавьте конфигурацию Stars:**
```sql
INSERT INTO nodeon_stars_config (config_key, config_value, description) VALUES
('stars_to_ndn_rate', '1.0', 'Курс обмена: 1 Star = 1 NDN'),
('min_stars_purchase', '10', 'Минимальная покупка в Stars'),
('max_stars_purchase', '10000', 'Максимальная покупка в Stars')
ON CONFLICT (config_key) DO NOTHING;
```

3. **Создайте разработчика:**
```sql
INSERT INTO nodeon_users (
    telegram_id, username, first_name, last_name, 
    balance_ndn, is_pro, referral_link, is_active
) VALUES (
    207940967, 'developer', 'Разработчик NodeOn', 'Admin',
    10000.0, TRUE, 'https://t.me/pro_stars_bot?startapp=dev_207940967', TRUE
) ON CONFLICT (telegram_id) DO UPDATE SET
    balance_ndn = 10000.0,
    is_pro = TRUE;
```

### 2. 🤖 Настройка Telegram бота

1. **Создайте бота:**
   - Откройте @BotFather в Telegram
   - `/newbot` → выберите имя и username
   - Скопируйте токен

2. **Настройте Mini App:**
   - `/newapp` → выберите бота
   - URL: `https://kazilop.github.io/nodeon-pyramid/`
   - Название: `NodeOn Pyramid`

3. **Настройте webhook:**
```bash
# Добавьте токен в .env файл
echo "TELEGRAM_BOT_TOKEN=ваш_токен" >> .env

# Настройте webhook
python setup_webhook_production.py
```

### 3. 🧪 Проверка

```bash
# Проверьте систему
python check_production_system.py

# Должно показать: 6/6 компонентов работают ✅
```

---

## 🌐 URL системы

- **Frontend:** https://kazilop.github.io/nodeon-pyramid/
- **API:** https://nodeon-production.up.railway.app/api
- **Telegram бот:** @ваш_бот_username

---

## 📱 Тестирование

1. **Откройте бота в Telegram**
2. **Нажмите "Запустить приложение"**
3. **Проверьте:**
   - ✅ Имя пользователя отображается
   - ✅ Баланс NDN показывается
   - ✅ Pro статус работает
   - ✅ Реферальная ссылка генерируется
   - ✅ Покупка NDN за Stars работает

---

## 🎉 ГОТОВО!

После выполнения этих шагов система будет работать на 100%!

**Время настройки: ~5 минут**
**Результат: Полнофункциональная реферальная игра с NDN монетами**
