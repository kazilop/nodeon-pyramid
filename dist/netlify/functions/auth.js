const crypto = require('crypto');

// Переменные окружения
const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY;
const SECRET_KEY = process.env.SECRET_KEY;

exports.handler = async (event, context) => {
  const { httpMethod, path, body } = event;
  
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
    
    if (httpMethod === 'POST' && path.includes('/login')) {
      return await handleLogin(event, context);
    }
    
    if (httpMethod === 'GET' && path.includes('/me')) {
      return await handleGetMe(event, context);
    }
    
    if (httpMethod === 'GET' && path.includes('/profile')) {
      return await handleUserProfile(event, context);
    }
    
    return {
      statusCode: 404,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Route not found' })
    };
    
  } catch (error) {
    console.error('Auth error:', error);
    
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Internal server error' })
    };
  }
};

async function handleLogin(event, context) {
  try {
    const { initData } = JSON.parse(body || '{}');
    
    if (!initData) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ error: 'initData is required' })
      };
    }
    
    // Валидация Telegram данных
    const isValid = validateTelegramData(initData);
    
    if (!isValid) {
      return {
        statusCode: 401,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ error: 'Invalid Telegram data' })
      };
    }
    
    // Парсим данные пользователя
    const userData = parseInitData(initData);
    
    // Создаем или обновляем пользователя в Supabase
    const user = await createOrUpdateUser(userData);
    
    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({
        success: true,
        user: user
      })
    };
    
  } catch (error) {
    console.error('Login error:', error);
    
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Login failed' })
    };
  }
}

async function handleGetMe(event, context) {
  try {
    const userId = event.queryStringParameters?.user_id;
    
    if (!userId) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ error: 'user_id is required' })
      };
    }
    
    // Получаем пользователя из Supabase
    const user = await getUserFromSupabase(userId);
    
    if (!user) {
      return {
        statusCode: 404,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ error: 'User not found' })
      };
    }
    
    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({
        success: true,
        user: user
      })
    };
    
  } catch (error) {
    console.error('GetMe error:', error);
    
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Failed to get user data' })
    };
  }
}

async function handleUserProfile(event, context) {
  try {
    console.log('🔍 Обработка запроса профиля пользователя');
    
    // Получаем данные из заголовков
    const authHeader = event.headers?.authorization || event.headers?.Authorization;
    const initData = authHeader?.replace('tma ', '');
    
    console.log('Auth header:', authHeader);
    console.log('Init data:', initData);
    
    if (!initData) {
      return {
        statusCode: 401,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ error: 'Authorization header required' })
      };
    }
    
    // Парсим данные Telegram
    const userData = parseInitData(initData);
    
    if (!userData) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ error: 'Invalid Telegram data' })
      };
    }
    
    console.log('Parsed user data:', userData);
    
    // Получаем пользователя из Supabase
    const user = await getUserFromSupabase(userData.id);
    
    if (!user) {
      // Создаем нового пользователя
      console.log('Создаем нового пользователя:', userData.id);
      const newUser = await createUserInSupabase(userData);
      
      if (newUser) {
        return {
          statusCode: 200,
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
          },
          body: JSON.stringify({
            success: true,
            user: newUser
          })
        };
      } else {
        return {
          statusCode: 500,
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
          },
          body: JSON.stringify({ error: 'Failed to create user' })
        };
      }
    }
    
    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({
        success: true,
        user: user
      })
    };
    
  } catch (error) {
    console.error('UserProfile error:', error);
    
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Failed to get user profile' })
    };
  }
}

function validateTelegramData(initData) {
  try {
    const urlParams = new URLSearchParams(initData);
    const hash = urlParams.get('hash');
    urlParams.delete('hash');
    
    const dataCheckString = Array.from(urlParams.entries())
      .sort(([a], [b]) => a.localeCompare(b))
      .map(([key, value]) => `${key}=${value}`)
      .join('\n');
    
    const secretKey = crypto.createHmac('sha256', 'WebAppData').update(SECRET_KEY).digest();
    const calculatedHash = crypto.createHmac('sha256', secretKey).update(dataCheckString).digest('hex');
    
    return calculatedHash === hash;
  } catch (error) {
    console.error('Validation error:', error);
    return false;
  }
}

function parseInitData(initData) {
  const urlParams = new URLSearchParams(initData);
  const userParam = urlParams.get('user');
  
  if (userParam) {
    return JSON.parse(userParam);
  }
  
  return null;
}

async function createOrUpdateUser(userData) {
  // Здесь будет логика создания/обновления пользователя в Supabase
  // Пока возвращаем моковые данные
  return {
    id: userData.id,
    telegram_id: userData.id,
    username: userData.username,
    first_name: userData.first_name,
    last_name: userData.last_name,
    balance_ndn: 0,
    balance_stars: 0,
    is_pro: false
  };
}

async function getUserFromSupabase(userId) {
  try {
    console.log(`🔍 Поиск пользователя по telegram_id: ${userId}`);
    
    const url = `${SUPABASE_URL}/rest/v1/nodeon_users?telegram_id=eq.${userId}&select=*`;
    const headers = {
      "apikey": SUPABASE_ANON_KEY,
      "Authorization": `Bearer ${SUPABASE_ANON_KEY}`,
      "Content-Type": "application/json"
    };
    
    const response = await fetch(url, { headers });
    console.log(`📡 Запрос пользователя: ${url}`);
    console.log(`📊 Статус ответа: ${response.status}`);
    
    if (response.ok) {
      const data = await response.json();
      console.log(`📋 Получено пользователей: ${data ? data.length : 0}`);
      
      if (data && data.length > 0) {
        const user = data[0];
        console.log(`✅ Пользователь найден:`, user);
        return user;
      } else {
        console.log(`⚠️ Пользователь с telegram_id ${userId} не найден`);
      }
    } else {
      console.log(`❌ Ошибка запроса пользователя: ${response.status} - ${await response.text()}`);
    }
    
    return null;
  } catch (error) {
    console.error('Error getting user from Supabase:', error);
    return null;
  }
}

async function createUserInSupabase(userData) {
  try {
    console.log(`👤 Создание пользователя: ${userData.id}`);
    
    const url = `${SUPABASE_URL}/rest/v1/nodeon_users`;
    const headers = {
      "apikey": SUPABASE_ANON_KEY,
      "Authorization": `Bearer ${SUPABASE_ANON_KEY}`,
      "Content-Type": "application/json"
    };
    
    const newUser = {
      telegram_id: userData.id,
      username: userData.username || '',
      first_name: userData.first_name || '',
      last_name: userData.last_name || '',
      balance_ndn: 0.0,
      balance_stars: 0.0,
      total_stars_earned: 0.0,
      is_pro: false,
      referral_link: `https://t.me/pro_stars_bot?startapp=ref_${userData.id}`,
      created_at: new Date().toISOString()
    };
    
    const response = await fetch(url, {
      method: 'POST',
      headers: headers,
      body: JSON.stringify(newUser)
    });
    
    console.log(`📡 Создание пользователя: ${url}`);
    console.log(`📊 Статус ответа: ${response.status}`);
    
    if (response.ok) {
      const createdUser = await response.json();
      console.log(`✅ Пользователь создан:`, createdUser);
      return createdUser[0] || createdUser;
    } else {
      console.log(`❌ Ошибка создания пользователя: ${response.status} - ${await response.text()}`);
    }
    
    return null;
  } catch (error) {
    console.error('Error creating user in Supabase:', error);
    return null;
  }
}
