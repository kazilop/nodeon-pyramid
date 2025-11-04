const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_ANON_KEY);

async function checkBotWallet() {
  console.log('🤖 Проверяем баланс бота...');
  
  try {
    // Ищем бота по telegram_id
    const { data: bot, error: botError } = await supabase
      .from('nodeon_users')
      .select('*')
      .eq('telegram_id', 1000002098)
      .single();
    
    if (botError && botError.code === 'PGRST116') {
      console.log('❌ Бот с telegram_id 1000002098 не найден');
      
      // Показываем топ пользователей по балансу
      console.log('\n📊 Топ пользователей по балансу:');
      const { data: topUsers, error: topError } = await supabase
        .from('nodeon_users')
        .select('telegram_id, username, balance_ndn')
        .order('balance_ndn', { ascending: false })
        .limit(10);
      
      if (topUsers && !topError) {
        topUsers.forEach((user, index) => {
          console.log(`${index + 1}. Telegram ID: ${user.telegram_id}, Username: ${user.username || 'N/A'}, Balance: ${user.balance_ndn} NDN`);
        });
      }
      
    } else if (bot) {
      console.log('✅ Найден бот:');
      console.log('ID:', bot.id);
      console.log('Telegram ID:', bot.telegram_id);
      console.log('Username:', bot.username);
      console.log('Balance NDN:', bot.balance_ndn);
      console.log('Balance Stars:', bot.balance_stars);
      console.log('User Status:', bot.user_status);
    } else {
      console.error('❌ Ошибка поиска бота:', botError);
    }
    
  } catch (error) {
    console.error('❌ Общая ошибка:', error);
  }
}

checkBotWallet();











