const express = require('express');
const { createClient } = require('@supabase/supabase-js');
const axios = require('axios');

const router = express.Router();

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_ANON_KEY
);

const TELEGRAM_API = `https://api.telegram.org/bot${process.env.TELEGRAM_BOT_TOKEN}`;

// Webhook для обработки платежей от Telegram Bot
router.post('/webhook/telegram', async (req, res) => {
  try {
    console.log('📨 Получен webhook от Telegram:', req.body);
    
    const update = req.body;
    
    // Обработка pre_checkout_query - подтверждаем платеж
    if (update.pre_checkout_query) {
      const query = update.pre_checkout_query;
      
      console.log('✅ Обрабатываем pre_checkout_query:', {
        id: query.id,
        from: query.from.id,
        payload: query.invoice_payload
      });
      
      // Подтверждаем платеж через Bot API (делаем до ответа)
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
    
    // Обработка successful_payment
    if (update.message && update.message.successful_payment) {
      const payment = update.message.successful_payment;
      const userId = update.message.from.id;
      
      console.log('💳 Обрабатываем successful_payment:', {
        userId,
        payment: payment.invoice_payload
      });
      
      // Извлекаем данные из payload
      const payload = payment.invoice_payload;
      const parts = payload.split('_');
      
      console.log('📋 Разбираем payload:', { parts, length: parts.length });
      
      // Новый формат: ndn_telegram_id_amount_transaction_id
      if (parts.length >= 3 && parts[0] === 'ndn') {
        const telegram_id = parseInt(parts[1]);
        const amount_ndn = parseInt(parts[2]);
        const transaction_id = parts.length > 3 ? parseInt(parts[3]) : null;
        
        console.log('📤 Зачисляем NDN:', { telegram_id, amount_ndn });
        
        // Получаем пользователя
        const { data: user, error: userError } = await supabase
          .from('nodeon_users')
          .select('*')
          .eq('telegram_id', telegram_id)
          .single();
        
        if (userError || !user) {
          console.error('❌ Пользователь не найден:', telegram_id);
          return res.json({ ok: true });
        }
        
        // Зачисляем NDN на баланс
        const currentBalance = parseFloat(user.balance_ndn || 0);
        const newBalance = currentBalance + amount_ndn;
        
        console.log('💰 Обновление баланса:', {
          user_id: user.id,
          telegram_id: telegram_id,
          current_balance: currentBalance,
          amount_ndn: amount_ndn,
          new_balance: newBalance
        });
        
        // Обновляем баланс NDN СРАЗУ в БД
        const { data: updatedUser, error: updateError } = await supabase
          .from('nodeon_users')
          .update({
            balance_ndn: newBalance,
            updated_at: new Date().toISOString()
          })
          .eq('id', user.id)
          .select('balance_ndn')
          .single();
        
        if (updateError) {
          console.error('❌ Ошибка обновления баланса:', updateError);
          return res.json({ ok: true }); // Отвечаем Telegram, чтобы не повторял запрос
        }
        
        if (!updatedUser) {
          console.error('❌ Пользователь не найден после обновления');
          return res.json({ ok: true });
        }
        
        console.log('✅ NDN зачислены в БД:', { 
          user_id: user.id, 
          balance_before: currentBalance,
          amount_added: amount_ndn,
          new_balance: updatedUser.balance_ndn,
          balance_from_db: updatedUser.balance_ndn
        });
        
        // Проверяем, что баланс действительно обновился
        if (Math.abs(parseFloat(updatedUser.balance_ndn) - newBalance) > 0.01) {
          console.error('⚠️ ВНИМАНИЕ: Баланс в БД не совпадает с ожидаемым!', {
            expected: newBalance,
            actual: updatedUser.balance_ndn
          });
        }
        
        // Продолжаем только если баланс успешно обновлен
        if (updatedUser) {
          
          // Создаем транзакцию в базе для статистики (nodeon_transactions)
          const { error: transactionError, data: transactionData } = await supabase
            .from('nodeon_transactions')
            .insert({
              user_id: user.id,
              type: 'buy_ndn',
              amount_ndn: amount_ndn,
              amount_stars: amount_ndn, // Количество Stars, которое заплатил пользователь
              description: `Покупка ${amount_ndn} NDN за ${amount_ndn} Telegram Stars`,
              created_at: new Date().toISOString()
            })
            .select();
          
          if (transactionError) {
            console.error('❌ Ошибка создания транзакции:', transactionError);
          } else {
            console.log('✅ Транзакция создана для статистики:', transactionData?.[0]?.id);
          }
          
          // Создаем транзакцию для учет Stars в wallet_statistics
          // Получаем wallet_id серверного кошелька (обычно id=1)
          const { data: serverWallet, error: walletError } = await supabase
            .from('nodeon_server_wallet')
            .select('id, balance_ndn')
            .eq('is_active', true)
            .limit(1)
            .single();
          
          if (serverWallet && !walletError) {
            const wallet_id = serverWallet.id;
            const balance_before = serverWallet.balance_ndn || 0;
            const balance_after = balance_before; // NDN не увеличивается, так как пользователь просто обменивает Stars на NDN
            
            // Создаем wallet transaction для учета Stars
            const { error: walletTransactionError } = await supabase
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
            
            if (walletTransactionError) {
              console.error('❌ Ошибка создания wallet транзакции:', walletTransactionError);
            } else {
              console.log('✅ Wallet транзакция создана для учета Stars');
            }
          }
          
          // Отправляем уведомление пользователю с актуальным балансом из БД
          try {
            await axios.post(`${TELEGRAM_API}/sendMessage`, {
              chat_id: telegram_id,
              text: `✅ Платеж успешен! ${amount_ndn} NDN зачислены на ваш баланс. Новый баланс: ${updatedUser.balance_ndn} NDN`
            });
            console.log('✅ Уведомление отправлено пользователю:', telegram_id);
          } catch (notifError) {
            console.error('❌ Ошибка отправки уведомления:', notifError);
          }
        } else {
          console.error('❌ updatedUser не найден, не можем продолжить обработку');
        }
      } else {
        console.error('❌ Формат payload не распознан:', payload);
      }
      
      // Отвечаем Telegram после обработки successful_payment
      return res.json({ ok: true });
    }
    
    // Для других типов обновлений просто отвечаем OK
    return res.json({ ok: true });
    
  } catch (error) {
    console.error('❌ Ошибка обработки webhook:', error);
    res.json({ ok: true });
  }
});

module.exports = router;

