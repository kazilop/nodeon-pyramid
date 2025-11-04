// Используем встроенный fetch (Node.js 18+)

// Переменные окружения
const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY;

exports.handler = async (event, context) => {
  const { httpMethod, path, body, queryStringParameters } = event;
  const pathParts = path.replace('/.netlify/functions/stats/', '').split('/');

  try {
    if (httpMethod === 'OPTIONS') {
      return {
        statusCode: 200,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Headers': 'Content-Type',
          'Access-Control-Allow-Methods': 'GET, POST, OPTIONS'
        }
      };
    }

    if (httpMethod === 'GET' && pathParts[0] === 'leaderboard') {
      return await handleGetLeaderboard(event, context);
    }

    if (httpMethod === 'GET' && pathParts[0] === 'dashboard' && pathParts[1]) {
      return await handleGetDashboard(event, context);
    }

    return {
      statusCode: 404,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Stats endpoint not found' })
    };

  } catch (error) {
    console.error('Stats function error:', error);
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

async function handleGetLeaderboard(event, context) {
  try {
    console.log('🏆 Получение лидерборда...');

    const url = `${SUPABASE_URL}/rest/v1/nodeon_users?select=id,telegram_id,username,first_name,last_name,balance_ndn,is_pro&order=balance_ndn.desc&limit=10`;
    const headers = {
      "apikey": SUPABASE_ANON_KEY,
      "Authorization": `Bearer ${SUPABASE_ANON_KEY}`,
      "Content-Type": "application/json"
    };

    const response = await fetch(url, { headers });
    console.log(`📡 Запрос лидерборда: ${url}`);
    console.log(`📊 Статус ответа: ${response.status}`);

    if (response.ok) {
      const users = await response.json();
      console.log(`📋 Получено пользователей: ${users ? users.length : 0}`);

      const leaders = users.map((user, index) => ({
        rank: index + 1,
        id: user.id,
        telegram_id: user.telegram_id,
        username: user.username,
        first_name: user.first_name,
        last_name: user.last_name,
        balance_ndn: user.balance_ndn || 0,
        is_pro: user.is_pro || false
      }));

      return {
        statusCode: 200,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({
          success: true,
          leaders: leaders
        })
      };
    } else {
      console.log(`❌ Ошибка запроса лидерборда: ${response.status} - ${await response.text()}`);
      return {
        statusCode: 500,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ success: false, error: 'Failed to get leaderboard' })
      };
    }

  } catch (error) {
    console.error('Error in handleGetLeaderboard:', error);
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ success: false, error: 'Failed to get leaderboard' })
    };
  }
}

async function handleGetDashboard(event, context) {
  const userId = event.path.split('/').pop();
  console.log(`📊 Получение дашборда для пользователя: ${userId}`);

  try {
    // Получаем данные пользователя
    const userUrl = `${SUPABASE_URL}/rest/v1/nodeon_users?telegram_id=eq.${userId}&select=*`;
    const headers = {
      "apikey": SUPABASE_ANON_KEY,
      "Authorization": `Bearer ${SUPABASE_ANON_KEY}`,
      "Content-Type": "application/json"
    };

    const userResponse = await fetch(userUrl, { headers });
    
    if (userResponse.ok) {
      const users = await userResponse.json();
      if (users && users.length > 0) {
        const user = users[0];
        
        // Получаем статистику рефералов
        const statsUrl = `${SUPABASE_URL}/rest/v1/nodeon_referral_stats?user_id=eq.${user.id}&select=*`;
        const statsResponse = await fetch(statsUrl, { headers });
        
        let referralStats = [];
        if (statsResponse.ok) {
          referralStats = await statsResponse.json();
        }

        return {
          statusCode: 200,
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
          },
          body: JSON.stringify({
            success: true,
            user: user,
            referral_stats: referralStats
          })
        };
      }
    }

    return {
      statusCode: 404,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ success: false, error: 'User not found' })
    };

  } catch (error) {
    console.error('Error in handleGetDashboard:', error);
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ success: false, error: 'Failed to get dashboard' })
    };
  }
}
