const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_ANON_KEY);

async function updateReferralLinks() {
  console.log('🔧 Обновление referral_link в базе данных...');
  
  try {
    // Получаем всех пользователей
    const { data: users, error } = await supabase
      .from('nodeon_users')
      .select('id, referral_link');
    
    if (error) {
      console.error('Ошибка получения пользователей:', error);
      return;
    }
    
    console.log(`📊 Найдено ${users.length} пользователей`);
    
    let updatedCount = 0;
    
    for (const user of users) {
      const currentLink = user.referral_link;
      const userId = user.id;
      
      // Проверяем, нужно ли обновить
      if (!currentLink || currentLink === '' || currentLink.startsWith('https://')) {
        const newLink = `ref_${userId}`;
        
        const { error: updateError } = await supabase
          .from('nodeon_users')
          .update({ referral_link: newLink })
          .eq('id', userId);
        
        if (updateError) {
          console.error(`❌ Ошибка обновления пользователя ${userId}:`, updateError);
        } else {
          console.log(`✅ ID ${userId}: ${currentLink || 'null'} → ${newLink}`);
          updatedCount++;
        }
      } else {
        console.log(`⏭️ ID ${userId}: ${currentLink} (уже правильный формат)`);
      }
    }
    
    console.log(`\n🎉 Обновлено ${updatedCount} пользователей`);
    
    // Проверяем результат
    console.log('\n📋 Проверка результата:');
    const { data: updatedUsers } = await supabase
      .from('nodeon_users')
      .select('id, referral_link')
      .limit(5);
    
    updatedUsers.forEach(user => {
      console.log(`ID ${user.id}: ${user.referral_link}`);
    });
    
  } catch (error) {
    console.error('❌ Общая ошибка:', error);
  }
}

updateReferralLinks();











