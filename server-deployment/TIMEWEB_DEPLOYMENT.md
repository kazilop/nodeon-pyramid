# 🚀 NodeOn Pyramid - Развертывание на Timeweb VPS

## 📋 Инструкции для пустого сервера Timeweb

### 1. Подключение к серверу
```bash
ssh root@147.45.110.220
```

### 2. Создание структуры папок
```bash
# Создаем основные папки
mkdir -p /var/www/nodeon-pyramid
mkdir -p /var/log/nodeon-pyramid
mkdir -p /etc/nginx/sites-available
mkdir -p /etc/nginx/sites-enabled
mkdir -p /etc/letsencrypt/live
```

### 3. Загрузка файлов
```bash
# С локальной машины загружаем архив
scp nodeon-pyramid-server-updated.tar.gz root@147.45.110.220:/root/

# На сервере распаковываем в нашу папку
cd /var/www/nodeon-pyramid
tar -xzf /root/nodeon-pyramid-server-updated.tar.gz
```

### 4. Установка зависимостей
```bash
# Обновляем систему
apt update && apt upgrade -y

# Устанавливаем Node.js 18.x
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs

# Устанавливаем PM2
npm install -g pm2

# Устанавливаем Nginx
apt install -y nginx

# Устанавливаем Certbot
apt install -y certbot python3-certbot-nginx

# Устанавливаем UFW (firewall)
apt install -y ufw
```

### 5. Настройка приложения
```bash
cd /var/www/nodeon-pyramid

# Устанавливаем зависимости
npm install --production

# Настраиваем переменные окружения
nano .env
```

Содержимое файла `.env`:
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

### 6. Настройка Nginx
```bash
# Копируем конфигурацию сайта
cp nginx-site.conf /etc/nginx/sites-available/nodeon-pyramid

# Создаем символическую ссылку
ln -s /etc/nginx/sites-available/nodeon-pyramid /etc/nginx/sites-enabled/

# Удаляем default конфигурацию (если есть)
rm -f /etc/nginx/sites-enabled/default

# Тестируем конфигурацию
nginx -t

# Перезапускаем Nginx
systemctl restart nginx
systemctl enable nginx
```

### 7. Настройка PM2
```bash
cd /var/www/nodeon-pyramid

# Запускаем приложение
pm2 start ecosystem.config.js

# Сохраняем конфигурацию PM2
pm2 save

# Настраиваем автозапуск
pm2 startup
```

### 8. Настройка firewall
```bash
# Настраиваем UFW
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable
```

### 9. Получение SSL сертификата
```bash
# Получаем SSL сертификат
certbot --nginx -d sistemypro.ru -d www.sistemypro.ru

# Перезапускаем Nginx
systemctl restart nginx
```

### 10. Проверка работы
```bash
# Проверяем статус приложения
pm2 status

# Проверяем статус Nginx
systemctl status nginx

# Проверяем здоровье приложения
curl http://localhost:3000/health

# Проверяем доступность сайта
curl -I https://sistemypro.ru
```

## 🔧 Управление

### Проверка статуса
```bash
# Статус приложения
pm2 status

# Статус Nginx
systemctl status nginx

# Логи приложения
pm2 logs nodeon-pyramid

# Логи Nginx
tail -f /var/log/nginx/error.log
```

### Обновление приложения
```bash
cd /var/www/nodeon-pyramid
./update.sh
```

### Перезапуск сервисов
```bash
# Перезапуск приложения
pm2 restart nodeon-pyramid

# Перезапуск Nginx
systemctl restart nginx
```

## 🎯 Результат

После выполнения всех шагов ваше приложение будет доступно по адресу:
- **https://sistemypro.ru**
- **https://www.sistemypro.ru**

## 📁 Итоговая структура

```
/var/www/nodeon-pyramid/          # Наше приложение
├── server.js                     # Express сервер
├── public/index.html             # Фронтенд
├── routes/                       # API endpoints
├── .env                          # Переменные окружения
└── logs/                         # Логи

/etc/nginx/sites-available/       # Конфигурации Nginx
└── nodeon-pyramid                # Наш сайт

/etc/nginx/sites-enabled/         # Активные сайты
└── nodeon-pyramid -> ../sites-available/nodeon-pyramid
```

## 🚨 Важные моменты

1. **Домен** должен быть настроен на IP `147.45.110.220`
2. **Порт 3000** должен быть свободен
3. **SSL сертификат** обязателен для Telegram Mini App
4. **Firewall** настроен для портов 22, 80, 443

## ✅ Готово!

Ваше приложение NodeOn Pyramid будет работать на Timeweb VPS в отдельной папке!
