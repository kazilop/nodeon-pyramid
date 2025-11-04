# Финальный скрипт исправления сервера NodeOn Pyramid
# Использование: .\fix_server_final.ps1

param(
    [string]$ServerIP = "147.45.110.220",
    [string]$ServerUser = "root",
    [string]$AppDir = "/root/nodeon"
)

Write-Host "🚀 Автоматическое исправление сервера NodeOn Pyramid" -ForegroundColor Blue
Write-Host "==================================================" -ForegroundColor Blue

Write-Host "📋 Конфигурация:" -ForegroundColor Blue
Write-Host "  Сервер: ${ServerUser}@${ServerIP}" -ForegroundColor White
Write-Host "  Папка приложения: ${AppDir}" -ForegroundColor White
Write-Host ""

Write-Host "🔐 Подключение к серверу..." -ForegroundColor Blue
Write-Host "Введите пароль для ${ServerUser}@${ServerIP}:"

# Функция для выполнения команд на сервере
function Invoke-SSHCommand {
    param(
        [string]$Command,
        [string]$Description
    )
    
    Write-Host "🔧 $Description" -ForegroundColor Yellow
    
    try {
        $result = ssh -o StrictHostKeyChecking=no "${ServerUser}@${ServerIP}" $Command
        Write-Host "✅ $Description - выполнено" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "❌ $Description - ошибка" -ForegroundColor Red
        return $false
    }
    Write-Host ""
}

# 1. Проверка подключения
Invoke-SSHCommand "echo 'Подключение успешно'" "Проверка подключения к серверу"

# 2. Переход в папку приложения
Invoke-SSHCommand "cd ${AppDir}" "Переход в папку приложения"

# 3. Проверка файлов
Invoke-SSHCommand "ls -la" "Проверка файлов в папке приложения"

# 4. Создание .env файла
Invoke-SSHCommand "echo 'NODE_ENV=production' > .env" "Создание .env файла - NODE_ENV"
Invoke-SSHCommand "echo 'PORT=3000' >> .env" "Добавление PORT в .env"
Invoke-SSHCommand "echo 'SUPABASE_URL=https://ahxwpzgltlzlvrtrbanm.supabase.co' >> .env" "Добавление SUPABASE_URL в .env"
Invoke-SSHCommand "echo 'SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoeHdwemdsdGx6bHZydHJiYW1tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1MDMxNDksImV4cCI6MjA3NTA3OTE0OX0.h4sMVhVwvRUiHgbevDgv9W1G2S__uDWPUSCiXdrEy4E' >> .env" "Добавление SUPABASE_ANON_KEY в .env"
Invoke-SSHCommand "echo 'TELEGRAM_BOT_TOKEN=7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ' >> .env" "Добавление TELEGRAM_BOT_TOKEN в .env"
Invoke-SSHCommand "echo 'TELEGRAM_BOT_USERNAME=pro_stars_bot' >> .env" "Добавление TELEGRAM_BOT_USERNAME в .env"
Invoke-SSHCommand "echo 'SECRET_KEY=your_secret_key_here' >> .env" "Добавление SECRET_KEY в .env"
Invoke-SSHCommand "echo 'DEVELOPER_TELEGRAM_ID=207940967' >> .env" "Добавление DEVELOPER_TELEGRAM_ID в .env"

