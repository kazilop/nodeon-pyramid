#!/usr/bin/env python3
"""
Telegram Bot для NodeOn Pyramid с официальной поддержкой Stars
Соответствует требованиям https://core.telegram.org/bots/payments-stars
"""

import logging
import asyncio
import requests
import time
from telegram import Update, InlineKeyboardButton, InlineKeyboardMarkup, LabeledPrice
from telegram.ext import Application, CommandHandler, CallbackQueryHandler, ContextTypes, PreCheckoutQueryHandler, MessageHandler, filters
from telegram.error import TelegramError

# Настройки
TELEGRAM_BOT_TOKEN = "7670372637:AAG7XWbNkhvNx_M4MI4118AYXvIsn3bRMDQ"
API_BASE = "https://nodeon-production.up.railway.app/api"
SUPABASE_URL = "https://ahxwpzgltlzlvrtrbanm.supabase.co"
SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoeHdwemdsdGx6bHZydHJiYW5tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1MDMxNDksImV4cCI6MjA3NTA3OTE0OX0.h4sMVhVwvRUiHgbevDgv9W1G2S__uDWPUSCiXdrEy4E"

# Настройка логирования
logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)
logger = logging.getLogger(__name__)

def get_supabase_headers():
    """Получение заголовков для Supabase API"""
    return {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }

