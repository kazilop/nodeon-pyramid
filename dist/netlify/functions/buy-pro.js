// Используем встроенный fetch (Node.js 18+)

// Переменные окружения
const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY;

exports.handler = async (event, context) => {
  const { httpMethod, path, body } = event;

  try {
    if (httpMethod === 'OPTIONS') {
      return {
        statusCode: 200,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Headers': 'Content-Type, Authorization',
          'Access-Control-Allow-Methods': 'POST, OPTIONS'
        }
      };
    }

    if (httpMethod === 'POST') {
      return await handleBuyProStatus(event, context);
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
    console.error('Buy Pro function error:', error);
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

async function handleBuyProStatus(event, context) {
  try {
    const requestBody = JSON.parse(event.body || '{}');
    const { telegram_id } = requestBody;
    
    console.log(`💎 Покупка Pro статуса для пользователя: ${telegram_id}`);

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

    // 1. Получаем данные пользователя
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

    const proCost = 1000; // Стоимость Pro статуса в NDN
    if (user.balance_ndn < proCost) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ success: false, error: 'Insufficient NDN balance' })
      };
    }

    // 2. Обновляем Pro статус и баланс
    const newBalance = user.balance_ndn - proCost;
    const updateUrl = `${SUPABASE_URL}/rest/v1/nodeon_users?id=eq.${user.id}`;
    const updateResponse = await fetch(updateUrl, {
      method: 'PATCH',
      headers: headers,
      body: JSON.stringify({ is_pro: true, balance_ndn: newBalance })
    });

    if (!updateResponse.ok) {
      throw new Error('Failed to update user Pro status and balance');
    }

    // 3. Записываем транзакцию
    const transactionUrl = `${SUPABASE_URL}/rest/v1/nodeon_transactions`;
    const transactionResponse = await fetch(transactionUrl, {
      method: 'POST',
      headers: headers,
      body: JSON.stringify({
        user_id: user.id,
        type: 'purchase_pro',
        amount: -proCost,
        currency: 'NDN',
        description: 'Покупка Pro статуса'
      })
    });

    if (!transactionResponse.ok) {
      console.error('Failed to record transaction for Pro status purchase');
    }

    console.log(`✅ Pro статус успешно куплен для пользователя ${telegram_id}. Новый баланс: ${newBalance}`);
    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({
        success: true,
        message: 'Pro status purchased successfully',
        new_balance: newBalance
      })
    };

  } catch (error) {
    console.error('Error in handleBuyProStatus:', error);
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ success: false, error: 'Failed to purchase Pro status' })
    };
  }
}
