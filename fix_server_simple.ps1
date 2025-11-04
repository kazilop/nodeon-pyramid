# Упрощенный скрипт исправления сервера NodeOn Pyramid
# Использование: .\fix_server_simple.ps1

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
Invoke-SSHCommand "cd ${AppDir}; pwd" "Переход в папку приложения"

# 3. Проверка файлов
Invoke-SSHCommand "cd ${AppDir}; ls -la" "Проверка файлов в папке приложения"

# 4. Создание .env файла
$envCommand = @"
cd ${AppDir}; cat > .env << 'EOF'
NODE_ENV=production
PORT=3000

SUPABASE_URL=https://ahxwpzgltlzlvrtrbanm.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoeHdwemdsdGx6bHZydHJiYW1tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1MDMxNDksImV4cCI6MjA3NTA3OTE0OX0.h4sMVhVwvRUiHgbevDgv9W1G2S__uDWPUSCiXdrEy4E

TELEGRAM_BOT_TOKEN=7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ
TELEGRAM_BOT_USERNAME=pro_stars_bot

SECRET_KEY=your_secret_key_here
DEVELOPER_TELEGRAM_ID=207940967
EOF
"@

Invoke-SSHCommand $envCommand "Создание .env файла"

# 5. Создание ecosystem.config.js
$ecosystemCommand = @"
cd ${AppDir}; cat > ecosystem.config.js << 'EOF'
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
EOF
"@

Invoke-SSHCommand $ecosystemCommand "Создание ecosystem.config.js"

# 6. Создание папки public
Invoke-SSHCommand "cd ${AppDir}; mkdir -p public" "Создание папки public"

# 7. Копирование index.html в public
Invoke-SSHCommand "cd ${AppDir}; if [ -f index.html ] && [ ! -f public/index.html ]; then cp index.html public/; fi" "Копирование index.html в public"

# 8. Установка зависимостей
Invoke-SSHCommand "cd ${AppDir}; npm install" "Установка зависимостей Node.js"

# 9. Остановка всех процессов PM2
Invoke-SSHCommand "pm2 stop all || true" "Остановка всех процессов PM2"

# 10. Удаление всех процессов PM2
Invoke-SSHCommand "pm2 delete all || true" "Удаление всех процессов PM2"

# 11. Запуск приложения
Invoke-SSHCommand "cd ${AppDir}; pm2 start ecosystem.config.js" "Запуск приложения через PM2"

# 12. Сохранение конфигурации PM2
Invoke-SSHCommand "pm2 save" "Сохранение конфигурации PM2"

# 13. Создание конфигурации Nginx
$nginxCommand = @"
cat > /etc/nginx/sites-available/nodeon << 'EOF'
server {
    listen 80;
    server_name sistemypro.ru www.sistemypro.ru;
    
    root ${AppDir}/public;
    index index.html;
    
    location / {
        try_files `$uri `$uri/ /index.html;
    }
    
    location /api/ {
        proxy_pass http://localhost:3000;
        proxy_set_header Host `$host;
        proxy_set_header X-Real-IP `$remote_addr;
        proxy_set_header X-Forwarded-For `$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto `$scheme;
    }
    
    location /health {
        proxy_pass http://localhost:3000;
        proxy_set_header Host `$host;
        proxy_set_header X-Real-IP `$remote_addr;
        proxy_set_header X-Forwarded-For `$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto `$scheme;
    }
}
EOF
"@

Invoke-SSHCommand $nginxCommand "Создание конфигурации Nginx"

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
Invoke-SSHCommand "curl -s http://localhost:3000/health || echo 'Health endpoint недоступен'" "Проверка health endpoint"

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
