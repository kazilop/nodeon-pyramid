const express = require('express');
const { createClient } = require('@supabase/supabase-js');
const router = express.Router();

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_ANON_KEY
);

// GET /api/game/data/:telegram_id - Получение игровых данных
router.get('/data/:telegram_id', async (req, res) => {
  try {
    const { telegram_id } = req.params;
    
    console.log(`🎮 Getting game data for user: ${telegram_id}`);

    // Получаем данные пользователя
    const { data: user, error: userError } = await supabase
      .from('nodeon_users')
      .select('*')
      .eq('telegram_id', telegram_id)
      .single();

    if (userError) {
      console.error('User fetch error:', userError);
      return res.status(404).json({ error: 'User not found' });
    }

    // Получаем данные майнера
    const { data: minerData, error: minerError } = await supabase
      .from('nodeon_miner_data')
      .select('*')
      .eq('user_id', user.id)
      .single();

    const gameData = {
      level: 1,
      experience: 0,
      total_farms: minerData?.total_farms || 0,
      total_gas_earned: minerData?.gas || 0
    };

    res.json({
      success: true,
      game_data: gameData
    });

  } catch (error) {
    console.error('Game data error:', error);
    res.status(500).json({ error: 'Failed to get game data' });
  }
});

// GET /api/game/achievements - Получение достижений
router.get('/achievements', async (req, res) => {
  try {
    console.log('🏆 Getting achievements');

    // Расширенная система достижений (30+)
    // ЭКОНОМИКА: Максимум 100 NDN в неделю
    // Ежедневные награды: 49 NDN/неделю
    // Достижения (долгосрочные): не влияют на недельный лимит, малые награды
    const achievements = [
      // === КАТЕГОРИЯ: НОВИЧОК (быстрые, за первую неделю) ===
      {
        id: 'first_step',
        title: 'Первый шаг',
        description: 'Зайти в приложение',
        icon: '✨',
        category: 'beginner',
        progress: 1,
        max_progress: 1,
        reward: 2, // Уменьшено
        completed: true
      },
      {
        id: 'explorer',
        title: 'Знакомство',
        description: 'Посетить все вкладки',
        icon: '🎮',
        category: 'beginner',
        progress: 0,
        max_progress: 4,
        reward: 3, // Уменьшено
        completed: false
      },
      {
        id: 'active_start',
        title: 'Активный старт',
        description: 'Провести в приложении 30 минут',
        icon: '📱',
        category: 'beginner',
        progress: 0,
        max_progress: 1800,
        reward: 5, // Уменьшено
        completed: false
      },
      
      // === КАТЕГОРИЯ: МАЙНИНГ (средние сроки) ===
      {
        id: 'first_click',
        title: 'Первый клик',
        description: 'Намайнить 100 Gas',
        icon: '⛏️',
        category: 'mining',
        progress: 0,
        max_progress: 100,
        reward: 3,
        completed: false
      },
      {
        id: 'first_farm',
        title: 'Промышленник',
        description: 'Купить 5 ферм',
        icon: '🏭',
        category: 'mining',
        progress: 0,
        max_progress: 5,
        reward: 5,
        completed: false
      },
      {
        id: 'energy_master',
        title: 'Энергетик',
        description: 'Пополнить энергию 10 раз',
        icon: '⚡',
        category: 'mining',
        progress: 0,
        max_progress: 10,
        reward: 5,
        completed: false
      },
      {
        id: 'efficient_miner',
        title: 'Эффективность',
        description: 'Намайнить 1000 Gas за час',
        icon: '🎯',
        category: 'mining',
        progress: 0,
        max_progress: 1000,
        reward: 8,
        completed: false
      },
      {
        id: 'gas_king',
        title: 'Gas King',
        description: 'Накопить 10,000 Gas',
        icon: '💎',
        category: 'mining',
        progress: 0,
        max_progress: 10000,
        reward: 10,
        completed: false
      },
      {
        id: 'mega_miner',
        title: 'Mega Miner',
        description: 'Намайнить 100,000 Gas за всё время',
        icon: '🏆',
        category: 'mining',
        progress: 0,
        max_progress: 100000,
        reward: 15,
        completed: false
      },
      
      // === КАТЕГОРИЯ: БОГАТСТВО (долгосрочные) ===
      {
        id: 'first_earning',
        title: 'Первый заработок',
        description: 'Заработать 100 NDN',
        icon: '💰',
        category: 'wealth',
        progress: 0,
        max_progress: 100,
        reward: 5,
        completed: false
      },
      {
        id: 'wealthy',
        title: 'Состоятельный',
        description: 'Накопить 1,000 NDN',
        icon: '💎',
        category: 'wealth',
        progress: 0,
        max_progress: 1000,
        reward: 10,
        completed: false
      },
      {
        id: 'millionaire',
        title: 'Миллионер',
        description: 'Накопить 10,000 NDN',
        icon: '🏆',
        category: 'wealth',
        progress: 0,
        max_progress: 10000,
        reward: 20,
        completed: false
      },
      {
        id: 'oligarch',
        title: 'Олигарх',
        description: 'Накопить 100,000 NDN',
        icon: '👑',
        category: 'wealth',
        progress: 0,
        max_progress: 100000,
        reward: 50,
        completed: false
      },
      
      // === КАТЕГОРИЯ: РЕФЕРАЛЫ (важно для роста) ===
      {
        id: 'mentor',
        title: 'Наставник',
        description: 'Пригласить 1 друга',
        icon: '👥',
        category: 'referral',
        progress: 0,
        max_progress: 1,
        reward: 5,
        completed: false
      },
      {
        id: 'popular',
        title: 'Популярный',
        description: 'Пригласить 5 друзей',
        icon: '🌟',
        category: 'referral',
        progress: 0,
        max_progress: 5,
        reward: 15,
        completed: false
      },
      {
        id: 'community_leader',
        title: 'Лидер сообщества',
        description: 'Пригласить 10 друзей',
        icon: '🎖️',
        category: 'referral',
        progress: 0,
        max_progress: 10,
        reward: 25,
        completed: false
      },
      {
        id: 'legend',
        title: 'Легенда',
        description: 'Пригласить 50 друзей',
        icon: '👑',
        category: 'referral',
        progress: 0,
        max_progress: 50,
        reward: 50,
        completed: false
      },
      {
        id: 'empire',
        title: 'Империя',
        description: '5 друзей купили Pro',
        icon: '🌍',
        category: 'referral',
        progress: 0,
        max_progress: 5,
        reward: 30,
        completed: false
      },
      
      // === КАТЕГОРИЯ: АКТИВНОСТЬ ===
      {
        id: 'regular_client',
        title: 'Постоянный клиент',
        description: 'Войти 7 дней подряд',
        icon: '📅',
        category: 'activity',
        progress: 0,
        max_progress: 7,
        reward: 10,
        completed: false
      },
      {
        id: 'flaming_player',
        title: 'Пламенный игрок',
        description: 'Войти 30 дней подряд',
        icon: '🔥',
        category: 'activity',
        progress: 0,
        max_progress: 30,
        reward: 25,
        completed: false
      },
      {
        id: 'veteran',
        title: 'Ветеран',
        description: 'Войти 100 дней подряд',
        icon: '⭐',
        category: 'activity',
        progress: 0,
        max_progress: 100,
        reward: 50,
        completed: false
      },
      {
        id: 'precision',
        title: 'Точность',
        description: 'Собрать все ежедневные награды за неделю',
        icon: '🎯',
        category: 'activity',
        progress: 0,
        max_progress: 7,
        reward: 10,
        completed: false
      },
      
      // === КАТЕГОРИЯ: ПРОГРЕСС ===
      {
        id: 'level_5',
        title: 'Уровень 5',
        description: 'Достичь 5 уровня',
        icon: '📊',
        category: 'progress',
        progress: 0,
        max_progress: 5,
        reward: 5,
        completed: false
      },
      {
        id: 'level_10',
        title: 'Уровень 10',
        description: 'Достичь 10 уровня',
        icon: '🎖️',
        category: 'progress',
        progress: 0,
        max_progress: 10,
        reward: 10,
        completed: false
      },
      {
        id: 'level_20',
        title: 'Уровень 20',
        description: 'Достичь 20 уровня',
        icon: '👑',
        category: 'progress',
        progress: 0,
        max_progress: 20,
        reward: 20,
        completed: false
      },
      {
        id: 'maximalist',
        title: 'Максималист',
        description: 'Достичь 50 уровня',
        icon: '💫',
        category: 'progress',
        progress: 0,
        max_progress: 50,
        reward: 50,
        completed: false
      },
      
      // === КАТЕГОРИЯ: ОСОБЫЕ ===
      {
        id: 'generous',
        title: 'Щедрый',
        description: 'Отправить подарок другу',
        icon: '🎁',
        category: 'special',
        progress: 0,
        max_progress: 1,
        reward: 5,
        completed: false
      },
      {
        id: 'pro_player',
        title: 'Pro игрок',
        description: 'Купить Pro статус',
        icon: '💎',
        category: 'special',
        progress: 0,
        max_progress: 1,
        reward: 20,
        completed: false
      },
      {
        id: 'lucky_one',
        title: 'Везунчик',
        description: 'Выиграть в случайном событии майнера',
        icon: '🎲',
        category: 'special',
        progress: 0,
        max_progress: 1,
        reward: 5,
        completed: false
      },
      {
        id: 'collector',
        title: 'Коллекционер',
        description: 'Купить все типы ферм',
        icon: '🌟',
        category: 'special',
        progress: 0,
        max_progress: 5,
        reward: 15,
        completed: false
      }
    ];

    res.json({
      success: true,
      achievements: achievements
    });

  } catch (error) {
    console.error('Achievements error:', error);
    res.status(500).json({ error: 'Failed to get achievements' });
  }
});

