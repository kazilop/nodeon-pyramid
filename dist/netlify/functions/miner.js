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
          'Access-Control-Allow-Headers': 'Content-Type',
          'Access-Control-Allow-Methods': 'GET, POST, OPTIONS'
        }
      };
    }
    
    // Маршрутизация майнера
    if (httpMethod === 'GET' && path.includes('/data/')) {
      return await handleGetMinerData(event, context);
    }
    
    if (httpMethod === 'POST' && path.includes('/buy-farm')) {
      return await handleBuyFarm(event, context);
    }
    
    if (httpMethod === 'POST' && path.includes('/buy-premium-farm')) {
      return await handleBuyPremiumFarm(event, context);
    }
    
    if (httpMethod === 'POST' && path.includes('/save-state')) {
      return await handleSaveState(event, context);
    }
    
    if (httpMethod === 'POST' && path.includes('/save-gas')) {
      return await handleSaveGas(event, context);
    }
    
    if (httpMethod === 'GET' && path.includes('/leaderboard')) {
      return await handleGetLeaderboard(event, context);
    }
    
    if (httpMethod === 'GET' && path.includes('/stats/')) {
      return await handleGetStats(event, context);
    }
    
    if (httpMethod === 'GET' && path.includes('/check-tables')) {
      return await handleCheckTables(event, context);
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
    console.error('Miner error:', error);
    
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

async function handleGetMinerData(event, context) {
  try {
    const userId = event.path.split('/').pop();
    
    if (!userId) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ error: 'User ID is required' })
      };
    }
    
    // Получаем данные майнера из Supabase
    const minerData = await getMinerDataFromSupabase(userId);
    
    if (!minerData) {
      // Создаем начальные данные
      const initialData = createInitialMinerData();
      await saveMinerDataToSupabase(userId, initialData);
      
      return {
        statusCode: 200,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({
          success: true,
          miner_data: initialData
        })
      };
    }
    
    // Рассчитываем оффлайн заработок
    const updatedData = calculateOfflineEarnings(minerData);
    
    // Сохраняем обновленные данные обратно в базу
    await saveMinerDataToSupabase(userId, updatedData);
    
    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({
        success: true,
        miner_data: updatedData
      })
    };
    
  } catch (error) {
    console.error('GetMinerData error:', error);
    
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Failed to get miner data' })
    };
  }
}

async function handleBuyFarm(event, context) {
  try {
    const { user_id, farm_type } = JSON.parse(body || '{}');
    
    if (!user_id || !farm_type) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ error: 'user_id and farm_type are required' })
      };
    }
    
    // Получаем данные пользователя и майнера
    const user = await getUserFromSupabase(user_id);
    const minerData = await getMinerDataFromSupabase(user_id);
    
    if (!user || !minerData) {
      return {
        statusCode: 404,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ error: 'User or miner data not found' })
      };
    }
    
    // Логика покупки фермы
    const farmCost = getFarmCost(farm_type);
    
    if (minerData.ndnGas < farmCost) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ error: 'Insufficient NDN Gas' })
      };
    }
    
    // Обновляем данные
    minerData.ndnGas -= farmCost;
    minerData.farms = minerData.farms || [];
    minerData.farms.push({
      type: farm_type,
      level: 1,
      purchased_at: Date.now()
    });
    
    // Сохраняем в Supabase
    await saveMinerDataToSupabase(user_id, minerData);
    
    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({
        success: true,
        miner_data: minerData
      })
    };
    
  } catch (error) {
    console.error('BuyFarm error:', error);
    
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Failed to buy farm' })
    };
  }
}

