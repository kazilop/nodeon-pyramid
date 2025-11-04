const express = require('express');
const { createClient } = require('@supabase/supabase-js');
const router = express.Router();

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_ANON_KEY
);

// GET /api/users/find-by-id/:id - Поиск пользователя по внутреннему ID
router.get('/find-by-id/:id', async (req, res) => {
  try {
    const { id } = req.params;
    
    console.log(`👤 Finding user by ID: ${id}`);

    const { data: user, error } = await supabase
      .from('nodeon_users')
      .select('*')
      .eq('id', id)
      .single();

    if (error) {
      console.error('User fetch error:', error);
      return res.status(404).json({ error: 'User not found' });
    }

    res.json({
      success: true,
      user: {
        id: user.id,
        telegram_id: user.telegram_id,
        username: user.username,
        first_name: user.first_name,
        last_name: user.last_name,
        balance_ndn: user.balance_ndn,
        is_pro: user.is_pro,
        referral_link: user.referral_link
      }
    });

  } catch (error) {
    console.error('Find user error:', error);
    res.status(500).json({ error: 'Failed to find user' });
  }
});

// POST /api/users/buy-pro - Покупка Pro статуса
router.post('/buy-pro', async (req, res) => {
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

    if (userError) {
      console.error('User fetch error:', userError);
      return res.status(404).json({ error: 'User not found' });
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
    const referralLink = `https://t.me/pro_stars_bot?startapp=ref_${user.id}`;

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
      return res.status(500).json({ error: 'Failed to update user status' });
    }

    // Создаем транзакцию
    const { error: transactionError } = await supabase
      .from('nodeon_transactions')
      .insert({
        user_id: user.id,
        type: 'pro_purchase',
        amount_ndn: -PRO_COST,
        description: 'Pro status purchase',
        created_at: new Date().toISOString()
      });

    if (transactionError) {
      console.error('Transaction error:', transactionError);
    }

    res.json({
      success: true,
      message: 'Pro status purchased successfully',
      new_balance: newBalance,
      referral_link: referralLink
    });

  } catch (error) {
    console.error('Buy Pro error:', error);
    res.status(500).json({ error: 'Failed to buy Pro status' });
  }
});

