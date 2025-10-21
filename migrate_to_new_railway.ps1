# NodeOn Pyramid - PowerShell скрипт миграции на новый Railway
# Использование: .\migrate_to_new_railway.ps1

param(
    [switch]$SkipDependencies,
    [switch]$SkipDatabase,
    [switch]$SkipBot
)

# Функции для вывода сообщений
function Write-Log {
    param([string]$Message)
    Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] $Message" -ForegroundColor Blue
}

function Write-Success {
    param([string]$Message)
    Write-Host "✅ $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "⚠️  $Message" -ForegroundColor Yellow
}

function Write-Error {
    param([string]$Message)
    Write-Host "❌ $Message" -ForegroundColor Red
}

# Проверка зависимостей
function Test-Dependencies {
    Write-Log "Проверка зависимостей..."
    
    $dependencies = @{
        "Python3" = "python"
        "pip3" = "pip"
        "Git" = "git"
        "Node.js" = "node"
        "npm" = "npm"
    }
    
    foreach ($name in $dependencies.Keys) {
        $command = $dependencies[$name]
        if (Get-Command $command -ErrorAction SilentlyContinue) {
            Write-Success "$name установлен"
        } else {
            Write-Error "$name не установлен"
            exit 1
        }
    }
    
    # Проверяем Railway CLI
    if (Get-Command railway -ErrorAction SilentlyContinue) {
        Write-Success "Railway CLI установлен"
    } else {
        Write-Warning "Railway CLI не установлен. Устанавливаем..."
        npm install -g @railway/cli
    }
}

# Установка зависимостей Python
function Install-Dependencies {
    Write-Log "Установка Python зависимостей..."
    pip install -r requirements.txt
    Write-Success "Python зависимости установлены"
}

# Настройка Railway
function Setup-Railway {
    Write-Log "Настройка Railway..."
    
    # Проверяем авторизацию
    try {
        railway whoami | Out-Null
        Write-Success "Авторизация в Railway прошла успешно"
    } catch {
        Write-Warning "Необходима авторизация в Railway"
        railway login
    }
    
    # Создаем новый проект
    Write-Log "Создание нового проекта Railway..."
    railway new --name "nodeon-pyramid"
    Write-Success "Railway проект создан"
}

# Настройка переменных окружения
function Setup-Environment {
    Write-Log "Настройка переменных окружения..."
    
    Write-Host "Введите значения для переменных окружения:" -ForegroundColor Cyan
    Write-Host ""
    
    $SUPABASE_URL = Read-Host "SUPABASE_URL"
    $SUPABASE_ANON_KEY = Read-Host "SUPABASE_ANON_KEY"
    $TELEGRAM_BOT_TOKEN = Read-Host "TELEGRAM_BOT_TOKEN"
    $DEVELOPER_TELEGRAM_ID = Read-Host "DEVELOPER_TELEGRAM_ID"
    $SECRET_KEY = Read-Host "SECRET_KEY (или нажмите Enter для автогенерации)"
    
    # Генерируем SECRET_KEY если не указан
    if ([string]::IsNullOrEmpty($SECRET_KEY)) {
        $SECRET_KEY = -join ((1..32) | ForEach {Get-Random -InputObject (0..9 + 'A'..'F')})
        Write-Log "Сгенерирован SECRET_KEY: $SECRET_KEY"
    }
    
    # Устанавливаем переменные в Railway
    railway variables set SUPABASE_URL="$SUPABASE_URL"
    railway variables set SUPABASE_ANON_KEY="$SUPABASE_ANON_KEY"
    railway variables set TELEGRAM_BOT_TOKEN="$TELEGRAM_BOT_TOKEN"
    railway variables set DEVELOPER_TELEGRAM_ID="$DEVELOPER_TELEGRAM_ID"
    railway variables set SECRET_KEY="$SECRET_KEY"
    railway variables set PORT="8000"
    railway variables set HOST="0.0.0.0"
    
    Write-Success "Переменные окружения настроены"
}

