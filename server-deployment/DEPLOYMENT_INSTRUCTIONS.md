# NodeOn Pyramid - Инструкции по развертыванию на сервере

## 🚀 Развертывание на сервере 147.45.110.220

### 📋 Предварительные требования

- Сервер Ubuntu 20.04+ или Debian 11+
- Root доступ к серверу
- Домен `sistemypro.ru` настроен на IP `147.45.110.220`

### 🔧 Шаги развертывания

#### 1. Подключение к серверу
```bash
ssh root@147.45.110.220
```

#### 2. Загрузка файлов на сервер
```bash
# Создаем папку для проекта
mkdir -p /var/www/nodeon-pyramid

# Загружаем файлы (используйте scp, rsync или git)
# Пример с scp:
scp -r server-deployment/* root@147.45.110.220:/var/www/nodeon-pyramid/
```

#### 3. Запуск автоматического развертывания
```bash
cd /var/www/nodeon-pyramid
chmod +x deploy.sh
./deploy.sh
```

#### 4. Настройка переменных окружения
```bash
nano .env
```

Убедитесь, что в файле `.env` указаны правильные значения:
```env
NODE_ENV=production
PORT=3000

SUPABASE_URL=https://ahxwpzgltlzlvrtrbanm.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoeHdwemdsdGx6bHZydHJiYW1tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1MDMxNDksImV4cCI6MjA3NTA3OTE0OX0.h4sMVhVwvRUiHgbevDgv9W1G2S__uDWPUSCiXdrEy4E

TELEGRAM_BOT_TOKEN=7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ
TELEGRAM_BOT_USERNAME=pro_stars_bot

SECRET_KEY=your_secret_key_here
DEVELOPER_TELEGRAM_ID=207940967
```

#### 5. Получение SSL сертификата
```bash
certbot --nginx -d sistemypro.ru -d www.sistemypro.ru
```

#### 6. Перезапуск сервисов
```bash
systemctl restart nginx
pm2 restart nodeon-pyramid
```

### 🔄 Обновление приложения

Для обновления приложения используйте скрипт `update.sh`:

```bash
cd /var/www/nodeon-pyramid
chmod +x update.sh
./update.sh
```

### 📊 Мониторинг и управление

#### Проверка статуса
```bash
# Статус приложения
pm2 status

# Статус Nginx
systemctl status nginx

# Проверка здоровья приложения
curl http://localhost:3000/health
```

#### Просмотр логов
```bash
# Логи приложения
pm2 logs nodeon-pyramid

# Логи Nginx
tail -f /var/log/nginx/error.log
tail -f /var/log/nginx/access.log
```

#### Управление сервисами
```bash
# Перезапуск приложения
pm2 restart nodeon-pyramid

# Перезапуск Nginx
systemctl restart nginx

# Перезагрузка конфигурации Nginx
systemctl reload nginx
```

### 🌐 Структура проекта

```
/var/www/nodeon-pyramid/
├── server.js                 # Основной сервер
├── package.json              # Зависимости Node.js
├── ecosystem.config.js       # Конфигурация PM2
├── nginx.conf                # Конфигурация Nginx
├── .env                      # Переменные окружения
├── routes/                   # API маршруты
│   ├── auth.js
│   ├── miner.js
│   ├── users.js
│   ├── referrals.js
│   ├── stats.js
│   ├── game.js
│   ├── transfers.js
│   └── translations.js
├── public/                   # Статические файлы
│   └── index.html
├── locales/                  # Файлы переводов
│   ├── ru.json
│   ├── en.json
│   └── ...
└── logs/                     # Логи приложения
```

### 🔧 API Endpoints

После развертывания будут доступны следующие API endpoints:

- `GET /api/auth/me/:telegram_id` - Получение данных пользователя
- `POST /api/auth/login` - Авторизация через Telegram
- `GET /api/miner/data/:telegram_id` - Данные майнера
- `POST /api/miner/buy-farm` - Покупка фермы
- `POST /api/miner/save-state` - Сохранение состояния
- `GET /api/users/find-by-id/:id` - Поиск пользователя
- `POST /api/users/buy-pro` - Покупка Pro статуса
- `GET /api/referrals/by-id/:id` - Рефералы пользователя
- `GET /api/stats/leaderboard` - Лидерборд
- `GET /api/game/data/:telegram_id` - Игровые данные
- `GET /api/game/achievements` - Достижения
- `POST /api/game/daily-reward` - Ежедневная награда
- `POST /api/transfers/ndn` - Перевод NDN
- `GET /api/translations/:lang` - Переводы

### 🛡️ Безопасность

- SSL сертификат для HTTPS
- Firewall настроен (порты 22, 80, 443)
- Security headers в Nginx
- Gzip сжатие
- Кэширование статических файлов

### 🚨 Устранение неполадок

#### Приложение не запускается
```bash
# Проверьте логи
pm2 logs nodeon-pyramid

# Проверьте переменные окружения
cat .env

# Проверьте зависимости
npm list
```

#### Nginx не работает
```bash
# Проверьте конфигурацию
nginx -t

# Проверьте статус
systemctl status nginx

# Проверьте логи
tail -f /var/log/nginx/error.log
```

#### SSL проблемы
```bash
# Обновите сертификат
certbot renew

# Проверьте сертификат
openssl x509 -in /etc/letsencrypt/live/sistemypro.ru/cert.pem -text -noout
```

### 📞 Поддержка

При возникновении проблем:
1. Проверьте логи приложения и Nginx
2. Убедитесь, что все сервисы запущены
3. Проверьте конфигурацию переменных окружения
4. Убедитесь, что домен правильно настроен

### 🎯 Результат

После успешного развертывания ваше приложение будет доступно по адресу:
- **HTTP**: http://sistemypro.ru
- **HTTPS**: https://sistemypro.ru
- **API**: https://sistemypro.ru/api/
