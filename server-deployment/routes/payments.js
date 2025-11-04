const express = require('express');
const router = express.Router();
const { createClient } = require('@supabase/supabase-js');
const axios = require('axios');

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_ANON_KEY
);

// Telegram Bot API для создания invoice
const TELEGRAM_API = `https://api.telegram.org/bot${process.env.TELEGRAM_BOT_TOKEN}`;

// POST /api/payments/create-invoice - Создание счета для покупки NDN за Stars
router.post('/create-invoice', async (req, res) => {
  try {
    console.log('💳 Получен запрос на создание счета');
    console.log('Body:', req.body);
    console.log('Headers:', req.headers);
    
    const { amount_ndn, description } = req.body;
    const authHeader = req.headers.authorization;
    
    console.log('💳 Создание счета для покупки NDN:', { amount_ndn, description });
    
    if (!amount_ndn || amount_ndn < 1) {
      return res.status(400).json({ 
        error: 'Invalid amount',
        detail: 'Количество NDN должно быть больше 0'
      });
    }
    
    if (amount_ndn > 10000) {
      return res.status(400).json({ 
        error: 'Amount too large',
        detail: 'Максимальная сумма: 10,000 NDN'
      });
    }
    
    // Извлекаем telegram_id из заголовка авторизации
    let telegram_id = null;
    if (authHeader && authHeader.startsWith('tma ')) {
      const initData = authHeader.substring(4);
      try {
        // Простой парсинг initData (в реальном приложении нужна валидация подписи)
        const urlParams = new URLSearchParams(initData);
        const userParam = urlParams.get('user');
        if (userParam) {
          const user = JSON.parse(decodeURIComponent(userParam));
          telegram_id = user.id;
        }
      } catch (e) {
        console.error('Ошибка парсинга initData:', e);
      }
    }
    
    if (!telegram_id) {
      return res.status(401).json({ 
        error: 'Unauthorized',
        detail: 'Не удалось определить пользователя'
      });
    }
    
    // Проверяем, существует ли пользователь
    const { data: user, error: userError } = await supabase
      .from('nodeon_users')
      .select('*')
      .eq('telegram_id', telegram_id)
      .single();
    
    if (userError || !user) {
      return res.status(404).json({ 
        error: 'User not found',
        detail: 'Пользователь не найден'
      });
    }
    
    // Создаем транзакцию в БД
    const { data: transaction, error: transactionError } = await supabase
      .from('nodeon_transactions')
      .insert({
        user_id: user.id,
        type: 'buy_ndn_for_stars',
        amount_ndn: amount_ndn,
        amount_stars: amount_ndn, // 1 NDN = 1 Star
        description: description || `Покупка ${amount_ndn} NDN за ${amount_ndn} Telegram Stars`,
        created_at: new Date().toISOString()
      })
      .select()
      .single();
    
    if (transactionError) {
      console.error('Ошибка создания транзакции:', transactionError);
      return res.status(500).json({ 
        error: 'Transaction creation failed',
        detail: 'Ошибка создания транзакции'
      });
    }
    
    // Создаем invoice ссылку через Telegram Bot API
    try {
      const invoiceResponse = await axios.post(`${TELEGRAM_API}/createInvoiceLink`, {
        title: `Покупка ${amount_ndn} NDN`,
        description: description || `Покупка ${amount_ndn} NDN за ${amount_ndn} Telegram Stars`,
        payload: `ndn_${user.telegram_id}_${amount_ndn}_${transaction.id}`, // telegram_id для webhook
        provider_token: "", // Пустой для Stars
        currency: "XTR", // Telegram Stars
        prices: [
          { label: `${amount_ndn} NDN`, amount: Math.round(amount_ndn) }
        ]
      });
      
      if (invoiceResponse.data.ok) {
        console.log('✅ Invoice ссылка создана:', invoiceResponse.data.result);
        
        // Возвращаем объект invoice вместо ссылки
        res.json({
          success: true,
          transaction_id: transaction.id,
          amount_ndn: amount_ndn,
          amount_stars: Math.round(amount_ndn),
          description: description,
          invoice: {
            title: `Покупка ${amount_ndn} NDN`,
            description: description || `Покупка ${amount_ndn} NDN за ${amount_ndn} Telegram Stars`,
            photo_url: 'https://sistemypro.ru/favicon.ico',
            currency: 'XTR',
            prices: [
              { label: `${amount_ndn} NDN`, amount: Math.round(amount_ndn) }
            ]
          },
          invoice_url: invoiceResponse.data.result, // Ссылка на invoice
          invoice_link: invoiceResponse.data.result, // Дубликат для совместимости
          stars_amount: Math.round(amount_ndn)
        });
      } else {
        throw new Error('Failed to create invoice link');
      }
    } catch (error) {
      console.error('Ошибка создания invoice ссылки:', error);
      // Fallback: возвращаем данные для создания invoice
      res.json({
        success: true,
        transaction_id: transaction.id,
        amount_ndn: amount_ndn,
        amount_stars: Math.round(amount_ndn),
        description: description,
        invoice: {
          title: `Покупка ${amount_ndn} NDN`,
          description: description || `Покупка ${amount_ndn} NDN за ${amount_ndn} Telegram Stars`,
          photo_url: 'https://sistemypro.ru/favicon.ico',
          currency: 'XTR',
          prices: [
            { label: `${amount_ndn} NDN`, amount: Math.round(amount_ndn) }
          ]
        },
          invoice_url: `https://t.me/${process.env.TELEGRAM_BOT_USERNAME}/?start=invoice_${transaction.id}`,
          invoice_link: `https://t.me/${process.env.TELEGRAM_BOT_USERNAME}/?start=invoice_${transaction.id}`, // Дубликат для совместимости
          stars_amount: Math.round(amount_ndn)
      });
    }
    
  } catch (error) {
    console.error('Ошибка создания счета:', error);
    res.status(500).json({ 
      error: 'Internal server error',
      detail: 'Внутренняя ошибка сервера'
    });
  }
});

