# 🚀 Руководство по миграции NodeOn Pyramid на новый аккаунт Railway

## 📋 Подготовка

### 1. Создание нового аккаунта Railway
1. Перейдите на [railway.app](https://railway.app)
2. Зарегистрируйтесь с новым email
3. Подтвердите email
4. Создайте новый проект

### 2. Подготовка данных
Сохраните следующие данные с текущего проекта:
- **Supabase URL и ключи** (из переменных окружения)
- **Telegram Bot Token** (из BotFather)
- **Developer Telegram ID** (ваш ID)
- **Данные базы данных** (если нужно)

## 🔧 Настройка нового проекта

### Шаг 1: Создание проекта на Railway
```bash
# Установите Railway CLI
npm install -g @railway/cli

# Войдите в аккаунт
railway login

# Создайте новый проект
railway new
```

### Шаг 2: Клонирование репозитория
```bash
# Клонируйте репозиторий
git clone https://github.com/kazilop/nodeon-pyramid.git
cd nodeon-pyramid

# Добавьте Railway remote
railway link
```

### Шаг 3: Настройка переменных окружения
В Railway Dashboard → Variables добавьте:

```env
# Supabase Configuration
SUPABASE_URL=your_supabase_url_here
SUPABASE_ANON_KEY=your_supabase_anon_key_here

# Telegram Bot Configuration
TELEGRAM_BOT_TOKEN=your_telegram_bot_token_here
DEVELOPER_TELEGRAM_ID=your_developer_telegram_id_here

# Security
SECRET_KEY=your_secret_key_here

# Server Configuration
PORT=8000
HOST=0.0.0.0
```

### Шаг 4: Деплой
```bash
# Деплой на Railway
railway up
```

## 🗄️ Настройка базы данных

### Автоматическая настройка
После деплоя запустите скрипт настройки:

```bash
# Подключитесь к контейнеру Railway
railway shell

# Запустите настройку базы данных
python setup_database.py
```

### Ручная настройка (если нужно)
1. Откройте Supabase Dashboard
2. Перейдите в SQL Editor
3. Выполните SQL из файла `create_miner_tables.sql`

## 🤖 Настройка Telegram Bot

### Обновление webhook
```bash
# Запустите настройку бота
python setup_telegram_bot.py
```

### Ручная настройка
1. Получите новый URL приложения из Railway
2. Обновите webhook:
```bash
curl -X POST "https://api.telegram.org/bot<YOUR_BOT_TOKEN>/setWebhook" \
     -H "Content-Type: application/json" \
     -d '{"url": "https://your-app.railway.app/api/telegram/webhook"}'
```

## ✅ Проверка системы

### Запуск проверки
```bash
# Проверьте все компоненты системы
python check_system.py
```

### Ручная проверка
1. **Проверьте приложение**: Откройте URL Railway в браузере
2. **Проверьте бота**: Отправьте `/start` боту
3. **Проверьте API**: Тестируйте endpoints через браузер
4. **Проверьте базу данных**: Убедитесь, что данные сохраняются

## 🔄 Миграция данных (если нужно)

### Экспорт данных со старого проекта
```bash
# Создайте бэкап базы данных
pg_dump your_old_database > backup.sql
```

### Импорт данных в новый проект
```bash
# Импортируйте данные
psql your_new_database < backup.sql
```

## 📱 Обновление Telegram Mini App

### Обновление URL в BotFather
1. Откройте [@BotFather](https://t.me/BotFather)
2. Выполните команду `/mybots`
3. Выберите вашего бота
4. Выберите "Bot Settings" → "Menu Button"
5. Установите новый URL: `https://your-app.railway.app`

### Обновление webhook
```bash
# Установите новый webhook
curl -X POST "https://api.telegram.org/bot<YOUR_BOT_TOKEN>/setWebhook" \
     -H "Content-Type: application/json" \
     -d '{"url": "https://your-app.railway.app/api/telegram/webhook"}'
```

## 🚨 Устранение неполадок

### Проблема: Приложение не запускается
**Решение:**
1. Проверьте логи в Railway Dashboard
2. Убедитесь, что все переменные окружения установлены
3. Проверьте Dockerfile и requirements.txt

### Проблема: База данных не подключается
**Решение:**
1. Проверьте SUPABASE_URL и SUPABASE_ANON_KEY
2. Убедитесь, что таблицы созданы
3. Запустите `setup_database.py`

### Проблема: Telegram Bot не отвечает
**Решение:**
1. Проверьте TELEGRAM_BOT_TOKEN
2. Убедитесь, что webhook установлен правильно
3. Проверьте логи webhook в Railway

### Проблема: API endpoints не работают
**Решение:**
1. Проверьте CORS настройки
2. Убедитесь, что все зависимости установлены
3. Проверьте переменные окружения

## 📊 Мониторинг

### Логи Railway
```bash
# Просмотр логов
railway logs

# Просмотр логов в реальном времени
railway logs --follow
```

### Метрики
- **CPU Usage**: Мониторьте в Railway Dashboard
- **Memory Usage**: Следите за потреблением памяти
- **Response Time**: Проверяйте время ответа API

## 🔒 Безопасность

### Рекомендации
1. **Используйте HTTPS**: Railway автоматически предоставляет SSL
2. **Защитите переменные**: Не коммитьте секреты в Git
3. **Регулярные бэкапы**: Создавайте бэкапы базы данных
4. **Мониторинг**: Следите за логами на предмет подозрительной активности

## 📞 Поддержка

### Полезные ссылки
- [Railway Documentation](https://docs.railway.app/)
- [Supabase Documentation](https://supabase.com/docs)
- [Telegram Bot API](https://core.telegram.org/bots/api)

### Контакты
- **Telegram**: @your_support_bot
- **Email**: support@yourdomain.com

## 🎉 Завершение

После успешной миграции:
1. ✅ Протестируйте все функции
2. ✅ Обновите документацию
3. ✅ Уведомите пользователей о новом URL
4. ✅ Удалите старый проект (если уверены)

---

**Удачной миграции! 🚀**
