# Развертывание NodeOn Pyramid на Vercel

## 🚀 Пошаговая инструкция

### 1. Подготовка проекта

Убедитесь, что у вас есть:
- Аккаунт на [Vercel](https://vercel.com)
- Аккаунт на [Supabase](https://supabase.com) для PostgreSQL
- Аккаунт на [Upstash](https://upstash.com) для Redis

### 2. Настройка базы данных (Supabase)

1. Создайте новый проект в Supabase
2. Получите connection string:
   ```
   postgresql://postgres:[PASSWORD]@[HOST]:5432/postgres
   ```
3. Сохраните его для настройки переменных окружения

### 3. Настройка Redis (Upstash)

1. Создайте новый Redis database в Upstash
2. Получите connection string:
   ```
   redis://default:[PASSWORD]@[HOST]:6379
   ```

### 4. Развертывание на Vercel

#### Вариант A: Через Vercel CLI

```bash
# Установите Vercel CLI
npm i -g vercel

# Войдите в аккаунт
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

#### Вариант B: Через веб-интерфейс

1. Загрузите проект на GitHub
2. Подключите репозиторий к Vercel
3. Настройте переменные окружения в Settings → Environment Variables

### 5. Переменные окружения

Добавьте следующие переменные в Vercel:

```
DATABASE_URL=postgresql://postgres:[PASSWORD]@[HOST]:5432/postgres
REDIS_URL=redis://default:[PASSWORD]@[HOST]:6379
TELEGRAM_BOT_TOKEN=7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ
TELEGRAM_BOT_USERNAME=pro_stars_bot
SECRET_KEY=your_very_secure_secret_key_here
DEVELOPER_TELEGRAM_ID=207940967
```

### 6. Настройка Telegram Webhook

После развертывания получите URL вашего приложения (например: `https://your-app.vercel.app`)

Установите webhook:

```bash
curl -X POST "https://api.telegram.org/bot7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ/setWebhook" \
     -H "Content-Type: application/json" \
     -d '{"url": "https://your-app.vercel.app/webhook"}'
```

### 7. Настройка Mini App

1. Откройте [@BotFather](https://t.me/botfather)
2. Выберите вашего бота: `/mybots`
3. Нажмите на бота → Bot Settings → Mini App
4. Установите URL: `https://your-app.vercel.app`

### 8. Обновление переменных в проекте

Обновите `env.example` с новым webhook URL:

```env
TELEGRAM_WEBHOOK_URL=https://your-app.vercel.app/webhook
```

### 9. Тестирование

1. Откройте бота в Telegram: [@pro_stars_bot](https://t.me/pro_stars_bot)
2. Нажмите `/start`
3. Нажмите "Открыть приложение"
4. Проверьте все функции

## 🔧 Структура проекта для Vercel

```
├── api/
│   └── index.py          # FastAPI приложение
├── frontend/
│   └── build/            # Собранный React
├── vercel.json           # Конфигурация Vercel
├── requirements.txt      # Python зависимости
└── .vercelignore        # Игнорируемые файлы
```

## 📝 Важные замечания

### Ограничения Vercel
- **Serverless functions** - ограничение времени выполнения
- **Memory limits** - до 1GB RAM
- **Timeout** - до 10 секунд для Hobby плана

### Рекомендации
- Используйте **Pro план** для продакшена
- Настройте **мониторинг** ошибок
- Создайте **резервные копии** БД
- Используйте **CDN** для статических файлов

### Альтернативы
Если Vercel не подходит, рассмотрите:
- **Railway** - проще для full-stack приложений
- **Render** - дешевле для долгосрочного использования
- **DigitalOcean App Platform** - больше контроля

## 🚨 Troubleshooting

### Ошибка подключения к БД
```bash
# Проверьте connection string
# Убедитесь, что БД доступна извне
# Проверьте firewall настройки
```

### Webhook не работает
```bash
# Проверьте URL webhook
curl https://api.telegram.org/bot7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ/getWebhookInfo

# Удалите webhook если нужно
curl -X POST "https://api.telegram.org/bot7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ/deleteWebhook"
```

### Mini App не открывается
- Проверьте URL в BotFather
- Убедитесь, что приложение доступно по HTTPS
- Проверьте CORS настройки

## 📞 Поддержка

Если возникли проблемы:
1. Проверьте логи в Vercel Dashboard
2. Проверьте статус сервисов (Supabase, Upstash)
3. Обратитесь в поддержку Vercel
4. Создайте issue в GitHub репозитории

---

**Удачи с развертыванием! 🚀**
