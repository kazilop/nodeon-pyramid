// Используем встроенный fetch (Node.js 18+)

// Переменные окружения
const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY;

exports.handler = async (event, context) => {
  const { httpMethod, path, body, queryStringParameters } = event;
  const pathParts = path.replace('/.netlify/functions/users/', '').split('/');

  try {
    if (httpMethod === 'OPTIONS') {
      return {
        statusCode: 200,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Headers': 'Content-Type, Authorization',
          'Access-Control-Allow-Methods': 'GET, POST, OPTIONS'
        }
      };
    }

    if (httpMethod === 'GET' && pathParts[0] === 'find-by-id' && pathParts[1]) {
      return await handleFindUserById(event, context);
    }

    if (httpMethod === 'GET' && pathParts[0] === 'balance' && pathParts[1]) {
      return await handleGetUserBalance(event, context);
    }

    return {
      statusCode: 404,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Users endpoint not found' })
    };

  } catch (error) {
    console.error('Users function error:', error);
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

async function handleFindUserById(event, context) {
  const userId = event.path.split('/').pop();
  console.log(`🔍 Поиск пользователя по ID: ${userId}`);

  try {
    const url = `${SUPABASE_URL}/rest/v1/nodeon_users?id=eq.${userId}&select=*`;
    const headers = {
      "apikey": SUPABASE_ANON_KEY,
      "Authorization": `Bearer ${SUPABASE_ANON_KEY}`,
      "Content-Type": "application/json"
    };

    const response = await fetch(url, { headers });
    console.log(`📡 Запрос пользователя: ${url}`);
    console.log(`📊 Статус ответа: ${response.status}`);

    if (response.ok) {
      const users = await response.json();
      console.log(`📋 Получено пользователей: ${users ? users.length : 0}`);

      if (users && users.length > 0) {
        const user = users[0];
        console.log(`✅ Пользователь найден:`, user);

        return {
          statusCode: 200,
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
          },
          body: JSON.stringify({
            success: true,
            user: {
              id: user.id,
              telegram_id: user.telegram_id,
              username: user.username,
              first_name: user.first_name,
              last_name: user.last_name,
              balance_ndn: user.balance_ndn,
              is_pro: user.is_pro
            }
          })
        };
      } else {
        console.log(`⚠️ Пользователь с ID ${userId} не найден`);
        return {
          statusCode: 404,
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
          },
          body: JSON.stringify({ success: false, error: 'User not found' })
        };
      }
    } else {
      console.log(`❌ Ошибка запроса пользователя: ${response.status} - ${await response.text()}`);
      return {
        statusCode: 500,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ success: false, error: 'Database error' })
      };
    }

  } catch (error) {
    console.error('Error in handleFindUserById:', error);
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ success: false, error: 'Failed to find user' })
    };
  }
}

async function handleGetUserBalance(event, context) {
  const userId = event.path.split('/').pop();
  console.log(`💰 Получение баланса пользователя: ${userId}`);

  try {
    const url = `${SUPABASE_URL}/rest/v1/nodeon_users?id=eq.${userId}&select=id,balance_ndn,balance_stars`;
    const headers = {
      "apikey": SUPABASE_ANON_KEY,
      "Authorization": `Bearer ${SUPABASE_ANON_KEY}`,
      "Content-Type": "application/json"
    };

    const response = await fetch(url, { headers });

    if (response.ok) {
      const users = await response.json();

      if (users && users.length > 0) {
        const user = users[0];

        return {
          statusCode: 200,
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
          },
          body: JSON.stringify({
            success: true,
            balance_ndn: user.balance_ndn,
            balance_stars: user.balance_stars
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
    console.error('Error in handleGetUserBalance:', error);
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ success: false, error: 'Failed to get balance' })
    };
  }
}
