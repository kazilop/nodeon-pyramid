// Импортируем все API функции
const authRoutes = require('./auth');
const userRoutes = require('./users');
const paymentRoutes = require('./payments');
const referralRoutes = require('./referrals');
const statsRoutes = require('./stats');
const minerRoutes = require('./miner');
const gameRulesRoutes = require('./game-rules');
const translationsRoutes = require('./translations');
const proRoutes = require('./pro');
const transfersRoutes = require('./transfers');
const gameRoutes = require('./game');

exports.handler = async (event, context) => {
  const { httpMethod, path, body, queryStringParameters } = event;
  
  console.log(`${httpMethod} ${path}`);
  
  try {
    // Парсим путь для определения маршрута
    const pathParts = path.split('/').filter(part => part);
    
    // Маршрутизация API
    if (pathParts[0] === 'api') {
      const route = pathParts[1];
      const subRoute = pathParts[2];
      
      // Аутентификация
      if (route === 'auth') {
        return await authRoutes.handler(event, context);
      }
      
      // Пользователи
      if (route === 'user') {
        return await authRoutes.handler(event, context);
      }
      
      // Пользователи
      if (route === 'users') {
        return await userRoutes.handler(event, context);
      }
      
      // Платежи
      if (route === 'payments') {
        return await paymentRoutes.handler(event, context);
      }
      
      // Рефералы
      if (route === 'referrals') {
        return await referralRoutes.handler(event, context);
      }
      
      // Статистика
      if (route === 'stats') {
        return await statsRoutes.handler(event, context);
      }
      
      // Майнер
      if (route === 'miner') {
        return await minerRoutes.handler(event, context);
      }
      
      // Правила игры
      if (route === 'game-rules') {
        return await gameRulesRoutes.handler(event, context);
      }
      
      // Переводы
      if (route === 'translations') {
        return await translationsRoutes.handler(event, context);
      }
      
      // Pro статус
      if (route === 'pro') {
        return await proRoutes.handler(event, context);
      }
      
      // Переводы NDN
      if (route === 'transfers') {
        return await transfersRoutes.handler(event, context);
      }
      
      // Игровые данные
      if (route === 'game') {
        return await gameRoutes.handler(event, context);
      }
      
      // Telegram webhook
      if (route === 'telegram' && subRoute === 'webhook') {
        return await telegramWebhook(event, context);
      }
    }
    
    // Если маршрут не найден
    return {
      statusCode: 404,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS'
      },
      body: JSON.stringify({ error: 'Route not found' })
    };
    
  } catch (error) {
    console.error('API Error:', error);
    
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ 
        error: 'Internal server error',
        message: error.message 
      })
    };
  }
};

// Telegram webhook handler
async function telegramWebhook(event, context) {
  try {
    const body = JSON.parse(event.body || '{}');
    
    // Здесь будет логика обработки Telegram webhook
    console.log('Telegram webhook:', body);
    
    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ ok: true })
    };
  } catch (error) {
    console.error('Telegram webhook error:', error);
    
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ error: 'Webhook error' })
    };
  }
}
