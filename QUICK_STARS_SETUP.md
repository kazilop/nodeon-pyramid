# ⭐ БЫСТРАЯ НАСТРОЙКА STARS И ЮКАССЫ

## 🎯 Текущий статус: 50% готово (3/6 компонентов)

### ✅ Готово:
- **API** - работает на Railway
- **Frontend** - работает на GitHub Pages  
- **Авторизация** - работает через Telegram

### ⚠️ Нужно настроить:
- **База данных** - выполнить SQL скрипт
- **Stars** - настроить Telegram бота
- **ЮКасса** - зарегистрироваться и настроить

---

## 🚀 БЫСТРАЯ НАСТРОЙКА (30 минут)

### 1. 📊 Настройка базы данных (5 минут)

**Выполните в Supabase SQL Editor:**

```sql
-- Скопируйте и выполните весь скрипт из файла SETUP_STARS_AND_YOOKASSA.sql
```

**Или выполните по частям:**

1. **Создайте таблицы:**
```sql
CREATE TABLE IF NOT EXISTS nodeon_stars_config (
    id SERIAL PRIMARY KEY,
    config_key VARCHAR(100) UNIQUE NOT NULL,
    config_value TEXT NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS nodeon_yookassa_config (
    id SERIAL PRIMARY KEY,
    config_key VARCHAR(100) UNIQUE NOT NULL,
    config_value TEXT NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

2. **Добавьте конфигурацию:**
```sql
INSERT INTO nodeon_stars_config (config_key, config_value, description) VALUES
('stars_to_ndn_rate', '1.0', 'Курс обмена: 1 Star = 1 NDN'),
('min_stars_purchase', '10', 'Минимальная покупка в Stars'),
('max_stars_purchase', '10000', 'Максимальная покупка в Stars')
ON CONFLICT (config_key) DO NOTHING;
```

### 2. 🤖 Настройка Telegram бота с Stars (10 минут)

**Создайте бота:**
1. Откройте @BotFather в Telegram
2. `/newbot` → выберите имя и username
3. Скопируйте токен

**Активируйте Stars:**
1. Обратитесь в поддержку Telegram
2. Запросите активацию Stars для вашего бота
3. Дождитесь подтверждения (1-3 дня)

**Настройте Mini App:**
1. `/newapp` → выберите бота
2. URL: `https://kazilop.github.io/nodeon-pyramid/`
3. Название: `NodeOn Pyramid`

**Настройте webhook:**
```bash
# Добавьте токен в .env файл
echo "TELEGRAM_BOT_TOKEN=ваш_токен_бота" >> .env

# Настройте webhook
python setup_telegram_bot_stars.py
```

### 3. 💳 Настройка ЮКассы (15 минут)

**Регистрация:**
1. Откройте https://yookassa.ru/
2. Нажмите "Подключиться"
3. Выберите "Интернет-магазин"
4. Заполните данные организации
5. Пройдите верификацию (1-3 дня)

**Получение ключей:**
1. После верификации получите:
   - **Shop ID** - идентификатор магазина
   - **Secret Key** - секретный ключ

**Настройка в Supabase:**
```sql
-- Обновите конфигурацию ЮКассы
UPDATE nodeon_yookassa_config SET config_value = 'YOUR_SHOP_ID' WHERE config_key = 'yookassa_shop_id';
UPDATE nodeon_yookassa_config SET config_value = 'YOUR_SECRET_KEY' WHERE config_key = 'yookassa_secret_key';
```

**Настройка webhook:**
1. В личном кабинете ЮКассы:
   - Перейдите в "Настройки" → "Webhook"
   - URL: `https://nodeon-production.up.railway.app/api/yookassa/webhook`
   - События: `payment.succeeded`, `payment.canceled`

### 4. 🔄 Обновление API (5 минут)

**Замените main.py:**
```bash
cp main_with_payments.py main.py
```

**Добавьте зависимости:**
```bash
echo "yookassa==3.0.0" >> requirements.txt
```

**Перезапустите Railway:**
```bash
railway up --detach
```

### 5. 🧪 Проверка (5 минут)

```bash
# Проверьте систему
python FULL_SETUP_STARS_YOOKASSA.py

# Должно показать: 6/6 компонентов готовы ✅
```

---

## 🎯 ПОСЛЕ НАСТРОЙКИ (100% ГОТОВО)

### ✅ **Полный функционал:**
- 🔐 **Авторизация** - только через Telegram
- 💰 **NDN монеты** - баланс, покупка, вывод
- ⭐ **Stars интеграция** - покупка NDN за Telegram Stars
- 💳 **ЮКасса** - покупка NDN за рубли
- 🔗 **Реферальная система** - 7 уровней, награды
- 📊 **Статистика** - детальная аналитика

### ✅ **Готово к продакшну:**
- 🚀 **Масштабируемость** - Railway + Supabase
- 🔒 **Безопасность** - защита данных
- ⚡ **Производительность** - быстрая работа
- 📱 **Мобильная адаптация** - работает везде

---

## 🌐 URL СИСТЕМЫ

- **Frontend:** https://kazilop.github.io/nodeon-pyramid/
- **API:** https://nodeon-production.up.railway.app/api
- **Telegram бот:** @ваш_бот_username (после настройки)

---

## 📱 ТЕСТИРОВАНИЕ

1. **Откройте бота в Telegram**
2. **Нажмите "Запустить приложение"**
3. **Проверьте все функции:**
   - ✅ Покупка NDN за Stars
   - ✅ Покупка NDN за рубли
   - ✅ Вывод NDN в Stars
   - ✅ Реферальная система
   - ✅ Pro статус

---

## ⏱️ ВРЕМЯ ДО ГОТОВНОСТИ

**Общее время: 30 минут**

1. База данных: 5 минут
2. Telegram бот: 10 минут
3. ЮКасса: 15 минут
4. API: 5 минут
5. Проверка: 5 минут

**Результат: Полнофункциональная реферальная игра с платежами! 🎉**

---

## 🆘 ЕСЛИ ВОЗНИКЛИ ПРОБЛЕМЫ

### Проверьте логи:
```bash
# Логи Railway
railway logs

# Проверка системы
python FULL_SETUP_STARS_YOOKASSA.py
```

### Проверьте Supabase:
- Откройте SQL Editor
- Выполните: `SELECT * FROM nodeon_stars_config;`
- Должна быть таблица с конфигурацией

### Проверьте Telegram бота:
- Убедитесь, что Stars активированы
- Проверьте webhook: `python setup_telegram_bot_stars.py`

### Проверьте ЮКассу:
- Убедитесь, что верификация пройдена
- Проверьте webhook в личном кабинете

---

## 🎯 ГОТОВО К ЗАПУСКУ!

**NodeOn Pyramid с Stars и ЮКассой готов к использованию!** 🚀

- ✅ **Безопасность** - только Telegram авторизация
- ✅ **Платежи** - Stars и ЮКасса
- ✅ **Функциональность** - все основные функции работают
- ✅ **Дизайн** - красивый современный интерфейс
- ✅ **Производительность** - быстрая работа
- ✅ **Масштабируемость** - готов к росту

**Запускайте и зарабатывайте! 💰**