// POST /api/game/daily-reward - Получение ежедневной награды (старый endpoint для совместимости)
router.post('/daily-reward', async (req, res) => {
  try {
    const { telegram_id } = req.body;
    
    console.log(`🎁 Claiming daily reward for user: ${telegram_id}`);

    if (!telegram_id) {
      return res.status(400).json({ 
        success: false, 
        error: 'Missing telegram_id' 
      });
    }

    // Получаем данные пользователя
    const { data: user, error: userError } = await supabase
      .from('nodeon_users')
      .select('*')
      .eq('telegram_id', telegram_id)
      .single();

    if (userError) {
      console.error('User fetch error:', userError);
      return res.status(404).json({ error: 'User not found' });
    }

    // Проверяем, получал ли пользователь награду сегодня
    const today = new Date().toISOString().split('T')[0];
    const { data: todayTransaction, error: transactionError } = await supabase
      .from('nodeon_transactions')
      .select('*')
      .eq('user_id', user.id)
      .eq('type', 'daily_reward')
      .gte('created_at', today)
      .single();

    if (todayTransaction) {
      return res.status(400).json({ 
        success: false, 
        error: 'Daily reward already claimed today' 
      });
    }

    // Выдаем награду (уменьшенную в 5 раз)
    const reward = 20; // Было 100, стало 20
    const newBalance = user.balance_ndn + reward;

    // Обновляем баланс
    const { error: updateError } = await supabase
      .from('nodeon_users')
      .update({ balance_ndn: newBalance })
      .eq('id', user.id);

    if (updateError) {
      console.error('Update error:', updateError);
      return res.status(500).json({ error: 'Failed to update balance' });
    }

    // Создаем транзакцию
    const { error: transactionCreateError } = await supabase
      .from('nodeon_transactions')
      .insert({
        user_id: user.id,
        type: 'daily_reward',
        amount_ndn: reward,
        description: 'Daily reward',
        created_at: new Date().toISOString()
      });

    if (transactionCreateError) {
      console.error('Transaction error:', transactionCreateError);
    }

    res.json({
      success: true,
      message: 'Daily reward claimed successfully',
      reward: reward,
      new_balance: newBalance
    });

  } catch (error) {
    console.error('Daily reward error:', error);
    res.status(500).json({ error: 'Failed to claim daily reward' });
  }
});

