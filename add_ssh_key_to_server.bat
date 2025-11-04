@echo off
echo 🔑 Adding SSH Key to Server
echo ============================
echo.

set SERVER_IP=147.45.110.220
set SERVER_USER=root

echo 📋 1. Reading public key...
set /p PUBLIC_KEY=<%USERPROFILE%\.ssh\sistemypro_key.pub

echo Public key: %PUBLIC_KEY%
echo.

echo 📋 2. Adding key to server...
ssh -o StrictHostKeyChecking=no %SERVER_USER%@%SERVER_IP% "mkdir -p ~/.ssh && echo '%PUBLIC_KEY%' >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && chmod 700 ~/.ssh"

echo.
echo 📋 3. Testing connection...
ssh -o StrictHostKeyChecking=no -i %USERPROFILE%\.ssh\sistemypro_key %SERVER_USER%@%SERVER_IP% "echo 'SSH key authentication successful!'"

echo.
echo ✅ SSH key added to server!
echo.
echo 📋 4. You can now connect using:
echo    ssh sistemypro
echo    or
echo    .\connect_server.bat
echo.
pause












