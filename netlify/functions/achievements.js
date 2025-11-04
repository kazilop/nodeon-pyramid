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
      return await handleGetAchievements(event, context);
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
    console.error('Achievements function error:', error);
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

async function handleGetAchievements(event, context) {
  // Извлекаем ID из пути функции
  const pathParts = event.path.split('/');
  const userId = pathParts[pathParts.length - 1];
  
  console.log(`🏆 Получение достижений для пользователя: ${userId}`);

  try {
    // Моковые достижения (для примера)
    const achievements = [
      { 
        id: 'first_farm', 
        title: 'Первая ферма', 
        description: 'Купить первую ферму', 
        progress: 1, 
        maxProgress: 1, 
        reward: 10,
        completed: true
      },
      { 
        id: 'pro_user', 
        title: 'Pro пользователь', 
        description: 'Купить Pro статус', 
        progress: 0, 
        maxProgress: 1, 
        reward: 100,
        completed: false
      },
      { 
        id: 'miner_master', 
        title: 'Мастер майнинга', 
        description: 'Намайнить 1000 Gas', 
        progress: 500, 
        maxProgress: 1000, 
        reward: 50,
        completed: false
      },
      { 
        id: 'rich_player', 
        title: 'Богатый игрок', 
        description: 'Накопить 10000 NDN', 
        progress: 0, 
        maxProgress: 10000, 
        reward: 200,
        completed: false
      },
      { 
        id: 'referral_king', 
        title: 'Король рефералов', 
        description: 'Пригласить 10 друзей', 
        progress: 0, 
        maxProgress: 10, 
        reward: 150,
        completed: false
      }
    ];

    // В реальном приложении здесь будет запрос к базе данных для получения прогресса пользователя по достижениям
    // и объединение с общим списком достижений.

    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ success: true, achievements: achievements })
    };

  } catch (error) {
    console.error('Error in handleGetAchievements:', error);
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ success: false, error: 'Failed to get achievements' })
    };
  }
}




