# 🌐 Руководство по деплою на Netlify

## 📋 Обзор

Этот проект настроен для деплоя на Netlify с использованием serverless функций для API endpoints.

## 🛠️ Подготовка

### 1. Установка Netlify CLI
```bash
npm install -g netlify-cli
```

### 2. Авторизация в Netlify
```bash
netlify login
```

## 🚀 Автоматический деплой

### PowerShell (Windows):
```powershell
.\deploy_netlify.ps1
```

### Bash (Linux/Mac):
```bash
chmod +x deploy_netlify.sh
./deploy_netlify.sh
```

## 📁 Структура проекта для Netlify

```
├── netlify.toml              # Конфигурация Netlify
├── package.json              # Зависимости Node.js
├── netlify/
│   └── functions/            # Serverless функции
│       ├── api.js            # Главная API функция
│       ├── auth.js           # Аутентификация
│       ├── miner.js          # API майнера
│       ├── users.js          # API пользователей
│       ├── payments.js       # API платежей
│       ├── referrals.js      # API рефералов
│       └── stats.js          # API статистики
├── index.html                # Главная страница
├── locales/                  # Переводы
└── public/                   # Статические файлы
```

## ⚙️ Конфигурация

### netlify.toml
```toml
[build]
  publish = "dist"
  command = "npm run build"

[[redirects]]
  from = "/api/*"
  to = "/.netlify/functions/:splat"
  status = 200

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200

[functions]
  directory = "netlify/functions"
  node_bundler = "esbuild"
```

## 🔧 Переменные окружения

В Netlify Dashboard → Site settings → Environment variables добавьте:

```env
SUPABASE_URL=https://ahxwpzgltlzlvrtrbanm.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
TELEGRAM_BOT_TOKEN=7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ
DEVELOPER_TELEGRAM_ID=207940967
SECRET_KEY=nodeon-pyramid-secret-key-2024
```

## 📡 API Endpoints

После деплоя все API endpoints будут доступны по адресу:
```
https://your-app.netlify.app/api/...
```

### Доступные endpoints:

**Аутентификация:**
- `POST /api/auth/login` - Вход через Telegram
- `GET /api/auth/me` - Данные пользователя

**Майнер:**
- `GET /api/miner/data/{user_id}` - Данные майнера
- `POST /api/miner/buy-farm` - Покупка фермы
- `POST /api/miner/buy-premium-farm` - Покупка премиум фермы
- `POST /api/miner/save-state` - Сохранение состояния
- `POST /api/miner/save-gas` - Сохранение Gas
- `GET /api/miner/leaderboard` - Лидерборд
- `GET /api/miner/stats/{user_id}` - Статистика пользователя
- `GET /api/miner/check-tables` - Проверка таблиц

**Пользователи:**
- `POST /api/users/buy-pro` - Покупка Pro статуса
- `POST /api/users/withdraw` - Вывод NDN
- `GET /api/users/balance/{user_id}` - Баланс

**Платежи:**
- `POST /api/payments/buy-ndn` - Покупка NDN
- `POST /api/payments/telegram-stars-webhook` - Webhook Stars

**Рефералы:**
- `POST /api/referrals/join-by-referral` - Присоединение по рефералу
- `GET /api/referrals/referral-stats/{user_id}` - Статистика рефералов

**Статистика:**
- `GET /api/stats/dashboard/{user_id}` - Дашборд
- `GET /api/stats/transactions/{user_id}` - Транзакции
- `GET /api/stats/leaderboard` - Лидерборд

## 🔄 Обновление Telegram Bot

### 1. Обновление webhook:
```bash
curl -X POST "https://api.telegram.org/bot<YOUR_BOT_TOKEN>/setWebhook" \
     -H "Content-Type: application/json" \
     -d '{"url": "https://your-app.netlify.app/api/telegram/webhook"}'
```

### 2. Обновление Menu Button в BotFather:
1. Откройте [@BotFather](https://t.me/BotFather)
2. Выполните `/mybots`
3. Выберите вашего бота
4. Выберите "Bot Settings" → "Menu Button"
5. Установите URL: `https://your-app.netlify.app`

## 🧪 Тестирование

### 1. Проверка API:
```bash
curl https://your-app.netlify.app/api/miner/check-tables
```

### 2. Проверка главной страницы:
Откройте `https://your-app.netlify.app` в браузере

### 3. Тестирование бота:
Отправьте `/start` боту в Telegram

## 🚨 Устранение неполадок

### Проблема: Функции не работают
**Решение:**
1. Проверьте переменные окружения в Netlify Dashboard
2. Проверьте логи функций в Netlify Dashboard → Functions
3. Убедитесь, что все зависимости установлены

### Проблема: CORS ошибки
**Решение:**
1. Проверьте заголовки CORS в функциях
2. Убедитесь, что `Access-Control-Allow-Origin: *` установлен

### Проблема: Telegram webhook не работает
**Решение:**
1. Проверьте URL webhook
2. Убедитесь, что функция `api.js` правильно обрабатывает webhook
3. Проверьте логи в Netlify Dashboard

### Проблема: Supabase не подключается
**Решение:**
1. Проверьте `SUPABASE_URL` и `SUPABASE_ANON_KEY`
2. Убедитесь, что ключи правильные
3. Проверьте настройки CORS в Supabase

## 📊 Мониторинг

### Логи функций:
- Netlify Dashboard → Functions → View logs

### Метрики:
- Netlify Dashboard → Analytics
- Netlify Dashboard → Functions → Metrics

### Ошибки:
- Netlify Dashboard → Functions → Error logs

## 🔒 Безопасность

### Рекомендации:
1. **Используйте HTTPS** - Netlify автоматически предоставляет SSL
2. **Защитите переменные** - Не коммитьте секреты в Git
3. **Валидация данных** - Проверяйте все входящие данные
4. **Rate limiting** - Ограничьте количество запросов

## 📞 Поддержка

### Полезные ссылки:
- [Netlify Documentation](https://docs.netlify.com/)
- [Netlify Functions](https://docs.netlify.com/functions/overview/)
- [Telegram Bot API](https://core.telegram.org/bots/api)

### Контакты:
- **Telegram**: @your_support_bot
- **Email**: support@yourdomain.com

## 🎉 Завершение

После успешного деплоя:
1. ✅ Протестируйте все API endpoints
2. ✅ Обновите webhook Telegram бота
3. ✅ Протестируйте бота командой `/start`
4. ✅ Проверьте работу майнера
5. ✅ Уведомите пользователей о новом URL

---

**Удачного деплоя! 🚀**
