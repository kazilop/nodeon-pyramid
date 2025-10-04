# 🏦 НАСТРОЙКА СЕРВЕРНОГО КОШЕЛЬКА NDN

## 🎯 ПРОБЛЕМА РЕШЕНА!

### **❌ Была проблема:**
- NDN "создавались из воздуха" при покупке за Stars
- Нет реального резерва NDN на сервере
- Невозможно контролировать количество NDN в системе

### **✅ Теперь решено:**
- **Серверный кошелек** содержит реальный резерв NDN
- **Покупка NDN** - списывается из серверного кошелька
- **Продажа NDN** - возвращается в серверный кошелек
- **Полный контроль** над количеством NDN в системе

---

## 🚀 ПОШАГОВАЯ НАСТРОЙКА (20 минут)

### **ШАГ 1: Настройка базы данных (10 минут)**

1. **Откройте Supabase:**
   - Перейдите на https://supabase.com/dashboard
   - Войдите в проект `ahxwpzgltlzlvrtrbanm`
   - Откройте **SQL Editor**

2. **Выполните SQL скрипт:**
   - Скопируйте содержимое файла `CREATE_SERVER_WALLET.sql`
   - Вставьте в SQL Editor
   - Нажмите **"Run"** для выполнения

**Результат:** Создастся серверный кошелек с резервом 1,000,000 NDN

### **ШАГ 2: Обновление API (5 минут)**

1. **Замените main.py:**
   ```bash
   cp main_with_server_wallet.py main.py
   ```

2. **Перезапустите Railway:**
   ```bash
   railway up --detach
   ```

**Результат:** API будет работать с серверным кошельком

### **ШАГ 3: Обновление фронтенда (3 минуты)**

1. **Замените index.html:**
   ```bash
   cp index_with_server_wallet.html index.html
   ```

2. **Загрузите на GitHub Pages:**
   ```bash
   git add .
   git commit -m "Add server wallet support"
   git push origin main
   ```

**Результат:** Пользователи увидят баланс серверного кошелька

### **ШАГ 4: Тестирование (2 минуты)**

```bash
python test_server_wallet.py
```

**Ожидаемый результат:** "ВСЕ ТЕСТЫ СЕРВЕРНОГО КОШЕЛЬКА ПРОЙДЕНЫ!" ✅

---

## 🏦 СТРУКТУРА СЕРВЕРНОГО КОШЕЛЬКА

### **Таблица `nodeon_server_wallet`:**
```sql
id SERIAL PRIMARY KEY,
wallet_name VARCHAR(100) DEFAULT 'main_wallet',
balance_ndn DECIMAL(18,2) DEFAULT 0.0,           -- Текущий резерв NDN
total_ndn_issued DECIMAL(18,2) DEFAULT 0.0,      -- Всего выдано NDN
total_ndn_received DECIMAL(18,2) DEFAULT 0.0,    -- Всего получено NDN
is_active BOOLEAN DEFAULT TRUE,
created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
```

### **Таблица `nodeon_wallet_transactions`:**
```sql
id SERIAL PRIMARY KEY,
wallet_id INTEGER REFERENCES nodeon_server_wallet(id),
user_id INTEGER REFERENCES nodeon_users(id),
type VARCHAR(50),                                -- 'stars_purchase', 'stars_withdrawal'
stars_amount DECIMAL(10,2),                      -- Сумма в Stars
ndn_amount DECIMAL(18,2),                        -- Сумма в NDN
balance_before DECIMAL(18,2),                    -- Баланс до операции
balance_after DECIMAL(18,2),                     -- Баланс после операции
description TEXT,
created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
```

---

## 🔄 ЛОГИКА РАБОТЫ

