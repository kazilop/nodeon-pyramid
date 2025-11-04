// Используем встроенный fetch (Node.js 18+)

// Переменные окружения
const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY;

exports.handler = async (event, context) => {
  const { httpMethod, path, body, queryStringParameters } = event;
  const pathParts = path.replace('/.netlify/functions/pro/', '').split('/');

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

    if (httpMethod === 'POST' && pathParts[0] === 'buy') {
      return await handleBuyPro(event, context);
    }

    return {
      statusCode: 404,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Pro endpoint not found' })
    };

  } catch (error) {
    console.error('Pro function error:', error);
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

async function handleBuyPro(event, context) {
  try {
    console.log('💎 Обработка покупки Pro статуса...');

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
    console.log(`✅ Пользователь найден: ID=${user.id}, balance_ndn=${user.balance_ndn}, is_pro=${user.is_pro}`);

    // Проверяем, не является ли пользователь уже Pro
    if (user.is_pro) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ success: false, error: 'User already has Pro status' })
      };
    }

    // Проверяем баланс (Pro статус стоит 1000 NDN)
    const proCost = 1000;
    if (user.balance_ndn < proCost) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ 
          success: false, 
          error: 'Insufficient NDN balance',
          required: proCost,
          current: user.balance_ndn
        })
      };
    }

    // Обновляем пользователя: списываем NDN и активируем Pro статус
    const updateUrl = `${SUPABASE_URL}/rest/v1/nodeon_users?id=eq.${user.id}`;
    const updateData = {
      balance_ndn: user.balance_ndn - proCost,
      is_pro: true,
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
      type: 'pro_purchase',
      amount_ndn: -proCost,
      amount_stars: 0,
      description: 'Покупка Pro статуса',
      created_at: new Date().toISOString()
    };

    await fetch(transactionUrl, {
      method: 'POST',
      headers: headers,
      body: JSON.stringify(transactionData)
    });

    console.log(`✅ Pro статус активирован для пользователя ${user.id}`);

    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({
        success: true,
        message: 'Pro status activated successfully',
        new_balance: user.balance_ndn - proCost,
        is_pro: true
      })
    };

  } catch (error) {
    console.error('Error in handleBuyPro:', error);
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ success: false, error: 'Failed to buy Pro status' })
    };
  }
}