# Деплой на Railway
function Deploy-ToRailway {
    Write-Log "Деплой на Railway..."
    railway up
    Write-Success "Деплой завершен"
}

# Настройка базы данных
function Setup-Database {
    if ($SkipDatabase) {
        Write-Warning "Пропускаем настройку базы данных"
        return
    }
    
    Write-Log "Настройка базы данных..."
    python setup_database.py
    Write-Success "База данных настроена"
}

# Настройка Telegram Bot
function Setup-TelegramBot {
    if ($SkipBot) {
        Write-Warning "Пропускаем настройку Telegram Bot"
        return
    }
    
    Write-Log "Настройка Telegram Bot..."
    python setup_telegram_bot.py
    Write-Success "Telegram Bot настроен"
}

# Проверка системы
function Test-System {
    Write-Log "Проверка системы..."
    python check_system.py
    Write-Success "Проверка системы завершена"
}

# Получение URL приложения
function Get-AppUrl {
    Write-Log "Получение URL приложения..."
    try {
        $APP_URL = railway domain
        if ($APP_URL) {
            Write-Success "URL приложения: https://$APP_URL"
            $APP_URL | Out-File -FilePath "app_url.txt" -Encoding UTF8
        } else {
            Write-Warning "Не удалось получить URL приложения"
        }
    } catch {
        Write-Warning "Ошибка получения URL приложения: $_"
    }
}

# Основная функция
function Main {
    Write-Host ""
    Write-Host "🚀 NodeOn Pyramid - Миграция на новый Railway" -ForegroundColor Blue
    Write-Host "==============================================" -ForegroundColor Blue
    Write-Host ""
    
    # Проверяем, что мы в правильной директории
    if (-not (Test-Path "main.py")) {
        Write-Error "Файл main.py не найден. Запустите скрипт из корневой директории проекта."
        exit 1
    }
    
    # Выполняем шаги миграции
    if (-not $SkipDependencies) {
        Test-Dependencies
        Install-Dependencies
    }
    
    Setup-Railway
    Setup-Environment
    Deploy-ToRailway
    
    # Ждем, пока приложение запустится
    Write-Log "Ожидание запуска приложения..."
    Start-Sleep -Seconds 30
    
    Setup-Database
    Setup-TelegramBot
    Get-AppUrl
    Test-System
    
    Write-Host ""
    Write-Host "🎉 Миграция завершена успешно!" -ForegroundColor Green
    Write-Host "================================" -ForegroundColor Green
    Write-Host ""
    
    if (Test-Path "app_url.txt") {
        $APP_URL = Get-Content "app_url.txt"
        Write-Host "📱 URL приложения: https://$APP_URL" -ForegroundColor Cyan
        Write-Host "🤖 Обновите webhook в BotFather: https://$APP_URL/api/telegram/webhook" -ForegroundColor Cyan
        Write-Host "📝 Обновите Menu Button в BotFather: https://$APP_URL" -ForegroundColor Cyan
    }
    
    Write-Host ""
    Write-Host "📋 Следующие шаги:" -ForegroundColor Yellow
    Write-Host "   1. Протестируйте бота командой /start"
    Write-Host "   2. Проверьте все функции приложения"
    Write-Host "   3. Обновите документацию"
    Write-Host "   4. Уведомите пользователей о новом URL"
    
    Write-Host ""
    Write-Host "🔧 Полезные команды:" -ForegroundColor Yellow
    Write-Host "   railway logs          - Просмотр логов"
    Write-Host "   railway shell         - Подключение к контейнеру"
    Write-Host "   make check            - Проверка системы"
    Write-Host "   make setup-db         - Настройка БД"
    Write-Host "   make setup-bot        - Настройка бота"
}

# Обработка ошибок
$ErrorActionPreference = "Stop"

try {
    # Запуск основной функции
    Main
} catch {
    Write-Error "Произошла ошибка. Миграция прервана: $_"
    exit 1
}
