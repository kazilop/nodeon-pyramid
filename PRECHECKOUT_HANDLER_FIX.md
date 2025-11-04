# Исправление обработки pre_checkout_query

## Проблема
При попытке подтверждения платежа в Mini App отображался таймаут "your bot not respond in time". Бот не отвечал на запрос подтверждения платежа (`pre_checkout_query`).

## Причина
Webhook `/webhook/telegram` не обрабатывал события `pre_checkout_query` от Telegram Bot API, только `successful_payment`. Без подтверждения `pre_checkout_query` платеж не завершался.

## Решение

### Добавлена обработка pre_checkout_query в webhook.js

```javascript
// Обработка pre_checkout_query - подтверждаем платеж
if (update.pre_checkout_query) {
  const query = update.pre_checkout_query;
  
  console.log('✅ Обрабатываем pre_checkout_query:', {
    id: query.id,
    from: query.from.id,
    payload: query.invoice_payload
  });
  
  // Подтверждаем платеж через Bot API
  try {
    console.log('📤 Отправляем answerPreCheckoutQuery для:', query.id);
    const answerResponse = await axios.post(`${TELEGRAM_API}/answerPreCheckoutQuery`, {
      pre_checkout_query_id: query.id,
      ok: true
    });
    console.log('✅ Pre-checkout query подтвержден:', answerResponse.data);
  } catch (error) {
    console.error('❌ Ошибка подтверждения pre-checkout:', error.response?.data || error.message);
    console.error('Full error:', error);
  }
  
  // Отвечаем Telegram
  return res.json({ ok: true });
}
```

### Изменения в логике webhook.js
1. Добавлена обработка `update.pre_checkout_query` до обработки `successful_payment`
2. Вызов `answerPreCheckoutQuery` с параметрами:
   - `pre_checkout_query_id`: ID запроса
   - `ok: true`: Подтверждение платежа
3. Добавлено логирование для отладки
4. Ответ Telegram после подтверждения

## Процесс платежа

### Шаг 1: Создание invoice
Mini App вызывает `/api/payments/create-invoice`, который создает invoice через Telegram Bot API.

### Шаг 2: pre_checkout_query (подтверждение)
Telegram отправляет `pre_checkout_query` на `/webhook/telegram`:
- Webhook получает обновление
- Вызывает `answerPreCheckoutQuery` с `ok: true`
- Telegram показывает форму подтверждения пользователю

### Шаг 3: successful_payment (зачисление)
После подтверждения Telegram отправляет `successful_payment`:
- Webhook зачисляет NDN на баланс пользователя
- Отправляет уведомление пользователю

## Тестирование

### Автоматический тест
```bash
node test_precheckout.js
```

Результат:
- Статус: 200
- Ответ: `{"ok":true}`
- В логах: `✅ Обрабатываем pre_checkout_query`

### Логи сервера при реальном платеже
```
📨 Получен webhook от Telegram: {
  update_id: 445702025,
  pre_checkout_query: {
    id: '893099654830564193',
    from: { id: 207940967, ... },
    currency: 'XTR',
    total_amount: 1,
    invoice_payload: 'ndn_207940967_1_97'
  }
}
✅ Обрабатываем pre_checkout_query: {
  id: '893099654830564193',
  from: 207940967,
  payload: 'ndn_207940967_1_97'
}
📤 Отправляем answerPreCheckoutQuery для: 893099654830564193
✅ Pre-checkout query подтвержден: { ok: true }
```

## Итог
- Webhook теперь обрабатывает `pre_checkout_query`
- Платеж подтверждается через `answerPreCheckoutQuery`
- Telegram получает подтверждение вовремя (без таймаутов)
- Пользователь видит форму подтверждения платежа

## Следующие шаги
1. Протестировать реальный платеж в Mini App
2. Проверить что форма подтверждения отображается корректно
3. Убедиться что NDN зачисляются после успешной оплаты











