@echo off
echo 🔧 Fixing Nginx redirect cycle error
echo ====================================
echo.

set SERVER_IP=147.45.110.220
set SERVER_USER=root
set APP_DIR=/root/nodeon

echo 📋 1. Creating corrected Nginx configuration...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cat > /etc/nginx/sites-available/nodeon << 'EOF'
server {
    listen 443 ssl;
    server_name sistemypro.ru www.sistemypro.ru;
    
    ssl_certificate /etc/letsencrypt/live/sistemypro.ru/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/sistemypro.ru/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
    
    root %APP_DIR%/public;
    index index.html;
    
    # Serve static files directly
    location / {
        try_files \$uri \$uri/ @fallback;
    }
    
    # Fallback to index.html for SPA routing
    location @fallback {
        try_files /index.html =404;
    }
    
    # API routes - proxy to Node.js
    location /api/ {
        proxy_pass http://localhost:3000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_set_header X-Forwarded-Host \$host;
        proxy_set_header X-Forwarded-Port \$server_port;
    }
    
    # Health check - proxy to Node.js
    location /health {
        proxy_pass http://localhost:3000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}

server {
    listen 80;
    server_name sistemypro.ru www.sistemypro.ru;
    return 301 https://\$host\$request_uri;
}
EOF"
echo.

echo 📋 2. Testing Nginx configuration...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "nginx -t"
echo.

echo 📋 3. Restarting Nginx...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "systemctl restart nginx"
echo.

echo 📋 4. Checking Nginx status...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "systemctl status nginx --no-pager"
echo.

echo 📋 5. Testing HTTPS main page...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "curl -I https://sistemypro.ru/"
echo.

echo 📋 6. Testing HTTPS API...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "curl -I https://sistemypro.ru/api/health"
echo.

echo ✅ Fix completed!
echo.
echo 🌐 Test your website:
echo   https://sistemypro.ru
echo.
pause

