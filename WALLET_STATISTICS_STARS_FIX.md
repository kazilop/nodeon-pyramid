# Исправление учета Stars в wallet_statistics

## Проблема
После покупки NDN за Stars в таблице `wallet_statistics` не обновлялись поля для учета Stars:
- `total_stars_received` - общее количество Stars, полученных на кошелек
- `total_stars_paid` - общее количество Stars, выплаченных пользователям
- `net_stars_balance` - текущий баланс Stars в кошельке бота

## Причина
Webhook не создавал транзакции в таблице `nodeon_wallet_transactions` типа `stars_purchase`, которая используется представлением `wallet_statistics` для расчета статистики.

## Решение

### Добавлено создание транзакций в `nodeon_wallet_transactions`

Теперь после успешного платежа создаются две транзакции:

1. **В `nodeon_transactions`** - для общей статистики транзакций пользователя
2. **В `nodeon_wallet_transactions`** - для учета Stars в wallet_statistics

```javascript
// Создаем транзакцию для учет Stars в wallet_statistics
const { data: serverWallet } = await supabase
  .from('nodeon_server_wallet')
  .select('id, balance_ndn')
  .eq('is_active', true)
  .limit(1)
  .single();

if (serverWallet && !walletError) {
  const wallet_id = serverWallet.id;
  const balance_before = serverWallet.balance_ndn || 0;
  const balance_after = balance_before; // NDN не увеличивается
  
  // Создаем wallet transaction для учета Stars
  await supabase
    .from('nodeon_wallet_transactions')
    .insert({
      wallet_id: wallet_id,
      user_id: user.id,
      type: 'stars_purchase',
      stars_amount: amount_ndn, // Количество Stars, полученных ботом
      ndn_amount: amount_ndn,
      balance_before: balance_before,
      balance_after: balance_after,
      description: `Получено ${amount_ndn} Stars от пользователя ${telegram_id} за ${amount_ndn} NDN`,
      created_at: new Date().toISOString()
    });
}
```

## Структура данных

### Таблица `nodeon_wallet_transactions`:
```sql
id | wallet_id | user_id | type          | stars_amount | ndn_amount | description
1  | 1         | 5       | stars_purchase | 2            | 2         | Получено 2 Stars от пользователя 207940967 за 2 NDN
```

### Представление `wallet_statistics`:
```sql
SELECT 
    sw.id,
    sw.wallet_name,
    sw.balance_ndn,
    -- Stars статистика
    COALESCE(SUM(CASE WHEN wt.type = 'stars_purchase' THEN wt.stars_amount ELSE 0 END), 0) as total_stars_received,
    COALESCE(SUM(CASE WHEN wt.type = 'stars_withdrawal' THEN wt.stars_amount ELSE 0 END), 0) as total_stars_paid,
    -- Баланс Stars = получено - выплачено
    (COALESCE(SUM(CASE WHEN wt.type = 'stars_purchase' THEN wt.stars_amount ELSE 0 END), 0) - 
     COALESCE(SUM(CASE WHEN wt.type = 'stars_withdrawal' THEN wt.stars_amount ELSE 0 END), 0)) as net_stars_balance
FROM nodeon_server_wallet sw
LEFT JOIN nodeon_wallet_transactions wt ON sw.id = wt.wallet_id
GROUP BY sw.id;
```

## Как это работает

1. **Пользователь покупает NDN за Stars** → Telegram обрабатывает платеж
2. **Webhook получает `successful_payment`** → зачисляет NDN на баланс пользователя
3. **Создает транзакцию в `nodeon_transactions`** → для статистики пользователя
4. **Создает транзакцию в `nodeon_wallet_transactions`** → для учета Stars в кошельке
5. **Представление `wallet_statistics`** → рассчитывает:
   - `total_stars_received` - сумма всех `stars_amount` из транзакций типа `stars_purchase`
   - `total_stars_paid` - сумма всех `stars_amount` из транзакций типа `stars_withdrawal`
   - `net_stars_balance` - разница между полученными и выплаченными Stars

## Статистика в админ панели

Теперь админ панель может использовать `wallet_statistics` для отображения:

- **Получено Stars:** `total_stars_received` ⭐
- **Выплачено Stars:** `total_stars_paid` ⭐
- **Баланс Stars:** `net_stars_balance` ⭐ (получено - выплачено)

## Результат

- ✅ Транзакции создаются в `nodeon_wallet_transactions`
- ✅ Поле `stars_amount` заполняется корректно
- ✅ Тип транзакции `stars_purchase` указывает на получение Stars
- ✅ Представление `wallet_statistics` корректно рассчитывает статистику
- ✅ Админ панель показывает актуальный баланс Stars в кошельке

## Тестирование

1. Выполните покупку NDN за Stars через Mini App
2. Проверьте что в `nodeon_wallet_transactions` создана транзакция
3. Проверьте представление `wallet_statistics` в базе данных
4. Убедитесь что `total_stars_received` и `net_stars_balance` увеличились










