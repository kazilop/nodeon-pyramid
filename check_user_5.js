const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_ANON_KEY);

async function checkUser5() {
  console.log('🔍 Проверяем данные пользователя ID=5...');
  
  try {
    const { data: user, error } = await supabase
      .from('nodeon_users')
      .select('*')
      .eq('id', 5)
      .single();
    
    if (error) {
      console.error('❌ Ошибка получения данных:', error);
      return;
    }
    
    console.log('✅ Данные пользователя ID=5:');
    console.log('ID:', user.id);
    console.log('Telegram ID:', user.telegram_id);
    console.log('Username:', user.username);
    console.log('First Name:', user.first_name);
    console.log('Balance NDN:', user.balance_ndn);
    console.log('Is PRO:', user.is_pro);
    console.log('User Status:', user.user_status);
    console.log('Referral Link:', user.referral_link);
    console.log('Created At:', user.created_at);
    console.log('Updated At:', user.updated_at);
    
  } catch (error) {
    console.error('❌ Общая ошибка:', error);
  }
}

checkUser5();











