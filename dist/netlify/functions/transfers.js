// Используем встроенный fetch (Node.js 18+)

// Переменные окружения
const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY;

exports.handler = async (event, context) => {
  const { httpMethod, path, body, queryStringParameters } = event;
  const pathParts = path.replace('/.netlify/functions/transfers/', '').split('/');

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

    if (httpMethod === 'POST' && pathParts[0] === 'ndn') {
      return await handleTransferNDN(event, context);
    }

    return {
      statusCode: 404,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Transfers endpoint not found' })
    };

  } catch (error) {
    console.error('Transfers function error:', error);
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

async function handleTransferNDN(event, context) {
  try {
    console.log('💸 Обработка перевода NDN...');

    const requestBody = JSON.parse(event.body || '{}');
    const { from_telegram_id, to_user_id, amount, description } = requestBody;

    if (!from_telegram_id || !to_user_id || !amount) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ success: false, error: 'Missing required fields' })
      };
    }

    if (amount <= 0) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ success: false, error: 'Amount must be positive' })
      };
    }

    const headers = {
      "apikey": SUPABASE_ANON_KEY,
      "Authorization": `Bearer ${SUPABASE_ANON_KEY}`,
      "Content-Type": "application/json"
    };

    // Получаем данные отправителя
    const fromUserUrl = `${SUPABASE_URL}/rest/v1/nodeon_users?telegram_id=eq.${from_telegram_id}&select=*`;
    const fromUserResponse = await fetch(fromUserUrl, { headers });
    
    if (!fromUserResponse.ok) {
      throw new Error('Failed to get sender data');
    }

    const fromUsers = await fromUserResponse.json();
    if (!fromUsers || fromUsers.length === 0) {
      return {
        statusCode: 404,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ success: false, error: 'Sender not found' })
      };
    }

    const fromUser = fromUsers[0];

    // Получаем данные получателя
    const toUserUrl = `${SUPABASE_URL}/rest/v1/nodeon_users?id=eq.${to_user_id}&select=*`;
    const toUserResponse = await fetch(toUserUrl, { headers });
    
    if (!toUserResponse.ok) {
      throw new Error('Failed to get recipient data');
    }

    const toUsers = await toUserResponse.json();
    if (!toUsers || toUsers.length === 0) {
      return {
        statusCode: 404,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ success: false, error: 'Recipient not found' })
      };
    }

    const toUser = toUsers[0];

    // Проверяем баланс отправителя
    if (fromUser.balance_ndn < amount) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ 
          success: false, 
          error: 'Insufficient balance',
          current_balance: fromUser.balance_ndn,
          required: amount
        })
      };
    }

    // Обновляем балансы
    const fromUpdateUrl = `${SUPABASE_URL}/rest/v1/nodeon_users?id=eq.${fromUser.id}`;
    const fromUpdateData = {
      balance_ndn: fromUser.balance_ndn - amount,
      updated_at: new Date().toISOString()
    };

    const fromUpdateResponse = await fetch(fromUpdateUrl, {
      method: 'PATCH',
      headers: headers,
      body: JSON.stringify(fromUpdateData)
    });

    if (!fromUpdateResponse.ok) {
      throw new Error('Failed to update sender balance');
    }

    const toUpdateUrl = `${SUPABASE_URL}/rest/v1/nodeon_users?id=eq.${toUser.id}`;
    const toUpdateData = {
      balance_ndn: toUser.balance_ndn + amount,
      updated_at: new Date().toISOString()
    };

    const toUpdateResponse = await fetch(toUpdateUrl, {
      method: 'PATCH',
      headers: headers,
      body: JSON.stringify(toUpdateData)
    });

    if (!toUpdateResponse.ok) {
      throw new Error('Failed to update recipient balance');
    }

    // Создаем транзакции
    const transactionUrl = `${SUPABASE_URL}/rest/v1/nodeon_transactions`;
    
    // Транзакция для отправителя
    const fromTransactionData = {
      user_id: fromUser.id,
      type: 'transfer_out',
      amount_ndn: -amount,
      amount_stars: 0,
      description: `Перевод пользователю ${toUser.first_name || 'ID ' + toUser.id}: ${description || 'Перевод NDN'}`,
      created_at: new Date().toISOString()
    };

    await fetch(transactionUrl, {
      method: 'POST',
      headers: headers,
      body: JSON.stringify(fromTransactionData)
    });

    // Транзакция для получателя
    const toTransactionData = {
      user_id: toUser.id,
      type: 'transfer_in',
      amount_ndn: amount,
      amount_stars: 0,
      description: `Перевод от ${fromUser.first_name || 'ID ' + fromUser.id}: ${description || 'Перевод NDN'}`,
      created_at: new Date().toISOString()
    };

    await fetch(transactionUrl, {
      method: 'POST',
      headers: headers,
      body: JSON.stringify(toTransactionData)
    });

    console.log(`✅ Перевод выполнен: ${fromUser.id} -> ${toUser.id}, сумма: ${amount} NDN`);

    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({
        success: true,
        message: 'Transfer completed successfully',
        from_balance: fromUser.balance_ndn - amount,
        to_balance: toUser.balance_ndn + amount,
        amount: amount
      })
    };

  } catch (error) {
    console.error('Error in handleTransferNDN:', error);
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ success: false, error: 'Failed to process transfer' })
    };
  }
}