# 5. Создание ecosystem.config.js
Invoke-SSHCommand "echo 'module.exports = {' > ecosystem.config.js" "Создание ecosystem.config.js"
Invoke-SSHCommand "echo '  apps: [{' >> ecosystem.config.js" "Добавление apps в ecosystem.config.js"
Invoke-SSHCommand "echo '    name: \"nodeon-pyramid\",' >> ecosystem.config.js" "Добавление name в ecosystem.config.js"
Invoke-SSHCommand "echo '    script: \"server.js\",' >> ecosystem.config.js" "Добавление script в ecosystem.config.js"
Invoke-SSHCommand "echo '    instances: 1,' >> ecosystem.config.js" "Добавление instances в ecosystem.config.js"
Invoke-SSHCommand "echo '    autorestart: true,' >> ecosystem.config.js" "Добавление autorestart в ecosystem.config.js"
Invoke-SSHCommand "echo '    watch: false,' >> ecosystem.config.js" "Добавление watch в ecosystem.config.js"
Invoke-SSHCommand "echo '    max_memory_restart: \"1G\",' >> ecosystem.config.js" "Добавление max_memory_restart в ecosystem.config.js"
Invoke-SSHCommand "echo '    env: {' >> ecosystem.config.js" "Добавление env в ecosystem.config.js"
Invoke-SSHCommand "echo '      NODE_ENV: \"production\",' >> ecosystem.config.js" "Добавление NODE_ENV в ecosystem.config.js"
Invoke-SSHCommand "echo '      PORT: 3000' >> ecosystem.config.js" "Добавление PORT в ecosystem.config.js"
Invoke-SSHCommand "echo '    }' >> ecosystem.config.js" "Закрытие env в ecosystem.config.js"
Invoke-SSHCommand "echo '  }]' >> ecosystem.config.js" "Закрытие apps в ecosystem.config.js"
Invoke-SSHCommand "echo '};' >> ecosystem.config.js" "Закрытие module.exports в ecosystem.config.js"

# 6. Создание папки public
Invoke-SSHCommand "mkdir -p public" "Создание папки public"

# 7. Копирование index.html в public
Invoke-SSHCommand "cp index.html public/" "Копирование index.html в public"

# 8. Установка зависимостей
Invoke-SSHCommand "npm install" "Установка зависимостей Node.js"

# 9. Остановка всех процессов PM2
Invoke-SSHCommand "pm2 stop all" "Остановка всех процессов PM2"

# 10. Удаление всех процессов PM2
Invoke-SSHCommand "pm2 delete all" "Удаление всех процессов PM2"

# 11. Запуск приложения
Invoke-SSHCommand "pm2 start ecosystem.config.js" "Запуск приложения через PM2"

# 12. Сохранение конфигурации PM2
Invoke-SSHCommand "pm2 save" "Сохранение конфигурации PM2"

# 13. Создание конфигурации Nginx
Invoke-SSHCommand "echo 'server {' > /etc/nginx/sites-available/nodeon" "Создание конфигурации Nginx"
Invoke-SSHCommand "echo '    listen 80;' >> /etc/nginx/sites-available/nodeon" "Добавление listen в Nginx"
Invoke-SSHCommand "echo '    server_name sistemypro.ru www.sistemypro.ru;' >> /etc/nginx/sites-available/nodeon" "Добавление server_name в Nginx"
Invoke-SSHCommand "echo '    root ${AppDir}/public;' >> /etc/nginx/sites-available/nodeon" "Добавление root в Nginx"
Invoke-SSHCommand "echo '    index index.html;' >> /etc/nginx/sites-available/nodeon" "Добавление index в Nginx"
Invoke-SSHCommand "echo '    location / {' >> /etc/nginx/sites-available/nodeon" "Добавление location / в Nginx"
Invoke-SSHCommand "echo '        try_files \$uri \$uri/ /index.html;' >> /etc/nginx/sites-available/nodeon" "Добавление try_files в Nginx"
Invoke-SSHCommand "echo '    }' >> /etc/nginx/sites-available/nodeon" "Закрытие location / в Nginx"
Invoke-SSHCommand "echo '    location /api/ {' >> /etc/nginx/sites-available/nodeon" "Добавление location /api/ в Nginx"
Invoke-SSHCommand "echo '        proxy_pass http://localhost:3000;' >> /etc/nginx/sites-available/nodeon" "Добавление proxy_pass в Nginx"
Invoke-SSHCommand "echo '        proxy_set_header Host \$host;' >> /etc/nginx/sites-available/nodeon" "Добавление proxy_set_header Host в Nginx"
Invoke-SSHCommand "echo '        proxy_set_header X-Real-IP \$remote_addr;' >> /etc/nginx/sites-available/nodeon" "Добавление proxy_set_header X-Real-IP в Nginx"
Invoke-SSHCommand "echo '        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' >> /etc/nginx/sites-available/nodeon" "Добавление proxy_set_header X-Forwarded-For в Nginx"
Invoke-SSHCommand "echo '        proxy_set_header X-Forwarded-Proto \$scheme;' >> /etc/nginx/sites-available/nodeon" "Добавление proxy_set_header X-Forwarded-Proto в Nginx"
Invoke-SSHCommand "echo '    }' >> /etc/nginx/sites-available/nodeon" "Закрытие location /api/ в Nginx"
Invoke-SSHCommand "echo '    location /health {' >> /etc/nginx/sites-available/nodeon" "Добавление location /health в Nginx"
Invoke-SSHCommand "echo '        proxy_pass http://localhost:3000;' >> /etc/nginx/sites-available/nodeon" "Добавление proxy_pass для health в Nginx"
Invoke-SSHCommand "echo '        proxy_set_header Host \$host;' >> /etc/nginx/sites-available/nodeon" "Добавление proxy_set_header Host для health в Nginx"
Invoke-SSHCommand "echo '        proxy_set_header X-Real-IP \$remote_addr;' >> /etc/nginx/sites-available/nodeon" "Добавление proxy_set_header X-Real-IP для health в Nginx"
Invoke-SSHCommand "echo '        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' >> /etc/nginx/sites-available/nodeon" "Добавление proxy_set_header X-Forwarded-For для health в Nginx"
Invoke-SSHCommand "echo '        proxy_set_header X-Forwarded-Proto \$scheme;' >> /etc/nginx/sites-available/nodeon" "Добавление proxy_set_header X-Forwarded-Proto для health в Nginx"
Invoke-SSHCommand "echo '    }' >> /etc/nginx/sites-available/nodeon" "Закрытие location /health в Nginx"
Invoke-SSHCommand "echo '}' >> /etc/nginx/sites-available/nodeon" "Закрытие server в Nginx"

