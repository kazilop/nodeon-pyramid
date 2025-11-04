const express = require('express');
const { createClient } = require('@supabase/supabase-js');
const router = express.Router();

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_ANON_KEY
);

// GET /api/stats/leaderboard - Получение лидерборда
router.get('/leaderboard', async (req, res) => {
  try {
    console.log('🏆 Getting leaderboard');

    // Получаем топ пользователей по балансу
    const { data: users, error } = await supabase
      .from('nodeon_users')
      .select('id, telegram_id, username, first_name, last_name, balance_ndn, is_pro')
      .order('balance_ndn', { ascending: false })
      .limit(50);

    if (error) {
      console.error('Leaderboard fetch error:', error);
      return res.status(500).json({ error: 'Failed to fetch leaderboard' });
    }

    // Получаем общую статистику
    const { count: totalUsers, error: totalError } = await supabase
      .from('nodeon_users')
      .select('*', { count: 'exact', head: true });

    const { count: proUsers, error: proError } = await supabase
      .from('nodeon_users')
      .select('*', { count: 'exact', head: true })
      .eq('is_pro', true);

    console.log('✅ Leaderboard data:', users?.length || 0, 'users');

    res.json({
      success: true,
      leaderboard: users || [],
      stats: {
        total_users: totalUsers || 0,
        pro_users: proUsers || 0
      }
    });

  } catch (error) {
    console.error('Leaderboard error:', error);
    res.status(500).json({ error: 'Failed to get leaderboard' });
  }
});

module.exports = router;