// POST /api/payments/confirm-payment - Подтверждение платежа
router.post('/confirm-payment', async (req, res) => {
  try {
    console.log('💳 Получен запрос на подтверждение платежа:', req.body);
    const { telegram_id, amount_ndn, payment_id, transaction_id } = req.body;
    
    if (!telegram_id && !transaction_id) {
      return res.status(400).json({ 
        error: 'Missing parameters',
        detail: 'Отсутствует telegram_id или transaction_id'
      });
    }
    
    let user;
    
    // Если передан transaction_id, используем его
    if (transaction_id) {
      const { data: transaction, error: transError } = await supabase
        .from('nodeon_transactions')
        .select('*')
        .eq('id', transaction_id)
        .single();
      
      if (transError || !transaction) {
        return res.status(404).json({ 
          error: 'Transaction not found',
          detail: 'Транзакция не найдена'
        });
      }
      
      // Получаем пользователя по user_id из транзакции
      const { data: userData, error: userError } = await supabase
        .from('nodeon_users')
        .select('*')
        .eq('id', transaction.user_id)
        .single();
      
      if (userError || !userData) {
        return res.status(404).json({ 
          error: 'User not found',
          detail: 'Пользователь не найден'
        });
      }
      
      user = userData;
      amount_ndn = transaction.amount_ndn;
    } else {
      // Если передан telegram_id, используем его
      const { data: userData, error: userError } = await supabase
        .from('nodeon_users')
        .select('*')
        .eq('telegram_id', telegram_id)
        .single();
      
      if (userError || !userData) {
        return res.status(404).json({ 
          error: 'User not found',
          detail: 'Пользователь не найден'
        });
      }
      
      user = userData;
    }
    
    // Зачисляем NDN на баланс пользователя
    const newBalance = (user.balance_ndn || 0) + parseInt(amount_ndn);
    
    const { error: updateError } = await supabase
      .from('nodeon_users')
      .update({ 
        balance_ndn: newBalance,
        updated_at: new Date().toISOString()
      })
      .eq('id', user.id);
    
    if (updateError) {
      console.error('Ошибка обновления баланса:', updateError);
      return res.status(500).json({ 
        error: 'Balance update failed',
        detail: 'Ошибка обновления баланса'
      });
    }
    
    console.log('✅ NDN зачислены на баланс пользователя:', {
      user_id: user.id,
      amount: amount_ndn,
      new_balance: newBalance
    });
    
    res.json({
      success: true,
      message: 'NDN успешно зачислены',
      new_balance: newBalance
    });
    
  } catch (error) {
    console.error('Ошибка подтверждения платежа:', error);
    res.status(500).json({ 
      error: 'Internal server error',
      detail: 'Внутренняя ошибка сервера'
    });
  }
});

