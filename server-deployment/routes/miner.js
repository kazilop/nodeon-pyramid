const express = require('express');
const { createClient } = require('@supabase/supabase-js');
const router = express.Router();

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_ANON_KEY
);

// GET /api/miner/data/:telegram_id - Получение данных майнера
router.get('/data/:telegram_id', async (req, res) => {
  try {
    const { telegram_id } = req.params;
    
    console.log(`⛏️ Getting miner data for user: ${telegram_id}`);

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

        let miner;
        if (minerError && minerError.code === 'PGRST116') {
          // Создаем начальные данные майнера
          const initialMinerData = {
            ndnGas: 100, // Стартовый Gas для покупки первой фермы
            energy: 100,
            maxEnergy: 100,
            gasPerMinute: 0,
            farms: [],
            upgrades: { speed: 0, efficiency: 0, automation: 0 },
            totalGasEarned: 0,
            lastEnergyRefill: Date.now(),
            lastUpdate: Date.now()
          };

          const { data: newMiner, error: createError } = await supabase
            .from('nodeon_miner_data')
            .insert({
              user_id: user.id,
              miner_data: JSON.stringify(initialMinerData),
              created_at: new Date().toISOString(),
              updated_at: new Date().toISOString()
            })
            .select()
            .single();

          if (createError) {
            console.error('Create miner error:', createError);
            return res.status(500).json({ error: 'Failed to create miner data' });
          }

          miner = newMiner;
        } else if (minerError) {
          console.error('Miner fetch error:', minerError);
          return res.status(500).json({ error: 'Failed to fetch miner data' });
        } else {
          miner = minerData;
        }

        // Парсим данные майнера из JSON
        let parsedMinerData;
        try {
          parsedMinerData = JSON.parse(miner.miner_data);
        } catch (error) {
          console.error('Error parsing miner data:', error);
          parsedMinerData = {
            ndnGas: parsedMinerData.ndnGas || 100, // Если нет данных, даем стартовый Gas
            energy: 100,
            maxEnergy: 100,
            gasPerMinute: 0,
            farms: [],
            upgrades: { speed: 0, efficiency: 0, automation: 0 },
            totalGasEarned: 0,
            lastEnergyRefill: Date.now(),
            lastUpdate: Date.now()
          };
        }

        // Рассчитываем оффлайн заработок
        const now = Date.now();
        const lastUpdate = parsedMinerData.lastUpdate || now;
        const timeDiff = now - lastUpdate;
        const hoursDiff = timeDiff / (1000 * 60 * 60);

        let newGas = parsedMinerData.ndnGas || 0;
        let newEnergy = parsedMinerData.energy || 100;

        if (hoursDiff > 0) {
          // Восстанавливаем энергию
          const energyRecovery = Math.floor(hoursDiff * 10); // 10 энергии в час
          newEnergy = Math.min(parsedMinerData.maxEnergy || 100, newEnergy + energyRecovery);

          // Рассчитываем заработок газа
          if (parsedMinerData.farms && parsedMinerData.farms.length > 0) {
            const totalProduction = parsedMinerData.farms.reduce((sum, farm) => {
              return sum + (farm.production || 1); // Базовая продукция
            }, 0);
            
            const gasEarned = totalProduction * hoursDiff;
            newGas += gasEarned;
          }

          // Обновляем данные в базе
          const updatedMinerData = {
            ...parsedMinerData,
            ndnGas: newGas,
            energy: newEnergy,
            lastUpdate: now
          };

          const { error: updateError } = await supabase
            .from('nodeon_miner_data')
            .update({
              miner_data: JSON.stringify(updatedMinerData),
              updated_at: new Date().toISOString()
            })
            .eq('user_id', user.id);

          if (updateError) {
            console.error('Update miner error:', updateError);
          }
        }

        // Возвращаем обновленные данные майнера
        const updatedMinerData = {
          ...parsedMinerData,
          ndnGas: newGas,
          energy: newEnergy,
          lastUpdate: now
        };

        res.json({
          success: true,
          miner_data: updatedMinerData
        });

  } catch (error) {
    console.error('Miner data error:', error);
    res.status(500).json({ error: 'Failed to get miner data' });
  }
});

