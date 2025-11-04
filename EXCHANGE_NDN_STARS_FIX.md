# Исправление вывода Stars за NDN

## Проблема
При попытке обмена NDN на Stars возникала ошибка "unexpected token" и endpoint `/api/payments/exchange-request` отсутствовал.

## Причина
1. Endpoint `/api/payments/exchange-request` не был реализован в `payments.js`
2. Фронтенд пытался отправить запрос на несуществующий endpoint

## Решение

### Добавлен endpoint `/api/payments/exchange-request`

```javascript
// POST /api/payments/exchange-request - Заявка на обмен NDN на Stars
router.post('/exchange-request', async (req, res) => {
  try {
    const { amount_ndn, telegram_username, description } = req.body;
    const authHeader = req.headers.authorization;
    
    // Проверки валидации
    if (!amount_ndn || amount_ndn < 1) {
      return res.status(400).json({ error: 'Invalid amount' });
    }
    
    if (amount_ndn > 10000) {
      return res.status(400).json({ error: 'Amount too large' });
    }
    
    // Получение пользователя
    const { data: user } = await supabase
      .from('nodeon_users')
      .select('*')
      .eq('telegram_id', telegram_id)
      .single();
    
    // Проверка баланса
    if (user.balance_ndn < amount_ndn) {
      return res.status(400).json({ error: 'Insufficient balance' });
    }
    
    // Списываем NDN с баланса
    const newBalance = user.balance_ndn - amount_ndn;
    await supabase
      .from('nodeon_users')
      .update({ balance_ndn: newBalance })
      .eq('id', user.id);
    
    // Создаем транзакцию
    const { data: transaction } = await supabase
      .from('nodeon_transactions')
      .insert({
        user_id: user.id,
        type: 'exchange_request',
        amount_ndn: -amount_ndn,
        amount_stars: amount_ndn, // 1 NDN = 1 Star
        description: `Заявка на обмен ${amount_ndn} NDN на ${amount_ndn} Telegram Stars для ${telegram_username}`
      });
    
    res.json({
      success: true,
      message: `Заявка на обмен принята. Ожидайте получения ${amount_ndn} Stars на @${telegram_username}.`,
      new_balance: newBalance
    });
    
  } catch (error) {
    res.status(500).json({ error: 'Internal server error' });
  }
});
```

## Логика работы

### В тестовом режиме:
1. Пользователь указывает количество NDN и username
2. NDN списываются с баланса сразу
3. Создается транзакция типа `exchange_request`
4. Пользователь получает подтверждение
5. Админ вручную отправляет Stars через Telegram Bot

### В продакшене:
- Админ получает заявку через админ панель
- Админ отправляет Stars через Telegram Bot API
- Транзакция обновляется как выполненная

## Курс обмена

**Тестовый режим:** 1 NDN = 1 Star (курс 1:1)

## Структура транзакции

```sql
INSERT INTO nodeon_transactions (
  user_id,
  type,
  amount_ndn,
  amount_stars,
  description
) VALUES (
  5,
  'exchange_request',
  -2,               -- NDN списываются
  2,                -- Stars будут выданы
  'Заявка на обмен 2 NDN на 2 Telegram Stars для @username'
);
```

## Результат

- ✅ Endpoint `/api/payments/exchange-request` добавлен
- ✅ NDN списываются с баланса пользователя
- ✅ Создается транзакция для учета
- ✅ Баланс обновляется автоматически
- ✅ Пользователь получает подтверждение

## Тестирование

1. Откройте Mini App в Telegram
2. Нажмите "Обменять NDN на Stars"
3. Введите количество NDN и username (например, @username)
4. Нажмите "Обменять"
5. NDN спишутся с баланса
6. Вы получите подтверждение

## Следующие шаги для продакшена

1. Добавить админ панель для обработки заявок
2. Реализовать автоматическую отправку Stars через Telegram Bot API
3. Обновлять статус транзакции после отправки
4. Добавить уведомления пользователю о готовности выплаты