// POST /api/game/claim-daily-reward - Получение ежедневной награды с указанием дня
router.post('/claim-daily-reward', async (req, res) => {
  try {
    const { telegram_id, day } = req.body;
    
    console.log(`🎁 Claiming daily reward for user: ${telegram_id}, day: ${day}`);

    if (!telegram_id || !day) {
      return res.status(400).json({ 
        success: false, 
        error: 'Missing telegram_id or day' 
      });
    }

    // Награды по дням (соответствуют фронтенду)
    const rewards = {
      1: 1,
      2: 2,
      3: 3,
      4: 5,
      5: 8,
      6: 10,
      7: 20
    };

    const rewardAmount = rewards[day];
    if (!rewardAmount) {
      return res.status(400).json({ 
        success: false, 
        error: 'Invalid day number' 
      });
    }

    // Получаем данные пользователя
    const { data: user, error: userError } = await supabase
      .from('nodeon_users')
      .select('*')
      .eq('telegram_id', telegram_id)
      .single();

    if (userError) {
      console.error('User fetch error:', userError);
      return res.status(404).json({ 
        success: false,
        error: 'User not found' 
      });
    }

    // Проверяем, получал ли пользователь награду за этот конкретный день
    const today = new Date().toISOString().split('T')[0];
    const { data: dayTransaction, error: transactionError } = await supabase
      .from('nodeon_transactions')
      .select('*')
      .eq('user_id', user.id)
      .eq('type', 'daily_reward')
      .eq('description', `Daily reward day ${day}`)
      .gte('created_at', today)
      .single();

    if (dayTransaction) {
      return res.status(400).json({ 
        success: false, 
        error: `Daily reward for day ${day} already claimed today` 
      });
    }

    // Рассчитываем новый баланс
    const newBalance = (user.balance_ndn || 0) + rewardAmount;

    console.log(`💰 Updating balance: ${user.balance_ndn} + ${rewardAmount} = ${newBalance}`);

    // Обновляем баланс в базе данных
    const { error: updateError } = await supabase
      .from('nodeon_users')
      .update({ balance_ndn: newBalance })
      .eq('id', user.id);

    if (updateError) {
      console.error('❌ Update error:', updateError);
      return res.status(500).json({ 
        success: false,
        error: 'Failed to update balance' 
      });
    }

    console.log(`✅ Balance updated successfully for user ${user.id}: ${newBalance} NDN`);

    // Создаем транзакцию для отслеживания
    const { error: transactionCreateError } = await supabase
      .from('nodeon_transactions')
      .insert({
        user_id: user.id,
        type: 'daily_reward',
        amount_ndn: rewardAmount,
        description: `Daily reward day ${day}`,
        created_at: new Date().toISOString()
      });

    if (transactionCreateError) {
      console.error('⚠️ Transaction creation error:', transactionCreateError);
      // Не возвращаем ошибку, так как баланс уже обновлен
    }

    // Возвращаем успешный ответ с обновленным балансом
    res.json({
      success: true,
      message: `Daily reward claimed successfully for day ${day}`,
      reward_amount: rewardAmount,
      day: day,
      new_balance: newBalance
    });

  } catch (error) {
    console.error('❌ Daily reward error:', error);
    res.status(500).json({ 
      success: false,
      error: 'Failed to claim daily reward' 
    });
  }
});

