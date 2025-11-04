exports.handler = async (event, context) => {
  const { httpMethod, path, body, queryStringParameters } = event;

  try {
    if (httpMethod === 'OPTIONS') {
      return {
        statusCode: 200,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Headers': 'Content-Type, Accept-Language',
          'Access-Control-Allow-Methods': 'GET, OPTIONS'
        }
      };
    }

    if (httpMethod === 'GET') {
      return await handleGetGameRules(event, context);
    }

    return {
      statusCode: 404,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Game rules endpoint not found' })
    };

  } catch (error) {
    console.error('Game rules function error:', error);
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

async function handleGetGameRules(event, context) {
  try {
    console.log('📋 Получение правил игры...');

    // Получаем язык из заголовков
    const acceptLanguage = event.headers?.['accept-language'] || event.headers?.['Accept-Language'] || 'ru';
    const language = acceptLanguage.split(',')[0].split('-')[0].toLowerCase();
    
    console.log(`🌐 Язык: ${language}`);

    // Правила игры на разных языках
    const rules = {
      ru: {
        title: "📋 Правила игры NodeOn Pyramid",
        sections: [
          {
            title: "🎯 Цель игры",
            content: "Зарабатывайте NDN монеты, приглашая друзей и играя в мини-игры. Чем больше друзей вы пригласите, тем больше заработаете!"
          },
          {
            title: "💰 Как зарабатывать",
            content: "1. Приглашайте друзей по реферальной ссылке\n2. Получайте 200 NDN за каждого друга, который купит PRO статус\n3. Зарабатывайте до 7 уровней в глубину\n4. Играйте в майнер и получайте Gas"
          },
          {
            title: "⛏️ Игра Майнер",
            content: "1. Покупайте фермы за Gas\n2. Фермы генерируют Gas автоматически\n3. Покупайте улучшения для увеличения добычи\n4. Участвуйте в рейтинге майнеров"
          },
          {
            title: "💎 PRO статус",
            content: "PRO статус стоит 1000 NDN и дает:\n- Доступ к премиум функциям\n- Увеличенные награды\n- Приоритетную поддержку"
          },
          {
            title: "🏆 Рейтинги",
            content: "Соревнуйтесь с другими игроками в рейтингах по балансу NDN и добыче Gas"
          }
        ]
      },
      en: {
        title: "📋 NodeOn Pyramid Game Rules",
        sections: [
          {
            title: "🎯 Game Objective",
            content: "Earn NDN coins by inviting friends and playing mini-games. The more friends you invite, the more you earn!"
          },
          {
            title: "💰 How to Earn",
            content: "1. Invite friends using your referral link\n2. Get 200 NDN for each friend who buys PRO status\n3. Earn up to 7 levels deep\n4. Play miner game and earn Gas"
          },
          {
            title: "⛏️ Miner Game",
            content: "1. Buy farms with Gas\n2. Farms generate Gas automatically\n3. Buy upgrades to increase production\n4. Compete in miner rankings"
          },
          {
            title: "💎 PRO Status",
            content: "PRO status costs 1000 NDN and gives:\n- Access to premium features\n- Increased rewards\n- Priority support"
          },
          {
            title: "🏆 Rankings",
            content: "Compete with other players in rankings by NDN balance and Gas mining"
          }
        ]
      }
    };

    const selectedRules = rules[language] || rules['ru'];

    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({
        success: true,
        language: language,
        rules: selectedRules
      })
    };

  } catch (error) {
    console.error('Error in handleGetGameRules:', error);
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ success: false, error: 'Failed to get game rules' })
    };
  }
}
