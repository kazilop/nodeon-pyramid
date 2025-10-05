# ⭐ ОФИЦИАЛЬНАЯ ИНТЕГРАЦИЯ TELEGRAM STARS

## 📚 ОСНОВАННО НА ОФИЦИАЛЬНОЙ ДОКУМЕНТАЦИИ

Согласно [официальной документации Telegram](https://core.telegram.org/bots/payments-stars), для продажи цифровых товаров и услуг в Telegram **обязательно** использовать Telegram Stars.

---

## 🔑 ОБЯЗАТЕЛЬНЫЕ ТРЕБОВАНИЯ TELEGRAM

### **1. Только Telegram Stars**
- Все платежи за цифровые товары должны быть в **Telegram Stars**
- Валюта: `XTR` (обязательно)
- Нельзя использовать другие валюты или платежные системы

### **2. Bot API методы**
```python
# Создание инвойса
sendInvoice(
    chat_id=user_id,
    title="Покупка NDN",
    description="Покупка 100 NDN за 100 Stars",
    payload="ndn_purchase_123",
    provider_token="",  # Пустая строка для цифровых товаров
    currency="XTR",     # Обязательно XTR
    prices=[{"label": "NDN", "amount": 10000}]  # В копейках
)

# Подтверждение платежа
answerPreCheckoutQuery(
    pre_checkout_query_id=query_id,
    ok=True
)

# Возврат средств
refundStarPayment(
    user_id=user_id,
    telegram_payment_charge_id=charge_id
)
```

### **3. Обязательные команды бота**
```python
# /terms - Условия использования
def terms_command(update, context):
    terms_text = """
    УСЛОВИЯ ИСПОЛЬЗОВАНИЯ NODEON PYRAMID
    
    1. NDN - это игровая валюта для участия в реферальной программе
    2. Покупка NDN осуществляется за Telegram Stars
    3. Возврат средств возможен в течение 24 часов
    4. Разработчик не несет ответственности за потерю NDN
    5. Запрещено использование ботов и автоматизации
    """
    update.message.reply_text(terms_text)

# /support - Поддержка
def support_command(update, context):
    support_text = """
    ПОДДЕРЖКА NODEON PYRAMID
    
    По вопросам покупки NDN обращайтесь:
    - Telegram: @your_support_bot
    - Email: support@yourdomain.com
    
    Время ответа: до 24 часов
    """
    update.message.reply_text(support_text)

# /paysupport - Поддержка по платежам
def paysupport_command(update, context):
    paysupport_text = """
    ПОДДЕРЖКА ПО ПЛАТЕЖАМ
    
    Если у вас проблемы с платежами:
    1. Проверьте баланс Stars
    2. Убедитесь в стабильности интернета
    3. Обратитесь в поддержку
    
    Telegram поддержка НЕ поможет с платежами через бота!
    """
    update.message.reply_text(paysupport_text)
```

---

## 🏗️ ОБНОВЛЕННАЯ АРХИТЕКТУРА

### **1. Telegram Bot (обязательно)**
```python
# telegram_bot_stars.py
import logging
from telegram import Update, InlineKeyboardButton, InlineKeyboardMarkup
from telegram.ext import Application, CommandHandler, CallbackQueryHandler, ContextTypes
from telegram import LabeledPrice

class TelegramStarsBot:
    def __init__(self, token, api_base):
        self.token = token
        self.api_base = api_base
        self.application = Application.builder().token(token).build()
        self.setup_handlers()
    
    def setup_handlers(self):
        # Обязательные команды
        self.application.add_handler(CommandHandler("start", self.start_command))
        self.application.add_handler(CommandHandler("terms", self.terms_command))
        self.application.add_handler(CommandHandler("support", self.support_command))
        self.application.add_handler(CommandHandler("paysupport", self.paysupport_command))
        
        # Обработчики платежей
        self.application.add_handler(CallbackQueryHandler(self.handle_payment_callback))
    
    async def start_command(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Команда /start"""
        user = update.effective_user
        keyboard = [
            [InlineKeyboardButton("💰 Купить NDN", callback_data="buy_ndn")],
            [InlineKeyboardButton("📊 Статистика", callback_data="stats")],
            [InlineKeyboardButton("📋 Условия", callback_data="terms")],
            [InlineKeyboardButton("🆘 Поддержка", callback_data="support")]
        ]
        reply_markup = InlineKeyboardMarkup(keyboard)
        
        await update.message.reply_text(
            f"Привет, {user.first_name}!\n\n"
            "🚀 Добро пожаловать в NodeOn Pyramid!\n"
            "Реферальная игра с монетами NDN\n\n"
            "Выберите действие:",
            reply_markup=reply_markup
        )
    
    async def buy_ndn_invoice(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Создание инвойса для покупки NDN"""
        query = update.callback_query
        await query.answer()
        
        # Получаем данные пользователя
        user_id = query.from_user.id
        
        # Создаем инвойс
        await context.bot.send_invoice(
            chat_id=user_id,
            title="Покупка NDN",
            description="Покупка 100 NDN за 100 Telegram Stars",
            payload=f"ndn_purchase_{user_id}_{int(time.time())}",
            provider_token="",  # Пустая строка для цифровых товаров
            currency="XTR",     # Обязательно XTR для Stars
            prices=[LabeledPrice("NDN", 10000)],  # 100 Stars в копейках
            start_parameter="ndn_purchase"
        )
    
    async def pre_checkout_handler(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Обработка pre-checkout запроса"""
        query = update.pre_checkout_query
        
        # Проверяем платеж
        try:
            # Отправляем запрос на наш API для проверки
            response = requests.post(f"{self.api_base}/stars/validate-payment", json={
                "user_id": query.from_user.id,
                "payload": query.invoice_payload,
                "total_amount": query.total_amount,
                "currency": query.currency
            })
            
            if response.status_code == 200:
                data = response.json()
                if data.get('success'):
                    await query.answer(ok=True)
                else:
                    await query.answer(ok=False, error_message=data.get('message'))
            else:
                await query.answer(ok=False, error_message="Ошибка проверки платежа")
                
        except Exception as e:
            await query.answer(ok=False, error_message="Внутренняя ошибка сервера")
    
    async def successful_payment_handler(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Обработка успешного платежа"""
        payment = update.message.successful_payment
        
        try:
            # Отправляем запрос на наш API для обработки платежа
            response = requests.post(f"{self.api_base}/stars/process-payment", json={
                "user_id": update.effective_user.id,
                "telegram_payment_charge_id": payment.telegram_payment_charge_id,
                "provider_payment_charge_id": payment.provider_payment_charge_id,
                "currency": payment.currency,
                "total_amount": payment.total_amount,
                "invoice_payload": payment.invoice_payload
            })
            
            if response.status_code == 200:
                data = response.json()
                if data.get('success'):
                    await update.message.reply_text(
                        f"✅ Платеж успешно обработан!\n\n"
                        f"💰 Получено: {data.get('ndn_amount')} NDN\n"
                        f"⭐ Потрачено: {data.get('stars_amount')} Stars\n"
                        f"💳 ID платежа: {payment.telegram_payment_charge_id}\n\n"
                        f"Спасибо за покупку!"
                    )
                else:
                    await update.message.reply_text(
                        f"❌ Ошибка обработки платежа: {data.get('message')}\n\n"
                        f"Обратитесь в поддержку: /support"
                    )
            else:
                await update.message.reply_text(
                    "❌ Ошибка обработки платежа\n\n"
                    "Обратитесь в поддержку: /support"
                )
                
        except Exception as e:
            await update.message.reply_text(
                "❌ Внутренняя ошибка сервера\n\n"
                "Обратитесь в поддержку: /support"
            )
```

### **2. Обновленный API**
```python
# main_telegram_stars.py
from fastapi import FastAPI, HTTPException
import requests

app = FastAPI(title="NodeOn Pyramid - Telegram Stars API")

@app.post("/api/stars/validate-payment")
async def validate_payment(payment_data: dict):
    """Валидация платежа перед подтверждением"""
    try:
        user_id = payment_data.get('user_id')
        payload = payment_data.get('payload')
        total_amount = payment_data.get('total_amount')
        currency = payment_data.get('currency')
        
        # Проверяем валюту
        if currency != "XTR":
            return {"success": False, "message": "Неверная валюта"}
        
        # Проверяем сумму
        if total_amount != 10000:  # 100 Stars
            return {"success": False, "message": "Неверная сумма"}
        
        # Проверяем резерв серверного кошелька
        wallet_response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/get_server_wallet_balance",
            headers=get_supabase_headers(),
            json={}
        )
        
        if wallet_response.status_code == 200:
            wallet_data = wallet_response.json()
            if wallet_data.get('success'):
                wallet = wallet_data.get('wallet')
                if wallet.get('balance_ndn') < 100:  # 100 NDN
                    return {"success": False, "message": "Недостаточно NDN в резерве"}
        
        return {"success": True, "message": "Платеж валиден"}
        
    except Exception as e:
        return {"success": False, "message": "Ошибка валидации"}

@app.post("/api/stars/process-payment")
async def process_payment(payment_data: dict):
    """Обработка успешного платежа"""
    try:
        user_id = payment_data.get('user_id')
        telegram_payment_charge_id = payment_data.get('telegram_payment_charge_id')
        total_amount = payment_data.get('total_amount')
        
        # Рассчитываем количество NDN (1 Star = 1 NDN)
        stars_amount = total_amount / 100  # Конвертируем из копеек
        ndn_amount = stars_amount
        
        # Обрабатываем покупку через серверный кошелек
        purchase_response = requests.post(
            f"{SUPABASE_URL}/rest/v1/rpc/process_stars_purchase",
            headers=get_supabase_headers(),
            json={
                "p_user_id": user_id,
                "p_stars_amount": stars_amount,
                "p_ndn_amount": ndn_amount,
                "p_payment_id": telegram_payment_charge_id
            }
        )
        
        if purchase_response.status_code == 200:
            data = purchase_response.json()
            if data.get('success'):
                return {
                    "success": True,
                    "message": "Платеж обработан",
                    "ndn_amount": ndn_amount,
                    "stars_amount": stars_amount,
                    "transaction_id": data.get('transaction_id')
                }
            else:
                return {"success": False, "message": data.get('error')}
        else:
            return {"success": False, "message": "Ошибка обработки платежа"}
            
    except Exception as e:
        return {"success": False, "message": "Внутренняя ошибка"}

@app.post("/api/stars/refund")
async def refund_payment(refund_data: dict):
    """Возврат платежа"""
    try:
        user_id = refund_data.get('user_id')
        telegram_payment_charge_id = refund_data.get('telegram_payment_charge_id')
        amount = refund_data.get('amount')
        
        # Выполняем возврат через Telegram Bot API
        refund_response = requests.post(
            f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/refundStarPayment",
            json={
                "user_id": user_id,
                "telegram_payment_charge_id": telegram_payment_charge_id,
                "amount": amount
            }
        )
        
        if refund_response.status_code == 200:
            data = refund_response.json()
            if data.get('ok'):
                return {"success": True, "message": "Возврат выполнен"}
            else:
                return {"success": False, "message": data.get('description')}
        else:
            return {"success": False, "message": "Ошибка возврата"}
            
    except Exception as e:
        return {"success": False, "message": "Внутренняя ошибка"}
```

---

## 🚀 ПОШАГОВАЯ НАСТРОЙКА

### **ШАГ 1: Создание Telegram бота**
1. Обратитесь к [@BotFather](https://t.me/BotFather)
2. Создайте нового бота: `/newbot`
3. Получите токен бота
4. Настройте команды:
   ```
   /setcommands
   start - Запустить бота
   terms - Условия использования
   support - Поддержка
   paysupport - Поддержка по платежам
   ```

### **ШАГ 2: Активация Stars**
1. Обратитесь в [@BotSupport](https://t.me/BotSupport)
2. Запросите активацию Stars для вашего бота
3. Дождитесь подтверждения (1-3 дня)

### **ШАГ 3: Настройка webhook**
```python
# setup_webhook_stars.py
import requests

TELEGRAM_BOT_TOKEN = "YOUR_BOT_TOKEN"
WEBHOOK_URL = "https://yourdomain.com/webhook"

# Устанавливаем webhook
response = requests.post(
    f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/setWebhook",
    json={"url": WEBHOOK_URL}
)

print(f"Webhook установлен: {response.json()}")
```

### **ШАГ 4: Тестирование**
```python
# test_telegram_stars.py
import requests

# Тестируем создание инвойса
response = requests.post(
    f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/sendInvoice",
    json={
        "chat_id": "USER_ID",
        "title": "Тест покупки NDN",
        "description": "Покупка 100 NDN за 100 Stars",
        "payload": "test_payment",
        "provider_token": "",
        "currency": "XTR",
        "prices": [{"label": "NDN", "amount": 10000}]
    }
)

print(f"Инвойс создан: {response.json()}")
```

---

## 📋 ЧЕКЛИСТ ДЛЯ ЗАПУСКА

### **Обязательные требования:**
- ✅ **2FA включена** на аккаунте владельца бота
- ✅ **Команда /terms** - условия использования
- ✅ **Команда /support** - поддержка пользователей
- ✅ **Команда /paysupport** - поддержка по платежам
- ✅ **Webhook настроен** для обработки платежей
- ✅ **Сервер стабилен** с резервными копиями
- ✅ **Возвраты работают** через refundStarPayment

### **Дополнительные требования:**
- ✅ **Тестирование завершено** в тестовой среде
- ✅ **Документация готова** для пользователей
- ✅ **Мониторинг настроен** для отслеживания ошибок
- ✅ **Логирование включено** для всех операций

---

## 🎯 РЕЗУЛЬТАТ

После настройки в соответствии с официальной документацией:

✅ **Соответствие требованиям Telegram** - все платежи в Stars
✅ **Официальная интеграция** - использование Bot API
✅ **Обязательные команды** - /terms, /support, /paysupport
✅ **Возможность возвратов** - через refundStarPayment
✅ **Соответствие App Store/Play Store** - только Stars для цифровых товаров
✅ **Полная совместимость** - с официальными требованиями Telegram

**Система готова к официальному запуску! 🚀**
