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
      return await handleBuyFarm(event, context);
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
    console.error('Buy farm function error:', error);
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

async function handleBuyFarm(event, context) {
  try {
    console.log('🏭 Buy farm function called');
    console.log('Event body:', event.body);
    
    const requestBody = JSON.parse(event.body || '{}');
    const { user_id, farm_type } = requestBody;
    
    console.log(`🏭 Покупка фермы для пользователя: ${user_id}, тип: ${farm_type}`);
    console.log('Request body parsed:', requestBody);

    if (!user_id || !farm_type) {
      console.log('❌ Missing required fields:', { user_id, farm_type });
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ success: false, error: 'Missing required fields', received: { user_id, farm_type } })
      };
    }

    // 1. Получаем данные пользователя
    const userUrl = `${SUPABASE_URL}/rest/v1/nodeon_users?telegram_id=eq.${user_id}&select=*`;
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

    // 2. Получаем данные майнера
    const minerUrl = `${SUPABASE_URL}/rest/v1/nodeon_miner_data?user_id=eq.${user.id}&select=*`;
    const minerResponse = await fetch(minerUrl, { headers });
    
    let minerData = null;
    if (minerResponse.ok) {
      const miners = await minerResponse.json();
      if (miners && miners.length > 0) {
        minerData = miners[0];
      }
    }

    if (!minerData) {
      return {
        statusCode: 404,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ success: false, error: 'Miner data not found' })
      };
    }

    // 3. Парсим данные майнера
    let minerDataParsed = {};
    try {
      minerDataParsed = typeof minerData.miner_data === 'string' 
        ? JSON.parse(minerData.miner_data) 
        : minerData.miner_data || {};
    } catch (e) {
      console.error('Error parsing miner data:', e);
      minerDataParsed = {};
    }

    // 4. Определяем стоимость фермы
    const farmCosts = {
      'basic': 50,
      'advanced': 200,
      'premium': 500,
      'golden': 1000
    };

    const farmCost = farmCosts[farm_type] || 50;
    const currentGas = minerDataParsed.ndnGas || 100;

    if (currentGas < farmCost) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ 
          success: false, 
          error: 'Insufficient Gas',
          current_gas: currentGas,
          required_gas: farmCost
        })
      };
    }

    // 5. Обновляем данные майнера
    if (!minerDataParsed.farms) {
      minerDataParsed.farms = [];
    }

    // Добавляем ферму
    const newFarm = {
      id: farm_type,
      type: farm_type,
      level: 1,
      efficiency: 1,
      purchased_at: new Date().toISOString()
    };

    minerDataParsed.farms.push(newFarm);
    minerDataParsed.ndnGas = currentGas - farmCost;

    // 6. Сохраняем обновленные данные
    const updateUrl = `${SUPABASE_URL}/rest/v1/nodeon_miner_data?user_id=eq.${user.id}`;
    const updateResponse = await fetch(updateUrl, {
      method: 'PATCH',
      headers: headers,
      body: JSON.stringify({
        miner_data: JSON.stringify(minerDataParsed),
        last_update: new Date().toISOString()
      })
    });

    if (!updateResponse.ok) {
      throw new Error('Failed to update miner data');
    }

    console.log(`✅ Ферма ${farm_type} успешно куплена для пользователя ${user_id}`);
    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({
        success: true,
        message: 'Farm purchased successfully',
        farm_type: farm_type,
        new_gas: minerDataParsed.ndnGas,
        farms: minerDataParsed.farms
      })
    };

  } catch (error) {
    console.error('Error in handleBuyFarm:', error);
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ success: false, error: 'Failed to buy farm' })
    };
  }
}
