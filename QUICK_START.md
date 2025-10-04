# 🚀 Быстрый старт NodeOn Pyramid

## 1. Подготовка (5 минут)

### Создайте аккаунты:
- [Vercel](https://vercel.com) - для хостинга
- [Supabase](https://supabase.com) - для PostgreSQL
- [Upstash](https://upstash.com) - для Redis

### Установите Vercel CLI:
```bash
npm i -g vercel
```

## 2. Настройка базы данных (2 минуты)

### Supabase (уже настроен):
- **URL**: https://ahxwpzgltlzlvrtrbanm.supabase.co
- **API Key**: уже в .env файле
- **Нужно**: получить пароль от базы данных

### Получение пароля:
1. Откройте [Supabase Dashboard](https://ahxwpzgltlzlvrtrbanm.supabase.co)
2. Settings → Database
3. Скопируйте пароль из connection string
4. Замените `[PASSWORD]` в .env файле

### Upstash:
1. Создайте Redis database
2. Скопируйте connection string
3. Сохраните для переменных окружения

## 3. Развертывание на Vercel (2 минуты)

```bash
# Войдите в Vercel
vercel login

# Разверните проект
vercel

# Настройте переменные окружения
vercel env add DATABASE_URL
vercel env add REDIS_URL
vercel env add TELEGRAM_BOT_TOKEN
vercel env add TELEGRAM_BOT_USERNAME
vercel env add SECRET_KEY
vercel env add DEVELOPER_TELEGRAM_ID
```

## 4. Настройка Telegram (1 минута)

### Обновите webhook URL:
```bash
# Установите webhook (замените YOUR_APP_URL на ваш URL)
curl -X POST "https://api.telegram.org/bot7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ/setWebhook" \
     -H "Content-Type: application/json" \
     -d '{"url": "https://YOUR_APP_URL.vercel.app/webhook"}'
```

### Настройте Mini App:
1. Откройте [@BotFather](https://t.me/botfather)
2. `/mybots` → выберите бота
3. Bot Settings → Mini App
4. URL: `https://YOUR_APP_URL.vercel.app`

## 5. Тестирование (1 минута)

1. Откройте [@pro_stars_bot](https://t.me/pro_stars_bot)
2. `/start`
3. "Открыть приложение"
4. Проверьте все функции

## 📋 Переменные окружения

Добавьте в Vercel:

```
DATABASE_URL=postgresql://postgres:[PASSWORD]@[HOST]:5432/postgres
REDIS_URL=redis://default:[PASSWORD]@[HOST]:6379
TELEGRAM_BOT_TOKEN=7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ
TELEGRAM_BOT_USERNAME=pro_stars_bot
SECRET_KEY=your_very_secure_secret_key_here
DEVELOPER_TELEGRAM_ID=207940967
```

## 🔧 Автоматическая настройка webhook

```bash
# Установите зависимости
pip install -r scripts/requirements.txt

# Настройте webhook
python scripts/setup_webhook.py
```

## ⚡ Готово!

Ваше приложение развернуто и готово к использованию!

**URL приложения**: `https://YOUR_APP_URL.vercel.app`
**Telegram бот**: [@pro_stars_bot](https://t.me/pro_stars_bot)

## 🆘 Если что-то не работает

1. **Проверьте логи** в Vercel Dashboard
2. **Проверьте переменные** окружения
3. **Проверьте webhook** через BotFather
4. **Обратитесь в поддержку** Vercel

---

**Время развертывания: ~12 минут** ⏱️