// GET /api/game/rules - Получение правил игры
router.get('/rules', async (req, res) => {
  try {
    const fs = require('fs');
    const path = require('path');
    
    let lang = req.headers['accept-language'] || 'ru';
    
    console.log(`📋 Getting game rules for language: ${lang}`);

    // Определяем язык из заголовка
    if (lang) {
      if (lang.startsWith('en')) lang = 'en';
      else if (lang.startsWith('es')) lang = 'es';
      else if (lang.startsWith('de')) lang = 'de';
      else if (lang.startsWith('fr')) lang = 'fr';
      else if (lang.startsWith('it')) lang = 'it';
      else if (lang.startsWith('pt')) lang = 'pt';
      else if (lang.startsWith('ar')) lang = 'ar';
      else if (lang.startsWith('hi')) lang = 'hi';
      else if (lang.startsWith('ja')) lang = 'ja';
      else if (lang.startsWith('ko')) lang = 'ko';
      else if (lang.startsWith('zh')) lang = 'zh';
      else lang = 'ru';
    } else {
      lang = 'ru';
    }

    // Загружаем правила из файла локализации
    const candidatePaths = [
      path.join(__dirname, '..', 'locales', `${lang}.json`),
      path.join(__dirname, '..', '..', 'locales', `${lang}.json`),
      path.join(process.cwd(), 'locales', `${lang}.json`)
    ];

    const translationsPath = candidatePaths.find(p => fs.existsSync(p));

    // Пытаемся загрузить из файла локализации
    if (translationsPath && fs.existsSync(translationsPath)) {
      try {
        const translations = JSON.parse(fs.readFileSync(translationsPath, 'utf8'));
        
        // Если в локализации есть game_rules с sections, используем их
        if (translations.game_rules) {
          if (translations.game_rules.sections && Array.isArray(translations.game_rules.sections) && translations.game_rules.sections.length > 0) {
            console.log(`✅ Loaded game rules from localization file for ${lang}, sections: ${translations.game_rules.sections.length}`);
            console.log(`📋 First section: ${translations.game_rules.sections[0].id}, content items: ${translations.game_rules.sections[0].content?.length || 0}`);
            return res.json({
              success: true,
              rules: translations.game_rules
            });
          } else {
            console.log(`⚠️ game_rules found but no sections or empty sections for ${lang}, converting old format`);
            // Преобразуем старый формат в новый (для обратной совместимости)
            const convertedRules = {
              title: translations.game_rules.title || 'Game Rules',
              description: translations.game_rules.description || '',
              sections: convertOldRulesFormat(translations.game_rules, lang)
            };
            return res.json({
              success: true,
              rules: convertedRules
            });
          }
        }
      } catch (err) {
        console.error('Error loading from localization file:', err);
      }
    }

    // Fallback: правила по умолчанию (если не найдены в локализации)
    console.log(`⚠️ Using default rules for ${lang}`);
    
    // Правила для разных языков (fallback)
    const rules = {
      ru: {
        title: '📚 Полное руководство NodeOn Crypto',
        description: 'Изучите все возможности для максимального заработка NDN!',
        sections: [
          {
            id: 'getting_started',
            icon: '🚀',
            title: 'С чего начать',
            category: 'basics',
            badge: 'NEW',
            badgeColor: 'green',
            priority: 'high',
            content: [
              { text: 'Создайте аккаунт через Telegram WebApp', highlight: false },
              { text: 'Получите стартовые 100 Gas для игры Miner', highlight: true, value: '100 Gas' },
              { text: 'Изучите интерфейс и доступные функции', highlight: false },
              { text: 'Купите Pro статус за 1000 NDN для полного доступа', highlight: true, value: '1000 NDN' }
            ]
          },
          {
            id: 'pro_status',
            icon: '💎',
            title: 'Pro статус',
            category: 'premium',
            badge: 'VIP',
            badgeColor: 'purple',
            priority: 'critical',
            highlight: true,
            content: [
              { text: 'Стоимость: 1000 NDN', highlight: true, value: '1000 NDN', type: 'cost' },
              { text: 'Открывает доступ к реферальной системе', highlight: false, type: 'benefit' },
              { text: 'Позволяет приглашать друзей и зарабатывать', highlight: false, type: 'benefit' },
              { text: 'Получите уникальную реферальную ссылку', highlight: true, type: 'feature' },
              { text: 'Доступ к расширенным функциям и статистике', highlight: false, type: 'benefit' }
            ]
          },
          {
            id: 'referral_system',
            icon: '👥',
            title: 'Реферальная система',
            category: 'earnings',
            badge: 'HOT',
            badgeColor: 'red',
            priority: 'high',
            highlight: true,
            content: [
              { text: 'Приглашайте друзей по своей реферальной ссылке', highlight: false },
              { text: 'Получайте награды до 7 уровней в глубину', highlight: true, value: '7 уровней', type: 'info' },
              { text: 'Награда за 1-й уровень: 200 NDN', highlight: true, value: '200 NDN', type: 'reward' },
              { text: 'Награда за уровни 2-7: по 150 NDN', highlight: true, value: '150 NDN', type: 'reward' },
              { text: 'Награды приходят автоматически при покупке Pro', highlight: true, type: 'auto' },
              { text: 'Только Pro пользователи могут приглашать друзей', highlight: true, type: 'requirement' }
            ],
            stats: {
              totalLevels: 7,
              maxReward: 200,
              minReward: 150
            }
          },
          {
            id: 'daily_rewards',
            icon: '🎁',
            title: 'Ежедневные награды',
            category: 'rewards',
            badge: 'POPULAR',
            badgeColor: 'orange',
            priority: 'medium',
            content: [
              { text: 'Заходите каждый день для получения бонусов', highlight: false },
              { text: 'Награды растут с каждым днем недели', highlight: true, type: 'progressive' },
              { text: 'День 1: 1 NDN', highlight: true, value: '1 NDN', type: 'reward' },
              { text: 'День 2: 2 NDN', highlight: true, value: '2 NDN', type: 'reward' },
              { text: 'День 3: 3 NDN', highlight: true, value: '3 NDN', type: 'reward' },
              { text: 'День 4: 5 NDN', highlight: true, value: '5 NDN', type: 'reward' },
              { text: 'День 5: 8 NDN', highlight: true, value: '8 NDN', type: 'reward' },
              { text: 'День 6: 10 NDN', highlight: true, value: '10 NDN', type: 'reward' },
              { text: 'День 7: 20 NDN (бонусный день!)', highlight: true, value: '20 NDN', type: 'bonus' },
              { text: 'Награды сбрасываются каждую неделю', highlight: false },
              { text: 'Получайте XP за каждую награду', highlight: true, value: '+10 XP', type: 'xp' }
            ],
            rewardsTable: [
              { day: 1, amount: 1 },
              { day: 2, amount: 2 },
              { day: 3, amount: 3 },
              { day: 4, amount: 5 },
              { day: 5, amount: 8 },
              { day: 6, amount: 10 },
              { day: 7, amount: 20, bonus: true }
            ],
            totalWeekReward: 49
          },
          {
            id: 'miner_game',
            icon: '⛏️',
            title: 'Игра Miner',
            content: [
              'Покупайте майнеры и зарабатывайте Gas',
              'Стартовый Gas: 100 (для новых пользователей)',
              'Первый майнер (CPU Miner) доступен сразу',
              'Остальные открываются по уровню игрока',
              'Майнеры работают в фоновом режиме',
              'Собирайте накопленный Gas регулярно',
              'Используйте Gas для покупки новых майнеров',
              'Повышайте уровень для доступа к новым майнерам'
            ]
          },
          {
            id: 'buying_ndn',
            icon: '💰',
            title: 'Покупка NDN',
            category: 'trading',
            priority: 'medium',
            content: [
              { text: 'Покупайте NDN за Telegram Stars', highlight: false },
              { text: 'Курс: 1 NDN = 1 Telegram Star', highlight: true, value: '1:1', type: 'rate' },
              { text: 'Минимальная покупка: 2 NDN', highlight: true, value: '2 NDN', type: 'limit', limitType: 'min' },
              { text: 'Максимальная покупка: 100,000 NDN за раз', highlight: true, value: '100,000 NDN', type: 'limit', limitType: 'max' },
              { text: 'Баланс обновляется автоматически', highlight: true, type: 'auto' },
              { text: 'Все транзакции записываются в историю', highlight: false }
            ]
          },
          {
            id: 'withdrawal',
            icon: '💸',
            title: 'Вывод средств',
            category: 'trading',
            badge: 'INFO',
            badgeColor: 'blue',
            priority: 'medium',
            content: [
              { text: 'Выводите NDN обратно в Telegram Stars', highlight: false },
              { text: 'Минимальная сумма вывода: 500 Stars', highlight: true, value: '500 Stars', type: 'limit', limitType: 'min', important: true },
              { text: 'Вывод доступен через 21 день после последнего ввода', highlight: true, value: '21 день', type: 'time', important: true },
              { text: 'Соблюдение правил Telegram обязательны', highlight: true, type: 'requirement' },
              { text: 'Заявки на вывод создаются в системе', highlight: false },
              { text: 'Менеджер проверяет и обрабатывает заявки', highlight: false },
              { text: 'Срок обработки: до 3 рабочих дней', highlight: true, value: '3 дня', type: 'time' }
            ]
          },
          {
            id: 'levels_progress',
            icon: '📈',
            title: 'Уровни и прогресс',
            content: [
              'Получайте XP за различные действия',
              'Ежедневные награды: +10 XP',
              'Покупка майнеров: +25 XP',
              'Достижение уровня открывает новые возможности',
              'Уровень = XP / (уровень × 100)',
              'Повышайте уровень для разблокировки контента'
            ]
          },
          {
            id: 'achievements',
            icon: '🏆',
            title: 'Достижения',
            content: [
              'Открывайте достижения за выполнение заданий',
              'Категории: торговля, рефералы, социальные',
              'Отслеживайте прогресс в реальном времени',
              'Получайте награды за выполнение достижений',
              'Соревнуйтесь с другими игроками'
            ]
          },
          {
            id: 'shops',
            icon: '🏪',
            title: 'Магазины',
            content: [
              'Покупайте специальные предметы и бонусы',
              'Разблокируйте магазины по достижению уровней',
              'Используйте NDN для покупок',
              'Ограниченные предложения и акции'
            ]
          },
          {
            id: 'important_info',
            icon: '⚠️',
            title: 'Важная информация',
            category: 'rules',
            badge: 'WARNING',
            badgeColor: 'orange',
            priority: 'critical',
            highlight: true,
            content: [
              { text: 'Все операции фиксируются в блокчейне', highlight: true, type: 'security' },
              { text: 'Соблюдайте правила платформы Telegram', highlight: true, type: 'requirement', important: true },
              { text: 'Запрещена торговля аккаунтами', highlight: true, type: 'prohibition', prohibited: true },
              { text: 'Запрещено использование ботов и автоматизации', highlight: true, type: 'prohibition', prohibited: true },
              { text: 'При нарушении правил аккаунт может быть заблокирован', highlight: true, type: 'warning', important: true },
              { text: 'Поддержка доступна через Telegram бота', highlight: false, type: 'support' }
            ]
          }
        ],
        old_format: {
          how_to_play: {
            title: 'Как играть',
            steps: [
              '1. Купите Pro статус за 1000 NDN, чтобы получить возможность приглашать друзей',
              '2. Покупайте NDN за Telegram Stars',
              '3. Приглашайте друзей по реферальной ссылке',
              '4. Получайте награды за Pro рефералов',
              '5. Открывайте достижения и магазины'
            ]
          },
          rewards: {
            title: 'Награды за рефералов',
            levels: [
              '1-й уровень: 200 NDN',
              '2-7 уровни: по 150 NDN'
            ],
            developer_fee: 'Комиссия разработчика: 200 NDN'
          },
          features: {
            title: 'Функции',
            list: [
              '💰 Покупка NDN за Stars',
              '💎 Pro статус',
              '👥 Реферальная система',
              '🏆 Достижения',
              '⛏️ Игра Miner',
              '🏪 Магазины'
            ]
          },
          tips: {
            title: 'Советы',
            list: [
              'Приглашайте активных пользователей',
              'Купите Pro статус для доступа к реферальной системе',
              'Заходите каждый день за ежедневными наградами',
              'Играйте в Miner для дополнительного заработка'
            ]
          }
        }
      },
      en: {
        title: '📚 Complete NodeOn Crypto Guide',
        description: 'Discover all features for maximum NDN earnings!',
        sections: [
          {
            id: 'getting_started',
            icon: '🚀',
            title: 'Getting Started',
            content: [
              'Create an account via Telegram WebApp',
              'Get starting 100 Gas for Miner game',
              'Explore interface and available features',
              'Buy Pro status for 1000 NDN for full access'
            ]
          },
          {
            id: 'pro_status',
            icon: '💎',
            title: 'Pro Status',
            content: [
              'Cost: 1000 NDN',
              'Unlocks access to referral system',
              'Allows inviting friends and earning',
              'Get unique referral link',
              'Access to advanced features and statistics'
            ]
          },
          {
            id: 'referral_system',
            icon: '👥',
            title: 'Referral System',
            content: [
              'Invite friends using your referral link',
              'Earn rewards up to 7 levels deep',
              'Level 1 reward: 200 NDN',
              'Levels 2-7 reward: 150 NDN each',
              'Rewards come automatically when Pro is purchased',
              'Only Pro users can invite friends'
            ]
          },
          {
            id: 'daily_rewards',
            icon: '🎁',
            title: 'Daily Rewards',
            content: [
              'Check in every day to receive bonuses',
              'Rewards increase with each day of the week',
              'Day 1: 1 NDN | Day 2: 2 NDN | Day 3: 3 NDN',
              'Day 4: 5 NDN | Day 5: 8 NDN | Day 6: 10 NDN',
              'Day 7: 20 NDN (bonus day!)',
              'Rewards reset every week',
              'Earn XP for each reward'
            ]
          },
          {
            id: 'miner_game',
            icon: '⛏️',
            title: 'Miner Game',
            content: [
              'Buy miners and earn Gas',
              'Starting Gas: 100 (for new users)',
              'First miner (CPU Miner) available immediately',
              'Others unlock by player level',
              'Miners work in background mode',
              'Collect accumulated Gas regularly',
              'Use Gas to buy new miners',
              'Level up to access new miners'
            ]
          },
          {
            id: 'buying_ndn',
            icon: '💰',
            title: 'Buying NDN',
            content: [
              'Buy NDN with Telegram Stars',
              'Rate: 1 NDN = 1 Telegram Star',
              'Minimum purchase: 2 NDN',
              'Maximum purchase: 100,000 NDN per transaction',
              'Balance updates automatically',
              'All transactions are recorded in history'
            ]
          },
          {
            id: 'withdrawal',
            icon: '💸',
            title: 'Withdrawal',
            content: [
              'Withdraw NDN back to Telegram Stars',
              'Minimum withdrawal: 500 Stars',
              'Withdrawal available 21 days after last deposit',
              'Telegram rules compliance required',
              'Withdrawal requests are created in the system',
              'Manager reviews and processes requests',
              'Processing time: up to 3 business days'
            ]
          },
          {
            id: 'levels_progress',
            icon: '📈',
            title: 'Levels & Progress',
            content: [
              'Earn XP for various actions',
              'Daily rewards: +10 XP',
              'Buying miners: +25 XP',
              'Reaching level unlocks new opportunities',
              'Level = XP / (level × 100)',
              'Level up to unlock content'
            ]
          },
          {
            id: 'achievements',
            icon: '🏆',
            title: 'Achievements',
            content: [
              'Unlock achievements by completing tasks',
              'Categories: trading, referrals, social',
              'Track progress in real-time',
              'Get rewards for completing achievements',
              'Compete with other players'
            ]
          },
          {
            id: 'shops',
            icon: '🏪',
            title: 'Shops',
            content: [
              'Buy special items and bonuses',
              'Unlock shops by reaching levels',
              'Use NDN for purchases',
              'Limited offers and promotions'
            ]
          },
          {
            id: 'important_info',
            icon: '⚠️',
            title: 'Important Information',
            content: [
              'All operations are recorded on blockchain',
              'Follow Telegram platform rules',
              'Account trading is prohibited',
              'Using bots and automation is prohibited',
              'Account may be blocked for rule violations',
              'Support available via Telegram bot'
            ]
          }
        ]
      }
    };

    // Определяем язык из Accept-Language заголовка
    let selectedLang = 'ru';
    if (lang) {
      if (lang.startsWith('en')) selectedLang = 'en';
      else if (lang.startsWith('es')) selectedLang = 'es';
      else if (lang.startsWith('de')) selectedLang = 'de';
      else if (lang.startsWith('fr')) selectedLang = 'fr';
      else if (lang.startsWith('it')) selectedLang = 'it';
      else if (lang.startsWith('pt')) selectedLang = 'pt';
      else if (lang.startsWith('ar')) selectedLang = 'ar';
      else if (lang.startsWith('hi')) selectedLang = 'hi';
      else if (lang.startsWith('ja')) selectedLang = 'ja';
      else if (lang.startsWith('ko')) selectedLang = 'ko';
      else if (lang.startsWith('zh')) selectedLang = 'zh';
    }
    
    // Расширяем правила для других языков (используем переводы, похожие на русский/английский)
    if (!rules[selectedLang]) {
      // Для остальных языков используем английскую версию как основу
      selectedLang = 'en';
    }
    
    const gameRules = rules[selectedLang] || rules.ru;

    res.json({
      success: true,
      rules: gameRules
    });

  } catch (error) {
    console.error('❌ Game rules error:', error);
    console.error('Error stack:', error.stack);
    
    // Возвращаем хотя бы базовую структуру правил даже при ошибке
    try {
      res.status(500).json({ 
        success: false,
        error: 'Failed to get game rules',
        errorMessage: error.message,
        rules: {
          title: 'Правила игры',
          description: 'Ошибка загрузки правил',
          sections: [{
            id: 'error',
            icon: '⚠️',
            title: 'Ошибка загрузки',
            content: [{ text: 'Не удалось загрузить правила. Попробуйте обновить страницу.', highlight: true }]
          }]
        }
      });
    } catch (sendError) {
      console.error('❌ Ошибка отправки ответа об ошибке:', sendError);
      res.status(500).json({ 
        success: false,
        error: 'Failed to get game rules'
      });
    }
  }
});

