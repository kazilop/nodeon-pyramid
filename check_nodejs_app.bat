@echo off
echo 🔍 Checking Node.js application on port 3000
echo ============================================
echo.

set SERVER_IP=147.45.110.220
set SERVER_USER=root
set APP_DIR=/root/nodeon

echo 📋 1. Checking if port 3000 is listening...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "netstat -tlnp | grep 3000"
echo.

echo 📋 2. Checking PM2 status...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "pm2 status"
echo.

echo 📋 3. Testing direct connection to localhost:3000...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "curl -v http://localhost:3000/health"
echo.

echo 📋 4. Checking PM2 logs for errors...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "pm2 logs nodeon-pyramid --lines 10"
echo.

echo 📋 5. Checking if server.js exists...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && ls -la server.js"
echo.

echo 📋 6. Checking .env file...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && cat .env"
echo.

echo 📋 7. Checking package.json...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "cd %APP_DIR% && head -20 package.json"
echo.

echo ✅ Check completed!
pause

