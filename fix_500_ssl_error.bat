@echo off
echo 🔧 Fixing 500 Internal Server Error after SSL
echo ============================================
echo.

set SERVER_IP=147.45.110.220
set SERVER_USER=root
set APP_DIR=/root/nodeon

echo 📋 1. Checking PM2 status...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "pm2 status"
echo.

echo 📋 2. Checking if port 3000 is listening...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "netstat -tlnp | grep 3000"
echo.

echo 📋 3. Checking PM2 logs for errors...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "pm2 logs nodeon-pyramid --lines 10"
echo.

echo 📋 4. Restarting PM2 application...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && pm2 restart nodeon-pyramid"
echo.

echo 📋 5. Waiting 5 seconds...
timeout /t 5 /nobreak
echo.

echo 📋 6. Checking PM2 status again...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "pm2 status"
echo.

echo 📋 7. Testing local app connection...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "curl -s http://localhost:3000/health"
echo.

echo 📋 8. Restarting Nginx...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "systemctl restart nginx"
echo.

echo 📋 9. Checking Nginx status...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "systemctl status nginx --no-pager"
echo.

echo 📋 10. Testing HTTPS connection...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "curl -s -I https://sistemypro.ru"
echo.

echo ✅ Fix completed!
echo.
echo 🌐 Test your website:
echo   https://sistemypro.ru
echo.
pause

