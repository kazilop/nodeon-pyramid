# Исправление статистики Stars в админ панели

## Проблема
После успешной покупки NDN за Stars, в админ панели не отображалось, что баланс Stars увеличился. Статистика "Получено Stars" не обновлялась.

## Причина
1. В webhook не создавалась транзакция в БД после успешного платежа
2. Статистика в админ панели рассчитывалась из `nodeon_transactions`, где отсутствовали записи о платежах
3. Поле `amount_stars` не заполнялось в транзакциях

## Решение

### 1. Добавлено создание транзакций в webhook.js

```javascript
// Создаем транзакцию в базе для статистики
const { error: transactionError } = await supabase
  .from('nodeon_transactions')
  .insert({
    user_id: user.id,
    type: 'buy_ndn',
    amount_ndn: amount_ndn,
    amount_stars: amount_ndn, // Количество Stars, которое заплатил пользователь
    description: `Покупка ${amount_ndn} NDN за ${amount_ndn} Telegram Stars`,
    created_at: new Date().toISOString()
  });
```

### 2. Логика в admin.js (уже была правильной)

Админ панель суммирует все транзакции типа `buy_ndn`:
```javascript
if (transaction.type === 'buy_ndn') {
  totalStarsReceived += transaction.amount_stars || 0;
}
```

## Как это работает

### Поток данных:

1. **Пользователь покупает NDN за Stars** → Telegram обрабатывает платеж
2. **Webhook получает `successful_payment`** → обрабатывает через `/webhook/telegram`
3. **Зачисляет NDN на баланс** → обновляет `nodeon_users.balance_ndn`
4. **Создает транзакцию** → вставляет запись в `nodeon_transactions`:
   - `type: 'buy_ndn'` - тип покупки
   - `amount_ndn: 2` - количество полученных NDN
   - `amount_stars: 2` - количество заплаченных Stars
5. **Админ панель подгружает статистику** → суммирует все `amount_stars` из транзакций типа `buy_ndn`
6. **Отображает "Получено Stars"** → показывает сумму Stars, полученных ботом

## Структура данных

### Таблица `nodeon_transactions`:
```sql
id | user_id | type      | amount_ndn | amount_stars | description
1  | 5       | buy_ndn   | 2          | 2           | Покупка 2 NDN за 2 Telegram Stars
```

### Админ панель:
```javascript
wallet: {
  balance_ndn: 1000002098.00,
  balance_stars: 0,
  total_stars_received: 4,  // Сумма всех amount_stars из транзакций buy_ndn
  total_ndn_exchanged: 0,
  total_stars_sent: 0
}
```

## Результат

- ✅ Транзакции создаются после каждого успешного платежа
- ✅ Поле `amount_stars` заполняется корректно
- ✅ Админ панель отображает актуальную статистику Stars
- ✅ Баланс Stars в кошельке бота отображается корректно

## Тестирование

1. Выполните покупку NDN за Stars через Mini App
2. Перейдите в админ панель
3. Проверьте что "Получено Stars" увеличилось
4. Проверьте что в БД создана транзакция `type='buy_ndn'`