### **1. Покупка NDN за Stars:**
```python
# Пользователь покупает 100 Stars за 100 NDN
async def buy_ndn_with_stars(stars_amount=100):
    ndn_amount = stars_amount * 1.0  # Курс 1:1
    
    # 1. Проверяем резерв серверного кошелька
    if server_wallet.balance_ndn < ndn_amount:
        raise Exception("Недостаточно NDN в серверном резерве")
    
    # 2. Списываем NDN с серверного кошелька
    server_wallet.balance_ndn -= ndn_amount
    server_wallet.total_ndn_issued += ndn_amount
    
    # 3. Зачисляем NDN пользователю
    user.balance_ndn += ndn_amount
    
    # 4. Записываем транзакцию
    create_wallet_transaction(
        type='stars_purchase',
        stars_amount=stars_amount,
        ndn_amount=ndn_amount,
        balance_before=old_balance,
        balance_after=new_balance
    )
```

### **2. Продажа NDN за Stars:**
```python
# Пользователь продает 50 NDN за 47.5 Stars (комиссия 5%)
async def sell_ndn_for_stars(ndn_amount=50):
    fee = ndn_amount * 0.05  # Комиссия 5%
    stars_amount = (ndn_amount - fee) * 1.0
    
    # 1. Проверяем баланс пользователя
    if user.balance_ndn < ndn_amount:
        raise Exception("Недостаточно NDN у пользователя")
    
    # 2. Списываем NDN у пользователя
    user.balance_ndn -= ndn_amount
    
    # 3. Возвращаем NDN в серверный кошелек
    server_wallet.balance_ndn += ndn_amount
    server_wallet.total_ndn_received += ndn_amount
    
    # 4. Записываем транзакцию
    create_wallet_transaction(
        type='stars_withdrawal',
        stars_amount=stars_amount,
        ndn_amount=ndn_amount,
        balance_before=old_balance,
        balance_after=new_balance
    )
```

---

## 🎨 ИНТЕРФЕЙС ПОЛЬЗОВАТЕЛЯ

### **Отображение серверного кошелька:**
```html
<div class="server-info">
    <h3>🏦 Серверный кошелек</h3>
    <div class="server-balance">
        <div class="balance-label">Резерв NDN:</div>
        <div class="balance-amount">1,000,000</div>
    </div>
    <div class="server-stats">
        <div class="stat-item">
            <span>Выдано:</span>
            <span>50,000 NDN</span>
        </div>
        <div class="stat-item">
            <span>Получено:</span>
            <span>10,000 NDN</span>
        </div>
    </div>
</div>
```

### **Модальные окна с расчетами:**
- 💰 **Покупка NDN** - показывает остаток в резерве
- ⭐ **Продажа NDN** - показывает новый резерв
- 📊 **Реальные расчеты** - все суммы рассчитываются в реальном времени

---

## 🧪 ТЕСТИРОВАНИЕ

### **После настройки запустите:**

```bash
python test_server_wallet.py
```