// Функция для преобразования старого формата правил в новый
function convertOldRulesFormat(oldRules, lang) {
  const sections = [];
  
  // Раздел "Как играть"
  if (oldRules.how_to_play || oldRules.step1) {
    sections.push({
      id: 'getting_started',
      icon: '🚀',
      title: oldRules.how_to_play || 'Getting Started',
      category: 'basics',
      priority: 'high',
      content: [
        oldRules.step1 ? { text: oldRules.step1.replace(/^\d+\.\s*/, ''), highlight: false } : null,
        oldRules.step2 ? { text: oldRules.step2.replace(/^\d+\.\s*/, ''), highlight: false } : null,
        oldRules.step3 ? { text: oldRules.step3.replace(/^\d+\.\s*/, ''), highlight: false } : null,
        oldRules.step4 ? { text: oldRules.step4.replace(/^\d+\.\s*/, ''), highlight: false } : null,
      ].filter(Boolean)
    });
  }
  
  // Раздел "Награды"
  if (oldRules.rewards || oldRules.level1) {
    sections.push({
      id: 'referral_rewards',
      icon: '💰',
      title: oldRules.rewards || 'Rewards',
      category: 'earnings',
      priority: 'high',
      content: [
        oldRules.level1 ? { text: oldRules.level1, highlight: true, value: oldRules.level1.match(/\d+/)?.[0] + ' NDN', type: 'reward' } : null,
        oldRules.level2_7 ? { text: oldRules.level2_7, highlight: true, value: oldRules.level2_7.match(/\d+/)?.[0] + ' NDN', type: 'reward' } : null,
        oldRules.developer_fee ? { text: oldRules.developer_fee, highlight: true, type: 'info' } : null,
      ].filter(Boolean)
    });
  }
  
  return sections;
}

