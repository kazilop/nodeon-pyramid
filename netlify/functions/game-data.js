// Используем встроенный fetch (Node.js 18+)

// Переменные окружения
const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY;

exports.handler = async (event, context) => {
  const { httpMethod, path, body } = event;
  
  // Извлекаем ID из пути функции
  const pathParts = event.path.split('/');
  const userId = pathParts[pathParts.length - 1];

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
      return await handleGetGameData(event, context);
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
    console.error('Game data function error:', error);
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

async function handleGetGameData(event, context) {
  // Извлекаем ID из пути функции
  const pathParts = event.path.split('/');
  const userId = pathParts[pathParts.length - 1];
  
  console.log(`🎮 Получение игровых данных для пользователя: ${userId}`);

  try {
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

    // Здесь можно добавить логику для получения других игровых данных, например, статистики
    const gameData = {
      user_id: user.id,
      balance_ndn: user.balance_ndn,
      is_pro: user.is_pro,
      total_stars_earned: user.total_stars_earned || 0,
      // ... другие игровые данные
    };

    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ success: true, game_data: gameData })
    };

  } catch (error) {
    console.error('Error in handleGetGameData:', error);
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ success: false, error: 'Failed to get game data' })
    };
  }
}




