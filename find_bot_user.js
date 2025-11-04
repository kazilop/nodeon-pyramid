const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_ANON_KEY);

async function findBotUser() {
  console.log('🔍 Ищем пользователя с большим балансом (возможно бот)...');
  
  try {
    // Ищем всех пользователей с балансом больше 10000
    const { data: highBalanceUsers, error } = await supabase
      .from('nodeon_users')
      .select('*')
      .gt('balance_ndn', 10000)
      .order('balance_ndn', { ascending: false });
    
    if (error) {
      console.error('❌ Ошибка поиска:', error);
      return;
    }
    
    if (highBalanceUsers && highBalanceUsers.length > 0) {
      console.log('✅ Найдены пользователи с большим балансом:');
      highBalanceUsers.forEach((user, index) => {
        console.log(`${index + 1}. ID: ${user.id}, Telegram ID: ${user.telegram_id}, Username: ${user.username || 'N/A'}, Balance: ${user.balance_ndn} NDN, Status: ${user.user_status || 'N/A'}`);
      });
    } else {
      console.log('❌ Пользователи с балансом больше 10000 NDN не найдены');
      
      // Показываем всех пользователей
      console.log('\n📋 Все пользователи в системе:');
      const { data: allUsers, error: allError } = await supabase
        .from('nodeon_users')
        .select('id, telegram_id, username, balance_ndn, user_status')
        .order('balance_ndn', { ascending: false });
      
      if (allUsers && !allError) {
        allUsers.forEach((user, index) => {
          console.log(`${index + 1}. ID: ${user.id}, Telegram ID: ${user.telegram_id}, Username: ${user.username || 'N/A'}, Balance: ${user.balance_ndn} NDN, Status: ${user.user_status || 'N/A'}`);
        });
      }
    }
    
  } catch (error) {
    console.error('❌ Общая ошибка:', error);
  }
}

findBotUser();











