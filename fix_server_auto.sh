#!/bin/bash

# Автоматическое исправление сервера NodeOn Pyramid
# Использование: ./fix_server_auto.sh

set -e

echo "🚀 Автоматическое исправление сервера NodeOn Pyramid"
echo "=================================================="

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Конфигурация
SERVER_IP="147.45.110.220"
SERVER_USER="root"
APP_DIR="/root/nodeon"

echo -e "${BLUE}📋 Конфигурация:${NC}"
echo "  Сервер: $SERVER_USER@$SERVER_IP"
echo "  Папка приложения: $APP_DIR"
echo ""

# Функция для выполнения команд на сервере
run_ssh_command() {
    local command="$1"
    local description="$2"
    
    echo -e "${YELLOW}🔧 $description${NC}"
    ssh -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP "$command"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ $description - выполнено${NC}"
    else
        echo -e "${RED}❌ $description - ошибка${NC}"
        return 1
    fi
    echo ""
}

echo -e "${BLUE}🔐 Подключение к серверу...${NC}"
echo "Введите пароль для $SERVER_USER@$SERVER_IP:"

# 1. Проверка подключения
run_ssh_command "echo 'Подключение успешно'" "Проверка подключения к серверу"

# 2. Переход в папку приложения
run_ssh_command "cd $APP_DIR && pwd" "Переход в папку приложения"

# 3. Проверка файлов
run_ssh_command "cd $APP_DIR && ls -la" "Проверка файлов в папке приложения"

# 4. Создание .env файла
run_ssh_command "cd $APP_DIR && echo 'NODE_ENV=production' > .env" "Создание .env файла - NODE_ENV"
run_ssh_command "cd $APP_DIR && echo 'PORT=3000' >> .env" "Добавление PORT в .env"
run_ssh_command "cd $APP_DIR && echo 'SUPABASE_URL=https://ahxwpzgltlzlvrtrbanm.supabase.co' >> .env" "Добавление SUPABASE_URL в .env"
run_ssh_command "cd $APP_DIR && echo 'SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoeHdwemdsdGx6bHZydHJiYW1tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1MDMxNDksImV4cCI6MjA3NTA3OTE0OX0.h4sMVhVwvRUiHgbevDgv9W1G2S__uDWPUSCiXdrEy4E' >> .env" "Добавление SUPABASE_ANON_KEY в .env"
run_ssh_command "cd $APP_DIR && echo 'TELEGRAM_BOT_TOKEN=7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ' >> .env" "Добавление TELEGRAM_BOT_TOKEN в .env"
run_ssh_command "cd $APP_DIR && echo 'TELEGRAM_BOT_USERNAME=pro_stars_bot' >> .env" "Добавление TELEGRAM_BOT_USERNAME в .env"
run_ssh_command "cd $APP_DIR && echo 'SECRET_KEY=your_secret_key_here' >> .env" "Добавление SECRET_KEY в .env"
run_ssh_command "cd $APP_DIR && echo 'DEVELOPER_TELEGRAM_ID=207940967' >> .env" "Добавление DEVELOPER_TELEGRAM_ID в .env"

# 5. Создание ecosystem.config.js
run_ssh_command "cd $APP_DIR && cat > ecosystem.config.js << 'EOF'
module.exports = {
  apps: [{
    name: 'nodeon-pyramid',
    script: 'server.js',
    instances: 1,
    autorestart: true,
    watch: false,
    max_memory_restart: '1G',
    env: {
      NODE_ENV: 'production',
      PORT: 3000
    },
    error_file: './logs/err.log',
    out_file: './logs/out.log',
    log_file: './logs/combined.log',
    time: true
  }]
};
EOF" "Создание ecosystem.config.js"

# 6. Создание папки public
run_ssh_command "cd $APP_DIR && mkdir -p public" "Создание папки public"

# 7. Копирование index.html в public
run_ssh_command "cd $APP_DIR && cp index.html public/" "Копирование index.html в public"

# 8. Установка зависимостей
run_ssh_command "cd $APP_DIR && npm install" "Установка зависимостей Node.js"

# 9. Остановка всех процессов PM2
run_ssh_command "pm2 stop all || true" "Остановка всех процессов PM2"

# 10. Удаление всех процессов PM2
run_ssh_command "pm2 delete all || true" "Удаление всех процессов PM2"

# 11. Запуск приложения
run_ssh_command "cd $APP_DIR && pm2 start ecosystem.config.js" "Запуск приложения через PM2"

# 12. Сохранение конфигурации PM2
run_ssh_command "pm2 save" "Сохранение конфигурации PM2"

# 13. Создание конфигурации Nginx
run_ssh_command "cat > /etc/nginx/sites-available/nodeon << 'EOF'
server {
    listen 80;
    server_name sistemypro.ru www.sistemypro.ru;
    
    root $APP_DIR/public;
    index index.html;
    
    location / {
        try_files \$uri \$uri/ /index.html;
    }
    
    location /api/ {
        proxy_pass http://localhost:3000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
    
    location /health {
        proxy_pass http://localhost:3000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF" "Создание конфигурации Nginx"

# 14. Активация конфигурации Nginx
run_ssh_command "ln -sf /etc/nginx/sites-available/nodeon /etc/nginx/sites-enabled/" "Активация конфигурации Nginx"

# 15. Удаление default конфигурации
run_ssh_command "rm -f /etc/nginx/sites-enabled/default" "Удаление default конфигурации Nginx"

# 16. Проверка конфигурации Nginx
run_ssh_command "nginx -t" "Проверка конфигурации Nginx"

# 17. Перезапуск Nginx
run_ssh_command "systemctl restart nginx" "Перезапуск Nginx"

# 18. Проверка статуса сервисов
run_ssh_command "pm2 status" "Проверка статуса PM2"

# 19. Проверка порта 3000
run_ssh_command "netstat -tlnp | grep 3000" "Проверка порта 3000"

# 20. Проверка health endpoint
run_ssh_command "curl -s http://localhost:3000/health || echo 'Health endpoint недоступен'" "Проверка health endpoint"

# 21. Проверка сайта
run_ssh_command "curl -s -I http://sistemypro.ru | head -1" "Проверка доступности сайта"

echo -e "${GREEN}🎉 Автоматическое исправление завершено!${NC}"
echo ""
echo -e "${BLUE}📊 Результат:${NC}"
echo "  Сайт: http://sistemypro.ru"
echo "  API: http://sistemypro.ru/api/health"
echo ""
echo -e "${BLUE}📋 Полезные команды:${NC}"
echo "  ssh $SERVER_USER@$SERVER_IP 'pm2 status'"
echo "  ssh $SERVER_USER@$SERVER_IP 'pm2 logs nodeon-pyramid'"
echo "  ssh $SERVER_USER@$SERVER_IP 'systemctl status nginx'"
echo ""
echo -e "${YELLOW}🔒 Для получения SSL сертификата выполните:${NC}"
echo "  ssh $SERVER_USER@$SERVER_IP 'certbot --nginx -d sistemypro.ru -d www.sistemypro.ru'"
