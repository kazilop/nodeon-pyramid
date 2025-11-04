@echo off
echo 🔍 Diagnosing 500 Internal Server Error
echo ======================================
echo.

set SERVER_IP=147.45.110.220
set SERVER_USER=root
set APP_DIR=/root/nodeon

echo 📋 1. Checking PM2 status...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "pm2 status"
echo.

echo 📋 2. Checking port 3000...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "netstat -tlnp | grep 3000"
echo.

echo 📋 3. Checking PM2 logs...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "pm2 logs nodeon-pyramid --lines 20"
echo.

echo 📋 4. Checking Nginx logs...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "tail -20 /var/log/nginx/error.log"
echo.

echo 📋 5. Checking file structure...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && ls -la"
echo.

echo 📋 6. Checking server.js...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && ls -la server.js"
echo.

echo 📋 7. Checking package.json...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && ls -la package.json"
echo.

echo 📋 8. Checking .env file...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && cat .env"
echo.

echo 📋 9. Testing local app connection...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "curl -v http://localhost:3000/health"
echo.

echo 📋 10. Checking Nginx configuration...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cat /etc/nginx/sites-available/nodeon"
echo.

echo ✅ Diagnosis completed!
pause
