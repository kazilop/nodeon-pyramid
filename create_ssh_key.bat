@echo off
echo 🔑 Creating SSH Key for Passwordless Login
echo ==========================================
echo.

echo 📋 1. Creating SSH key...
ssh-keygen -t rsa -b 4096 -f %USERPROFILE%\.ssh\sistemypro_key -C "sistemypro_server" -N ""

echo.
echo 📋 2. Checking if key was created...
if exist "%USERPROFILE%\.ssh\sistemypro_key" (
    echo ✅ Private key created: %USERPROFILE%\.ssh\sistemypro_key
) else (
    echo ❌ Private key not found
    pause
    exit /b 1
)

if exist "%USERPROFILE%\.ssh\sistemypro_key.pub" (
    echo ✅ Public key created: %USERPROFILE%\.ssh\sistemypro_key.pub
) else (
    echo ❌ Public key not found
    pause
    exit /b 1
)

echo.
echo 📋 3. Displaying public key...
echo Copy this key and add it to the server:
echo ========================================
type "%USERPROFILE%\.ssh\sistemypro_key.pub"
echo ========================================

echo.
echo 📋 4. Creating SSH config...
if not exist "%USERPROFILE%\.ssh\config" (
    echo Host sistemypro > "%USERPROFILE%\.ssh\config"
    echo     HostName 147.45.110.220 >> "%USERPROFILE%\.ssh\config"
    echo     User root >> "%USERPROFILE%\.ssh\config"
    echo     IdentityFile %USERPROFILE%\.ssh\sistemypro_key >> "%USERPROFILE%\.ssh\config"
    echo     IdentitiesOnly yes >> "%USERPROFILE%\.ssh\config"
    echo ✅ SSH config created
) else (
    echo ⚠️  SSH config already exists
)

echo.
echo 📋 5. Creating connection script...
echo @echo off > connect_server.bat
echo ssh sistemypro >> connect_server.bat
echo ✅ Connection script created: connect_server.bat

echo.
echo 📋 6. Next steps:
echo.
echo 1. Copy the public key above
echo 2. Connect to server: ssh root@147.45.110.220
echo 3. Run these commands on server:
echo    mkdir -p ~/.ssh
echo    echo "PASTE_PUBLIC_KEY_HERE" ^>^> ~/.ssh/authorized_keys
echo    chmod 600 ~/.ssh/authorized_keys
echo    chmod 700 ~/.ssh
echo.
echo 4. Test connection: ssh sistemypro
echo.
echo ✅ SSH key setup completed!
pause












