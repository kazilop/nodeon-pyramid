# NodeOn Pyramid - Telegram Mini App

Реферальная игра с монетами NDN для Telegram. Пользователи покупают Pro статус за 1000 NDN и зарабатывают с рефералов до 7 уровней в глубину.

## 🚀 Особенности

- **Telegram Mini App** - современный веб-интерфейс
- **Реферальная система** - 7 уровней с наградами
- **Telegram Stars** - покупка и вывод через официальную платежную систему
- **Docker** - простое развертывание
- **FastAPI** - быстрый и надежный бэкенд
- **React** - современный фронтенд

## 📋 Архитектура

```
├── backend/           # FastAPI бэкенд
│   ├── main.py       # Основное приложение
│   ├── database.py   # Модели БД
│   ├── config.py     # Конфигурация
│   ├── routers/      # API роутеры
│   └── telegram_bot.py # Telegram бот
├── frontend/         # React фронтенд
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   └── contexts/
├── docker-compose.yml
└── README.md
```

## 🛠 Установка и запуск

### 1. Клонирование репозитория

```bash
git clone <repository-url>
cd nodeon-pyramid
```

### 2. Настройка переменных окружения

Скопируйте `env.example` в `.env` и заполните:

```bash
cp env.example .env
```

Отредактируйте `.env`:

```env
# Telegram Bot Configuration
TELEGRAM_BOT_TOKEN=your_bot_token_here
TELEGRAM_BOT_USERNAME=your_bot_username
TELEGRAM_WEBHOOK_URL=https://yourdomain.com/webhook

# Database
DATABASE_URL=postgresql://nodeon_user:nodeon_password@localhost:5432/nodeon_db

# Redis
REDIS_URL=redis://localhost:6379

# Security
SECRET_KEY=your_secret_key_here

# Developer Account
DEVELOPER_TELEGRAM_ID=your_telegram_id
```

### 3. Создание Telegram бота

1. Найдите [@BotFather](https://t.me/botfather) в Telegram
2. Создайте нового бота: `/newbot`
3. Получите токен и username
4. Настройте Mini App: `/newapp`

### 4. Запуск через Docker

```bash
docker-compose up -d
```

### 5. Настройка webhook (опционально)

```bash
curl -X POST "https://api.telegram.org/bot<YOUR_BOT_TOKEN>/setWebhook" \
     -H "Content-Type: application/json" \
     -d '{"url": "https://yourdomain.com/webhook"}'
```

## 🎮 Как играть

### Для пользователей:

1. **Регистрация**: Откройте бота и нажмите "Открыть приложение"
2. **Покупка NDN**: Купите 1000 NDN за Telegram Stars
3. **Pro статус**: Приобретите Pro статус за 1000 NDN
4. **Реферальная ссылка**: Получите свою уникальную ссылку
5. **Приглашение друзей**: Делитесь ссылкой и зарабатывайте
6. **Вывод средств**: Конвертируйте NDN обратно в Stars

### Реферальная система:

- **Уровень 1**: 200 NDN за каждого Pro реферала
- **Уровень 2-7**: 150 NDN за каждого Pro реферала
- **Комиссия разработчика**: 200 NDN с каждой покупки Pro

## 📊 API Endpoints

### Аутентификация
- `POST /api/auth/login` - Авторизация через Telegram
- `GET /api/auth/me` - Получение данных пользователя

### Пользователи
- `POST /api/users/buy-pro` - Покупка Pro статуса
- `POST /api/users/withdraw` - Запрос на вывод NDN
- `GET /api/users/balance/{user_id}` - Получение баланса

### Платежи
- `POST /api/payments/buy-ndn` - Покупка NDN за Stars
- `POST /api/payments/telegram-stars-webhook` - Webhook Telegram Stars
- `GET /api/payments/payment-methods` - Способы оплаты

### Рефералы
- `POST /api/referrals/join-by-referral` - Присоединение по ссылке
- `GET /api/referrals/referral-stats/{user_id}` - Статистика рефералов
- `GET /api/referrals/referral-tree/{user_id}` - Дерево рефералов

### Статистика
- `GET /api/stats/dashboard/{user_id}` - Дашборд
- `GET /api/stats/transactions/{user_id}` - История транзакций
- `GET /api/stats/leaderboard` - Таблица лидеров
- `GET /api/stats/game-rules` - Правила игры

## 🗄 База данных

### Основные таблицы:

- **users** - Пользователи
- **transactions** - Транзакции
- **referral_stats** - Статистика рефералов
- **payment_requests** - Заявки на вывод

### Схема реферальной системы:

```
User A (Pro) -> User B (Pro) -> User C (Pro) -> ...
    200 NDN        150 NDN        150 NDN
```

## 🔧 Разработка

### Локальная разработка:

```bash
# Бэкенд
cd backend
pip install -r requirements.txt
uvicorn main:app --reload

# Фронтенд
cd frontend
npm install
npm start

# Бот
python telegram_bot.py
```

### Тестирование:

```bash
# Запуск тестов
docker-compose -f docker-compose.test.yml up --build
```

## 📱 Telegram WebApp SDK

Приложение использует официальный Telegram WebApp SDK:

```javascript
// Инициализация
window.Telegram.WebApp.ready();
window.Telegram.WebApp.expand();

// Получение данных пользователя
const user = window.Telegram.WebApp.initDataUnsafe.user;

// Закрытие приложения
window.Telegram.WebApp.close();
```

## 🔒 Безопасность

- Проверка подписи Telegram WebApp
- Валидация всех входящих данных
- Защита от SQL-инъекций через SQLAlchemy
- Rate limiting для API
- HTTPS для продакшена

## 📈 Мониторинг

- Логирование всех операций
- Метрики производительности
- Мониторинг ошибок
- Алерты при критических ошибках

## 🚀 Деплой

### Production настройки:

1. Обновите `TELEGRAM_WEBHOOK_URL` в `.env`
2. Настройте домен для Mini App
3. Включите HTTPS
4. Настройте мониторинг
5. Создайте резервные копии БД

### Масштабирование:

- Горизонтальное масштабирование через Docker Swarm
- Кэширование через Redis
- CDN для статических файлов
- Load balancer для API

## 📞 Поддержка

- **Telegram**: @your_support_bot
- **Email**: support@yourdomain.com
- **GitHub Issues**: [Создать issue](https://github.com/your-repo/issues)

## 📄 Лицензия

MIT License - см. файл [LICENSE](LICENSE)

## 🤝 Вклад в проект

1. Fork репозитория
2. Создайте feature branch
3. Commit изменения
4. Push в branch
5. Создайте Pull Request

---

**NodeOn Pyramid** - зарабатывайте с рефералами в Telegram! 🚀