### **Ожидаемый результат:**
```
🧪 ТЕСТИРОВАНИЕ СЕРВЕРНОГО КОШЕЛЬКА
============================================================
🏥 Тест здоровья API
------------------------------
✅ API работает: Supabase API with Server Wallet is working

🏦 Тест баланса серверного кошелька
--------------------------------------------------
Статус: 200
✅ Баланс серверного кошелька работает:
   ID кошелька: 1
   Название: main_wallet
   Резерв NDN: 1000000.0 NDN
   Выдано NDN: 0.0 NDN
   Получено NDN: 0.0 NDN
   Доступно NDN: 1000000.0 NDN

💰 Тест покупки NDN за Stars
--------------------------------------------------
Статус: 200
✅ Покупка NDN за Stars работает:
   Сообщение: NDN успешно куплены
   Сумма Stars: 50.0
   Сумма NDN: 50.0
   Баланс сервера до: 1000000.0 NDN
   Баланс сервера после: 999950.0 NDN
   Баланс пользователя: 50.0 NDN
   ID транзакции: 1

⭐ Тест продажи NDN за Stars
--------------------------------------------------
Статус: 200
✅ Продажа NDN за Stars работает:
   Сообщение: NDN успешно проданы
   Сумма NDN: 25.0
   Сумма Stars: 23.75
   Комиссия: 1.25 NDN
   Баланс сервера до: 999950.0 NDN
   Баланс сервера после: 999975.0 NDN
   Баланс пользователя: 25.0 NDN
   ID транзакции: 2

📊 Тест истории транзакций кошелька
--------------------------------------------------
Статус: 200
✅ История транзакций работает:
   Количество транзакций: 2
   Последняя транзакция:
     Тип: stars_withdrawal
     Пользователь: Майя
     Stars: 23.75
     NDN: 25.0
     Баланс до: 999950.0
     Баланс после: 999975.0

🚫 Тест недостаточных средств
--------------------------------------------------
Статус: 200
✅ Правильно заблокирована покупка при недостатке средств:
   Сообщение: Insufficient NDN in server wallet

============================================================
📊 РЕЗУЛЬТАТЫ ТЕСТИРОВАНИЯ СЕРВЕРНОГО КОШЕЛЬКА
============================================================
✅ API Health
✅ Server Wallet Balance
✅ Buy NDN with Stars
✅ Sell NDN for Stars
✅ Wallet Transactions
✅ Insufficient Funds Check

📈 Общий результат: 6/6 тестов пройдено

🎉 ВСЕ ТЕСТЫ СЕРВЕРНОГО КОШЕЛЬКА ПРОЙДЕНЫ!
✅ Серверный кошелек работает корректно
✅ NDN покупаются из реального резерва
✅ NDN продаются обратно в резерв
✅ Все транзакции записываются
✅ Проверка недостаточных средств работает
```

---

## 🎯 РЕЗУЛЬТАТ

После настройки:

✅ **Реальный резерв NDN** - 1,000,000 NDN в серверном кошельке
✅ **Контролируемая эмиссия** - NDN выдаются только из резерва
✅ **Полная прозрачность** - все транзакции записываются
✅ **Защита от инфляции** - нельзя создать NDN "из воздуха"
✅ **Мониторинг резерва** - видно состояние кошелька
✅ **Безопасность** - проверка балансов перед операциями

---

## 📊 МОНИТОРИНГ КОШЕЛЬКА

### **API для мониторинга:**
```
GET /api/wallet/balance          # Баланс кошелька
GET /api/wallet/transactions     # История транзакций
```

### **Ключевые метрики:**
- **Резерв NDN** - сколько NDN доступно для выдачи
- **Выдано NDN** - сколько NDN выдано пользователям
- **Получено NDN** - сколько NDN возвращено в резерв
- **Чистая эмиссия** - выдано минус получено

---

## ⚠️ ВАЖНЫЕ ЗАМЕЧАНИЯ

### **1. Управление резервом:**
- Начальный резерв: 1,000,000 NDN
- При необходимости можно пополнить резерв
- Следите за балансом кошелька

### **2. Безопасность:**
- Все операции проверяют балансы
- Невозможно выдать больше чем есть в резерве
- Все транзакции логируются

### **3. Масштабирование:**
- При росте пользователей может потребоваться пополнение резерва
- Мониторьте метрики через API
- Планируйте пополнение заранее

---

## 🆘 ЕСЛИ НЕ ПОМОГЛО

### **Проверьте логи Railway:**
```bash
railway logs --tail 20
```

### **Проверьте Supabase:**
- Убедитесь, что SQL скрипт выполнился без ошибок
- Проверьте таблицы: `SELECT * FROM nodeon_server_wallet;`

### **Перезапустите Railway:**
```bash
railway up --detach
```

**Серверный кошелек будет работать! 🚀**

---

## 🎉 ИТОГ

**Проблема с покупкой NDN за Stars полностью решена!**

- 🏦 **Серверный кошелек** - реальный резерв NDN
- 💰 **Покупка NDN** - списывается из резерва
- ⭐ **Продажа NDN** - возвращается в резерв
- 📊 **Полный контроль** - над количеством NDN
- 🔒 **Безопасность** - защита от инфляции

**Система готова к реальному использованию! 🚀**
