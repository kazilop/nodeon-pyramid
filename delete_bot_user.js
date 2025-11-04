const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_ANON_KEY);

async function deleteBotUser() {
  console.log('🗑️ Удаляем созданного бота...');
  
  try {
    const { error } = await supabase
      .from('nodeon_users')
      .delete()
      .eq('telegram_id', 1000002098);
    
    if (error) {
      console.error('❌ Ошибка удаления бота:', error);
      return;
    }
    
    console.log('✅ Бот удален успешно');
    
  } catch (error) {
    console.error('❌ Общая ошибка:', error);
  }
}

deleteBotUser();











