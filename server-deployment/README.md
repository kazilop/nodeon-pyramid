# NodeOn Pyramid - Server Deployment

Telegram Mini App - реферальная игра с монетами NDN, развернутая на собственном сервере.

## 🚀 Быстрый старт

### 1. Загрузка на сервер
```bash
# Подключение к серверу
ssh root@147.45.110.220

# Создание директории
mkdir -p /var/www/nodeon-pyramid

# Загрузка файлов (с локальной машины)
scp -r server-deployment/* root@147.45.110.220:/var/www/nodeon-pyramid/
```

### 2. Автоматическое развертывание
```bash
cd /var/www/nodeon-pyramid
chmod +x deploy.sh
./deploy.sh
```

### 3. Настройка SSL
```bash
certbot --nginx -d sistemypro.ru -d www.sistemypro.ru
```

## 📋 Что включено

- ✅ **Express.js сервер** с API endpoints
- ✅ **Nginx** для статических файлов и прокси
- ✅ **PM2** для управления процессами
- ✅ **SSL/HTTPS** поддержка
- ✅ **Автоматические скрипты** развертывания
- ✅ **Мониторинг** и логирование
- ✅ **Безопасность** и оптимизация

## 🔧 Технологии

- **Backend**: Node.js + Express.js
- **Database**: Supabase (PostgreSQL)
- **Web Server**: Nginx
- **Process Manager**: PM2
- **SSL**: Let's Encrypt
- **Frontend**: HTML + JavaScript + Telegram WebApp SDK

## 📊 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/auth/login` | Авторизация через Telegram |
| GET | `/api/auth/me/:telegram_id` | Данные пользователя |
| GET | `/api/miner/data/:telegram_id` | Данные майнера |
| POST | `/api/miner/buy-farm` | Покупка фермы |
| POST | `/api/miner/save-state` | Сохранение состояния |
| GET | `/api/users/find-by-id/:id` | Поиск пользователя |
| POST | `/api/users/buy-pro` | Покупка Pro статуса |
| GET | `/api/referrals/by-id/:id` | Рефералы |
| GET | `/api/stats/leaderboard` | Лидерборд |
| GET | `/api/game/data/:telegram_id` | Игровые данные |
| POST | `/api/game/daily-reward` | Ежедневная награда |
| POST | `/api/transfers/ndn` | Перевод NDN |
| GET | `/api/translations/:lang` | Переводы |

## 🛠️ Управление

### Основные команды
```bash
# Статус приложения
pm2 status

# Логи приложения
pm2 logs nodeon-pyramid

# Перезапуск приложения
pm2 restart nodeon-pyramid

# Статус Nginx
systemctl status nginx

# Перезапуск Nginx
systemctl restart nginx
```

### Обновление
```bash
cd /var/www/nodeon-pyramid
./update.sh
```

## 🔒 Безопасность

- HTTPS с Let's Encrypt
- Security headers в Nginx
- Firewall (UFW) настроен
- Gzip сжатие
- Кэширование статических файлов

## 📁 Структура

```
server-deployment/
├── server.js              # Основной сервер
├── package.json           # Зависимости
├── ecosystem.config.js    # PM2 конфигурация
├── nginx.conf            # Nginx конфигурация
├── deploy.sh             # Скрипт развертывания
├── update.sh             # Скрипт обновления
├── routes/               # API маршруты
├── public/               # Статические файлы
├── locales/              # Переводы
└── README.md             # Документация
```

## 🌐 Домен

После развертывания приложение будет доступно по адресу:
- **https://sistemypro.ru**
- **https://www.sistemypro.ru**

## 📞 Поддержка

При проблемах проверьте:
1. Логи приложения: `pm2 logs nodeon-pyramid`
2. Логи Nginx: `tail -f /var/log/nginx/error.log`
3. Статус сервисов: `pm2 status` и `systemctl status nginx`
4. Переменные окружения в файле `.env`
