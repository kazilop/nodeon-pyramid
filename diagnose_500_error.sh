#!/bin/bash

echo "🔍 Диагностика ошибки 500 Internal Server Error"
echo "=============================================="
echo

SERVER_IP="147.45.110.220"
SERVER_USER="root"
APP_DIR="/root/nodeon"

echo "📋 1. Проверка статуса PM2..."
ssh -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP "pm2 status"
echo

echo "📋 2. Проверка порта 3000..."
ssh -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP "netstat -tlnp | grep 3000"
echo

echo "📋 3. Проверка логов PM2..."
ssh -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP "pm2 logs nodeon-pyramid --lines 20"
echo

echo "📋 4. Проверка логов Nginx..."
ssh -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP "tail -20 /var/log/nginx/error.log"
echo

echo "📋 5. Проверка структуры файлов..."
ssh -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP "cd $APP_DIR && ls -la"
echo

echo "📋 6. Проверка наличия server.js..."
ssh -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP "cd $APP_DIR && ls -la server.js"
echo

echo "📋 7. Проверка наличия package.json..."
ssh -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP "cd $APP_DIR && ls -la package.json"
echo

echo "📋 8. Проверка .env файла..."
ssh -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP "cd $APP_DIR && cat .env"
echo

echo "📋 9. Тест локального подключения к приложению..."
ssh -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP "curl -v http://localhost:3000/health"
echo

echo "📋 10. Проверка конфигурации Nginx..."
ssh -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP "cat /etc/nginx/sites-available/nodeon"
echo

echo "✅ Диагностика завершена!"
