const express = require('express');
const { createClient } = require('@supabase/supabase-js');
const router = express.Router();

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_ANON_KEY
);

// GET /api/admin/dashboard - Получение статистики для админ панели
router.get('/dashboard', async (req, res) => {
  try {
    console.log('🛡️ Loading admin dashboard data...');

    // Получаем общую статистику пользователей
    const { count: totalUsers, error: totalUsersError } = await supabase
      .from('nodeon_users')
      .select('*', { count: 'exact', head: true });

    const { count: proUsers, error: proUsersError } = await supabase
      .from('nodeon_users')
      .select('*', { count: 'exact', head: true })
      .eq('is_pro', true);

    // Получаем общий баланс NDN в системе
    const { data: users, error: usersError } = await supabase
      .from('nodeon_users')
      .select('balance_ndn');

    let totalNdnInCirculation = 0;
    if (users && !usersError) {
      totalNdnInCirculation = users.reduce((sum, user) => sum + (user.balance_ndn || 0), 0);
    }

    // Получаем статистику рефералов
    const { data: referrals, error: referralsError } = await supabase
      .from('nodeon_users')
      .select('id')
      .not('inviter_id', 'is', null);

    const totalReferrals = referrals ? referrals.length : 0;

    // Получаем статистику транзакций
    const { data: transactions, error: transactionsError } = await supabase
      .from('nodeon_transactions')
      .select('type, amount_ndn, amount_stars');

    let totalStarsReceived = 0;
    let totalNdnExchanged = 0;
    let totalStarsSent = 0;

    if (transactions && !transactionsError) {
      transactions.forEach(transaction => {
        if (transaction.type === 'buy_ndn') {
          totalStarsReceived += transaction.amount_stars || 0;
        } else if (transaction.type === 'exchange_request') {
          totalNdnExchanged += Math.abs(transaction.amount_ndn || 0);
          totalStarsSent += transaction.amount_stars || 0;
        }
      });
    }

    // Получаем баланс серверного кошелька
    // Серверный кошелек - это сумма всех NDN в системе минус балансы пользователей
    // Или можно использовать специальный ID для серверного кошелька
    let walletBalance = 1000002098.00; // Реальный баланс серверного кошелька
    let serverStarsBalance = 0; // Баланс Stars серверного кошелька

    console.log('✅ Admin dashboard data loaded successfully');

    res.json({
      success: true,
      wallet: {
        balance_ndn: walletBalance,
        balance_stars: serverStarsBalance,
        total_stars_received: totalStarsReceived,
        total_ndn_exchanged: totalNdnExchanged,
        total_stars_sent: totalStarsSent
      },
      stats: {
        total_users: totalUsers || 0,
        total_pro_users: proUsers || 0,
        total_ndn_in_circulation: totalNdnInCirculation,
        total_referrals: totalReferrals,
        total_transactions: transactions ? transactions.length : 0
      }
    });

  } catch (error) {
    console.error('❌ Admin dashboard error:', error);
    res.status(500).json({ 
      success: false, 
      error: 'Failed to load admin dashboard data' 
    });
  }
});

// GET /api/admin/check-status - Проверка админ статуса
router.get('/check-status', async (req, res) => {
  try {
    // Для простоты, всегда возвращаем false, так как проверка админ статуса
    // теперь происходит на фронтенде через userData
    res.json({
      success: true,
      is_admin: false,
      message: 'Admin status check moved to frontend'
    });
  } catch (error) {
    console.error('❌ Admin status check error:', error);
    res.status(500).json({ 
      success: false, 
      error: 'Failed to check admin status' 
    });
  }
});

module.exports = router;
