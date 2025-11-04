// Используем встроенный fetch (Node.js 18+)

// Переменные окружения
const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY;

exports.handler = async (event, context) => {
  const { httpMethod, path, body, queryStringParameters } = event;

  try {
    if (httpMethod === 'OPTIONS') {
      return {
        statusCode: 200,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Headers': 'Content-Type, Authorization',
          'Access-Control-Allow-Methods': 'GET, OPTIONS'
        }
      };
    }

    if (httpMethod === 'GET') {
      return await handleGetReferrals(event, context);
    }

    return {
      statusCode: 404,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Method not allowed' })
    };

  } catch (error) {
    console.error('Referrals by ID function error:', error);
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Internal Server Error' })
    };
  }
};

async function handleGetReferrals(event, context) {
  // Извлекаем ID из пути функции
  const pathParts = event.path.split('/');
  const userId = pathParts[pathParts.length - 1];
  
  console.log(`👥 Получение рефералов для пользователя: ${userId}`);

  try {
    // Получаем данные пользователя по внутреннему ID
    const userUrl = `${SUPABASE_URL}/rest/v1/nodeon_users?id=eq.${userId}&select=*`;
    const headers = {
      "apikey": SUPABASE_ANON_KEY,
      "Authorization": `Bearer ${SUPABASE_ANON_KEY}`,
      "Content-Type": "application/json"
    };

    const userResponse = await fetch(userUrl, { headers });
    
    if (!userResponse.ok) {
      throw new Error('Failed to get user data');
    }

    const users = await userResponse.json();
    if (!users || users.length === 0) {
      return {
        statusCode: 404,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ success: false, error: 'User not found' })
      };
    }

    const user = users[0];
    console.log(`✅ Пользователь найден: ID=${user.id}, telegram_id=${user.telegram_id}`);

    // Получаем всех рефералов этого пользователя
    const referralsUrl = `${SUPABASE_URL}/rest/v1/nodeon_users?inviter_id=eq.${user.id}&select=*`;
    const referralsResponse = await fetch(referralsUrl, { headers });
    
    let allReferrals = [];
    if (referralsResponse.ok) {
      allReferrals = await referralsResponse.json();
      console.log(`📋 Найдено рефералов: ${allReferrals.length}`);
    }

    // Получаем статистику рефералов
    const statsUrl = `${SUPABASE_URL}/rest/v1/nodeon_referral_stats?user_id=eq.${user.id}&select=*`;
    const statsResponse = await fetch(statsUrl, { headers });
    
    let referralStats = [];
    if (statsResponse.ok) {
      referralStats = await statsResponse.json();
      console.log(`📊 Найдено статистики: ${referralStats.length}`);
    }

    // Подсчитываем статистику
    const totalReferrals = allReferrals.length;
    const proReferrals = allReferrals.filter(ref => ref.is_pro).length;
    const regularReferrals = totalReferrals - proReferrals;

    // Группируем рефералов по уровням (упрощенная версия)
    const referralsByLevel = {};
    allReferrals.forEach((referral, index) => {
      const level = Math.min(Math.floor(index / 10) + 1, 7); // Максимум 7 уровней
      if (!referralsByLevel[level]) {
        referralsByLevel[level] = [];
      }
      referralsByLevel[level].push(referral);
    });

    // Подсчитываем общие заработки
    let totalEarnings = 0;
    if (referralStats) {
      totalEarnings = referralStats.reduce((sum, stat) => sum + (stat.total_earnings || 0), 0);
    }

    const result = {
      success: true,
      total_referrals: totalReferrals,
      regular_referrals: regularReferrals,
      pro_referrals: proReferrals,
      all_referrals: allReferrals,
      referrals_by_level: referralsByLevel,
      referral_stats: referralStats,
      total_earnings: totalEarnings
    };

    console.log(`✅ Результат рефералов:`, {
      total: result.total_referrals,
      pro: result.pro_referrals,
      earnings: result.total_earnings
    });

    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify(result)
    };

  } catch (error) {
    console.error('Error in handleGetReferrals:', error);
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ success: false, error: 'Failed to get referrals' })
    };
  }
}




