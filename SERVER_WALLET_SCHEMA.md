# 💰 СХЕМА СЕРВЕРНОГО КОШЕЛЬКА NDN

## 🎯 ПРИНЦИП РАБОТЫ

### **Текущая проблема:**
- Пользователи покупают NDN за Stars
- NDN "создаются из воздуха" 
- Нет реального резерва NDN на сервере

### **Правильная схема:**
1. **Серверный кошелек** - содержит резерв NDN
2. **Пользователь покупает Stars** - переводит Stars на счет сервера
3. **Сервер переводит NDN** - из своего кошелька пользователю
4. **Реальный обмен** - Stars ↔ NDN через серверный резерв

---

## 🗄️ СТРУКТУРА БАЗЫ ДАННЫХ

### **1. Серверный кошелек:**
```sql
CREATE TABLE nodeon_server_wallet (
    id SERIAL PRIMARY KEY,
    wallet_name VARCHAR(100) DEFAULT 'main_wallet',
    balance_ndn DECIMAL(18,2) DEFAULT 0.0 NOT NULL,
    total_ndn_issued DECIMAL(18,2) DEFAULT 0.0 NOT NULL,
    total_ndn_received DECIMAL(18,2) DEFAULT 0.0 NOT NULL,
    is_active BOOLEAN DEFAULT TRUE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### **2. Транзакции кошелька:**
```sql
CREATE TABLE nodeon_wallet_transactions (
    id SERIAL PRIMARY KEY,
    wallet_id INTEGER REFERENCES nodeon_server_wallet(id),
    user_id INTEGER REFERENCES nodeon_users(id),
    type VARCHAR(50) NOT NULL, -- 'stars_purchase', 'ndn_issue', 'ndn_receive'
    stars_amount DECIMAL(10,2) DEFAULT 0.0,
    ndn_amount DECIMAL(18,2) NOT NULL,
    balance_before DECIMAL(18,2) NOT NULL,
    balance_after DECIMAL(18,2) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### **3. Обновленная таблица Stars платежей:**
```sql
ALTER TABLE nodeon_stars_payments 
ADD COLUMN wallet_transaction_id INTEGER REFERENCES nodeon_wallet_transactions(id),
ADD COLUMN server_ndn_balance_before DECIMAL(18,2),
ADD COLUMN server_ndn_balance_after DECIMAL(18,2);
```

---

## 🔄 ЛОГИКА РАБОТЫ

### **1. Инициализация серверного кошелька:**
```sql
-- Создаем серверный кошелек с начальным резервом
INSERT INTO nodeon_server_wallet (balance_ndn, total_ndn_issued) 
VALUES (1000000.00, 0.00);
```

### **2. Покупка NDN за Stars:**
```python
async def process_stars_purchase(user_id, stars_amount):
    # 1. Получаем курс Stars к NDN
    rate = get_stars_rate()  # 1 Star = 1 NDN
    
    # 2. Рассчитываем количество NDN
    ndn_amount = stars_amount * rate
    
    # 3. Проверяем резерв серверного кошелька
    wallet = get_server_wallet()
    if wallet.balance_ndn < ndn_amount:
        raise Exception("Недостаточно NDN в серверном кошельке")
    
    # 4. Списываем NDN с серверного кошелька
    new_wallet_balance = wallet.balance_ndn - ndn_amount
    update_server_wallet_balance(new_wallet_balance)
    
    # 5. Зачисляем NDN пользователю
    add_user_ndn_balance(user_id, ndn_amount)
    
    # 6. Записываем транзакцию кошелька
    create_wallet_transaction(
        type='stars_purchase',
        user_id=user_id,
        stars_amount=stars_amount,
        ndn_amount=ndn_amount,
        balance_before=wallet.balance_ndn,
        balance_after=new_wallet_balance
    )
    
    # 7. Записываем транзакцию пользователя
    create_user_transaction(
        user_id=user_id,
        type='stars_purchase',
        amount_ndn=ndn_amount,
        description=f'Покупка NDN за {stars_amount} Stars'
    )
```

### **3. Вывод NDN в Stars:**
```python
async def process_ndn_withdraw(user_id, ndn_amount):
    # 1. Проверяем баланс пользователя
    user_balance = get_user_ndn_balance(user_id)
    if user_balance < ndn_amount:
        raise Exception("Недостаточно NDN у пользователя")
    
    # 2. Рассчитываем комиссию и сумму Stars
    fee_percent = get_withdrawal_fee_percent()  # 5%
    fee_amount = ndn_amount * (fee_percent / 100)
    stars_amount = (ndn_amount - fee_amount) * get_ndn_to_stars_rate()
    
    # 3. Списываем NDN у пользователя
    new_user_balance = user_balance - ndn_amount
    update_user_ndn_balance(user_id, new_user_balance)
    
    # 4. Возвращаем NDN в серверный кошелек
    wallet = get_server_wallet()
    new_wallet_balance = wallet.balance_ndn + ndn_amount
    update_server_wallet_balance(new_wallet_balance)
    
    # 5. Записываем транзакции
    create_wallet_transaction(
        type='ndn_receive',
        user_id=user_id,
        ndn_amount=ndn_amount,
        balance_before=wallet.balance_ndn,
        balance_after=new_wallet_balance
    )
    
    create_user_transaction(
        user_id=user_id,
        type='stars_withdrawal',
        amount_ndn=-ndn_amount,
        description=f'Вывод NDN в Stars (комиссия: {fee_amount} NDN)'
    )
```

---

## 🏦 API ENDPOINTS

### **1. Получить баланс серверного кошелька:**
```
GET /api/wallet/balance
```
**Ответ:**
```json
{
  "success": true,
  "wallet": {
    "balance_ndn": 1000000.00,
    "total_ndn_issued": 50000.00,
    "total_ndn_received": 10000.00,
    "available_ndn": 950000.00
  }
}
```

### **2. Покупка NDN за Stars (обновленная):**
```
POST /api/stars/buy-ndn
{
  "init_data": "telegram_init_data",
  "stars_amount": 100.0
}
```
**Ответ:**
```json
{
  "success": true,
  "message": "NDN успешно куплены",
  "stars_amount": 100.0,
  "ndn_amount": 100.0,
  "server_balance_before": 1000000.00,
  "server_balance_after": 999900.00,
  "user_balance": 100.0
}
```

### **3. Вывод NDN в Stars (обновленная):**
```
POST /api/stars/sell-ndn
{
  "init_data": "telegram_init_data",
  "ndn_amount": 50.0
}
```
**Ответ:**
```json
{
  "success": true,
  "message": "NDN успешно проданы",
  "ndn_amount": 50.0,
  "stars_amount": 47.5,
  "withdrawal_fee": 2.5,
  "server_balance_before": 999900.00,
  "server_balance_after": 999950.00
}
```

### **4. История транзакций кошелька:**
```
GET /api/wallet/transactions?limit=50
```
**Ответ:**
```json
{
  "success": true,
  "transactions": [
    {
      "id": 1,
      "type": "stars_purchase",
      "user_name": "Майя",
      "stars_amount": 100.0,
      "ndn_amount": 100.0,
      "balance_before": 1000000.00,
      "balance_after": 999900.00,
      "created_at": "2024-01-01T12:00:00Z"
    }
  ]
}
```

---

## 🎨 FRONTEND ОБНОВЛЕНИЯ

### **1. Отображение баланса сервера:**
```html
<div class="server-info">
  <h3>🏦 Серверный кошелек</h3>
  <div class="server-balance">
    <span class="balance-label">Резерв NDN:</span>
    <span class="balance-amount" id="serverNdnBalance">1,000,000</span>
  </div>
  <div class="server-stats">
    <div class="stat-item">
      <span>Выдано:</span>
      <span id="totalIssued">50,000 NDN</span>
    </div>
    <div class="stat-item">
      <span>Получено:</span>
      <span id="totalReceived">10,000 NDN</span>
    </div>
  </div>
</div>
```

### **2. Обновленные модальные окна:**
```javascript
// Покупка NDN за Stars
async function buyNdnWithStars(starsAmount) {
    const response = await fetch(`${API_BASE}/stars/buy-ndn`, {
        method: 'POST',
        body: JSON.stringify({
            init_data: initData,
            stars_amount: starsAmount
        })
    });
    
    const data = await response.json();
    
    if (data.success) {
        // Обновляем балансы
        updateUserBalance(data.user_balance);
        updateServerBalance(data.server_balance_after);
        
        alert(`Куплено ${data.ndn_amount} NDN за ${data.stars_amount} Stars!`);
    }
}

// Продажа NDN за Stars
async function sellNdnForStars(ndnAmount) {
    const response = await fetch(`${API_BASE}/stars/sell-ndn`, {
        method: 'POST',
        body: JSON.stringify({
            init_data: initData,
            ndn_amount: ndnAmount
        })
    });
    
    const data = await response.json();
    
    if (data.success) {
        // Обновляем балансы
        updateUserBalance(data.user_balance);
        updateServerBalance(data.server_balance_after);
        
        alert(`Продано ${data.ndn_amount} NDN за ${data.stars_amount} Stars!`);
    }
}
```

---

## 🔧 НАСТРОЙКА СЕРВЕРНОГО КОШЕЛЬКА

### **1. SQL скрипт для создания кошелька:**
```sql
-- Создаем серверный кошелек
INSERT INTO nodeon_server_wallet (balance_ndn, total_ndn_issued) 
VALUES (1000000.00, 0.00);

-- Создаем функции для работы с кошельком
CREATE OR REPLACE FUNCTION get_server_wallet_balance()
RETURNS JSON AS $$
DECLARE
    wallet_record RECORD;
BEGIN
    SELECT * INTO wallet_record FROM nodeon_server_wallet WHERE is_active = TRUE LIMIT 1;
    
    IF wallet_record IS NULL THEN
        RETURN '{"error": "Server wallet not found"}'::JSON;
    END IF;
    
    RETURN json_build_object(
        'balance_ndn', wallet_record.balance_ndn,
        'total_ndn_issued', wallet_record.total_ndn_issued,
        'total_ndn_received', wallet_record.total_ndn_received,
        'available_ndn', wallet_record.balance_ndn
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION process_stars_purchase(
    p_user_id INTEGER,
    p_stars_amount DECIMAL(10,2),
    p_ndn_amount DECIMAL(18,2)
)
RETURNS JSON AS $$
DECLARE
    v_wallet_balance DECIMAL(18,2);
    v_new_balance DECIMAL(18,2);
    v_user_balance DECIMAL(18,2);
    v_new_user_balance DECIMAL(18,2);
BEGIN
    -- Получаем текущий баланс кошелька
    SELECT balance_ndn INTO v_wallet_balance FROM nodeon_server_wallet WHERE is_active = TRUE LIMIT 1;
    
    IF v_wallet_balance IS NULL THEN
        RETURN '{"error": "Server wallet not found"}'::JSON;
    END IF;
    
    IF v_wallet_balance < p_ndn_amount THEN
        RETURN '{"error": "Insufficient NDN in server wallet"}'::JSON;
    END IF;
    
    -- Обновляем баланс кошелька
    v_new_balance := v_wallet_balance - p_ndn_amount;
    UPDATE nodeon_server_wallet 
    SET 
        balance_ndn = v_new_balance,
        total_ndn_issued = total_ndn_issued + p_ndn_amount,
        updated_at = NOW()
    WHERE is_active = TRUE;
    
    -- Обновляем баланс пользователя
    SELECT balance_ndn INTO v_user_balance FROM nodeon_users WHERE id = p_user_id;
    v_new_user_balance := v_user_balance + p_ndn_amount;
    UPDATE nodeon_users 
    SET balance_ndn = v_new_user_balance 
    WHERE id = p_user_id;
    
    -- Записываем транзакцию кошелька
    INSERT INTO nodeon_wallet_transactions (
        wallet_id, user_id, type, stars_amount, ndn_amount, 
        balance_before, balance_after, description
    ) VALUES (
        (SELECT id FROM nodeon_server_wallet WHERE is_active = TRUE LIMIT 1),
        p_user_id, 'stars_purchase', p_stars_amount, p_ndn_amount,
        v_wallet_balance, v_new_balance, 
        'Покупка NDN за Stars пользователем ' || p_user_id
    );
    
    -- Записываем транзакцию пользователя
    INSERT INTO nodeon_transactions (
        user_id, type, amount_ndn, description
    ) VALUES (
        p_user_id, 'stars_purchase', p_ndn_amount,
        'Покупка NDN за ' || p_stars_amount || ' Stars'
    );
    
    RETURN json_build_object(
        'success', true,
        'message', 'NDN successfully purchased',
        'stars_amount', p_stars_amount,
        'ndn_amount', p_ndn_amount,
        'server_balance_before', v_wallet_balance,
        'server_balance_after', v_new_balance,
        'user_balance', v_new_user_balance
    );
END;
$$ LANGUAGE plpgsql;
```

---

## 🎯 РЕЗУЛЬТАТ

После реализации:

✅ **Серверный кошелек** - содержит резерв NDN
✅ **Реальный обмен** - Stars ↔ NDN через сервер
✅ **Контроль резерва** - нельзя выдать больше чем есть
✅ **Полная прозрачность** - все транзакции записываются
✅ **Безопасность** - проверка балансов перед операциями
✅ **Мониторинг** - видно состояние серверного кошелька

**Система готова к реальному использованию! 🚀**
