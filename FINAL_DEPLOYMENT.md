# 🚀 Финальное развертывание NodeOn Pyramid

## ✅ Что готово

- **База данных Supabase**: настроена и протестирована
- **Таблицы NodeOn**: созданы и работают
- **Приложение**: полностью готово к развертыванию
- **Telegram бот**: настроен (@pro_stars_bot)

## 📋 Твои данные

- **Supabase URL**: https://ahxwpzgltlzlvrtrbanm.supabase.co
- **Database URL**: postgresql://postgres.nodeon:G-Gje9!Jr4B9-$C@ahxwpzgltlzlvrtrbanm.supabase.co:5432/postgres
- **Telegram Bot**: @pro_stars_bot
- **Bot Token**: 7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ

## 🎯 Развертывание на Vercel (5 минут)

### 1. Установи Vercel CLI
```bash
npm i -g vercel
```

### 2. Войди в аккаунт Vercel
```bash
vercel login
```

### 3. Разверни проект
```bash
vercel
```

### 4. Настрой переменные окружения в Vercel Dashboard

Перейди в Settings → Environment Variables и добавь:

```
DATABASE_URL=postgresql://postgres.nodeon:G-Gje9!Jr4B9-$C@ahxwpzgltlzlvrtrbanm.supabase.co:5432/postgres
SUPABASE_URL=https://ahxwpzgltlzlvrtrbanm.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoeHdwemdsdGx6bHZydHJiYW5tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1MDMxNDksImV4cCI6MjA3NTA3OTE0OX0.h4sMVhVwvRUiHgbevDgv9W1G2S__uDWPUSCiXdrEy4E
TELEGRAM_BOT_TOKEN=7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ
TELEGRAM_BOT_USERNAME=pro_stars_bot
SECRET_KEY=your_very_secure_secret_key_here
DEVELOPER_TELEGRAM_ID=207940967
REDIS_URL=redis://default:your_redis_password@your_redis_host:6379
```

### 5. Настрой webhook (1 минута)

```bash
# Установи зависимости
pip install requests python-dotenv

# Настрой webhook
python scripts/setup_webhook.py
```

### 6. Настрой Mini App в BotFather (1 минута)

1. Открой [@BotFather](https://t.me/botfather)
2. `/mybots` → выбери `@pro_stars_bot`
3. Bot Settings → Mini App
4. URL: `https://YOUR_APP_URL.vercel.app`

## 🧪 Тестирование

### 1. Проверь приложение
1. Открой [@pro_stars_bot](https://t.me/pro_stars_bot)
2. `/start`
3. "Открыть приложение"
4. Проверь все функции

### 2. Проверь webhook
```bash
curl https://api.telegram.org/bot7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ/getWebhookInfo
```

### 3. Проверь базу данных
Открой [Supabase Dashboard](https://ahxwpzgltlzlvrtrbanm.supabase.co) → Table Editor

## 📊 Структура базы данных

### Таблицы NodeOn:
- `nodeon_users` - пользователи
- `nodeon_transactions` - транзакции
- `nodeon_referral_stats` - статистика рефералов
- `nodeon_payment_requests` - заявки на вывод

### Тестовые данные:
- Пользователь: Test User (ID: 1, telegram_id: 123456789)
- Баланс: 1000 NDN
- Pro статус: активен

## 🔧 Полезные команды

### Проверка подключения:
```bash
python test_app_connection.py
```

### Проверка таблиц:
```bash
python check_nodeon_tables.py
```

### Настройка webhook:
```bash
python scripts/setup_webhook.py
```

## 🚨 Troubleshooting

### Ошибка подключения к БД:
- Проверь DATABASE_URL в Vercel
- Убедись, что Supabase проект активен

### Webhook не работает:
- Проверь URL в BotFather
- Убедись, что приложение доступно по HTTPS

### Mini App не открывается:
- Проверь URL в BotFather
- Проверь CORS настройки

## 📱 Готовое приложение

После развертывания у тебя будет:

- **Telegram бот**: [@pro_stars_bot](https://t.me/pro_stars_bot)
- **Mini App**: доступен через бота
- **API**: `https://YOUR_APP_URL.vercel.app/api/`
- **Webhook**: `https://YOUR_APP_URL.vercel.app/webhook`
- **База данных**: https://ahxwpzgltlzlvrtrbanm.supabase.co

## 🎉 Готово!

Твое приложение **NodeOn Pyramid** полностью готово к использованию!

**Время развертывания: ~7 минут** ⏱️

---

**Удачи с запуском! 🚀**
