import asyncio
import logging
from telegram import Update, InlineKeyboardButton, InlineKeyboardMarkup, WebAppInfo, LabeledPrice
from telegram.ext import Application, CommandHandler, ContextTypes, MessageHandler, filters, PreCheckoutQueryHandler, MessageHandler
from config import settings
import httpx

# Настройка логирования
logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)
logger = logging.getLogger(__name__)

class TelegramBot:
    def __init__(self):
        self.application = Application.builder().token(settings.telegram_bot_token).build()
        self.setup_handlers()
    
    def setup_handlers(self):
        """Настройка обработчиков команд"""
        self.application.add_handler(CommandHandler("start", self.start_command))
        self.application.add_handler(CommandHandler("help", self.help_command))
        self.application.add_handler(CommandHandler("buy_ndn", self.buy_ndn_command))
        self.application.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, self.handle_message))
        # Обработчики платежей через Stars
        self.application.add_handler(PreCheckoutQueryHandler(self.precheckout_handler))
        self.application.add_handler(MessageHandler(filters.SUCCESSFUL_PAYMENT, self.successful_payment_handler))
    
    async def start_command(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Обработка команды /start"""
        user = update.effective_user
        referral_code = None
        
        # Проверяем, есть ли реферальный код в команде
        if context.args:
            referral_code = context.args[0]
        
        # Создаем клавиатуру с Mini App
        keyboard = [
            [InlineKeyboardButton(
                "🚀 Открыть приложение",
                web_app=WebAppInfo(url=f"https://yourdomain.com")  # Замените на ваш домен
            )]
        ]
        
        if referral_code:
            keyboard.append([InlineKeyboardButton(
                "📱 Присоединиться по реферальной ссылке",
                web_app=WebAppInfo(url=f"https://yourdomain.com?ref={referral_code}")
            )])
        
        reply_markup = InlineKeyboardMarkup(keyboard)
        
        welcome_text = f"""
🎉 Добро пожаловать в NodeOn Pyramid, {user.first_name}!

💰 Реферальная игра с монетами NDN
📈 Зарабатывайте до 7 уровней в глубину
⭐ Покупайте и выводите через Telegram Stars

{self.get_rules_text()}
        """
        
        await update.message.reply_text(
            welcome_text,
            reply_markup=reply_markup,
            parse_mode='HTML'
        )
    
    async def help_command(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Обработка команды /help"""
        help_text = """
🤖 <b>NodeOn Pyramid Bot</b>

<b>Основные команды:</b>
/start - Запустить приложение
/help - Показать эту справку

<b>Как играть:</b>
1. Нажмите "Открыть приложение"
2. Купите 1000 NDN за Telegram Stars
3. Приобретите Pro статус
4. Получите реферальную ссылку
5. Приглашайте друзей и зарабатывайте!

<b>Реферальная система:</b>
• Уровень 1: 200 NDN
• Уровень 2-7: 150 NDN каждый

<b>Поддержка:</b>
@your_support_username
        """
        
        await update.message.reply_text(help_text, parse_mode='HTML')
    
    async def handle_message(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Обработка обычных сообщений"""
        message_text = update.message.text.lower()
        
        if any(word in message_text for word in ['правила', 'как играть', 'помощь']):
            await self.help_command(update, context)
        elif any(word in message_text for word in ['приложение', 'открыть', 'игра']):
            keyboard = [[InlineKeyboardButton(
                "🚀 Открыть приложение",
                web_app=WebAppInfo(url="https://yourdomain.com")
            )]]
            reply_markup = InlineKeyboardMarkup(keyboard)
            await update.message.reply_text(
                "Нажмите кнопку ниже, чтобы открыть приложение:",
                reply_markup=reply_markup
            )
        else:
            await update.message.reply_text(
                "Используйте /start для запуска приложения или /help для справки."
            )
    
    async def buy_ndn_command(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Создание invoice для покупки NDN через Stars"""
        user = update.effective_user
        
        try:
            # Получаем количество NDN из аргументов
            amount = int(context.args[0]) if context.args else 100
            
            if amount < 1 or amount > 10000:
                await update.message.reply_text(
                    "Количество NDN должно быть от 1 до 10,000"
                )
                return
            
            # Создаем invoice для Telegram Stars
            await update.message.reply_invoice(
                title=f"Покупка {amount} NDN",
                description=f"Покупка {amount} NDN за {amount} Telegram Stars",
                payload=f"ndn_{user.id}_{amount}",
                provider_token="",  # Пустой для Stars
                currency="XTR",  # Telegram Stars
                prices=[LabeledPrice(label=f"{amount} NDN", amount=amount)]
            )
        except ValueError:
            await update.message.reply_text("Используйте: /buy_ndn <количество>")
        except Exception as e:
            logger.error(f"Error creating invoice: {e}")
            await update.message.reply_text("Ошибка создания счета")
    
    async def precheckout_handler(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Обработка PreCheckoutQuery"""
        query = update.pre_checkout_query
        
        try:
            # Валидация платежа
            # В реальном приложении здесь проверка баланса и т.д.
            
            # Подтверждаем платеж
            await query.answer(ok=True)
            logger.info(f"Precheckout approved for user {query.from_user.id}")
        except Exception as e:
            logger.error(f"Error in precheckout: {e}")
            await query.answer(ok=False, error_message="Ошибка обработки платежа")
    
    async def successful_payment_handler(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Обработка успешного платежа"""
        payment = update.message.successful_payment
        user = update.effective_user
        
        try:
            # Извлекаем данные из payload
            payload = payment.invoice_payload
            parts = payload.split('_')
            
            if len(parts) == 3 and parts[0] == 'ndn':
                telegram_id = int(parts[1])
                amount = int(parts[2])
                
                # Зачисляем NDN на баланс пользователя через API
                async with httpx.AsyncClient() as client:
                    response = await client.post(
                        f"{settings.backend_url}/api/payments/confirm-payment",
                        json={
                            "telegram_id": telegram_id,
                            "amount_ndn": amount,
                            "payment_id": payment.telegram_payment_charge_id
                        }
                    )
                    
                    if response.status_code == 200:
                        await update.message.reply_text(
                            f"✅ Спасибо за покупку! {amount} NDN зачислены на ваш баланс."
                        )
                    else:
                        await update.message.reply_text(
                            "Ошибка зачисления NDN. Обратитесь в поддержку."
                        )
        except Exception as e:
            logger.error(f"Error processing payment: {e}")
            await update.message.reply_text(
                "Ошибка обработки платежа. Обратитесь в поддержку."
            )
    
    def get_rules_text(self):
        """Получение текста правил"""
        return """
<b>📋 Правила игры:</b>
• Купите Pro статус за 1000 NDN
• Получите реферальную ссылку
• Приглашайте друзей по ссылке
• Зарабатывайте с каждого Pro реферала
• Выводите NDN обратно в Stars

<b>💰 Награды по уровням:</b>
1️⃣ 200 NDN
2️⃣ 150 NDN
3️⃣ 150 NDN
4️⃣ 150 NDN
5️⃣ 150 NDN
6️⃣ 150 NDN
7️⃣ 150 NDN
        """
    
    async def process_referral_join(self, user_id: int, referral_code: str):
        """Обработка присоединения по реферальной ссылке"""
        try:
            async with httpx.AsyncClient() as client:
                response = await client.post(
                    f"http://backend:8000/api/referrals/join-by-referral",
                    json={
                        "user_id": user_id,
                        "referral_code": referral_code
                    }
                )
                return response.json()
        except Exception as e:
            logger.error(f"Error processing referral join: {e}")
            return None
    
    async def send_notification(self, user_id: int, message: str):
        """Отправка уведомления пользователю"""
        try:
            await self.application.bot.send_message(
                chat_id=user_id,
                text=message,
                parse_mode='HTML'
            )
        except Exception as e:
            logger.error(f"Error sending notification: {e}")
    
    def run(self):
        """Запуск бота"""
        self.application.run_polling()

# Создаем экземпляр бота
bot = TelegramBot()

if __name__ == "__main__":
    bot.run()
