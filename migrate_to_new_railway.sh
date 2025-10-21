#!/bin/bash

# NodeOn Pyramid - Скрипт быстрой миграции на новый Railway
# Использование: ./migrate_to_new_railway.sh

set -e  # Остановить при ошибке

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Функция для вывода сообщений
log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

success() {
    echo -e "${GREEN}✅ $1${NC}"
}

warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

error() {
    echo -e "${RED}❌ $1${NC}"
}

# Проверка зависимостей
check_dependencies() {
    log "Проверка зависимостей..."
    
    if ! command -v python3 &> /dev/null; then
        error "Python3 не установлен"
        exit 1
    fi
    
    if ! command -v pip3 &> /dev/null; then
        error "pip3 не установлен"
        exit 1
    fi
    
    if ! command -v railway &> /dev/null; then
        warning "Railway CLI не установлен. Устанавливаем..."
        npm install -g @railway/cli
    fi
    
    if ! command -v git &> /dev/null; then
        error "Git не установлен"
        exit 1
    fi
    
    success "Все зависимости установлены"
}

# Установка зависимостей Python
install_dependencies() {
    log "Установка Python зависимостей..."
    pip3 install -r requirements.txt
    success "Python зависимости установлены"
}

# Настройка Railway
setup_railway() {
    log "Настройка Railway..."
    
    # Проверяем, авторизован ли пользователь
    if ! railway whoami &> /dev/null; then
        warning "Необходима авторизация в Railway"
        railway login
    fi
    
    # Создаем новый проект
    log "Создание нового проекта Railway..."
    railway new --name "nodeon-pyramid"
    
    success "Railway проект создан"
}

# Настройка переменных окружения
setup_environment() {
    log "Настройка переменных окружения..."
    
    echo "Введите значения для переменных окружения:"
    echo
    
    read -p "SUPABASE_URL: " SUPABASE_URL
    read -p "SUPABASE_ANON_KEY: " SUPABASE_ANON_KEY
    read -p "TELEGRAM_BOT_TOKEN: " TELEGRAM_BOT_TOKEN
    read -p "DEVELOPER_TELEGRAM_ID: " DEVELOPER_TELEGRAM_ID
    read -p "SECRET_KEY (или нажмите Enter для автогенерации): " SECRET_KEY
    
    # Генерируем SECRET_KEY если не указан
    if [ -z "$SECRET_KEY" ]; then
        SECRET_KEY=$(openssl rand -hex 32)
        log "Сгенерирован SECRET_KEY: $SECRET_KEY"
    fi
    
    # Устанавливаем переменные в Railway
    railway variables set SUPABASE_URL="$SUPABASE_URL"
    railway variables set SUPABASE_ANON_KEY="$SUPABASE_ANON_KEY"
    railway variables set TELEGRAM_BOT_TOKEN="$TELEGRAM_BOT_TOKEN"
    railway variables set DEVELOPER_TELEGRAM_ID="$DEVELOPER_TELEGRAM_ID"
    railway variables set SECRET_KEY="$SECRET_KEY"
    railway variables set PORT="8000"
    railway variables set HOST="0.0.0.0"
    
    success "Переменные окружения настроены"
}

# Деплой на Railway
deploy_to_railway() {
    log "Деплой на Railway..."
    railway up
    success "Деплой завершен"
}

# Настройка базы данных
setup_database() {
    log "Настройка базы данных..."
    python3 setup_database.py
    success "База данных настроена"
}

# Настройка Telegram Bot
setup_telegram_bot() {
    log "Настройка Telegram Bot..."
    python3 setup_telegram_bot.py
    success "Telegram Bot настроен"
}

# Проверка системы
check_system() {
    log "Проверка системы..."
    python3 check_system.py
    success "Проверка системы завершена"
}

# Получение URL приложения
get_app_url() {
    log "Получение URL приложения..."
    APP_URL=$(railway domain)
    if [ -n "$APP_URL" ]; then
        success "URL приложения: https://$APP_URL"
        echo "https://$APP_URL" > app_url.txt
    else
        warning "Не удалось получить URL приложения"
    fi
}

# Основная функция
main() {
    echo -e "${BLUE}"
    echo "🚀 NodeOn Pyramid - Миграция на новый Railway"
    echo "=============================================="
    echo -e "${NC}"
    
    # Проверяем, что мы в правильной директории
    if [ ! -f "main.py" ]; then
        error "Файл main.py не найден. Запустите скрипт из корневой директории проекта."
        exit 1
    fi
    
    # Выполняем шаги миграции
    check_dependencies
    install_dependencies
    setup_railway
    setup_environment
    deploy_to_railway
    
    # Ждем, пока приложение запустится
    log "Ожидание запуска приложения..."
    sleep 30
    
    setup_database
    setup_telegram_bot
    get_app_url
    check_system
    
    echo -e "${GREEN}"
    echo "🎉 Миграция завершена успешно!"
    echo "================================"
    echo -e "${NC}"
    
    if [ -f "app_url.txt" ]; then
        APP_URL=$(cat app_url.txt)
        echo "📱 URL приложения: $APP_URL"
        echo "🤖 Обновите webhook в BotFather: $APP_URL/api/telegram/webhook"
        echo "📝 Обновите Menu Button в BotFather: $APP_URL"
    fi
    
    echo
    echo "📋 Следующие шаги:"
    echo "   1. Протестируйте бота командой /start"
    echo "   2. Проверьте все функции приложения"
    echo "   3. Обновите документацию"
    echo "   4. Уведомите пользователей о новом URL"
    
    echo
    echo "🔧 Полезные команды:"
    echo "   railway logs          - Просмотр логов"
    echo "   railway shell         - Подключение к контейнеру"
    echo "   make check            - Проверка системы"
    echo "   make setup-db         - Настройка БД"
    echo "   make setup-bot        - Настройка бота"
}

# Обработка ошибок
trap 'error "Произошла ошибка. Миграция прервана."; exit 1' ERR

# Запуск основной функции
main "$@"
