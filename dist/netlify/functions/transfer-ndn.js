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
          'Access-Control-Allow-Headers': 'Content-Type, Authorization',
          'Access-Control-Allow-Methods': 'POST, OPTIONS'
        }
      };
    }

    if (httpMethod === 'POST') {
      return await handleTransferNDN(event, context);
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
    console.error('Transfer NDN function error:', error);
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

    console.log('📋 Параметры перевода:', { from_telegram_id, to_user_id, amount, description });

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

    // 1. Получаем данные отправителя по telegram_id
    const senderUrl = `${SUPABASE_URL}/rest/v1/nodeon_users?telegram_id=eq.${from_telegram_id}&select=*`;
    const headers = {
      "apikey": SUPABASE_ANON_KEY,
      "Authorization": `Bearer ${SUPABASE_ANON_KEY}`,
      "Content-Type": "application/json"
    };

    const senderResponse = await fetch(senderUrl, { headers });
    if (!senderResponse.ok) {
      throw new Error('Failed to get sender data');
    }
    const senders = await senderResponse.json();
    if (!senders || senders.length === 0) {
      return {
        statusCode: 404,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ success: false, error: 'Sender not found' })
      };
    }
    const sender = senders[0];

    if (sender.balance_ndn < amount) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ success: false, error: 'Insufficient NDN balance' })
      };
    }

    // 2. Получаем данные получателя по внутреннему ID
    const recipientUrl = `${SUPABASE_URL}/rest/v1/nodeon_users?id=eq.${to_user_id}&select=*`;
    const recipientResponse = await fetch(recipientUrl, { headers });
    if (!recipientResponse.ok) {
      throw new Error('Failed to get recipient data');
    }
    const recipients = await recipientResponse.json();
    if (!recipients || recipients.length === 0) {
      return {
        statusCode: 404,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ success: false, error: 'Recipient not found' })
      };
    }
    const recipient = recipients[0];

    // 3. Обновляем балансы
    const newSenderBalance = sender.balance_ndn - amount;
    const newRecipientBalance = recipient.balance_ndn + amount;

    const updateSenderUrl = `${SUPABASE_URL}/rest/v1/nodeon_users?id=eq.${sender.id}`;
    const updateSenderResponse = await fetch(updateSenderUrl, {
      method: 'PATCH',
      headers: headers,
      body: JSON.stringify({ balance_ndn: newSenderBalance })
    });

    const updateRecipientUrl = `${SUPABASE_URL}/rest/v1/nodeon_users?id=eq.${recipient.id}`;
    const updateRecipientResponse = await fetch(updateRecipientUrl, {
      method: 'PATCH',
      headers: headers,
      body: JSON.stringify({ balance_ndn: newRecipientBalance })
    });

    if (!updateSenderResponse.ok || !updateRecipientResponse.ok) {
      throw new Error('Failed to update balances');
    }

    // 4. Записываем транзакции
    const transactionUrl = `${SUPABASE_URL}/rest/v1/nodeon_transactions`;
    await fetch(transactionUrl, {
      method: 'POST',
      headers: headers,
      body: JSON.stringify({
        user_id: sender.id,
        type: 'transfer_out',
        amount: -amount,
        currency: 'NDN',
        description: `Перевод NDN пользователю ${recipient.username || recipient.id}`
      })
    });
    await fetch(transactionUrl, {
      method: 'POST',
      headers: headers,
      body: JSON.stringify({
        user_id: recipient.id,
        type: 'transfer_in',
        amount: amount,
        currency: 'NDN',
        description: `Получение NDN от пользователя ${sender.username || sender.id}`
      })
    });

    console.log(`✅ NDN успешно переведен. Отправитель: ${newSenderBalance}, Получатель: ${newRecipientBalance}`);
    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({
        success: true,
        message: 'NDN transferred successfully',
        from_balance: newSenderBalance,
        to_balance: newRecipientBalance
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
      body: JSON.stringify({ success: false, error: 'Failed to transfer NDN' })
    };
  }
}
