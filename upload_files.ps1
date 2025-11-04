# Скрипт для загрузки файлов на сервер
$SERVER = "147.45.110.220"
$USER = "root"
$PASSWORD = "cogZE.f+5-^BN6"
$REMOTE_PATH = "/root/nodeon"

Write-Host "🚀 Загрузка файлов на сервер..." -ForegroundColor Yellow

# Используем PSCP (PuTTY) для загрузки
$pscpPath = "C:\Program Files\PuTTY\pscp.exe"

if (Test-Path $pscpPath) {
    Write-Host "✅ PSCP найден" -ForegroundColor Green
} else {
    Write-Host "❌ PSCP не найден. Установите PuTTY." -ForegroundColor Red
    exit 1
}

# Загрузка файлов
$files = @(
    @{Local="server-deployment\routes\pro.js"; Remote="$REMOTE_PATH/routes/pro.js"},
    @{Local="server-deployment\routes\payments.js"; Remote="$REMOTE_PATH/routes/payments.js"},
    @{Local="server-deployment\server.js"; Remote="$REMOTE_PATH/server.js"},
    @{Local="server-deployment\public\index.html"; Remote="$REMOTE_PATH/public/index.html"}
)

foreach ($file in $files) {
    $local = $file.Local
    $remote = $file.Remote
    
    if (Test-Path $local) {
        Write-Host "📤 Загрузка: $local" -ForegroundColor Cyan
        
        $args = "-pw", $PASSWORD, $local, "$USER@$SERVER`:$remote"
        & $pscpPath $args
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Загружено" -ForegroundColor Green
        } else {
            Write-Host "❌ Ошибка загрузки" -ForegroundColor Red
        }
    } else {
        Write-Host "⚠️ Файл не найден: $local" -ForegroundColor Yellow
    }
}

Write-Host "`n🔄 Перезапуск сервера..." -ForegroundColor Yellow

# Подключение к серверу и перезапуск
$session = New-SSHSession -ComputerName $SERVER -Credential (New-Object System.Management.Automation.PSCredential($USER, (ConvertTo-SecureString $PASSWORD -AsPlainText -Force))) -AcceptKey

if ($session) {
    # Перезапуск PM2
    $command = "cd $REMOTE_PATH; pm2 restart nodeon-pyramid"
    Invoke-SSHCommand -SessionId $session.SessionId -Command $command
    
    # Проверка статуса
    Write-Host "`n📊 Статус сервера:" -ForegroundColor Cyan
    Invoke-SSHCommand -SessionId $session.SessionId -Command "pm2 status nodeon-pyramid"
    
    # Логи
    Write-Host "`n📋 Последние логи:" -ForegroundColor Cyan
    Invoke-SSHCommand -SessionId $session.SessionId -Command "pm2 logs nodeon-pyramid --lines 20 --nostream"
    
    Remove-SSHSession -SessionId $session.SessionId
} else {
    Write-Host "❌ Не удалось подключиться к серверу" -ForegroundColor Red
}

Write-Host "`n✅ Готово!" -ForegroundColor Green










