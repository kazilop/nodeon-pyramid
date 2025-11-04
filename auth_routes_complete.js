const express = require('express');
const { createClient } = require('@supabase/supabase-js');
const router = express.Router();

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_ANON_KEY
);

// POST /api/auth/login - Авторизация через Telegram
router.post('/login', async (req, res) => {
  try {
    const { initData } = req.body;
    
    if (!initData) {
      return res.status(400).json({ error: 'Missing initData' });
    }

    // Парсим данные Telegram
    const urlParams = new URLSearchParams(initData);
    const userData = {};
    
    for (const [key, value] of urlParams) {
      if (key === 'user') {
        try {
          userData.user = JSON.parse(decodeURIComponent(value));
        } catch (e) {
          console.error('Error parsing user data:', e);
        }
      } else {
        userData[key] = value;
      }
    }

    if (!userData.user) {
      return res.status(400).json({ error: 'Invalid user data' });
    }

    const telegramUser = userData.user;
    console.log('🔐 Login attempt for user:', telegramUser.id);

    // Проверяем существование пользователя
    const { data: existingUser, error: fetchError } = await supabase
      .from('nodeon_users')
      .select('*')
      .eq('telegram_id', telegramUser.id)
      .single();

    if (fetchError && fetchError.code !== 'PGRST116') {
      console.error('Database error:', fetchError);
      return res.status(500).json({ error: 'Database error' });
    }

    let user;
    if (existingUser) {
      // Обновляем данные существующего пользователя
      const { data: updatedUser, error: updateError } = await supabase
        .from('nodeon_users')
        .update({
          username: telegramUser.username || null,
          first_name: telegramUser.first_name || 'Пользователь',
          last_name: telegramUser.last_name || '',
          updated_at: new Date().toISOString()
        })
        .eq('telegram_id', telegramUser.id)
        .select()
        .single();

      if (updateError) {
        console.error('Update error:', updateError);
        return res.status(500).json({ error: 'Update failed' });
      }

      user = updatedUser;
      console.log('✅ User updated:', user.id);
    } else {
      // Создаем нового пользователя
      const { data: newUser, error: createError } = await supabase
        .from('nodeon_users')
        .insert({
          telegram_id: telegramUser.id,
          username: telegramUser.username || null,
          first_name: telegramUser.first_name || 'Пользователь',
          last_name: telegramUser.last_name || '',
          balance_ndn: 100,
          is_pro: false,
          referral_link: `ref_${telegramUser.id}_${Date.now()}`,
          created_at: new Date().toISOString(),
          updated_at: new Date().toISOString()
        })
        .select()
        .single();

      if (createError) {
        console.error('Create error:', createError);
        return res.status(500).json({ error: 'User creation failed' });
      }

      user = newUser;
      console.log('✅ New user created:', user.id);
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
    console.error('Auth error:', error);
    res.status(500).json({ error: 'Authentication failed' });
  }
});

// GET /api/auth/me/:telegram_id - Получение данных пользователя
router.get('/me/:telegram_id', async (req, res) => {
  try {
    const { telegram_id } = req.params;
    
    const { data: user, error } = await supabase
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
    console.error('Get user error:', error);
    res.status(500).json({ error: 'Failed to get user data' });
  }
});

// GET /api/auth/profile/:telegram_id - Получение профиля пользователя (для фронтенда)
router.get('/profile/:telegram_id', async (req, res) => {
  try {
    const { telegram_id } = req.params;
    
    console.log(`👤 Getting profile for telegram_id: ${telegram_id}`);
    
    const { data: user, error } = await supabase
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
    console.error('Get profile error:', error);
    res.status(500).json({ error: 'Failed to get user profile' });
  }
});

module.exports = router;