// ==================== НОВЫЕ ENDPOINTS ====================

// GET /api/game/boosts - Получение списка бустов
router.get('/boosts', async (req, res) => {
  try {
    console.log('🚀 Getting boosts');

    const boosts = [
      {
        id: 'speed_boost',
        name: '⚡ Турбо-режим',
        description: 'x2 скорость майнинга на 1 час',
        cost: 500, // Gas, не NDN!
        costType: 'gas',
        duration: 3600000, // 1 час в миллисекундах
        effect: { speedMultiplier: 2 },
        icon: '⚡'
      },
      {
        id: 'energy_boost',
        name: '🔋 Энергия+',
        description: 'Бесконечная энергия на 30 минут',
        cost: 300,
        costType: 'gas',
        duration: 1800000, // 30 минут
        effect: { infiniteEnergy: true },
        icon: '🔋'
      },
      {
        id: 'mega_boost',
        name: '💎 Мега-буст',
        description: 'x3 скорость + бесплатная энергия на 15 минут',
        cost: 800,
        costType: 'gas',
        duration: 900000, // 15 минут
        effect: { speedMultiplier: 3, infiniteEnergy: true },
        icon: '💎'
      },
      {
        id: 'lucky_boost',
        name: '🍀 Удача',
        description: 'x2 награды от событий на 2 часа',
        cost: 400,
        costType: 'gas',
        duration: 7200000, // 2 часа
        effect: { luckMultiplier: 2 },
        icon: '🍀'
      }
    ];

    res.json({
      success: true,
      boosts: boosts
    });

  } catch (error) {
    console.error('Boosts error:', error);
    res.status(500).json({ error: 'Failed to get boosts' });
  }
});

