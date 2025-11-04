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
          'Access-Control-Allow-Headers': 'Content-Type',
          'Access-Control-Allow-Methods': 'GET, OPTIONS'
        }
      };
    }

    if (httpMethod === 'GET') {
      return await handleGetLeaderboard(event, context);
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
    console.error('Leaderboard function error:', error);
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




