exports.handler = async (event, context) => {
  const { httpMethod, path, body, queryStringParameters } = event;
  const pathParts = path.replace('/.netlify/functions/translations/', '').split('/');

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

    if (httpMethod === 'GET' && pathParts[0]) {
      return await handleGetTranslations(event, context);
    }

    return {
      statusCode: 404,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Translations endpoint not found' })
    };

  } catch (error) {
    console.error('Translations function error:', error);
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

async function handleGetTranslations(event, context) {
  const language = event.path.split('/').pop();
  console.log(`🌐 Получение переводов для языка: ${language}`);

  try {
    // Загружаем переводы из файлов
    const translations = await loadTranslationsFromFile(language);
    
    if (!translations) {
      return {
        statusCode: 404,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ error: 'Translations not found' })
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
        language: language,
        translations: translations
      })
    };

  } catch (error) {
    console.error('Error in handleGetTranslations:', error);
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ success: false, error: 'Failed to get translations' })
    };
  }
}

async function loadTranslationsFromFile(language) {
  // Встроенные переводы (так как Netlify Functions не могут читать файлы напрямую)
  const translations = {
    ru: {
      "app": {
        "name": "NodeOn Crypto",
        "description": "Крипто игра с монетами NDN",
        "tagline": "Зарабатывай, играй, приглашай друзей!"
      },
      "buttons": {
        "buy_pro": "Купить Pro статус",
        "buy_ndn": "Купить NDN",
        "withdraw_ndn": "Вывести NDN",
        "transfer_ndn": "Перевести NDN",
        "referrals": "Мои рефералы",
        "leaderboard": "Таблица лидеров",
        "rules": "Правила игры",
        "language": "Язык",
        "achievements": "Достижения",
        "shops": "Магазины",
        "invite_friends": "Пригласить друзей",
        "close": "Закрыть",
        "confirm": "Подтвердить",
        "cancel": "Отмена",
        "copy": "Копировать",
        "share": "Поделиться",
        "back": "Назад",
        "search": "Поиск",
        "find_player": "Найти игрока",
        "send": "Отправить",
        "buy": "Купить",
        "exchange": "Обменять",
        "withdraw": "Вывести"
      },
      "user": {
        "balance_ndn": "Баланс NDN",
        "balance_stars": "Баланс Stars",
        "pro_status": "Pro статус",
        "user_id": "Ваш игровой ID",
        "user_id_hint": "Используйте этот ID для переводов вам другими игроками"
      },
      "tabs": {
        "core": "🏠 Основное",
        "game": "🎮 Игра",
        "miner": "⛏️ Майнер"
      }
    },
    en: {
      "app": {
        "name": "NodeOn Crypto",
        "description": "Crypto game with NDN coins",
        "tagline": "Earn, play, invite friends!"
      },
      "buttons": {
        "buy_pro": "Buy Pro Status",
        "buy_ndn": "Buy NDN",
        "withdraw_ndn": "Withdraw NDN",
        "transfer_ndn": "Transfer NDN",
        "referrals": "My Referrals",
        "leaderboard": "Leaderboard",
        "rules": "Game Rules",
        "language": "Language",
        "achievements": "Achievements",
        "shops": "Shops",
        "invite_friends": "Invite Friends",
        "close": "Close",
        "confirm": "Confirm",
        "cancel": "Cancel",
        "copy": "Copy",
        "share": "Share",
        "back": "Back",
        "search": "Search",
        "find_player": "Find Player",
        "send": "Send",
        "buy": "Buy",
        "exchange": "Exchange",
        "withdraw": "Withdraw"
      },
      "user": {
        "balance_ndn": "NDN Balance",
        "balance_stars": "Stars Balance",
        "pro_status": "Pro Status",
        "user_id": "Your Game ID",
        "user_id_hint": "Use this ID for transfers from other players"
      },
      "tabs": {
        "core": "🏠 Main",
        "game": "🎮 Game",
        "miner": "⛏️ Miner"
      }
    }
  };

  return translations[language] || null;
}
