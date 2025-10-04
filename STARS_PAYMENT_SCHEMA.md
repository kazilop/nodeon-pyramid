# ⭐ СХЕМА ПОКУПКИ ЗА TELEGRAM STARS

## 🎯 ОБЩАЯ СХЕМА

### **1. Пользователь инициирует покупку**
- Пользователь выбирает количество NDN для покупки
- Система рассчитывает стоимость в Stars
- Показывается модальное окно с подтверждением

### **2. Создание платежа**
- Создается запись в `nodeon_stars_payments` со статусом `pending`
- Генерируется уникальный `payment_id`
- Пользователь перенаправляется на оплату

### **3. Обработка платежа**
- Telegram обрабатывает платеж
- Webhook получает уведомление о статусе
- Обновляется баланс пользователя

### **4. Завершение транзакции**
- Статус платежа меняется на `completed`
- NDN зачисляются на баланс пользователя
- Создается запись в `nodeon_transactions`

---

## 🗄️ СТРУКТУРА БАЗЫ ДАННЫХ

### **Таблица `nodeon_users`:**
```sql
balance_stars DECIMAL(10,2) DEFAULT 0.0,           -- Текущий баланс Stars
total_stars_earned DECIMAL(10,2) DEFAULT 0.0,      -- Всего заработано Stars
total_stars_spent DECIMAL(10,2) DEFAULT 0.0,       -- Всего потрачено Stars
```

### **Таблица `nodeon_stars_payments`:**
```sql
id SERIAL PRIMARY KEY,
user_id INTEGER NOT NULL REFERENCES nodeon_users(id),
payment_id VARCHAR(255) UNIQUE NOT NULL,           -- Уникальный ID платежа
stars_amount DECIMAL(10,2) NOT NULL,               -- Сумма в Stars
ndn_amount DECIMAL(10,2) NOT NULL,                 -- Сумма в NDN
status VARCHAR(50) NOT NULL DEFAULT 'pending',     -- Статус платежа
telegram_payment_id VARCHAR(255),                  -- ID платежа в Telegram
created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
completed_at TIMESTAMP WITH TIME ZONE
```

### **Таблица `nodeon_stars_config`:**
```sql
stars_to_ndn_rate DECIMAL(5,2) DEFAULT 1.0,        -- Курс: 1 Star = 1 NDN
min_stars_purchase DECIMAL(10,2) DEFAULT 10.0,     -- Минимум Stars
max_stars_purchase DECIMAL(10,2) DEFAULT 10000.0,  -- Максимум Stars
stars_purchase_fee_percent DECIMAL(5,2) DEFAULT 0.0, -- Комиссия за покупку
stars_withdrawal_fee_percent DECIMAL(5,2) DEFAULT 5.0 -- Комиссия за вывод
```

---

## 🔄 API ENDPOINTS

### **1. Получить конфигурацию Stars**
```
GET /api/stars/config
```
**Ответ:**
```json
{
  "success": true,
  "config": {
    "stars_to_ndn_rate": "1.0",
    "min_stars_purchase": "10",
    "max_stars_purchase": "10000",
    "stars_purchase_fee_percent": "0",
    "stars_withdrawal_fee_percent": "5"
  }
}
```

### **2. Создать платеж за Stars**
```
POST /api/stars/create-payment
{
  "init_data": "telegram_init_data",
  "stars_amount": 100.0
}
```
**Ответ:**
```json
{
  "success": true,
  "payment_id": "stars_123_1640995200",
  "stars_amount": 100.0,
  "ndn_amount": 100.0,
  "payment_url": "https://t.me/pro_stars_bot?startapp=payment_stars_123_1640995200"
}
```

### **3. Подтвердить платеж**
```
POST /api/stars/confirm-payment
{
  "payment_id": "stars_123_1640995200",
  "telegram_payment_id": "telegram_payment_123"
}
```
**Ответ:**
```json
{
  "success": true,
  "message": "Платеж успешно обработан",
  "ndn_amount": 100.0,
  "new_balance": 100.0
}
```

### **4. Вывести NDN в Stars**
```
POST /api/stars/withdraw
{
  "init_data": "telegram_init_data",
  "ndn_amount": 50.0
}
```
**Ответ:**
```json
{
  "success": true,
  "message": "Вывод успешно обработан",
  "ndn_amount": 50.0,
  "stars_amount": 47.5,
  "withdrawal_fee": 2.5,
  "new_balance": 50.0
}
```

---

## 🎨 FRONTEND ИНТЕРФЕЙС

### **1. Отображение баланса Stars**
```javascript
// В профиле пользователя
<div class="balance-stars">
  <span class="stars-icon">⭐</span>
  <span class="stars-amount">100.0</span>
  <span class="stars-label">Stars</span>
</div>
```

