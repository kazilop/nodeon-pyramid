const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_ANON_KEY);

async function createBotUser() {
  console.log('🤖 Создаем пользователя для бота...');
  
  try {
    // Создаем пользователя для бота
    const { data: botUser, error } = await supabase
      .from('nodeon_users')
      .insert({
        telegram_id: 1000002098,
        username: 'pro_stars_bot',
        first_name: 'Pro Stars Bot',
        last_name: '',
        balance_ndn: 1000000.00,
        balance_stars: 0,
        total_stars_earned: 0,
        total_stars_spent: 0,
        is_pro: true,
        referral_link: 'ref_bot',
        inviter_id: null,
        referral_path: 'bot',
        referral_level: 0,
        is_active: true,
        user_status: 'bot',
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      })
      .select()
      .single();
    
    if (error) {
      console.error('❌ Ошибка создания бота:', error);
      return;
    }
    
    if (botUser) {
      console.log('✅ Бот создан успешно:');
      console.log('ID:', botUser.id);
      console.log('Telegram ID:', botUser.telegram_id);
      console.log('Username:', botUser.username);
      console.log('Balance NDN:', botUser.balance_ndn);
      console.log('User Status:', botUser.user_status);
    }
    
  } catch (error) {
    console.error('❌ Общая ошибка:', error);
  }
}

createBotUser();
