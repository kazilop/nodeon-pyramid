from fastapi import FastAPI
from fastapi.responses import HTMLResponse
import os

app = FastAPI()

@app.get("/")
async def root():
    html_content = """
    <!DOCTYPE html>
    <html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>NodeOn Pyramid</title>
        <script src="https://telegram.org/js/telegram-web-app.js"></script>
        <style>
            body {
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                margin: 0;
                padding: 20px;
                background: var(--tg-theme-bg-color, #ffffff);
                color: var(--tg-theme-text-color, #000000);
            }
            .container {
                max-width: 400px;
                margin: 0 auto;
                text-align: center;
            }
            .header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 30px 20px;
                border-radius: 16px;
                margin-bottom: 20px;
            }
            .title {
                font-size: 24px;
                margin: 0 0 10px 0;
            }
            .subtitle {
                font-size: 16px;
                opacity: 0.9;
                margin: 0;
            }
            .stats {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 15px;
                margin-bottom: 20px;
            }
            .stat-card {
                background: var(--tg-theme-secondary-bg-color, #f8f9fa);
                padding: 20px;
                border-radius: 12px;
                border: 1px solid var(--tg-theme-hint-color, #e0e0e0);
            }
            .stat-value {
                font-size: 24px;
                font-weight: bold;
                color: var(--tg-theme-text-color, #000000);
                margin-bottom: 5px;
            }
            .stat-label {
                font-size: 14px;
                color: var(--tg-theme-hint-color, #666666);
            }
            .button {
                width: 100%;
                background: var(--tg-theme-button-color, #2481cc);
                color: var(--tg-theme-button-text-color, #ffffff);
                border: none;
                border-radius: 12px;
                padding: 16px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                margin-bottom: 12px;
                transition: all 0.2s ease;
            }
            .button:hover {
                opacity: 0.9;
            }
            .rules {
                background: var(--tg-theme-secondary-bg-color, #f8f9fa);
                padding: 20px;
                border-radius: 16px;
                text-align: left;
                margin-top: 20px;
            }
            .rules h3 {
                margin: 0 0 15px 0;
                color: var(--tg-theme-text-color, #000000);
            }
            .rules ul {
                margin: 0;
                padding-left: 20px;
            }
            .rules li {
                margin-bottom: 8px;
                color: var(--tg-theme-hint-color, #666666);
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1 class="title">NodeOn Pyramid</h1>
                <p class="subtitle">Реферальная игра с монетами NDN</p>
            </div>
            
            <div class="stats">
                <div class="stat-card">
                    <div class="stat-value">0</div>
                    <div class="stat-label">NDN</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">0</div>
                    <div class="stat-label">Рефералов</div>
                </div>
            </div>
            
            <button class="button" onclick="buyPro()">Купить Pro статус (1000 NDN)</button>
            <button class="button" onclick="buyNDN()">Купить NDN за Stars</button>
            <button class="button" onclick="showStats()">Статистика</button>
            
            <div class="rules">
                <h3>📋 Правила игры</h3>
                <ul>
                    <li>Купите Pro статус за 1000 NDN</li>
                    <li>Получите реферальную ссылку</li>
                    <li>Приглашайте друзей по ссылке</li>
                    <li>Зарабатывайте с каждого Pro реферала</li>
                    <li>До 7 уровней рефералов</li>
                </ul>
            </div>
        </div>
        
        <script>
            // Инициализация Telegram WebApp
            if (window.Telegram && window.Telegram.WebApp) {
                window.Telegram.WebApp.ready();
                window.Telegram.WebApp.expand();
            }
            
            function buyPro() {
                alert('Функция покупки Pro статуса будет доступна после полной настройки');
            }
            
            function buyNDN() {
                alert('Функция покупки NDN будет доступна после интеграции с Telegram Stars');
            }
            
            function showStats() {
                alert('Статистика будет доступна после покупки Pro статуса');
            }
        </script>
    </body>
    </html>
    """
    return HTMLResponse(content=html_content)

@app.get("/webhook")
async def webhook():
    return {"status": "ok", "message": "Webhook работает"}

@app.get("/api/health")
async def health():
    return {"status": "healthy", "message": "NodeOn Pyramid API работает"}
