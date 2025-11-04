const express = require('express');
const { createClient } = require('@supabase/supabase-js');
const router = express.Router();

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_ANON_KEY
);

// GET /api/referrals/by-id/:id - Получение рефералов по внутреннему ID
router.get('/by-id/:id', async (req, res) => {
  try {
    const { id } = req.params;
    
    console.log(`👥 Getting referrals for user ID: ${id}`);

    // Получаем всех рефералов по referral_path (все уровни)
    const { data: allReferrals, error } = await supabase
      .from('nodeon_users')
      .select('id, telegram_id, username, first_name, last_name, balance_ndn, is_pro, referral_level, referral_path, created_at')
      .like('referral_path', `${id}%`)
      .neq('id', id) // Исключаем самого пользователя
      .order('referral_level', { ascending: true })
      .order('created_at', { ascending: false });

    if (error) {
      console.error('Referrals fetch error:', error);
      return res.status(500).json({ error: 'Failed to fetch referrals' });
    }

    // Группируем рефералов по уровням
    const referralsByLevel = {};
    const totalReferrals = allReferrals?.length || 0;
    let totalEarnings = 0;

    if (allReferrals) {
      allReferrals.forEach(referral => {
        const level = referral.referral_level || 1;
        if (!referralsByLevel[level]) {
          referralsByLevel[level] = [];
        }
        referralsByLevel[level].push(referral);
        
        // Подсчитываем потенциальные заработки (только для PRO рефералов)
        if (referral.is_pro) {
          if (level === 1) {
            totalEarnings += 200; // 1-й уровень
          } else if (level >= 2 && level <= 7) {
            totalEarnings += 150; // 2-7 уровни
          }
        }
      });
    }

    // Получаем статистику рефералов
    const { data: stats, error: statsError } = await supabase
      .from('nodeon_referral_stats')
      .select('*')
      .eq('user_id', id);

    if (statsError) {
      console.error('Stats fetch error:', statsError);
    }

    console.log(`✅ Found ${totalReferrals} referrals across ${Object.keys(referralsByLevel).length} levels`);

    res.json({
      success: true,
      referrals: allReferrals || [],
      referralsByLevel: referralsByLevel,
      stats: {
        total_referrals: totalReferrals,
        total_earnings: totalEarnings,
        levels_count: Object.keys(referralsByLevel).length,
        pro_referrals: allReferrals?.filter(r => r.is_pro).length || 0
      },
      referralStats: stats || []
    });

  } catch (error) {
    console.error('Get referrals error:', error);
    res.status(500).json({ error: 'Failed to get referrals' });
  }
});

// POST /api/referrals/stats - Получение статистики рефералов по telegram_id
router.post('/stats', async (req, res) => {
  try {
    const { telegram_id } = req.body;
    
    if (!telegram_id) {
      return res.status(400).json({ error: 'telegram_id is required' });
    }
    
    console.log(`👥 Getting referral stats for telegram_id: ${telegram_id}`);
    
    // Получаем пользователя по telegram_id
    const { data: user, error: userError } = await supabase
      .from('nodeon_users')
      .select('id')
      .eq('telegram_id', telegram_id)
      .single();
    
    if (userError || !user) {
      console.error('User not found:', userError);
      return res.status(404).json({ error: 'User not found' });
    }
    
    // Используем существующий endpoint для получения рефералов
    const referralsResponse = await supabase
      .from('nodeon_users')
      .select('id, telegram_id, username, first_name, last_name, balance_ndn, is_pro, referral_level, referral_path, created_at')
      .like('referral_path', `${user.id}%`)
      .neq('id', user.id)
      .order('referral_level', { ascending: true })
      .order('created_at', { ascending: false });
    
    const allReferrals = referralsResponse.data || [];
    
    // Группируем по уровням
    const referralsByLevel = {};
    let totalEarnings = 0;
    
    allReferrals.forEach(referral => {
      const level = referral.referral_level || 1;
      if (!referralsByLevel[level]) {
        referralsByLevel[level] = [];
      }
      referralsByLevel[level].push(referral);
      
      if (referral.is_pro) {
        if (level === 1) {
          totalEarnings += 200;
        } else if (level >= 2 && level <= 7) {
          totalEarnings += 150;
        }
      }
    });
    
    // Получаем статистику рефералов
    const { data: stats } = await supabase
      .from('nodeon_referral_stats')
      .select('*')
      .eq('user_id', user.id);
    
    res.json({
      success: true,
      referrals: allReferrals,
      referralsByLevel: referralsByLevel,
      stats: {
        total_referrals: allReferrals.length,
        total_earnings: totalEarnings,
        levels_count: Object.keys(referralsByLevel).length,
        pro_referrals: allReferrals.filter(r => r.is_pro).length
      },
      referralStats: stats || []
    });
    
  } catch (error) {
    console.error('Referral stats error:', error);
    res.status(500).json({ error: 'Failed to get referral stats' });
  }
});

module.exports = router;