// POST /api/game/buy-boost - Покупка буста
router.post('/buy-boost', async (req, res) => {
  try {
    const { telegram_id, boost_id } = req.body;
    
    console.log(`🚀 Buying boost: ${boost_id} for user: ${telegram_id}`);

    if (!telegram_id || !boost_id) {
      return res.status(400).json({ 
        success: false, 
        error: 'Missing telegram_id or boost_id' 
      });
    }

    // TODO: Реализовать покупку и активацию буста
    // Это будет связано с майнером и нужно списать Gas

    res.json({
      success: true,
      message: 'Буст активирован!',
      boost_id: boost_id,
      expires_at: Date.now() + 3600000 // Пример
    });

  } catch (error) {
    console.error('Buy boost error:', error);
    res.status(500).json({ error: 'Failed to buy boost' });
  }
});

// GET /api/game/daily-quests - Получение ежедневных квестов
router.get('/daily-quests', async (req, res) => {
  try {
    console.log('🎯 Getting daily quests');

    const dailyQuests = [
      {
        id: 'daily_mining',
        title: '⛏️ Дневной майнинг',
        description: 'Намайнить 500 Gas',
        reward: 1, // NDN
        progress: 0,
        target: 500,
        type: 'mining',
        completed: false
      },
      {
        id: 'daily_login_morning',
        title: '🌅 Утренний визит',
        description: 'Войти в приложение утром (6:00-12:00)',
        reward: 1,
        progress: 0,
        target: 1,
        type: 'time',
        completed: false
      },
      {
        id: 'daily_energy',
        title: '⚡ Энергичный день',
        description: 'Использовать 50 энергии',
        reward: 1,
        progress: 0,
        target: 50,
        type: 'energy',
        completed: false
      },
      {
        id: 'daily_upgrade',
        title: '⬆️ Улучшение',
        description: 'Купить любое улучшение',
        reward: 1,
        progress: 0,
        target: 1,
        type: 'upgrade',
        completed: false
      }
    ];

    res.json({
      success: true,
      quests: dailyQuests,
      total_reward: 4 // NDN за все квесты дня
    });

  } catch (error) {
    console.error('Daily quests error:', error);
    res.status(500).json({ error: 'Failed to get daily quests' });
  }
});

