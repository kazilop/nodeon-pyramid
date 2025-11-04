// Используем встроенный fetch (Node.js 18+)

// Переменные окружения
const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY;

exports.handler = async (event, context) => {
  const { httpMethod, path, body, queryStringParameters } = event;
  const pathParts = path.replace('/.netlify/functions/game/', '').split('/');

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

    if (httpMethod === 'GET' && pathParts[0] === 'data' && pathParts[1]) {
      return await handleGetGameData(event, context);
    }

    if (httpMethod === 'POST' && pathParts[0] === 'claim-daily-reward') {
      return await handleClaimDailyReward(event, context);
    }

    if (httpMethod === 'GET' && pathParts[0] === 'achievements' && pathParts[1]) {
      return await handleGetAchievements(event, context);
    }

    return {
      statusCode: 404,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Game endpoint not found' })
    };

  } catch (error) {
    console.error('Game function error:', error);
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
  const userId = event.path.split('/').pop();
  console.log(`🎮 Получение игровых данных для пользователя: ${userId}`);

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
        
        // Создаем игровые данные
        const gameData = {
          user_id: user.id,
          telegram_id: user.telegram_id,
          level: 1,
          experience: 0,
          total_earned: user.balance_ndn || 0,
          total_referrals: 0, // Можно подсчитать из рефералов
          last_daily_reward: null,
          achievements: [],
          stats: {
            total_earned: user.balance_ndn || 0,
            total_referrals: 0,
            days_played: 1,
            pro_status: user.is_pro || false
          }
        };

        return {
          statusCode: 200,
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
          },
          body: JSON.stringify({
            success: true,
            game_data: gameData
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

async function handleClaimDailyReward(event, context) {
  try {
    console.log('🎁 Обработка ежедневной награды...');

    const requestBody = JSON.parse(event.body || '{}');
    const { telegram_id } = requestBody;

    if (!telegram_id) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ success: false, error: 'Telegram ID is required' })
      };
    }

    // Получаем данные пользователя
    const userUrl = `${SUPABASE_URL}/rest/v1/nodeon_users?telegram_id=eq.${telegram_id}&select=*`;
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

    // Проверяем, можно ли получить награду (упрощенная логика)
    const today = new Date().toISOString().split('T')[0];
    const lastReward = user.last_daily_reward;

    if (lastReward === today) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ success: false, error: 'Daily reward already claimed today' })
      };
    }

    // Выдаем награду (уменьшенная в 5 раз)
    const rewardAmount = 20; // Было 100, стало 20

    // Обновляем пользователя
    const updateUrl = `${SUPABASE_URL}/rest/v1/nodeon_users?id=eq.${user.id}`;
    const updateData = {
      balance_ndn: user.balance_ndn + rewardAmount,
      last_daily_reward: today,
      updated_at: new Date().toISOString()
    };

    const updateResponse = await fetch(updateUrl, {
      method: 'PATCH',
      headers: headers,
      body: JSON.stringify(updateData)
    });

    if (!updateResponse.ok) {
      throw new Error('Failed to update user');
    }

    // Создаем транзакцию
    const transactionUrl = `${SUPABASE_URL}/rest/v1/nodeon_transactions`;
    const transactionData = {
      user_id: user.id,
      type: 'daily_reward',
      amount_ndn: rewardAmount,
      amount_stars: 0,
      description: 'Ежедневная награда',
      created_at: new Date().toISOString()
    };

    await fetch(transactionUrl, {
      method: 'POST',
      headers: headers,
      body: JSON.stringify(transactionData)
    });

    console.log(`✅ Ежедневная награда выдана пользователю ${user.id}: ${rewardAmount} NDN`);

    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({
        success: true,
        message: 'Daily reward claimed successfully',
        reward_amount: rewardAmount,
        new_balance: user.balance_ndn + rewardAmount
      })
    };

  } catch (error) {
    console.error('Error in handleClaimDailyReward:', error);
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ success: false, error: 'Failed to claim daily reward' })
    };
  }
}

async function handleGetAchievements(event, context) {
  const userId = event.path.split('/').pop();
  console.log(`🏆 Получение достижений для пользователя: ${userId}`);

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
        
        // Создаем список достижений
        const achievements = [
          {
            id: 'first_login',
            title: 'Первый вход',
            description: 'Войти в игру впервые',
            icon: '🎮',
            completed: true,
            reward: 10
          },
          {
            id: 'pro_user',
            title: 'Pro пользователь',
            description: 'Купить Pro статус',
            icon: '💎',
            completed: user.is_pro || false,
            reward: 100
          },
          {
            id: 'referral_master',
            title: 'Мастер рефералов',
            description: 'Пригласить 5 друзей',
            icon: '👥',
            completed: false, // Можно подсчитать из рефералов
            reward: 200
          }
        ];

        return {
          statusCode: 200,
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
          },
          body: JSON.stringify({
            success: true,
            achievements: achievements
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