async function handleBuyPremiumFarm(event, context) {
  try {
    const { user_id, farm_type } = JSON.parse(body || '{}');
    
    if (!user_id || !farm_type) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ error: 'user_id and farm_type are required' })
      };
    }
    
    // Получаем данные пользователя
    const user = await getUserFromSupabase(user_id);
    
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
    
    const farmCost = getPremiumFarmCost(farm_type);
    
    if (user.balance_ndn < farmCost) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ error: 'Insufficient NDN balance' })
      };
    }
    
    // Обновляем баланс пользователя
    user.balance_ndn -= farmCost;
    await updateUserInSupabase(user);
    
    // Добавляем ферму в майнер
    const minerData = await getMinerDataFromSupabase(user_id);
    minerData.farms = minerData.farms || [];
    minerData.farms.push({
      type: farm_type,
      level: 1,
      purchased_at: Date.now(),
      premium: true
    });
    
    await saveMinerDataToSupabase(user_id, minerData);
    
    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({
        success: true,
        miner_data: minerData
      })
    };
    
  } catch (error) {
    console.error('BuyPremiumFarm error:', error);
    
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Failed to buy premium farm' })
    };
  }
}

async function handleSaveState(event, context) {
  try {
    const { user_id, miner_data } = JSON.parse(body || '{}');
    
    if (!user_id || !miner_data) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ error: 'user_id and miner_data are required' })
      };
    }
    
    // Сохраняем состояние майнера
    await saveMinerDataToSupabase(user_id, miner_data);
    
    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({
        success: true,
        message: 'Miner state saved successfully'
      })
    };
    
  } catch (error) {
    console.error('SaveState error:', error);
    
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Failed to save miner state' })
    };
  }
}

async function handleSaveGas(event, context) {
  try {
    const { user_id, ndnGas, totalGasEarned } = JSON.parse(body || '{}');
    
    if (!user_id || ndnGas === undefined) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ error: 'user_id and ndnGas are required' })
      };
    }
    
    // Получаем текущие данные майнера
    const minerData = await getMinerDataFromSupabase(user_id);
    
    if (!minerData) {
      return {
        statusCode: 404,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ error: 'Miner data not found' })
      };
    }
    
    // Проверяем на читерство (максимальное увеличение +10000 Gas)
    const gasIncrease = ndnGas - (minerData.ndnGas || 0);
    if (gasIncrease > 10000) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ error: 'Suspicious gas increase detected' })
      };
    }
    
    // Обновляем данные
    minerData.ndnGas = ndnGas;
    if (totalGasEarned !== undefined) {
      minerData.totalGasEarned = totalGasEarned;
    }
    minerData.lastUpdate = Date.now();
    
    // Сохраняем в Supabase
    await saveMinerDataToSupabase(user_id, minerData);
    
    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({
        success: true,
        message: 'Gas saved successfully'
      })
    };
    
  } catch (error) {
    console.error('SaveGas error:', error);
    
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Failed to save gas' })
    };
  }
}

async function handleGetLeaderboard(event, context) {
  try {
    // Получаем лидерборд из Supabase
    const leaderboard = await getLeaderboardFromSupabase();
    
    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({
        success: true,
        leaderboard: leaderboard
      })
    };
    
  } catch (error) {
    console.error('GetLeaderboard error:', error);
    
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Failed to get leaderboard' })
    };
  }
}

async function handleGetStats(event, context) {
  try {
    const userId = event.path.split('/').pop();
    
    if (!userId) {
      return {
        statusCode: 400,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({ error: 'User ID is required' })
      };
    }
    
    // Получаем статистику пользователя
    const stats = await getUserStatsFromSupabase(userId);
    
    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({
        success: true,
        stats: stats
      })
    };
    
  } catch (error) {
    console.error('GetStats error:', error);
    
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Failed to get user stats' })
    };
  }
}

async function handleCheckTables(event, context) {
  try {
    // Проверяем существование таблиц в Supabase
    const tablesStatus = await checkSupabaseTables();
    
    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({
        success: true,
        tables: tablesStatus
      })
    };
    
  } catch (error) {
    console.error('CheckTables error:', error);
    
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Failed to check tables' })
    };
  }
}