// POST /api/miner/buy-farm - Покупка фермы
router.post('/buy-farm', async (req, res) => {
  try {
    const { telegram_id, farm_type } = req.body;
    
    console.log(`🏭 Buying farm for user: ${telegram_id}, type: ${farm_type}`);

    if (!telegram_id || !farm_type) {
      return res.status(400).json({ 
        success: false, 
        error: 'Missing required fields' 
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

        // Получаем данные майнера
        const { data: minerData, error: minerError } = await supabase
          .from('nodeon_miner_data')
          .select('*')
          .eq('user_id', user.id)
          .single();

        if (minerError) {
          console.error('Miner fetch error:', minerError);
          return res.status(500).json({ error: 'Failed to fetch miner data' });
        }

        // Парсим данные майнера из JSON
        let miner;
        try {
          miner = JSON.parse(minerData.miner_data);
        } catch (error) {
          console.error('Error parsing miner data:', error);
          miner = {
            ndnGas: 0,
            energy: 100,
            maxEnergy: 100,
            gasPerMinute: 0,
            farms: [],
            upgrades: { speed: 0, efficiency: 0, automation: 0 },
            totalGasEarned: 0,
            lastEnergyRefill: Date.now(),
            lastUpdate: Date.now()
          };
        }

    // Определяем стоимость и характеристики фермы
    const farmConfigs = {
      // Базовые майнеры
      cpu_miner: { cost: 50, production: 1, name: 'CPU Miner', gasPerMinute: 1, energyCost: 1, unlockLevel: 1 },
      solar_farm: { cost: 150, production: 4, name: 'Solar Farm', gasPerMinute: 4, energyCost: 0, unlockLevel: 2 },
      gpu_farm: { cost: 250, production: 5, name: 'GPU Farm', gasPerMinute: 5, energyCost: 3, unlockLevel: 3 },
      mining_cluster: { cost: 500, production: 12, name: 'Mining Cluster', gasPerMinute: 12, energyCost: 6, unlockLevel: 4 },
      mining_pool: { cost: 2000, production: 25, name: 'Mining Pool', gasPerMinute: 25, energyCost: 12, unlockLevel: 5 },
      cloud_mining: { cost: 5000, production: 40, name: 'Cloud Mining', gasPerMinute: 40, energyCost: 0, unlockLevel: 6 },
      quantum_computer: { cost: 10000, production: 50, name: 'Quantum Computer', gasPerMinute: 50, energyCost: 10, unlockLevel: 7 },
      nuclear_reactor: { cost: 15000, production: 80, name: 'Nuclear Reactor', gasPerMinute: 80, energyCost: 30, unlockLevel: 8 },
      asic_rig: { cost: 1000, production: 20, name: 'ASIC Rig', gasPerMinute: 20, energyCost: 8, unlockLevel: 5 },
      data_center: { cost: 5000, production: 100, name: 'Data Center', gasPerMinute: 100, energyCost: 25, unlockLevel: 10 },
      
      // Рекламные майнеры (бесплатные)
      ad_miner_1: { cost: 0, production: 3, name: 'Ad Miner (10 min)', gasPerMinute: 3, energyCost: 5, unlockLevel: 0, isTemp: true, duration: 600000 },
      ad_miner_2: { cost: 0, production: 5, name: 'Ad Miner (15 min)', gasPerMinute: 5, energyCost: 8, unlockLevel: 0, isTemp: true, duration: 900000 },
      
      // Старые типы для совместимости
      basic: { cost: 50, production: 1, name: 'Basic Farm', gasPerMinute: 1, energyCost: 1 },
      advanced: { cost: 200, production: 5, name: 'Advanced Farm', gasPerMinute: 5, energyCost: 3 },
      premium: { cost: 500, production: 15, name: 'Premium Farm', gasPerMinute: 15, energyCost: 8 }
    };

    const farmConfig = farmConfigs[farm_type];
    if (!farmConfig) {
      console.error('❌ Invalid farm type:', farm_type);
      console.log('📋 Available types:', Object.keys(farmConfigs));
      return res.status(400).json({ 
        success: false, 
        error: `Invalid farm type: ${farm_type}` 
      });
    }

    // Проверяем баланс Gas (не NDN!)
    if ((miner.ndnGas || 0) < farmConfig.cost) {
      console.error('❌ Insufficient Gas balance:', miner.ndnGas, 'need:', farmConfig.cost);
      return res.status(400).json({ 
        success: false, 
        error: `Insufficient Gas balance. Need: ${farmConfig.cost}, have: ${miner.ndnGas || 0}` 
      });
    }

        // Создаем новую ферму
        const newFarm = {
          type: farm_type,
          level: 1,
          purchased_at: Date.now()
        };

        // Обновляем данные
        const farms = [...(miner.farms || []), newFarm];
        const newGasBalance = (miner.ndnGas || 0) - farmConfig.cost;

        // Обновляем данные майнера (списываем Gas)
        const updatedMinerData = {
          ...miner,
          ndnGas: newGasBalance,
          farms: farms,
          lastUpdate: Date.now()
        };

        const { error: minerUpdateError } = await supabase
          .from('nodeon_miner_data')
          .update({
            miner_data: JSON.stringify(updatedMinerData),
            updated_at: new Date().toISOString()
          })
          .eq('user_id', user.id);

        if (minerUpdateError) {
          console.error('Miner update error:', minerUpdateError);
          return res.status(500).json({ error: 'Failed to update miner data' });
        }

    res.json({
      success: true,
      message: 'Farm purchased successfully',
      farm: newFarm,
      miner_data: updatedMinerData,
      new_gas_balance: newGasBalance
    });

  } catch (error) {
    console.error('Buy farm error:', error);
    res.status(500).json({ error: 'Failed to buy farm' });
  }
});

// POST /api/miner/save-state - Сохранение состояния майнера
router.post('/save-state', async (req, res) => {
  try {
    const { telegram_id, miner_data } = req.body;
    
    console.log(`Saving miner state for user: ${telegram_id}`);

    if (!telegram_id || !miner_data) {
      return res.status(400).json({ 
        success: false, 
        error: 'Missing required fields' 
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

        // Обновляем данные майнера
        const updatedMinerData = {
          ndnGas: miner_data.gas,
          energy: miner_data.energy,
          maxEnergy: miner_data.max_energy || 100,
          gasPerMinute: 0,
          farms: miner_data.farms || [],
          upgrades: { speed: 0, efficiency: 0, automation: 0 },
          totalGasEarned: miner_data.gas || 0,
          lastEnergyRefill: miner_data.last_energy_refill || Date.now(),
          lastUpdate: Date.now()
        };

        const { error: updateError } = await supabase
          .from('nodeon_miner_data')
          .update({
            miner_data: JSON.stringify(updatedMinerData),
            updated_at: new Date().toISOString()
          })
          .eq('user_id', user.id);

    if (updateError) {
      console.error('Save state error:', updateError);
      return res.status(500).json({ error: 'Failed to save miner state' });
    }

    res.json({
      success: true,
      message: 'Miner state saved successfully'
    });

  } catch (error) {
    console.error('Save state error:', error);
    res.status(500).json({ error: 'Failed to save miner state' });
  }
});

// POST /api/miner/activate-ad-miner - Активация Ad Miner после просмотра рекламы
router.post('/activate-ad-miner', async (req, res) => {
  try {
    const { telegram_id, miner_type } = req.body;
    
    console.log(`🎬 Activating ad miner for user: ${telegram_id}, type: ${miner_type}`);
    
    if (!telegram_id || !miner_type) {
      return res.status(400).json({ 
        success: false, 
        error: 'Missing required fields' 
      });
    }

    // Проверяем тип майнера
    if (miner_type !== 'ad_miner_1' && miner_type !== 'ad_miner_2') {
      return res.status(400).json({ 
        success: false, 
        error: 'Invalid miner type' 
      });
    }

    // Получаем данные пользователя
    const { data: user, error: userError } = await supabase
      .from('nodeon_users')
      .select('*')
      .eq('telegram_id', telegram_id)
      .single();

    if (userError || !user) {
      return res.status(404).json({ error: 'User not found' });
    }

    // Получаем данные майнера
    const { data: minerData, error: minerError } = await supabase
      .from('nodeon_miner_data')
      .select('*')
      .eq('user_id', user.id)
      .single();

    if (minerError) {
      return res.status(500).json({ error: 'Failed to fetch miner data' });
    }

    let miner;
    try {
      miner = JSON.parse(minerData.miner_data);
    } catch (error) {
      miner = { farms: [], ndnGas: 0, energy: 100 };
    }

    // Создаем временную ферму
    const duration = miner_type === 'ad_miner_1' ? 10 * 60 * 1000 : 15 * 60 * 1000;
    const production = miner_type === 'ad_miner_1' ? 3 : 5;
    
    const newFarm = {
      type: miner_type,
      level: 1,
      purchased_at: Date.now(),
      expires_at: Date.now() + duration,
      is_temp: true,
      production: production
    };

    // Добавляем ферму
    miner.farms = miner.farms || [];
    miner.farms.push(newFarm);

    // Сохраняем в БД
    const { error } = await supabase
      .from('nodeon_miner_data')
      .update({
        miner_data: JSON.stringify(miner),
        updated_at: new Date().toISOString()
      })
      .eq('user_id', user.id);

    if (error) {
      console.error('Miner update error:', error);
      return res.status(500).json({ error: 'Failed to update miner' });
    }

    res.json({
      success: true,
      message: `Ad Miner активирован на ${duration / 60 / 1000} минут`,
      miner_data: miner,
      farm: newFarm
    });

  } catch (error) {
    console.error('Activate ad miner error:', error);
    res.status(500).json({ error: 'Failed to activate ad miner' });
  }
});

module.exports = router;

