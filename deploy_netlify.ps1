# NodeOn Pyramid - PowerShell скрипт деплоя на Netlify

Write-Host "🚀 Деплой NodeOn Pyramid на Netlify" -ForegroundColor Blue
Write-Host "==================================" -ForegroundColor Blue

# Проверяем, установлен ли Netlify CLI
if (-not (Get-Command netlify -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Netlify CLI не установлен" -ForegroundColor Red
    Write-Host "📦 Устанавливаем Netlify CLI..." -ForegroundColor Yellow
    npm install -g netlify-cli
}

# Проверяем авторизацию
Write-Host "🔐 Проверка авторизации в Netlify..." -ForegroundColor Yellow
try {
    netlify status | Out-Null
    Write-Host "✅ Авторизация прошла успешно" -ForegroundColor Green
} catch {
    Write-Host "🔑 Необходима авторизация в Netlify" -ForegroundColor Yellow
    netlify login
}

# Создаем директорию dist если её нет
if (-not (Test-Path "dist")) {
    Write-Host "📁 Создание директории dist..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path "dist" -Force
}

# Копируем файлы в dist
Write-Host "📋 Копирование файлов..." -ForegroundColor Yellow
Copy-Item "index.html" "dist/" -Force
Copy-Item "locales" "dist/" -Recurse -Force
if (Test-Path "public") {
    Copy-Item "public" "dist/" -Recurse -Force
}

# Создаем package.json для Netlify
Write-Host "📦 Создание package.json для Netlify..." -ForegroundColor Yellow
$packageJson = @"
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
"@
$packageJson | Out-File -FilePath "dist/package.json" -Encoding UTF8

# Копируем netlify.toml
Copy-Item "netlify.toml" "dist/" -Force

# Копируем функции Netlify
Write-Host "⚡ Копирование Netlify функций..." -ForegroundColor Yellow
Copy-Item "netlify" "dist/" -Recurse -Force

# Деплой на Netlify
Write-Host "🚀 Деплой на Netlify..." -ForegroundColor Yellow
Set-Location "dist"
netlify deploy --prod --dir .

Write-Host "✅ Деплой завершен!" -ForegroundColor Green
Write-Host "🌐 URL приложения будет показан выше" -ForegroundColor Cyan
Write-Host ""
Write-Host "📝 Следующие шаги:" -ForegroundColor Yellow
Write-Host "   1. Обновите webhook в BotFather" -ForegroundColor White
Write-Host "   2. Обновите Menu Button в BotFather" -ForegroundColor White
Write-Host "   3. Протестируйте приложение" -ForegroundColor White
