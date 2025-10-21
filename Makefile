# NodeOn Pyramid - Makefile для управления проектом

.PHONY: help install dev build deploy test clean setup-db setup-bot check

# Переменные
PYTHON = python3
PIP = pip3
RAILWAY = railway

# Цвета для вывода
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
BLUE = \033[0;34m
NC = \033[0m # No Color

help: ## Показать справку
	@echo "$(BLUE)NodeOn Pyramid - Команды управления$(NC)"
	@echo "=================================="
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "$(GREEN)%-15s$(NC) %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: ## Установить зависимости
	@echo "$(YELLOW)Установка зависимостей...$(NC)"
	$(PIP) install -r requirements.txt
	@echo "$(GREEN)✅ Зависимости установлены$(NC)"

dev: ## Запустить в режиме разработки
	@echo "$(YELLOW)Запуск в режиме разработки...$(NC)"
	uvicorn main:app --reload --host 0.0.0.0 --port 8000

build: ## Собрать Docker образ
	@echo "$(YELLOW)Сборка Docker образа...$(NC)"
	docker build -t nodeon-pyramid .
	@echo "$(GREEN)✅ Docker образ собран$(NC)"

deploy: ## Деплой на Railway
	@echo "$(YELLOW)Деплой на Railway...$(NC)"
	$(RAILWAY) up
	@echo "$(GREEN)✅ Деплой завершен$(NC)"

test: ## Запустить тесты
	@echo "$(YELLOW)Запуск тестов...$(NC)"
	$(PYTHON) check_system.py

setup-db: ## Настроить базу данных
	@echo "$(YELLOW)Настройка базы данных...$(NC)"
	$(PYTHON) setup_database.py
	@echo "$(GREEN)✅ База данных настроена$(NC)"

setup-bot: ## Настроить Telegram Bot
	@echo "$(YELLOW)Настройка Telegram Bot...$(NC)"
	$(PYTHON) setup_telegram_bot.py
	@echo "$(GREEN)✅ Telegram Bot настроен$(NC)"

check: ## Проверить систему
	@echo "$(YELLOW)Проверка системы...$(NC)"
	$(PYTHON) check_system.py

logs: ## Показать логи Railway
	@echo "$(YELLOW)Логи Railway...$(NC)"
	$(RAILWAY) logs

shell: ## Подключиться к Railway shell
	@echo "$(YELLOW)Подключение к Railway shell...$(NC)"
	$(RAILWAY) shell

clean: ## Очистить временные файлы
	@echo "$(YELLOW)Очистка временных файлов...$(NC)"
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} +
	@echo "$(GREEN)✅ Временные файлы очищены$(NC)"

docker-run: ## Запустить в Docker
	@echo "$(YELLOW)Запуск в Docker...$(NC)"
	docker run -p 8000:8000 --env-file .env nodeon-pyramid

docker-compose-up: ## Запустить через docker-compose
	@echo "$(YELLOW)Запуск через docker-compose...$(NC)"
	docker-compose up --build

docker-compose-down: ## Остановить docker-compose
	@echo "$(YELLOW)Остановка docker-compose...$(NC)"
	docker-compose down

full-setup: install setup-db setup-bot check ## Полная настройка проекта
	@echo "$(GREEN)🎉 Полная настройка завершена!$(NC)"

migrate: deploy setup-db setup-bot check ## Миграция на новый Railway
	@echo "$(GREEN)🎉 Миграция завершена!$(NC)"

# Команды для разработки
format: ## Форматировать код
	@echo "$(YELLOW)Форматирование кода...$(NC)"
	black *.py
	isort *.py

lint: ## Проверить код линтером
	@echo "$(YELLOW)Проверка кода...$(NC)"
	flake8 *.py
	mypy *.py

# Команды для мониторинга
status: ## Показать статус системы
	@echo "$(BLUE)Статус системы:$(NC)"
	@echo "Python: $$(python3 --version)"
	@echo "Pip: $$(pip3 --version)"
	@echo "Railway: $$(railway --version 2>/dev/null || echo 'Не установлен')"
	@echo "Docker: $$(docker --version 2>/dev/null || echo 'Не установлен')"

# Команды для бэкапа
backup-db: ## Создать бэкап базы данных
	@echo "$(YELLOW)Создание бэкапа базы данных...$(NC)"
	$(PYTHON) backup_database.py

restore-db: ## Восстановить базу данных из бэкапа
	@echo "$(YELLOW)Восстановление базы данных...$(NC)"
	$(PYTHON) restore_database.py

check-db: ## Проверить состояние базы данных
	@echo "$(YELLOW)Проверка состояния базы данных...$(NC)"
	$(PYTHON) check_database.py
