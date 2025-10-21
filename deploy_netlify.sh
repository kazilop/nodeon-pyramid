#!/bin/bash

# NodeOn Pyramid - Скрипт деплоя на Netlify

echo "🚀 Деплой NodeOn Pyramid на Netlify"
echo "=================================="

# Проверяем, установлен ли Netlify CLI
if ! command -v netlify &> /dev/null; then
    echo "❌ Netlify CLI не установлен"
    echo "📦 Устанавливаем Netlify CLI..."
    npm install -g netlify-cli
fi

# Проверяем авторизацию
echo "🔐 Проверка авторизации в Netlify..."
if ! netlify status &> /dev/null; then
    echo "🔑 Необходима авторизация в Netlify"
    netlify login
fi

# Создаем директорию dist если её нет
if [ ! -d "dist" ]; then
    echo "📁 Создание директории dist..."
    mkdir -p dist
fi

# Копируем файлы в dist
echo "📋 Копирование файлов..."
cp index.html dist/
cp -r locales dist/
cp -r public dist/ 2>/dev/null || true

# Создаем package.json для Netlify
echo "📦 Создание package.json для Netlify..."
cat > dist/package.json << EOF
{
  "name": "nodeon-pyramid",
  "version": "1.0.0",
  "description": "NodeOn Pyramid - Telegram Mini App",
  "main": "index.html",
  "scripts": {
    "build": "echo 'Build completed'",
    "dev": "python -m http.server 3000"
  },
  "keywords": ["telegram", "mini-app", "crypto", "game"],
  "author": "NodeOn Team",
  "license": "MIT"
}
EOF

# Копируем netlify.toml
cp netlify.toml dist/

# Копируем функции Netlify
echo "⚡ Копирование Netlify функций..."
cp -r netlify dist/

# Деплой на Netlify
echo "🚀 Деплой на Netlify..."
cd dist
netlify deploy --prod --dir .

echo "✅ Деплой завершен!"
echo "🌐 URL приложения будет показан выше"
echo ""
echo "📝 Следующие шаги:"
echo "   1. Обновите webhook в BotFather"
echo "   2. Обновите Menu Button в BotFather"
echo "   3. Протестируйте приложение"
