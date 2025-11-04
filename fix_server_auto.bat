@echo off
echo 🚀 Automatic NodeOn Pyramid Server Fix
echo ======================================
echo.

set SERVER_IP=147.45.110.220
set SERVER_USER=root
set APP_DIR=/root/nodeon

echo 📋 Configuration:
echo   Server: %SERVER_USER%@%SERVER_IP%
echo   App Directory: %APP_DIR%
echo.

echo 🔐 Connecting to server...
echo Enter password for %SERVER_USER%@%SERVER_IP%:
echo.

echo 🔧 Testing server connection
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo 'Connection successful'"
if %errorlevel% neq 0 (
    echo ❌ Connection error
    pause
    exit /b 1
)
echo ✅ Connection test - completed
echo.

echo 🔧 Navigating to app directory
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && pwd"
echo ✅ Navigation to app directory - completed
echo.

echo 🔧 Checking files in app directory
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && ls -la"
echo ✅ File check - completed
echo.

echo 🔧 Creating .env file
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo NODE_ENV=production > .env"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo PORT=3000 >> .env"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo SUPABASE_URL=https://ahxwpzgltlzlvrtrbanm.supabase.co >> .env"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoeHdwemdsdGx6bHZydHJiYW1tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1MDMxNDksImV4cCI6MjA3NTA3OTE0OX0.h4sMVhVwvRUiHgbevDgv9W1G2S__uDWPUSCiXdrEy4E >> .env"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo TELEGRAM_BOT_TOKEN=7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ >> .env"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo TELEGRAM_BOT_USERNAME=pro_stars_bot >> .env"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo SECRET_KEY=your_secret_key_here >> .env"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo DEVELOPER_TELEGRAM_ID=207940967 >> .env"
echo ✅ .env file creation - completed
echo.

echo 🔧 Creating ecosystem.config.js
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo module.exports = { > ecosystem.config.js"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo '  apps: [{' >> ecosystem.config.js"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo '    name: \"nodeon-pyramid\",' >> ecosystem.config.js"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo '    script: \"server.js\",' >> ecosystem.config.js"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo '    instances: 1,' >> ecosystem.config.js"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo '    autorestart: true,' >> ecosystem.config.js"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo '    watch: false,' >> ecosystem.config.js"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo '    max_memory_restart: \"1G\",' >> ecosystem.config.js"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo '    env: {' >> ecosystem.config.js"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo '      NODE_ENV: \"production\",' >> ecosystem.config.js"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo '      PORT: 3000' >> ecosystem.config.js"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo '    }' >> ecosystem.config.js"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo '  }]' >> ecosystem.config.js"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && echo '};' >> ecosystem.config.js"
echo ✅ ecosystem.config.js creation - completed
echo.

echo 🔧 Creating public folder
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && mkdir -p public"
echo ✅ Public folder creation - completed
echo.

echo 🔧 Copying index.html to public
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && cp index.html public/"
echo ✅ index.html copy - completed
echo.

echo 🔧 Installing Node.js dependencies
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && npm install"
echo ✅ Dependencies installation - completed
echo.

echo 🔧 Stopping all PM2 processes
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "pm2 stop all"
echo ✅ PM2 processes stopped - completed
echo.

echo 🔧 Deleting all PM2 processes
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "pm2 delete all"
echo ✅ PM2 processes deleted - completed
echo.

echo 🔧 Starting application via PM2
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && pm2 start ecosystem.config.js"
echo ✅ Application started - completed
echo.

echo 🔧 Saving PM2 configuration
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "pm2 save"
echo ✅ PM2 configuration saved - completed
echo.

echo 🔧 Creating Nginx configuration
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo server { > /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '    listen 80;' >> /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '    server_name sistemypro.ru www.sistemypro.ru;' >> /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '    root %APP_DIR%/public;' >> /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '    index index.html;' >> /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '    location / {' >> /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '        try_files \$uri \$uri/ /index.html;' >> /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '    }' >> /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '    location /api/ {' >> /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '        proxy_pass http://localhost:3000;' >> /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '        proxy_set_header Host \$host;' >> /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '        proxy_set_header X-Real-IP \$remote_addr;' >> /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' >> /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '        proxy_set_header X-Forwarded-Proto \$scheme;' >> /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '    }' >> /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '    location /health {' >> /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '        proxy_pass http://localhost:3000;' >> /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '        proxy_set_header Host \$host;' >> /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '        proxy_set_header X-Real-IP \$remote_addr;' >> /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' >> /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '        proxy_set_header X-Forwarded-Proto \$scheme;' >> /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '    }' >> /etc/nginx/sites-available/nodeon"
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "echo '}' >> /etc/nginx/sites-available/nodeon"
echo ✅ Nginx configuration created - completed
echo.

echo 🔧 Activating Nginx configuration
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "ln -sf /etc/nginx/sites-available/nodeon /etc/nginx/sites-enabled/"
echo ✅ Nginx configuration activated - completed
echo.

echo 🔧 Removing default Nginx configuration
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "rm -f /etc/nginx/sites-enabled/default"
echo ✅ Default configuration removed - completed
echo.

echo 🔧 Testing Nginx configuration
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "nginx -t"
echo ✅ Nginx configuration test - completed
echo.

echo 🔧 Restarting Nginx
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "systemctl restart nginx"
echo ✅ Nginx restart - completed
echo.

echo 🔧 Checking PM2 status
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "pm2 status"
echo ✅ PM2 status check - completed
echo.

echo 🔧 Checking port 3000
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "netstat -tlnp | grep 3000"
echo ✅ Port 3000 check - completed
echo.

echo 🔧 Testing health endpoint
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "curl -s http://localhost:3000/health"
echo ✅ Health endpoint test - completed
echo.

echo 🔧 Testing website availability
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "curl -s -I http://sistemypro.ru | head -1"
echo ✅ Website availability test - completed
echo.

echo 🎉 Automatic server fix completed!
echo.
echo 📊 Result:
echo   Website: http://sistemypro.ru
echo   API: http://sistemypro.ru/api/health
echo.
echo 📋 Useful commands:
echo   ssh %SERVER_USER%@%SERVER_IP% "pm2 status"
echo   ssh %SERVER_USER%@%SERVER_IP% "pm2 logs nodeon-pyramid"
echo   ssh %SERVER_USER%@%SERVER_IP% "systemctl status nginx"
echo.
echo 🔒 To get SSL certificate, run:
echo   ssh %SERVER_USER%@%SERVER_IP% "certbot --nginx -d sistemypro.ru -d www.sistemypro.ru"
echo.
pause
