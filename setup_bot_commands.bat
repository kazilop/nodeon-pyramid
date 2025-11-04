@echo off
echo 🤖 Setting up Telegram Bot
echo ==========================
echo.

set SERVER_IP=147.45.110.220
set SERVER_USER=root
set BOT_TOKEN=7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ
set WEBHOOK_URL=https://sistemypro.ru/api/telegram/webhook

echo 📋 1. Setting up webhook...
curl -X POST "https://api.telegram.org/bot%BOT_TOKEN%/setWebhook" -H "Content-Type: application/json" -d "{\"url\": \"%WEBHOOK_URL%\", \"allowed_updates\": [\"message\", \"callback_query\"]}"
echo.

echo 📋 2. Checking webhook status...
curl "https://api.telegram.org/bot%BOT_TOKEN%/getWebhookInfo"
echo.

echo 📋 3. Setting up bot commands...
curl -X POST "https://api.telegram.org/bot%BOT_TOKEN%/setMyCommands" -H "Content-Type: application/json" -d "{\"commands\": [{\"command\": \"start\", \"description\": \"🚀 Запустить игру NodeOn\"}, {\"command\": \"play\", \"description\": \"🎮 Открыть игру\"}, {\"command\": \"balance\", \"description\": \"💰 Проверить баланс NDN\"}, {\"command\": \"referral\", \"description\": \"👥 Моя реферальная ссылка\"}, {\"command\": \"help\", \"description\": \"❓ Помощь и правила\"}]}"
echo.

echo 📋 4. Setting up start button...
curl -X POST "https://api.telegram.org/bot%BOT_TOKEN%/setChatMenuButton" -H "Content-Type: application/json" -d "{\"menu_button\": {\"type\": \"web_app\", \"text\": \"🎮 Играть\", \"web_app\": {\"url\": \"https://sistemypro.ru/\"}}}"
echo.

echo 📋 5. Testing webhook endpoint...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "curl -I %WEBHOOK_URL%"
echo.

echo 📋 6. Checking PM2 status...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "pm2 status"
echo.

echo ✅ Bot setup completed!
echo.
echo 🤖 Bot: @pro_stars_bot
echo 🌐 Game: https://sistemypro.ru/
echo.
echo 📱 Test the bot by sending /start to @pro_stars_bot
echo.
pause

