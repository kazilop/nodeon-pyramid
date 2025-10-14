# Настройка Telegram Stars для NodeOn Crypto

## Обзор
Этот документ описывает настройку системы платежей Telegram Stars для покупки NDN монет в приложении NodeOn Crypto.

## Что такое Telegram Stars?
Telegram Stars - это внутренняя валюта Telegram, которую пользователи могут покупать через App Store/Google Play и использовать для покупки цифровых товаров и услуг в ботов и мини-приложениях.

## Требования

### 1. Telegram Bot
- ✅ Бот уже создан: `@NodeOnCryptoBot`
- ✅ Token: `7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ`

### 2. Активация Stars
**ВАЖНО**: Нужно активировать Stars для бота через @BotSupport

1. Напишите @BotSupport в Telegram
2. Отправьте команду `/start`
3. Выберите "Stars for Bots"
4. Укажите username вашего бота: `@NodeOnCryptoBot`
5. Подтвердите активацию

### 3. Webhook настройка
Webhook уже настроен для обработки платежей:
- URL: `https://nodeon-crypto-production.up.railway.app/api/payments/webhook`
- Обрабатывает: `pre_checkout_query`, `message`

## API Endpoints

### 1. Создание счета
```
POST /api/payments/create-invoice
Authorization: tma <init_data>
Content-Type: application/json

{
    "amount_ndn": 100,
    "description": "Покупка 100 NDN за 100 Telegram Stars"
}
```

### 2. Webhook для обработки платежей
```
POST /api/payments/webhook
Content-Type: application/json

{
    "pre_checkout_query": { ... },
    "message": { ... }
}
```

## Процесс платежа

### 1. Пользователь нажимает "Купить NDN"
- Фронтенд отправляет запрос на `/api/payments/create-invoice`
- API создает счет через Telegram Bot API
- Пользователь получает уведомление в Telegram

### 2. Пользователь оплачивает в Telegram
- Открывается интерфейс оплаты Telegram
- Пользователь подтверждает платеж
- Telegram отправляет `pre_checkout_query` на webhook

### 3. Обработка платежа
- API проверяет данные платежа
- Подтверждает или отклоняет через `answerPreCheckoutQuery`
- При успешной оплате получает `successful_payment`
- Зачисляет NDN пользователю

## Курс валют
- **1 NDN = 1 Telegram Star**
- Минимальная покупка: 1 NDN
- Максимальная покупка: 10,000 NDN

## Тестирование

### 1. Тестовый режим
Telegram предоставляет тестовую среду для разработки:
- Используйте тестовые Stars
- Проверьте все сценарии платежей

### 2. Проверка webhook
```bash
python setup_telegram_webhook.py
```

### 3. Логи
Проверьте логи на Railway для отладки:
- Успешные платежи: `✅ Payment processed: X NDN for user Y`
- Ошибки: `❌ Error processing payment: ...`

## Безопасность

### 1. Валидация подписи
- Все запросы проверяются через `verify_telegram_auth()`
- Используется HMAC-SHA256 для проверки `init_data`

### 2. Защита от дублирования
- Каждый платеж имеет уникальный `telegram_payment_charge_id`
- Проверка на существование транзакции

### 3. Лимиты
- Максимальная сумма: 10,000 NDN
- Минимальная сумма: 1 NDN
- Таймаут обработки: 10 секунд

## Мониторинг

### 1. Метрики
- Количество успешных платежей
- Сумма обработанных Stars
- Ошибки платежей

### 2. Алерты
- Неудачные платежи
- Ошибки webhook
- Превышение лимитов

## Возвраты

### 1. Автоматические возвраты
- При ошибке обработки платежа
- При превышении лимитов
- При несуществующем пользователе

### 2. Ручные возвраты
```python
refund_star_payment(telegram_payment_charge_id, amount)
```

## Поддержка

### 1. Пользователи
- Команда `/paysupport` в боте
- Обработка через webhook

### 2. Разработчики
- Логи в Railway
- Мониторинг через Telegram Bot API

## Следующие шаги

1. ✅ Активировать Stars через @BotSupport
2. ✅ Протестировать платежи
3. ✅ Настроить мониторинг
4. ✅ Запустить в продакшн

## Полезные ссылки

- [Telegram Stars Documentation](https://core.telegram.org/bots/payments-stars)
- [Bot API Payments](https://core.telegram.org/bots/api#payments)
- [Telegram Bot Support](https://t.me/BotSupport)

