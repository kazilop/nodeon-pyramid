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
      const initialData = {
        user_id: user.id,
        gas: 0,
        energy: 100,
        max_energy: 100,
        last_energy_refill: new Date().toISOString(),
        energy_refill_cooldown: 3600000, // 1 час
        total_farms: 0,
        farms: [],
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      };

      const { data: newMiner, error: createError } = await supabase
        .from('nodeon_miner_data')
        .insert(initialData)
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

    // Рассчитываем оффлайн заработок
    const now = new Date();
    const lastUpdate = new Date(miner.updated_at);
    const timeDiff = now - lastUpdate;
    const hoursDiff = timeDiff / (1000 * 60 * 60);

    let newGas = miner.gas;
    let newEnergy = miner.energy;

    if (hoursDiff > 0) {
      // Восстанавливаем энергию
      const energyRecovery = Math.floor(hoursDiff * 10); // 10 энергии в час
      newEnergy = Math.min(miner.max_energy, miner.energy + energyRecovery);

      // Рассчитываем заработок газа
      if (miner.farms && miner.farms.length > 0) {
        const totalProduction = miner.farms.reduce((sum, farm) => {
          return sum + (farm.production || 0);
        }, 0);
        
        const gasEarned = totalProduction * hoursDiff;
        newGas += gasEarned;
      }

      // Обновляем данные в базе
      const { error: updateError } = await supabase
        .from('nodeon_miner_data')
        .update({
          gas: newGas,
          energy: newEnergy,
          updated_at: now.toISOString()
        })
        .eq('user_id', user.id);

      if (updateError) {
        console.error('Update miner error:', updateError);
      }
    }

    res.json({
      success: true,
      miner: {
        gas: newGas,
        energy: newEnergy,
        max_energy: miner.max_energy,
        last_energy_refill: miner.last_energy_refill,
        energy_refill_cooldown: miner.energy_refill_cooldown,
        total_farms: miner.total_farms,
        farms: miner.farms || []
      }
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

    // Определяем стоимость и характеристики фермы
    const farmConfigs = {
      basic: { cost: 50, production: 1, name: 'Basic Farm' },
      advanced: { cost: 200, production: 5, name: 'Advanced Farm' },
      premium: { cost: 500, production: 15, name: 'Premium Farm' }
    };

    const farmConfig = farmConfigs[farm_type];
    if (!farmConfig) {
      return res.status(400).json({ 
        success: false, 
        error: 'Invalid farm type' 
      });
    }

    // Проверяем баланс
    if (user.balance_ndn < farmConfig.cost) {
      return res.status(400).json({ 
        success: false, 
        error: 'Insufficient balance' 
      });
    }

    // Создаем новую ферму
    const newFarm = {
      id: Date.now(),
      type: farm_type,
      name: farmConfig.name,
      cost: farmConfig.cost,
      production: farmConfig.production,
      purchased_at: new Date().toISOString()
    };

    // Обновляем данные
    const farms = [...(minerData.farms || []), newFarm];
    const newBalance = user.balance_ndn - farmConfig.cost;

    // Обновляем баланс пользователя
    const { error: balanceError } = await supabase
      .from('nodeon_users')
      .update({ balance_ndn: newBalance })
      .eq('id', user.id);

    if (balanceError) {
      console.error('Balance update error:', balanceError);
      return res.status(500).json({ error: 'Failed to update balance' });
    }

    // Обновляем данные майнера
    const { error: minerUpdateError } = await supabase
      .from('nodeon_miner_data')
      .update({
        farms: farms,
        total_farms: farms.length,
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
      new_balance: newBalance
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
    
    console.log(`💾 Saving miner state for user: ${telegram_id}`);

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
    const { error: updateError } = await supabase
      .from('nodeon_miner_data')
      .update({
        gas: miner_data.gas,
        energy: miner_data.energy,
        farms: miner_data.farms,
        total_farms: miner_data.total_farms,
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

module.exports = router;












