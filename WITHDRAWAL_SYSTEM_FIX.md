# Система заявок на вывод Stars

## Проблема
При выводе Stars не было контроля:
- Нет проверки срока с момента ввода (21 день по правилам Telegram)
- Нет минимальной суммы вывода
- Нет системы заявок для проверки менеджером

## Решение

### 1. Создана таблица для заявок на вывод

```sql
CREATE TABLE nodeon_withdrawal_requests (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    telegram_id BIGINT NOT NULL,
    telegram_username VARCHAR(255),
    amount_ndn DECIMAL(10,2) NOT NULL,
    amount_stars DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) DEFAULT 'pending', -- 'pending', 'approved', 'rejected', 'completed'
    days_since_deposit INTEGER,
    last_deposit_date TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    reviewed_at TIMESTAMP WITH TIME ZONE,
    completed_at TIMESTAMP WITH TIME ZONE,
    admin_notes TEXT,
    reviewed_by INTEGER
);
```

### 2. Добавлена функция проверки возможности вывода

```sql
CREATE OR REPLACE FUNCTION can_withdraw_stars(p_user_id INTEGER)
RETURNS JSON AS $$
-- Проверяет прошло ли 21 день с момента последнего ввода Stars
-- Возвращает статус и количество дней
END;
```

### 3. Добавлена колонка для отслеживания ввода Stars

```sql
ALTER TABLE nodeon_users 
ADD COLUMN last_stars_deposit_date TIMESTAMP WITH TIME ZONE;
```

### 4. Обновлен endpoint `/api/payments/exchange-request`

**Проверки:**
- ✅ Минимальная сумма вывода: 500 Stars
- ✅ Проверка баланса NDN
- ✅ Проверка 21 дня с момента последнего ввода
- ✅ Создание заявки в `nodeon_withdrawal_requests`

**Логика:**
1. Проверяется минимальная сумма (500 Stars)
2. Проверяется баланс пользователя
3. Вызывается функция `can_withdraw_stars()` для проверки срока
4. Если все проверки пройдены:
   - Списываются NDN с баланса
   - Создается заявка в `nodeon_withdrawal_requests`
   - Создается транзакция в истории
   - Возвращается подтверждение

### 5. Обновлен webhook для отслеживания ввода Stars

При покупке NDN за Stars обновляется `last_stars_deposit_date`:

```javascript
.update({
  balance_ndn: newBalance,
  last_stars_deposit_date: new Date().toISOString(), // Текущая дата
  updated_at: new Date().toISOString()
})
```

## Правила вывода Stars

### Минимальная сумма: 500 Stars
Пользователь не может вывести меньше 500 Stars.

### Временное ограничение: 21 день
С момента последней покупки NDN за Stars должно пройти 21 день.

### Проверка менеджером
Все заявки создаются со статусом `pending` и требуют проверки менеджером.

## Процесс вывода

### 1. Пользователь создает заявку
- Указывает количество NDN (минимально 500)
- Указывает username
- Система проверяет:
  - Минимальная сумма
  - Баланс NDN
  - Прошло ли 21 день

### 2. Если проверки пройдены
- NDN списываются с баланса
- Создается заявка в `nodeon_withdrawal_requests` (статус: pending)
- Пользователь получает подтверждение

### 3. Менеджер рассматривает заявку
- Просматривает список заявок
- Проверяет информацию
- Одобряет или отклоняет

### 4. После одобрения
- Отправляет Stars через Telegram Bot API
- Обновляет статус заявки на `completed`
- Пользователь получает Stars

## Структура базы данных

### Таблица `nodeon_withdrawal_requests`
```
id | user_id | telegram_id | amount_ndn | amount_stars | status  | days_since_deposit | created_at
1  | 5       | 207940967   | 500        | 500          | pending | 25                  | 2024-01-15
```

### Таблица `nodeon_users` (добавлена колонка)
```
id | telegram_id | balance_ndn | last_stars_deposit_date
5  | 207940967   | 1000        | 2023-12-25
```

## Сообщения для пользователя

### Успешное создание заявки
```
Заявка на вывод 500 Stars принята. 
Менеджер рассмотрит заявку и отправит Stars на @username.
```

### Ошибка: Минимальная сумма
```
Минимальная сумма вывода: 500 Stars
```

### Ошибка: Не прошло 21 день
```
Осталось ждать 15 дней
```

### Ошибка: Недостаточно NDN
```
Недостаточно NDN на балансе
```

## Результат

- ✅ Минимальная сумма вывода: 500 Stars
- ✅ Временное ограничение: 21 день
- ✅ Таблица заявок создана
- ✅ Проверки перед созданием заявки
- ✅ Отслеживание даты ввода Stars
- ✅ Менеджер может рассматривать заявки
- ✅ Курс обмена 1:1 (тестовый режим)

## Установка

1. Выполнить SQL скрипт `CREATE_WITHDRAWAL_REQUESTS_TABLE.sql` в Supabase
2. Добавить колонку `last_stars_deposit_date` в `nodeon_users`
3. Создать функцию `can_withdraw_stars`

## Админ панель для менеджера

Необходимо создать админ панель для просмотра заявок:
- Список всех заявок со статусом `pending`
- Информация о пользователе
- Кнопки для одобрения/отклонения
- Отправка Stars через Bot API