// Вспомогательные функции
function createInitialMinerData() {
  return {
    ndnGas: 100,
    energy: 100,
    maxEnergy: 100,
    gasPerMinute: 0,
    farms: [],
    upgrades: {
      speed: 0,
      efficiency: 0,
      automation: 0
    },
    totalGasEarned: 100,
    lastEnergyRefill: Date.now(),
    energyRefillCooldown: 3 * 60 * 60 * 1000,
    lastUpdate: Date.now()
  };
}

function calculateOfflineEarnings(minerData) {
  const now = Date.now();
  const lastUpdate = minerData.lastUpdate || now;
  const timeDiff = now - lastUpdate;
  
  // Максимальное время оффлайн - 7 дней
  const maxOfflineTime = 7 * 24 * 60 * 60 * 1000;
  const actualTimeDiff = Math.min(timeDiff, maxOfflineTime);
  
  // Рассчитываем заработок (упрощенная формула)
  const gasPerMinute = minerData.gasPerMinute || 0;
  const offlineEarnings = (gasPerMinute * actualTimeDiff) / (1000 * 60);
  
  if (offlineEarnings > 0) {
    minerData.ndnGas = (minerData.ndnGas || 100) + offlineEarnings;
    minerData.totalGasEarned = (minerData.totalGasEarned || 100) + offlineEarnings;
  }
  
  minerData.lastUpdate = now;
  
  return minerData;
}

function getFarmCost(farmType) {
  const costs = {
    'cpu_miner': 50,
    'gpu_farm': 250,
    'asic_rig': 1000,
    'data_center': 5000
  };
  return costs[farmType] || 50;
}

function getPremiumFarmCost(farmType) {
  const costs = {
    'golden_farm': 1000,
    'diamond_farm': 5000,
    'quantum_farm': 10000
  };
  return costs[farmType] || 1000;
}

// Функции для работы с Supabase
async function getMinerDataFromSupabase(userId) {
  try {
    console.log(`🔍 Поиск данных майнера для user_id: ${userId}`);
    
    // Сначала получаем пользователя по telegram_id
    const user = await getUserFromSupabase(userId);
    if (!user) {
      console.log(`❌ Пользователь с telegram_id ${userId} не найден`);
      return null;
    }
    
    console.log(`✅ Пользователь найден в БД: ID=${user.id}, telegram_id=${user.telegram_id}`);
    
    const url = `${SUPABASE_URL}/rest/v1/nodeon_miner_data?user_id=eq.${user.id}&select=*`;
    const headers = {
      "apikey": SUPABASE_ANON_KEY,
      "Authorization": `Bearer ${SUPABASE_ANON_KEY}`,
      "Content-Type": "application/json"
    };
    
    const response = await fetch(url, { headers });
    console.log(`📡 Запрос к БД: ${url}`);
    console.log(`📊 Статус ответа: ${response.status}`);
    
    if (response.ok) {
      const data = await response.json();
      console.log(`📋 Получено записей: ${data ? data.length : 0}`);
      
      if (data && data.length > 0) {
        const minerRecord = data[0];
        console.log(`📄 Запись майнера:`, minerRecord);
        
        if (minerRecord.miner_data) {
          const parsedData = JSON.parse(minerRecord.miner_data);
          console.log(`✅ Данные майнера успешно загружены:`, parsedData);
          return parsedData;
        } else {
          console.log("⚠️ Поле miner_data пустое");
        }
      } else {
        console.log("⚠️ Записи майнера не найдены");
      }
    } else {
      console.log(`❌ Ошибка запроса к БД: ${response.status} - ${await response.text()}`);
    }
    
    return null;
  } catch (error) {
    console.error('Error getting miner data from Supabase:', error);
    return null;
  }
}

