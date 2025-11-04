const express = require('express');
const { createClient } = require('@supabase/supabase-js');
const router = express.Router();

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_ANON_KEY
);

// POST /api/pro/buy - Покупка Pro статуса
router.post('/buy', async (req, res) => {
  try {
    const { telegram_id } = req.body;
    
    console.log(`💎 Buying Pro status for user: ${telegram_id}`);

    if (!telegram_id) {
      return res.status(400).json({ 
        success: false, 
        error: 'Missing telegram_id' 
      });
    }

    const PRO_COST = 1000;

    // Получаем данные пользователя
    const { data: user, error: userError } = await supabase
      .from('nodeon_users')
      .select('*')
      .eq('telegram_id', telegram_id)
      .single();

    if (userError || !user) {
      return res.status(404).json({ 
        success: false, 
        error: 'User not found' 
      });
    }

    if (user.is_pro) {
      return res.status(400).json({ 
        success: false, 
        error: 'User already has Pro status' 
      });
    }

    if (user.balance_ndn < PRO_COST) {
      return res.status(400).json({ 
        success: false, 
        error: 'Insufficient balance' 
      });
    }

    // Обновляем статус пользователя
    const newBalance = user.balance_ndn - PRO_COST;
    const referralLink = `ref_${user.id}`; // Короткая ссылка для БД

    const { error: updateError } = await supabase
      .from('nodeon_users')
      .update({
        balance_ndn: newBalance,
        is_pro: true,
        referral_link: referralLink,
        updated_at: new Date().toISOString()
      })
      .eq('id', user.id);

    if (updateError) {
      console.error('Update error:', updateError);
      return res.status(500).json({ 
        success: false,
        error: 'Failed to update user status' 
      });
    }

    // Создаем транзакцию
    await supabase
      .from('nodeon_transactions')
      .insert({
        user_id: user.id,
        type: 'pro_purchase',
        amount_ndn: -PRO_COST,
        description: 'Pro status purchase',
        created_at: new Date().toISOString()
      });

    // Распределение наград по реферальной цепочке
    let inviterId = user.inviter_id;
    let level = 1;
    const rewards = [200, 150, 150, 150, 150, 150, 150];
    const developerFee = 200;

    // Начисляем комиссию разработчику
    if (developerFee > 0) {
      const { data: developer } = await supabase
        .from('nodeon_users')
        .select('*')
        .eq('user_status', 'developer')
        .single();

      if (developer) {
        await supabase
          .from('nodeon_users')
          .update({ balance_ndn: developer.balance_ndn + developerFee })
          .eq('id', developer.id);

        await supabase
          .from('nodeon_transactions')
          .insert({
            user_id: developer.id,
            type: 'developer_fee',
            amount_ndn: developerFee,
            description: 'Developer fee from Pro purchase',
            referral_level: 0,
            created_at: new Date().toISOString()
          });
      }
    }

    // Распределяем награды по уровням
    while (inviterId && level <= 7) {
      const { data: inviter } = await supabase
        .from('nodeon_users')
        .select('*')
        .eq('id', inviterId)
        .single();

      if (inviter) {
        const reward = rewards[level - 1] || 0;
        
        if (reward > 0) {
          await supabase
            .from('nodeon_users')
            .update({ balance_ndn: inviter.balance_ndn + reward })
            .eq('id', inviter.id);

          await supabase
            .from('nodeon_transactions')
            .insert({
              user_id: inviter.id,
              type: 'referral_reward',
              amount_ndn: reward,
              description: `Referral reward level ${level}`,
              referral_level: level,
              created_at: new Date().toISOString()
            });
        }

        inviterId = inviter.inviter_id;
        level++;
      } else {
        break;
      }
    }

    res.json({
      success: true,
      message: 'Pro status purchased successfully',
      new_balance: newBalance,
      referral_link: referralLink
    });

  } catch (error) {
    console.error('Buy Pro error:', error);
    res.status(500).json({ 
      success: false,
      error: 'Failed to buy Pro status' 
    });
  }
});

module.exports = router;