// GET /api/payments/transactions/:user_id - Получение истории платежей пользователя
router.get('/transactions/:user_id', async (req, res) => {
  try {
    const { user_id } = req.params;
    
    console.log('📋 Получение истории платежей для пользователя:', user_id);
    
    const { data: transactions, error } = await supabase
      .from('nodeon_transactions')
      .select('*')
      .eq('user_id', user_id)
      .in('type', ['buy_ndn_for_stars', 'withdraw_stars'])
      .order('created_at', { ascending: false })
      .limit(50);
    
    if (error) {
      console.error('Ошибка получения транзакций:', error);
      return res.status(500).json({ 
        error: 'Failed to fetch transactions',
        detail: 'Ошибка получения истории платежей'
      });
    }
    
    res.json({
      success: true,
      transactions: transactions || [],
      count: transactions?.length || 0
    });
    
  } catch (error) {
    console.error('Ошибка получения истории платежей:', error);
    res.status(500).json({ 
      error: 'Internal server error',
      detail: 'Внутренняя ошибка сервера'
    });
  }
});

// POST /api/payments/exchange-request - Заявка на обмен NDN на Stars
router.post('/exchange-request', async (req, res) => {
  try {
    console.log('💫 Получен запрос на обмен NDN на Stars');
    console.log('Body:', req.body);
    
    const { amount_ndn, telegram_username, description } = req.body;
    const authHeader = req.headers.authorization;
    
    if (!amount_ndn || amount_ndn < 1) {
      return res.status(400).json({ 
        error: 'Invalid amount',
        detail: 'Количество NDN должно быть больше 0'
      });
    }
    
    if (amount_ndn > 10000) {
      return res.status(400).json({ 
        error: 'Amount too large',
        detail: 'Максимальная сумма: 10,000 NDN'
      });
    }
    
    // Извлекаем telegram_id из заголовка авторизации
    let telegram_id = null;
    if (authHeader && authHeader.startsWith('tma ')) {
      const initData = authHeader.substring(4);
      try {
        const urlParams = new URLSearchParams(initData);
        const userParam = urlParams.get('user');
        if (userParam) {
          const user = JSON.parse(decodeURIComponent(userParam));
          telegram_id = user.id;
        }
      } catch (e) {
        console.error('Ошибка парсинга initData:', e);
      }
    }
    
    if (!telegram_id) {
      return res.status(401).json({ 
        error: 'Unauthorized',
        detail: 'Не удалось определить пользователя'
      });
    }
    
    // Проверяем, существует ли пользователь
    const { data: user, error: userError } = await supabase
      .from('nodeon_users')
      .select('*')
      .eq('telegram_id', telegram_id)
      .single();
    
    if (userError || !user) {
      return res.status(404).json({ 
        error: 'User not found',
        detail: 'Пользователь не найден'
      });
    }
    
    // Проверяем минимальную сумму вывода (500 Stars = 500 NDN)
    const MIN_WITHDRAWAL = 500;
    if (amount_ndn < MIN_WITHDRAWAL) {
      return res.status(400).json({ 
        error: 'Minimum withdrawal',
        detail: `Минимальная сумма вывода: ${MIN_WITHDRAWAL} Stars`
      });
    }
    
    // Проверяем баланс
    if (user.balance_ndn < amount_ndn) {
      return res.status(400).json({ 
        error: 'Insufficient balance',
        detail: 'Недостаточно NDN на балансе'
      });
    }
    
    // Проверяем, прошло ли 21 день с момента последнего ввода Stars
    const { data: canWithdraw, error: checkError } = await supabase
      .rpc('can_withdraw_stars', { p_user_id: user.id });
    
    if (checkError || !canWithdraw.can_withdraw) {
      return res.status(400).json({ 
        error: 'Withdrawal not available',
        detail: canWithdraw.message || 'Вывод доступен только через 21 день после ввода Stars согласно правилам Telegram'
      });
    }
    
    // Списываем NDN с баланса
    const newBalance = user.balance_ndn - amount_ndn;
    const { error: updateError } = await supabase
      .from('nodeon_users')
      .update({ 
        balance_ndn: newBalance,
        updated_at: new Date().toISOString()
      })
      .eq('id', user.id);
    
    if (updateError) {
      console.error('Ошибка обновления баланса:', updateError);
      return res.status(500).json({ 
        error: 'Balance update failed',
        detail: 'Ошибка обновления баланса'
      });
    }
    
    // Создаем заявку на вывод в отдельной таблице
    const { data: withdrawalRequest, error: withdrawalError } = await supabase
      .from('nodeon_withdrawal_requests')
      .insert({
        user_id: user.id,
        telegram_id: telegram_id,
        telegram_username: telegram_username,
        amount_ndn: amount_ndn,
        amount_stars: amount_ndn, // 1 NDN = 1 Star
        status: 'pending',
        days_since_deposit: canWithdraw.days_passed,
        last_deposit_date: canWithdraw.last_deposit_date,
        created_at: new Date().toISOString()
      })
      .select()
      .single();
    
    if (withdrawalError) {
      console.error('Ошибка создания заявки на вывод:', withdrawalError);
      // Откатываем списание баланса
      await supabase
        .from('nodeon_users')
        .update({ 
          balance_ndn: user.balance_ndn,
          updated_at: new Date().toISOString()
        })
        .eq('id', user.id);
      
      return res.status(500).json({ 
        error: 'Withdrawal request creation failed',
        detail: 'Ошибка создания заявки на вывод'
      });
    }
    
    // Создаем транзакцию для истории
    const { data: transaction, error: transactionError } = await supabase
      .from('nodeon_transactions')
      .insert({
        user_id: user.id,
        type: 'exchange_request',
        amount_ndn: -amount_ndn,
        amount_stars: amount_ndn, // 1 NDN = 1 Star
        description: description || `Заявка на вывод ${amount_ndn} Stars для @${telegram_username} (статус: pending)`,
        created_at: new Date().toISOString()
      })
      .select()
      .single();
    
    if (transactionError) {
      console.error('Ошибка создания транзакции:', transactionError);
      // Откатываем списание баланса
      await supabase
        .from('nodeon_users')
        .update({ 
          balance_ndn: user.balance_ndn,
          updated_at: new Date().toISOString()
        })
        .eq('id', user.id);
      
      return res.status(500).json({ 
        error: 'Transaction creation failed',
        detail: 'Ошибка создания транзакции'
      });
    }
    
    // Заявка создана, возвращаем успешный ответ
    console.log('✅ Заявка на вывод создана:', {
      request_id: withdrawalRequest.id,
      user_id: user.id,
      amount_ndn: amount_ndn,
      amount_stars: amount_ndn,
      username: telegram_username
    });
    
    res.json({
      success: true,
      message: `Заявка на вывод ${amount_ndn} Stars принята. Менеджер рассмотрит заявку и отправит Stars на @${telegram_username}.`,
      new_balance: newBalance,
      request_id: withdrawalRequest.id
    });
    
  } catch (error) {
    console.error('Ошибка создания заявки:', error);
    res.status(500).json({ 
      error: 'Internal server error',
      detail: 'Внутренняя ошибка сервера'
    });
  }
});

module.exports = router;