// POST /api/user/create - Создание нового пользователя с учетом реферального кода
router.post('/create', async (req, res) => {
  try {
    const { telegram_id, username, first_name, last_name, referral_code } = req.body;
    
    console.log(`👤 Creating user: ${telegram_id}, referral_code: ${referral_code}`);
    
    if (!telegram_id) {
      return res.status(400).json({ 
        success: false, 
        error: 'Missing telegram_id' 
      });
    }
    
    // Проверяем существование пользователя
    const { data: existingUser, error: fetchError } = await supabase
      .from('nodeon_users')
      .select('*')
      .eq('telegram_id', telegram_id)
      .single();
    
    if (existingUser) {
      console.log('✅ User already exists:', existingUser.id);
      return res.json({
        success: true,
        user: {
          id: existingUser.id,
          telegram_id: existingUser.telegram_id,
          username: existingUser.username,
          first_name: existingUser.first_name,
          last_name: existingUser.last_name,
          balance_ndn: existingUser.balance_ndn,
          is_pro: existingUser.is_pro,
          referral_link: existingUser.referral_link
        }
      });
    }
    
    // Определяем inviter_id, referral_path и referral_level если есть реферальный код
    let inviter_id = null;
    let referral_path = '';
    let referral_level = 0;
    
    if (referral_code) {
      console.log('🔗 Processing referral code:', referral_code);
      
      // Извлекаем ID из referral_code (формат: ref_ID)
      const refId = referral_code.replace('ref_', '');
      console.log('📋 Extracted referral ID:', refId);
      
      // Ищем инвайтера по ID или telegram_id
      const { data: inviter, error: inviterError } = await supabase
        .from('nodeon_users')
        .select('*')
        .or(`id.eq.${refId},telegram_id.eq.${refId}`)
        .limit(1)
        .single();
      
      if (inviter && !inviterError) {
        inviter_id = inviter.id;
        
        // Устанавливаем referral_path и referral_level
        const inviterPath = inviter.referral_path || '';
        referral_path = inviterPath + inviter_id + ',';
        referral_level = (inviter.referral_level || 0) + 1;
        
        console.log('✅ Inviter found:', inviter_id, inviter.first_name);
        console.log('📊 Referral path:', referral_path, 'Level:', referral_level);
      } else {
        console.log('⚠️ Inviter not found for code:', referral_code);
      }
    }
    
    // Создаем пользователя без referral_link сначала
    const { data: newUser, error: createError } = await supabase
      .from('nodeon_users')
      .insert({
        telegram_id: telegram_id,
        username: username || null,
        first_name: first_name || 'Пользователь',
        last_name: last_name || '',
        balance_ndn: 0,
        is_pro: false,
        referral_link: null,  // Установим после получения ID
        inviter_id: inviter_id,
        referral_path: referral_path,
        referral_level: referral_level,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      })
      .select()
      .single();
    
    if (createError) {
      console.error('Create error:', createError);
      return res.status(500).json({ 
        success: false,
        error: 'User creation failed',
        detail: createError.message 
      });
    }
    
    // Теперь обновляем referral_link на основе полученного ID
    const referral_link = `ref_${newUser.id}`;
    
    const { error: updateError } = await supabase
      .from('nodeon_users')
      .update({ 
        referral_link: referral_link,
        updated_at: new Date().toISOString()
      })
      .eq('id', newUser.id);
    
    if (updateError) {
      console.error('Update referral_link error:', updateError);
    }
    
    // Обновляем объект newUser с новой ссылкой
    newUser.referral_link = referral_link;
    
    console.log('✅ New user created:', newUser.id, 'inviter_id:', inviter_id, 'referral_link:', referral_link);
    
    res.json({
      success: true,
      user: {
        id: newUser.id,
        telegram_id: newUser.telegram_id,
        username: newUser.username,
        first_name: newUser.first_name,
        last_name: newUser.last_name,
        balance_ndn: newUser.balance_ndn,
        is_pro: newUser.is_pro,
        referral_link: newUser.referral_link,
        inviter_id: newUser.inviter_id
      }
    });
    
  } catch (error) {
    console.error('Create user error:', error);
    res.status(500).json({ 
      success: false,
      error: 'Failed to create user' 
    });
  }
});

// GET /api/user/profile - Получение профиля пользователя
router.get('/profile', async (req, res) => {
  try {
    const authHeader = req.headers.authorization;
    
    if (!authHeader || !authHeader.startsWith('tma ')) {
      return res.status(401).json({ error: 'Unauthorized' });
    }

    const initData = authHeader.substring(4);
    const urlParams = new URLSearchParams(initData);
    const userParam = urlParams.get('user');
    
    if (!userParam) {
      return res.status(401).json({ error: 'Invalid user data' });
    }

    const user = JSON.parse(decodeURIComponent(userParam));
    const telegram_id = user.id;

    console.log('👤 Getting profile for user:', telegram_id);

    const { data: userData, error } = await supabase
      .from('nodeon_users')
      .select('*')
      .eq('telegram_id', telegram_id)
      .single();

    if (error) {
      console.error('User fetch error:', error);
      return res.status(404).json({ error: 'User not found' });
    }

    res.json({
      success: true,
      user: {
        id: userData.id,
        telegram_id: userData.telegram_id,
        username: userData.username,
        first_name: userData.first_name,
        last_name: userData.last_name,
        balance_ndn: userData.balance_ndn,
        is_pro: userData.is_pro,
        referral_link: userData.referral_link
      }
    });

  } catch (error) {
    console.error('Profile error:', error);
    res.status(500).json({ error: 'Failed to get profile' });
  }
});

module.exports = router;