class NodeOnPyramidBot:
    def __init__(self):
        self.application = Application.builder().token(TELEGRAM_BOT_TOKEN).build()
        self.setup_handlers()
    
    def setup_handlers(self):
        """Настройка обработчиков команд и событий"""
        # Обязательные команды согласно документации Telegram
        self.application.add_handler(CommandHandler("start", self.start_command))
        self.application.add_handler(CommandHandler("terms", self.terms_command))
        self.application.add_handler(CommandHandler("support", self.support_command))
        self.application.add_handler(CommandHandler("paysupport", self.paysupport_command))
        
        # Обработчики платежей
        self.application.add_handler(PreCheckoutQueryHandler(self.pre_checkout_handler))
        self.application.add_handler(MessageHandler(filters.SUCCESSFUL_PAYMENT, self.successful_payment_handler))
        
        # Обработчики кнопок
        self.application.add_handler(CallbackQueryHandler(self.handle_callback))
    
    async def start_command(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Команда /start - главное меню"""
        user = update.effective_user
        
        # Создаем клавиатуру
        keyboard = [
            [InlineKeyboardButton("💰 Купить NDN", callback_data="buy_ndn")],
            [InlineKeyboardButton("📊 Статистика", callback_data="stats")],
            [InlineKeyboardButton("🏆 Лидерборд", callback_data="leaderboard")],
            [InlineKeyboardButton("📋 Условия", callback_data="terms")],
            [InlineKeyboardButton("🆘 Поддержка", callback_data="support")]
        ]
        reply_markup = InlineKeyboardMarkup(keyboard)
        
        welcome_text = (
            f"Привет, {user.first_name}! 👋\n\n"
            "🚀 **NodeOn Pyramid**\n"
            "Реферальная игра с монетами NDN\n\n"
            "💎 **Что такое NDN?**\n"
            "NDN - это игровая валюта для участия в реферальной программе\n\n"
            "⭐ **Покупка NDN**\n"
            "NDN можно купить за Telegram Stars\n"
            "Курс: 1 Star = 1 NDN\n\n"
            "👑 **Pro статус**\n"
            "За 1000 NDN вы получаете Pro статус и реферальную ссылку\n\n"
            "Выберите действие:"
        )
        
        await update.message.reply_text(
            welcome_text,
            reply_markup=reply_markup,
            parse_mode='Markdown'
        )
    
    async def terms_command(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Команда /terms - условия использования (обязательно)"""
        terms_text = (
            "📋 **УСЛОВИЯ ИСПОЛЬЗОВАНИЯ NODEON PYRAMID**\n\n"
            "**1. Общие положения**\n"
            "• NDN - это игровая валюта для участия в реферальной программе\n"
            "• Покупка NDN осуществляется за Telegram Stars\n"
            "• Все операции необратимы, кроме случаев возврата\n\n"
            "**2. Покупка NDN**\n"
            "• Минимальная покупка: 10 Stars\n"
            "• Максимальная покупка: 10,000 Stars\n"
            "• Курс: 1 Star = 1 NDN\n"
            "• Платежи обрабатываются через Telegram Stars\n\n"
            "**3. Возврат средств**\n"
            "• Возврат возможен в течение 24 часов после покупки\n"
            "• Обратитесь в поддержку: /support\n"
            "• Возврат осуществляется в Telegram Stars\n\n"
            "**4. Ответственность**\n"
            "• Разработчик не несет ответственности за потерю NDN\n"
            "• Запрещено использование ботов и автоматизации\n"
            "• Пользователь несет ответственность за безопасность аккаунта\n\n"
            "**5. Поддержка**\n"
            "• Telegram поддержка НЕ поможет с платежами через бота\n"
            "• Все вопросы решаются через /support\n\n"
            "Используя бота, вы соглашаетесь с данными условиями."
        )
        
        await update.message.reply_text(terms_text, parse_mode='Markdown')
    
    async def support_command(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Команда /support - поддержка (обязательно)"""
        support_text = (
            "🆘 **ПОДДЕРЖКА NODEON PYRAMID**\n\n"
            "**По вопросам использования:**\n"
            "• Telegram: @your_support_bot\n"
            "• Email: support@yourdomain.com\n"
            "• Время ответа: до 24 часов\n\n"
            "**По вопросам платежей:**\n"
            "• Используйте команду /paysupport\n"
            "• Укажите ID платежа при обращении\n"
            "• Telegram поддержка НЕ поможет с платежами\n\n"
            "**Частые вопросы:**\n"
            "• Как купить NDN? - Используйте кнопку 'Купить NDN'\n"
            "• Как получить Pro статус? - Купите за 1000 NDN\n"
            "• Как работает реферальная программа? - Приглашайте друзей\n\n"
            "**Важно:** Telegram поддержка не поможет с платежами через бота!"
        )
        
        await update.message.reply_text(support_text, parse_mode='Markdown')
    
    async def paysupport_command(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Команда /paysupport - поддержка по платежам (обязательно)"""
        paysupport_text = (
            "💳 **ПОДДЕРЖКА ПО ПЛАТЕЖАМ**\n\n"
            "**Если у вас проблемы с платежами:**\n\n"
            "**1. Проверьте баланс Stars**\n"
            "• Убедитесь, что у вас достаточно Stars\n"
            "• Купите Stars через @PremiumBot\n\n"
            "**2. Проверьте интернет**\n"
            "• Убедитесь в стабильности соединения\n"
            "• Попробуйте еще раз\n\n"
            "**3. Обратитесь в поддержку**\n"
            "• Telegram: @your_support_bot\n"
            "• Укажите ID платежа\n"
            "• Опишите проблему подробно\n\n"
            "**4. Возврат средств**\n"
            "• Возврат возможен в течение 24 часов\n"
            "• Обратитесь в поддержку с ID платежа\n"
            "• Возврат в Telegram Stars\n\n"
            "**Важно:** Telegram поддержка НЕ поможет с платежами через бота!"
        )
        
        await update.message.reply_text(paysupport_text, parse_mode='Markdown')
    
    async def handle_callback(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Обработка нажатий на кнопки"""
        query = update.callback_query
        await query.answer()
        
        if query.data == "buy_ndn":
            await self.show_buy_options(query, context)
        elif query.data == "stats":
            await self.show_stats(query, context)
        elif query.data == "leaderboard":
            await self.show_leaderboard(query, context)
        elif query.data == "terms":
            await self.terms_command(update, context)
        elif query.data == "support":
            await self.support_command(update, context)
        elif query.data.startswith("buy_"):
            amount = query.data.split("_")[1]
            await self.create_invoice(query, context, amount)
    
    async def show_buy_options(self, query, context):
        """Показать варианты покупки NDN"""
        keyboard = [
            [InlineKeyboardButton("💰 100 NDN (100 Stars)", callback_data="buy_100")],
            [InlineKeyboardButton("💰 500 NDN (500 Stars)", callback_data="buy_500")],
            [InlineKeyboardButton("💰 1000 NDN (1000 Stars)", callback_data="buy_1000")],
            [InlineKeyboardButton("💰 5000 NDN (5000 Stars)", callback_data="buy_5000")],
            [InlineKeyboardButton("🔙 Назад", callback_data="back_to_main")]
        ]
        reply_markup = InlineKeyboardMarkup(keyboard)
        
        text = (
            "💰 **ПОКУПКА NDN**\n\n"
            "Выберите количество NDN для покупки:\n\n"
            "💎 **Курс:** 1 Star = 1 NDN\n"
            "⭐ **Минимум:** 10 Stars\n"
            "⭐ **Максимум:** 10,000 Stars\n\n"
            "**Важно:** Платежи обрабатываются через Telegram Stars"
        )
        
        await query.edit_message_text(text, reply_markup=reply_markup, parse_mode='Markdown')
    
    async def create_invoice(self, query, context, amount):
        """Создание инвойса для покупки NDN"""
        try:
            user_id = query.from_user.id
            amount_int = int(amount)
            
            # Проверяем лимиты
            if amount_int < 10 or amount_int > 10000:
                await query.edit_message_text(
                    "❌ Неверная сумма!\n\n"
                    "Минимум: 10 Stars\n"
                    "Максимум: 10,000 Stars"
                )
                return
            
            # Создаем инвойс согласно официальной документации
            await context.bot.send_invoice(
                chat_id=user_id,
                title=f"Покупка {amount_int} NDN",
                description=f"Покупка {amount_int} NDN за {amount_int} Telegram Stars",
                payload=f"ndn_purchase_{user_id}_{amount_int}_{int(time.time())}",
                provider_token="",  # Пустая строка для цифровых товаров
                currency="XTR",     # Обязательно XTR для Stars
                prices=[LabeledPrice("NDN", amount_int * 100)],  # В копейках
                start_parameter="ndn_purchase"
            )
            
            await query.edit_message_text(
                f"💳 **Инвойс создан!**\n\n"
                f"💰 Сумма: {amount_int} NDN\n"
                f"⭐ Стоимость: {amount_int} Stars\n\n"
                f"Нажмите кнопку 'Pay' в инвойсе для оплаты."
            )
            
        except TelegramError as e:
            logger.error(f"Ошибка создания инвойса: {e}")
            await query.edit_message_text(
                "❌ Ошибка создания инвойса\n\n"
                "Попробуйте еще раз или обратитесь в поддержку: /support"
            )
    
    async def pre_checkout_handler(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Обработка pre-checkout запроса (обязательно)"""
        query = update.pre_checkout_query
        
        try:
            # Валидируем платеж
            validation_result = await self.validate_payment(query)
            
            if validation_result['success']:
                await query.answer(ok=True)
            else:
                await query.answer(ok=False, error_message=validation_result['message'])
                
        except Exception as e:
            logger.error(f"Ошибка валидации платежа: {e}")
            await query.answer(ok=False, error_message="Внутренняя ошибка сервера")
    
    async def validate_payment(self, query):
        """Валидация платежа"""
        try:
            # Проверяем валюту
            if query.currency != "XTR":
                return {"success": False, "message": "Неверная валюта. Используйте Telegram Stars."}
            
            # Проверяем сумму
            amount = query.total_amount / 100  # Конвертируем из копеек
            if amount < 10 or amount > 10000:
                return {"success": False, "message": "Сумма должна быть от 10 до 10,000 Stars."}
            
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
                    if wallet.get('balance_ndn') < amount:
                        return {"success": False, "message": "Недостаточно NDN в резерве. Попробуйте позже."}
            
            return {"success": True, "message": "Платеж валиден"}
            
        except Exception as e:
            logger.error(f"Ошибка валидации: {e}")
            return {"success": False, "message": "Ошибка валидации платежа"}
    
    async def successful_payment_handler(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Обработка успешного платежа (обязательно)"""
        payment = update.message.successful_payment
        
        try:
            # Обрабатываем платеж
            result = await self.process_payment(payment, update.effective_user)
            
            if result['success']:
                await update.message.reply_text(
                    f"✅ **Платеж успешно обработан!**\n\n"
                    f"💰 **Получено:** {result['ndn_amount']} NDN\n"
                    f"⭐ **Потрачено:** {result['stars_amount']} Stars\n"
                    f"💳 **ID платежа:** `{payment.telegram_payment_charge_id}`\n\n"
                    f"🎉 Спасибо за покупку!\n\n"
                    f"Используйте /start для продолжения.",
                    parse_mode='Markdown'
                )
            else:
                await update.message.reply_text(
                    f"❌ **Ошибка обработки платежа**\n\n"
                    f"**Причина:** {result['message']}\n\n"
                    f"Обратитесь в поддержку: /support\n"
                    f"ID платежа: `{payment.telegram_payment_charge_id}`",
                    parse_mode='Markdown'
                )
                
        except Exception as e:
            logger.error(f"Ошибка обработки платежа: {e}")
            await update.message.reply_text(
                "❌ **Внутренняя ошибка сервера**\n\n"
                "Обратитесь в поддержку: /support\n"
                f"ID платежа: `{payment.telegram_payment_charge_id}`",
                parse_mode='Markdown'
            )
    
    async def process_payment(self, payment, user):
        """Обработка платежа"""
        try:
            user_id = user.id
            telegram_payment_charge_id = payment.telegram_payment_charge_id
            total_amount = payment.total_amount
            
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
                        "ndn_amount": ndn_amount,
                        "stars_amount": stars_amount,
                        "transaction_id": data.get('transaction_id')
                    }
                else:
                    return {"success": False, "message": data.get('error')}
            else:
                return {"success": False, "message": "Ошибка обработки платежа"}
                
        except Exception as e:
            logger.error(f"Ошибка обработки платежа: {e}")
            return {"success": False, "message": "Внутренняя ошибка"}
    
    async def show_stats(self, query, context):
        """Показать статистику пользователя"""
        try:
            user_id = query.from_user.id
            
            # Получаем данные пользователя
            response = requests.get(
                f"{API_BASE}/user/profile",
                params={"init_data": f"user_id={user_id}"}
            )
            
            if response.status_code == 200:
                data = response.json()
                if data.get('success'):
                    user = data.get('user')
                    
                    stats_text = (
                        f"📊 **СТАТИСТИКА**\n\n"
                        f"👤 **Пользователь:** {user.get('first_name')}\n"
                        f"💰 **Баланс NDN:** {user.get('balance_ndn')} NDN\n"
                        f"⭐ **Баланс Stars:** {user.get('balance_stars')} Stars\n"
                        f"👑 **Pro статус:** {'Да' if user.get('is_pro') else 'Нет'}\n\n"
                        f"📈 **Статистика Stars:**\n"
                        f"• Заработано: {user.get('total_stars_earned')} Stars\n"
                        f"• Потрачено: {user.get('total_stars_spent')} Stars"
                    )
                    
                    keyboard = [[InlineKeyboardButton("🔙 Назад", callback_data="back_to_main")]]
                    reply_markup = InlineKeyboardMarkup(keyboard)
                    
                    await query.edit_message_text(stats_text, reply_markup=reply_markup, parse_mode='Markdown')
                else:
                    await query.edit_message_text("❌ Ошибка загрузки статистики")
            else:
                await query.edit_message_text("❌ Ошибка загрузки данных")
                
        except Exception as e:
            logger.error(f"Ошибка загрузки статистики: {e}")
            await query.edit_message_text("❌ Ошибка загрузки статистики")
    
    async def show_leaderboard(self, query, context):
        """Показать лидерборд"""
        try:
            # Получаем лидерборд
            response = requests.get(f"{API_BASE}/stats/leaderboard")
            
            if response.status_code == 200:
                data = response.json()
                if data.get('success'):
                    leaders = data.get('leaders', [])
                    
                    leaderboard_text = "🏆 **ЛИДЕРБОРД**\n\n"
                    
                    for i, leader in enumerate(leaders[:10], 1):
                        crown = "👑" if leader.get('is_pro') else ""
                        leaderboard_text += f"{i}. {leader.get('first_name')} {crown}\n"
                        leaderboard_text += f"   💰 {leader.get('balance_ndn')} NDN\n\n"
                    
                    keyboard = [[InlineKeyboardButton("🔙 Назад", callback_data="back_to_main")]]
                    reply_markup = InlineKeyboardMarkup(keyboard)
                    
                    await query.edit_message_text(leaderboard_text, reply_markup=reply_markup, parse_mode='Markdown')
                else:
                    await query.edit_message_text("❌ Ошибка загрузки лидерборда")
            else:
                await query.edit_message_text("❌ Ошибка загрузки данных")
                
        except Exception as e:
            logger.error(f"Ошибка загрузки лидерборда: {e}")
            await query.edit_message_text("❌ Ошибка загрузки лидерборда")
    
    def run(self):
        """Запуск бота"""
        logger.info("Запуск NodeOn Pyramid Bot...")
        self.application.run_polling()

if __name__ == "__main__":
    bot = NodeOnPyramidBot()
    bot.run()
