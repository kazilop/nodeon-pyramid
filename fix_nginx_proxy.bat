@echo off
echo 🔧 Fixing Nginx proxy configuration
echo ===================================
echo.

set SERVER_IP=147.45.110.220
set SERVER_USER=root
set APP_DIR=/root/nodeon

echo 📋 1. Checking Nginx error logs...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "tail -20 /var/log/nginx/error.log"
echo.

echo 📋 2. Testing Nginx configuration...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "nginx -t"
echo.

echo 📋 3. Testing HTTPS API endpoint from server...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "curl -v https://sistemypro.ru/api/health"
echo.

echo 📋 4. Testing HTTPS main page from server...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "curl -v https://sistemypro.ru/"
echo.

echo 📋 5. Checking if public/index.html exists...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && ls -la public/"
echo.

echo 📋 6. Restarting Nginx...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "systemctl restart nginx"
echo.

echo 📋 7. Testing again after restart...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "curl -I https://sistemypro.ru/"
echo.

echo ✅ Fix completed!
pause

