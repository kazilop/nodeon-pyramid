# 💳 Настройка ЮКассы для NodeOn Pyramid

## 🎯 Обзор

ЮКасса - это платежная система для приема платежей в рублях. Интеграция позволит пользователям покупать NDN монеты за рубли.

## 🔧 Настройка ЮКассы

### 1. Регистрация в ЮКассе

1. **Перейдите на сайт ЮКассы:**
   - Откройте https://yookassa.ru/
   - Нажмите "Подключиться"

2. **Заполните данные:**
   - Выберите "Интернет-магазин"
   - Укажите данные вашей организации
   - Подтвердите email и телефон

3. **Пройдите верификацию:**
   - Загрузите документы
   - Дождитесь проверки (1-3 дня)

### 2. Получение ключей

После верификации вы получите:
- **Shop ID** - идентификатор магазина
- **Secret Key** - секретный ключ для API

### 3. Настройка в Supabase

Выполните SQL скрипт для добавления конфигурации:

```sql
-- Обновите конфигурацию ЮКассы
UPDATE nodeon_yookassa_config SET config_value = 'YOUR_SHOP_ID' WHERE config_key = 'yookassa_shop_id';
UPDATE nodeon_yookassa_config SET config_value = 'YOUR_SECRET_KEY' WHERE config_key = 'yookassa_secret_key';
```

### 4. Настройка webhook

1. **В личном кабинете ЮКассы:**
   - Перейдите в "Настройки" → "Webhook"
   - URL: `https://nodeon-production.up.railway.app/api/yookassa/webhook`
   - События: `payment.succeeded`, `payment.canceled`

2. **Проверьте webhook:**
   - ЮКасса отправит тестовое уведомление
   - Проверьте логи Railway

## 💰 Тарифы ЮКассы

### Комиссии:
- **Банковские карты:** 2.9% + 15₽
- **Электронные деньги:** 3.5% + 15₽
- **Банковские переводы:** 1.5% + 15₽

### Минимальные суммы:
- **Минимум:** 1₽
- **Максимум:** 15,000,000₽

## 🔧 Настройка API

### 1. Обновите main.py

Замените содержимое `main.py` на `main_with_payments.py`:

```bash
cp main_with_payments.py main.py
```

### 2. Добавьте зависимости

Добавьте в `requirements.txt`:

```
yookassa==3.0.0
```

### 3. Настройте переменные окружения

Добавьте в Railway:

```
YOOKASSA_SHOP_ID=ваш_shop_id
YOOKASSA_SECRET_KEY=ваш_secret_key
```

## 🧪 Тестирование

### 1. Тестовые карты

ЮКасса предоставляет тестовые карты:

- **Успешная оплата:** 5555 5555 5555 4444
- **Отклоненная оплата:** 5555 5555 5555 4445
- **Недостаточно средств:** 5555 5555 5555 4446

### 2. Запустите тесты

```bash
python test_stars_functionality.py
```

### 3. Проверьте в Telegram

1. Откройте бота в Telegram
2. Запустите приложение
3. Попробуйте купить NDN за рубли

## 📊 Мониторинг платежей

### 1. Логи Railway

```bash
railway logs --tail 50
```

### 2. Личный кабинет ЮКассы

- Перейдите в "Платежи"
- Просматривайте статистику
- Скачивайте отчеты

### 3. База данных

```sql
-- Просмотр платежей
SELECT * FROM nodeon_yookassa_payments ORDER BY created_at DESC;

-- Статистика по дням
SELECT 
    DATE(created_at) as date,
    COUNT(*) as payments,
    SUM(amount_rub) as total_rub,
    SUM(ndn_amount) as total_ndn
FROM nodeon_yookassa_payments 
WHERE status = 'succeeded'
GROUP BY DATE(created_at)
ORDER BY date DESC;
```

## 🔒 Безопасность

### 1. Проверка подписи

Все webhook уведомления должны проверяться:

```python
import hmac
import hashlib

def verify_yookassa_signature(data, signature, secret_key):
    expected_signature = hmac.new(
        secret_key.encode(),
        data.encode(),
        hashlib.sha256
    ).hexdigest()
    return hmac.compare_digest(signature, expected_signature)
```

### 2. Валидация данных

- Проверяйте сумму платежа
- Проверяйте статус платежа
- Логируйте все операции

## 📈 Аналитика

### 1. Метрики для отслеживания

- **Конверсия:** % успешных платежей
- **Средний чек:** средняя сумма платежа
- **Популярные суммы:** какие суммы покупают чаще
- **Время платежа:** как быстро пользователи оплачивают

### 2. Дашборд

Создайте дашборд с ключевыми метриками:

```sql
-- Топ пользователей по тратам
SELECT 
    u.first_name,
    u.username,
    SUM(yp.amount_rub) as total_rub,
    SUM(yp.ndn_amount) as total_ndn
FROM nodeon_yookassa_payments yp
JOIN nodeon_users u ON yp.user_id = u.id
WHERE yp.status = 'succeeded'
GROUP BY u.id, u.first_name, u.username
ORDER BY total_rub DESC
LIMIT 10;
```

## 🚀 Готово!

После настройки ЮКассы:

✅ **Пользователи смогут покупать NDN за рубли**
✅ **Автоматическое зачисление NDN после оплаты**
✅ **Подробная статистика платежей**
✅ **Безопасная обработка webhook**

**Время настройки: ~30 минут**
**Результат: Полнофункциональная платежная система!**