async function saveMinerDataToSupabase(userId, minerData) {
  try {
    console.log(`💾 Сохранение данных майнера для user_id: ${userId}`);
    
    // Получаем пользователя
    const user = await getUserFromSupabase(userId);
    if (!user) {
      console.log(`❌ Пользователь с telegram_id ${userId} не найден`);
      return false;
    }
    
    const url = `${SUPABASE_URL}/rest/v1/nodeon_miner_data`;
    const headers = {
      "apikey": SUPABASE_ANON_KEY,
      "Authorization": `Bearer ${SUPABASE_ANON_KEY}`,
      "Content-Type": "application/json"
    };
    
    const data = {
      user_id: user.id,
      miner_data: JSON.stringify(minerData),
      updated_at: new Date().toISOString()
    };
    
    // Проверяем, существует ли запись
    const checkUrl = `${SUPABASE_URL}/rest/v1/nodeon_miner_data?user_id=eq.${user.id}`;
    const checkResponse = await fetch(checkUrl, { headers });
    
    if (checkResponse.ok) {
      const existingData = await checkResponse.json();
      
      if (existingData && existingData.length > 0) {
        // Обновляем существующую запись
        const updateUrl = `${SUPABASE_URL}/rest/v1/nodeon_miner_data?user_id=eq.${user.id}`;
        const updateResponse = await fetch(updateUrl, {
          method: 'PATCH',
          headers: headers,
          body: JSON.stringify(data)
        });
        
        if (updateResponse.ok) {
          console.log(`✅ Данные майнера обновлены для пользователя ${user.id}`);
          return true;
        } else {
          console.log(`❌ Ошибка обновления: ${updateResponse.status}`);
          return false;
        }
      } else {
        // Создаем новую запись
        const createResponse = await fetch(url, {
          method: 'POST',
          headers: headers,
          body: JSON.stringify(data)
        });
        
        if (createResponse.ok) {
          console.log(`✅ Данные майнера созданы для пользователя ${user.id}`);
          return true;
        } else {
          console.log(`❌ Ошибка создания: ${createResponse.status}`);
          return false;
        }
      }
    }
    
    return false;
  } catch (error) {
    console.error('Error saving miner data to Supabase:', error);
    return false;
  }
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

async function updateUserInSupabase(user) {
  // Здесь будет обновление пользователя в Supabase
  console.log('Updating user:', user.id);
}

async function getLeaderboardFromSupabase() {
  // Здесь будет запрос лидерборда из Supabase
  return [
    { rank: 1, player: 'Player1', gasEarned: 10000, farms: 5, level: 10 },
    { rank: 2, player: 'Player2', gasEarned: 8000, farms: 4, level: 8 },
    { rank: 3, player: 'Player3', gasEarned: 6000, farms: 3, level: 6 }
  ];
}

async function getUserStatsFromSupabase(userId) {
  // Здесь будет запрос статистики пользователя из Supabase
  return {
    totalGasEarned: 1000,
    totalFarms: 2,
    level: 3,
    rank: 10
  };
}

async function checkSupabaseTables() {
  try {
    console.log("🔍 Проверка таблиц в Supabase...");
    
    const tables = [
      "nodeon_users",
      "nodeon_transactions", 
      "nodeon_referral_stats",
      "nodeon_miner_data",
      "nodeon_miner_stats"
    ];
    
    const results = {};
    const headers = {
      "apikey": SUPABASE_ANON_KEY,
      "Authorization": `Bearer ${SUPABASE_ANON_KEY}`,
      "Content-Type": "application/json"
    };
    
    for (const table of tables) {
      try {
        const url = `${SUPABASE_URL}/rest/v1/${table}?select=count`;
        const response = await fetch(url, { headers });
        
        if (response.ok) {
          results[table] = { exists: true, status: "OK" };
          console.log(`✅ ${table} - существует`);
        } else {
          results[table] = { exists: false, status: response.status, error: await response.text() };
          console.log(`❌ ${table} - ошибка ${response.status}`);
        }
      } catch (error) {
        results[table] = { exists: false, status: "ERROR", error: error.message };
        console.log(`❌ ${table} - ошибка: ${error.message}`);
      }
    }
    
    console.log("📊 Результат проверки таблиц:", results);
    return results;
    
  } catch (error) {
    console.error('Error checking Supabase tables:', error);
    return { error: error.message };
  }
}