# 14. Активация конфигурации Nginx
Invoke-SSHCommand "ln -sf /etc/nginx/sites-available/nodeon /etc/nginx/sites-enabled/" "Активация конфигурации Nginx"

# 15. Удаление default конфигурации
Invoke-SSHCommand "rm -f /etc/nginx/sites-enabled/default" "Удаление default конфигурации Nginx"

# 16. Проверка конфигурации Nginx
Invoke-SSHCommand "nginx -t" "Проверка конфигурации Nginx"

# 17. Перезапуск Nginx
Invoke-SSHCommand "systemctl restart nginx" "Перезапуск Nginx"

# 18. Проверка статуса сервисов
Invoke-SSHCommand "pm2 status" "Проверка статуса PM2"

# 19. Проверка порта 3000
Invoke-SSHCommand "netstat -tlnp | grep 3000" "Проверка порта 3000"

# 20. Проверка health endpoint
Invoke-SSHCommand "curl -s http://localhost:3000/health" "Проверка health endpoint"

# 21. Проверка сайта
Invoke-SSHCommand "curl -s -I http://sistemypro.ru | head -1" "Проверка доступности сайта"

Write-Host "🎉 Автоматическое исправление завершено!" -ForegroundColor Green
Write-Host ""
Write-Host "📊 Результат:" -ForegroundColor Blue
Write-Host "  Сайт: http://sistemypro.ru" -ForegroundColor White
Write-Host "  API: http://sistemypro.ru/api/health" -ForegroundColor White
Write-Host ""
Write-Host "📋 Полезные команды:" -ForegroundColor Blue
Write-Host "  ssh ${ServerUser}@${ServerIP} 'pm2 status'" -ForegroundColor White
Write-Host "  ssh ${ServerUser}@${ServerIP} 'pm2 logs nodeon-pyramid'" -ForegroundColor White
Write-Host "  ssh ${ServerUser}@${ServerIP} 'systemctl status nginx'" -ForegroundColor White
Write-Host ""
Write-Host "🔒 Для получения SSL сертификата выполните:" -ForegroundColor Yellow
Write-Host "  ssh ${ServerUser}@${ServerIP} 'certbot --nginx -d sistemypro.ru -d www.sistemypro.ru'" -ForegroundColor White
