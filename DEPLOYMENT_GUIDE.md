# 🚀 Полное руководство по развертыванию NodeOn Pyramid

## 📋 Твои данные

- **Supabase URL**: https://ahxwpzgltlzlvrtrbanm.supabase.co
- **Supabase API Key**: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoeHdwemdsdGx6bHZydHJiYW5tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1MDMxNDksImV4cCI6MjA3NTA3OTE0OX0.h4sMVhVwvRUiHgbevDgv9W1G2S__uDWPUSCiXdrEy4E
- **Telegram Bot**: @pro_stars_bot
- **Bot Token**: 7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ

## 🎯 Пошаговое развертывание

### Шаг 1: Получение пароля от Supabase (2 минуты)

1. Откройте [Supabase Dashboard](https://ahxwpzgltlzlvrtrbanm.supabase.co)
2. Войдите в аккаунт
3. Перейдите в **Settings** → **Database**
4. Найдите секцию **Connection string**
5. Скопируйте пароль (например: `your_password_here`)

### Шаг 2: Обновление .env файла (1 минута)

Замените `[PASSWORD]` в файле `env.example`:

```env
DATABASE_URL=postgresql://postgres:your_password_here@ahxwpzgltlzlvrtrbanm.supabase.co:5432/postgres
```

### Шаг 3: Инициализация базы данных (1 минута)

```bash
# Установите зависимости
pip install -r scripts/requirements.txt
pip install sqlalchemy psycopg2-binary

# Инициализируйте базу данных
python scripts/init_database.py
```

### Шаг 4: Создание аккаунтов (3 минуты)

- [Vercel](https://vercel.com) - для хостинга
- [Upstash](https://upstash.com) - для Redis

### Шаг 5: Развертывание на Vercel (2 минуты)

```bash
# Установите Vercel CLI
npm i -g vercel

# Войдите в аккаунт
vercel login

# Разверните проект
vercel
```

### Шаг 6: Настройка переменных окружения в Vercel (2 минуты)

Добавьте в Vercel Dashboard → Settings → Environment Variables:

```
DATABASE_URL=postgresql://postgres:your_password_here@ahxwpzgltlzlvrtrbanm.supabase.co:5432/postgres
SUPABASE_URL=https://ahxwpzgltlzlvrtrbanm.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoeHdwemdsdGx6bHZydHJiYW5tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1MDMxNDksImV4cCI6MjA3NTA3OTE0OX0.h4sMVhVwvRUiHgbevDgv9W1G2S__uDWPUSCiXdrEy4E
TELEGRAM_BOT_TOKEN=7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ
TELEGRAM_BOT_USERNAME=pro_stars_bot
SECRET_KEY=your_very_secure_secret_key_here
DEVELOPER_TELEGRAM_ID=207940967
REDIS_URL=redis://default:your_redis_password@your_redis_host:6379
```

### Шаг 7: Настройка Telegram webhook (1 минута)

```bash
# Установите зависимости для скрипта
pip install requests python-dotenv

# Настройте webhook (замените YOUR_APP_URL на ваш URL)
python scripts/setup_webhook.py
```

### Шаг 8: Настройка Mini App в BotFather (1 минута)

1. Откройте [@BotFather](https://t.me/botfather)
2. Нажмите `/mybots`
3. Выберите `@pro_stars_bot`
4. Нажмите **Bot Settings** → **Mini App**
5. Установите URL: `https://YOUR_APP_URL.vercel.app`

## 🧪 Тестирование

### 1. Проверка базы данных
```bash
# Запустите скрипт проверки
python scripts/get_supabase_connection.py
```

### 2. Проверка приложения
1. Откройте [@pro_stars_bot](https://t.me/pro_stars_bot)
2. Нажмите `/start`
3. Нажмите "Открыть приложение"
4. Проверьте все функции

### 3. Проверка webhook
```bash
# Проверьте статус webhook
curl https://api.telegram.org/bot7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ/getWebhookInfo
```

## 📊 Мониторинг

### Supabase Dashboard
- **Table Editor** - просмотр данных
- **SQL Editor** - выполнение запросов
- **Logs** - мониторинг запросов

### Vercel Dashboard
- **Functions** - логи API
- **Analytics** - статистика использования
- **Deployments** - история развертываний

## 🔧 Troubleshooting

### Ошибка подключения к БД
```bash
# Проверьте пароль
python scripts/get_supabase_connection.py

# Проверьте подключение
python scripts/init_database.py
```

### Webhook не работает
```bash
# Проверьте статус
curl https://api.telegram.org/bot7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ/getWebhookInfo

# Удалите webhook
curl -X POST "https://api.telegram.org/bot7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ/deleteWebhook"
```

### Mini App не открывается
- Проверьте URL в BotFather
- Убедитесь, что приложение доступно по HTTPS
- Проверьте CORS настройки

## 📱 Готовое приложение

После развертывания у тебя будет:

- **Telegram бот**: [@pro_stars_bot](https://t.me/pro_stars_bot)
- **Mini App**: доступен через бота
- **API**: `https://YOUR_APP_URL.vercel.app/api/`
- **Webhook**: `https://YOUR_APP_URL.vercel.app/webhook`
- **База данных**: https://ahxwpzgltlzlvrtrbanm.supabase.co

## ⚡ Время развертывания: ~12 минут

---

**Удачи с развертыванием! 🚀**