// GET /api/game/weekly-quests - Получение недельных квестов
router.get('/weekly-quests', async (req, res) => {
  try {
    console.log('📅 Getting weekly quests');

    const weeklyQuests = [
      {
        id: 'weekly_streak',
        title: '🔥 Недельная серия',
        description: 'Войти в приложение 7 дней подряд',
        reward: 5,
        progress: 0,
        target: 7,
        type: 'streak',
        completed: false
      },
      {
        id: 'weekly_gas',
        title: '💎 Недельный майнинг',
        description: 'Намайнить 5000 Gas за неделю',
        reward: 0, // Убрано для баланса
        progress: 0,
        target: 5000,
        type: 'mining',
        completed: false
      },
      {
        id: 'weekly_referral',
        title: '👥 Приглашение',
        description: 'Пригласить 2 друзей',
        reward: 4,
        progress: 0,
        target: 2,
        type: 'referral',
        completed: false
      }
    ];

    res.json({
      success: true,
      quests: weeklyQuests,
      total_reward: 9 // NDN за все квесты недели
    });

  } catch (error) {
    console.error('Weekly quests error:', error);
    res.status(500).json({ error: 'Failed to get weekly quests' });
  }
});

// POST /api/game/claim-quest - Получение награды за квест
router.post('/claim-quest', async (req, res) => {
  try {
    const { telegram_id, quest_id } = req.body;
    
    console.log(`🎯 Claiming quest: ${quest_id} for user: ${telegram_id}`);

    if (!telegram_id || !quest_id) {
      return res.status(400).json({ 
        success: false, 
        error: 'Missing telegram_id or quest_id' 
      });
    }

    // TODO: Проверить выполнение квеста и выдать награду

    res.json({
      success: true,
      message: 'Квест выполнен!',
      reward: 1, // NDN
      quest_id: quest_id
    });

  } catch (error) {
    console.error('Claim quest error:', error);
    res.status(500).json({ error: 'Failed to claim quest' });
  }
});

// POST /api/game/spin-wheel - Крутить колесо фортуны
router.post('/spin-wheel', async (req, res) => {
  try {
    const { telegram_id } = req.body;
    
    console.log(`🎲 Spinning wheel for user: ${telegram_id}`);

    if (!telegram_id) {
      return res.status(400).json({ 
        success: false, 
        error: 'Missing telegram_id' 
      });
    }

    // Проверяем, крутил ли пользователь колесо сегодня
    const today = new Date().toISOString().split('T')[0];
    // TODO: Проверить в БД

    // Призы с вероятностями
    const prizes = [
      { icon: '🎯', reward: 1, chance: 0.40, label: '1 NDN' },
      { icon: '💎', reward: 2, chance: 0.30, label: '2 NDN' },
      { icon: '⚡', reward: 3, chance: 0.15, label: '3 NDN' },
      { icon: '🎁', reward: 5, chance: 0.10, label: '5 NDN' },
      { icon: '🏆', reward: 10, chance: 0.04, label: '10 NDN' },
      { icon: '👑', reward: 20, chance: 0.01, label: '20 NDN' }
    ];

    // Определяем приз по вероятности
    const random = Math.random();
    let cumulative = 0;
    let won = prizes[0];

    for (const prize of prizes) {
      cumulative += prize.chance;
      if (random <= cumulative) {
        won = prize;
        break;
      }
    }

    console.log(`🎉 User won: ${won.label}`);

    // TODO: Выдать награду пользователю в БД

    res.json({
      success: true,
      prize: won,
      message: `Поздравляем! Вы выиграли ${won.label}!`,
      next_spin: Date.now() + 86400000 // Следующее через 24 часа
    });

  } catch (error) {
    console.error('Spin wheel error:', error);
    res.status(500).json({ error: 'Failed to spin wheel' });
  }
});

// GET /api/game/ranks - Получение системы рангов
router.get('/ranks', async (req, res) => {
  try {
    console.log('🏅 Getting ranks');

    const ranks = [
      { level: 1, title: '🌱 Новичок', bonus: 0, description: 'Начало пути' },
      { level: 5, title: '⭐ Игрок', bonus: 0.05, description: '+5% к майнингу Gas' },
      { level: 10, title: '💫 Продвинутый', bonus: 0.10, description: '+10% к майнингу Gas' },
      { level: 15, title: '🎖️ Эксперт', bonus: 0.15, description: '+15% к майнингу Gas' },
      { level: 20, title: '👑 Мастер', bonus: 0.20, description: '+20% к майнингу Gas' },
      { level: 30, title: '💎 Легенда', bonus: 0.30, description: '+30% к майнингу Gas' },
      { level: 50, title: '🏆 Чемпион', bonus: 0.50, description: '+50% к майнингу Gas' }
    ];

    res.json({
      success: true,
      ranks: ranks
    });

  } catch (error) {
    console.error('Ranks error:', error);
    res.status(500).json({ error: 'Failed to get ranks' });
  }
});

module.exports = router;