### **2. Модальное окно покупки**
```javascript
// Кнопка покупки NDN за Stars
<button onclick="showStarsPurchaseModal()">
  💰 Купить NDN за Stars
</button>

// Модальное окно
<div id="starsPurchaseModal" class="modal">
  <div class="modal-content">
    <h3>Покупка NDN за Stars</h3>
    <div class="stars-info">
      <p>Ваш баланс Stars: <span id="userStarsBalance">0</span></p>
      <p>Курс: 1 Star = 1 NDN</p>
    </div>
    <div class="form-group">
      <label>Количество Stars:</label>
      <input type="number" id="starsAmount" min="10" max="10000" step="0.1">
      <div class="input-help">Минимум: 10 Stars, Максимум: 10000 Stars</div>
    </div>
    <div class="conversion-display">
      <div class="conversion-item">
        <span class="conversion-label">Stars:</span>
        <span class="conversion-value" id="displayStarsAmount">0</span>
      </div>
      <div class="conversion-item">
        <span class="conversion-label">NDN:</span>
        <span class="conversion-value" id="displayNdnAmount">0</span>
      </div>
    </div>
    <div class="modal-actions">
      <button onclick="confirmStarsPurchase()">Оплатить</button>
      <button onclick="closeStarsPurchaseModal()">Отмена</button>
    </div>
  </div>
</div>
```

### **3. JavaScript функции**
```javascript
// Загрузка конфигурации Stars
async function loadStarsConfig() {
  try {
    const response = await fetch(`${API_BASE}/stars/config`);
    const data = await response.json();
    
    if (data.success) {
      window.starsConfig = data.config;
      updateStarsConfigUI();
    }
  } catch (error) {
    console.error('Ошибка загрузки конфигурации Stars:', error);
  }
}

// Создание платежа за Stars
async function createStarsPayment(starsAmount) {
  try {
    const response = await fetch(`${API_BASE}/stars/create-payment`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        init_data: window.Telegram.WebApp.initData,
        stars_amount: starsAmount
      })
    });
    
    const data = await response.json();
    
    if (data.success) {
      // Перенаправляем на оплату
      window.Telegram.WebApp.openTelegramLink(data.payment_url);
    } else {
      alert('Ошибка создания платежа: ' + data.message);
    }
  } catch (error) {
    console.error('Ошибка создания платежа:', error);
    alert('Ошибка создания платежа');
  }
}

// Подтверждение платежа
async function confirmStarsPayment(paymentId, telegramPaymentId) {
  try {
    const response = await fetch(`${API_BASE}/stars/confirm-payment`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        payment_id: paymentId,
        telegram_payment_id: telegramPaymentId
      })
    });
    
    const data = await response.json();
    
    if (data.success) {
      // Обновляем баланс пользователя
      loadUserData();
      alert(`Успешно куплено ${data.ndn_amount} NDN!`);
    } else {
      alert('Ошибка подтверждения платежа: ' + data.message);
    }
  } catch (error) {
    console.error('Ошибка подтверждения платежа:', error);
    alert('Ошибка подтверждения платежа');
  }
}
```

---

## 🔧 НАСТРОЙКА TELEGRAM BOT

### **1. Активация Stars**
- Обратитесь в поддержку Telegram
- Запросите активацию Stars для вашего бота
- Дождитесь подтверждения (1-3 дня)

### **2. Настройка Mini App**
```javascript
// В Telegram Mini App
window.Telegram.WebApp.ready();
window.Telegram.WebApp.expand();

// Обработка платежей
window.Telegram.WebApp.onEvent('paymentCompleted', (data) => {
  confirmStarsPayment(data.payment_id, data.telegram_payment_id);
});
```

### **3. Webhook для платежей**
```
POST /api/stars/webhook
{
  "payment_id": "stars_123_1640995200",
  "status": "completed",
  "telegram_payment_id": "telegram_payment_123"
}
```

---

## 🧪 ТЕСТИРОВАНИЕ

### **1. Тестовые данные**
- Используйте тестовый режим Telegram
- Проверьте все сценарии платежей
- Убедитесь в правильности расчетов

### **2. Проверка балансов**
```sql
-- Проверка баланса пользователя
SELECT 
  first_name,
  balance_ndn,
  balance_stars,
  total_stars_earned,
  total_stars_spent
FROM nodeon_users 
WHERE telegram_id = 123456789;

-- Проверка платежей
SELECT 
  payment_id,
  stars_amount,
  ndn_amount,
  status,
  created_at
FROM nodeon_stars_payments 
WHERE user_id = 1
ORDER BY created_at DESC;
```

---

## 🎯 РЕЗУЛЬТАТ

После реализации:

✅ **Пользователи могут покупать NDN за Stars**
✅ **Отображается баланс Stars в профиле**
✅ **Правильные расчеты и комиссии**
✅ **Безопасная обработка платежей**
✅ **Детальная статистика по Stars**
✅ **Красивый интерфейс для покупок**

**Система готова к использованию! 🚀**
