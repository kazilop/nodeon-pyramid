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
            .nav {
                display: flex;
                gap: 8px;
                margin-bottom: 20px;
            }
            .nav-button {
                flex: 1;
                background: var(--tg-theme-secondary-bg-color, #f0f0f0);
                color: var(--tg-theme-text-color, #000000);
                border: none;
                border-radius: 12px;
                padding: 12px;
                font-size: 14px;
                cursor: pointer;
            }
            .nav-button.active {
                background: var(--tg-theme-button-color, #2481cc);
                color: var(--tg-theme-button-text-color, #ffffff);
            }
            .page {
                display: none;
            }
            .page.active {
                display: block;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1 class="title">NodeOn Pyramid</h1>
                <p class="subtitle">Реферальная игра с монетами NDN</p>
            </div>
            
            <div class="nav">
                <button class="nav-button active" onclick="showPage('dashboard')">Главная</button>
                <button class="nav-button" onclick="showPage('rules')">Правила</button>
                <button class="nav-button" onclick="showPage('stats')">Статистика</button>
            </div>
            
            <!-- Dashboard Page -->
            <div id="dashboard" class="page active">
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
                <button class="button" onclick="withdrawNDN()">Вывести NDN</button>
            </div>
            
            <!-- Rules Page -->
            <div id="rules" class="page">
                <div class="rules">
                    <h3>📋 Правила игры</h3>
                    <ul>
                        <li>Купите Pro статус за 1000 NDN</li>
                        <li>Получите реферальную ссылку</li>
                        <li>Приглашайте друзей по ссылке</li>
                        <li>Зарабатывайте с каждого Pro реферала</li>
                        <li>До 7 уровней рефералов</li>
                    </ul>
                    
                    <h3>💰 Награды по уровням</h3>
                    <ul>
                        <li>Уровень 1: 200 NDN</li>
                        <li>Уровень 2-7: 150 NDN каждый</li>
                    </ul>
                    
                    <h3>📊 Пример заработка</h3>
                    <p>При 10 рефералах на каждом уровне можно заработать 180,000+ NDN!</p>
                </div>
            </div>
            
            <!-- Stats Page -->
            <div id="stats" class="page">
                <div class="rules">
                    <h3>📊 Статистика</h3>
                    <p>Статистика будет доступна после покупки Pro статуса</p>
                    
                    <div class="stats">
                        <div class="stat-card">
                            <div class="stat-value">0</div>
                            <div class="stat-label">Всего рефералов</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-value">0</div>
                            <div class="stat-label">Заработано</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <script>
            // Инициализация Telegram WebApp
            if (window.Telegram && window.Telegram.WebApp) {
                window.Telegram.WebApp.ready();
                window.Telegram.WebApp.expand();
            }
            
            function showPage(pageId) {
                // Скрыть все страницы
                document.querySelectorAll('.page').forEach(page => {
                    page.classList.remove('active');
                });
                
                // Убрать активный класс с кнопок
                document.querySelectorAll('.nav-button').forEach(button => {
                    button.classList.remove('active');
                });
                
                // Показать выбранную страницу
                document.getElementById(pageId).classList.add('active');
                
                // Добавить активный класс к кнопке
                event.target.classList.add('active');
            }
            
            function buyPro() {
                alert('Функция покупки Pro статуса будет доступна после полной настройки');
            }
            
            function buyNDN() {
                alert('Функция покупки NDN будет доступна после интеграции с Telegram Stars');
            }
            
            function withdrawNDN() {
                alert('Функция вывода NDN будет доступна после полной настройки');
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

if __name__ == "__main__":
    import uvicorn
    port = int(os.environ.get("PORT", 8000))
    uvicorn.run(app, host="0.0.0.0", port=port)
