# Интеграция Яндекс.Дзен рекламы

## Введение
Яндекс.Дзен предоставляет Ads API для показа рекламы в мобильных и веб-приложениях.

## Шаги интеграции

### 1. Регистрация в Яндекс.Дзен для разработчиков
1. Перейдите на https://partner.yandex.ru/
2. Создайте аккаунт разработчика
3. Подайте заявку на участие в программе для разработчиков
4. После одобрения получите:
   - App ID
   - Publisher ID
   - Секретный ключ API

### 2. Получение доступа к Ads API
1. Зайдите в Личный кабинет партнера
2. Раздел "Для разработчиков" → "Ads API"
3. Зарегистрируйте приложение
4. Получите:
   - Application ID
   - Application secret

### 3. Типы рекламы Яндекс.Дзен

#### A. Баннерная реклама
- URL: `https://yandex.ru/ads/system/`
- Размеры: 320x50, 300x250, 728x90
- Показ: При загрузке страницы

#### B. Видео-реклама (Rewarded Ads)
- URL: `https://yandex.ru/ads/rewarded/`
- Продолжительность: 15-30 секунд
- Награда: Только после полного просмотра

#### C. Межстраничная реклама (Interstitial)
- URL: `https://yandex.ru/ads/interstitial/`
- Показ: При переходе между экранами

### 4. SDK для веб-приложений

```html
<!-- Подключение Яндекс.Дзен Ads SDK -->
<script src="https://yastatic.net/advads2/ads_sdk.js"></script>

<script>
  // Инициализация SDK
  window.YandexAds.create({
    appId: 'YOUR_APP_ID',
    publisherId: 'YOUR_PUBLISHER_ID'
  }).then(function(ads) {
    // SDK готов к работе
    window.yandexAds = ads;
  });
</script>
```

### 5. Показ рекламы за награду (Rewarded Ads)

```javascript
// Показ рекламы для Ad Miner #1
async function showAdForMiner() {
  try {
    // Проверяем наличие SDK
    if (!window.yandexAds) {
      console.error('Yandex Ads SDK not loaded');
      return;
    }

    // Запрашиваем рекламу
    const ad = await window.yandexAds.createRewardedAd({
      adUnitId: 'YOUR_AD_UNIT_ID',
      onRewarded: (reward) => {
        console.log('Reward:', reward);
        // Активируем Ad Miner #1 на 10 минут
        activateAdMiner('ad_miner_1', 10 * 60 * 1000); // 10 минут в миллисекундах
      },
      onClose: () => {
        console.log('Ad closed');
      },
      onError: (error) => {
        console.error('Ad error:', error);
      }
    });

    // Показываем рекламу
    await ad.show();
  } catch (error) {
    console.error('Error showing ad:', error);
  }
}

// Активация Ad Miner после просмотра рекламы
function activateAdMiner(type, duration) {
  // Добавляем временную ферму в minerData
  const tempFarm = {
    type: type,
    level: 1,
    purchased_at: Date.now(),
    expires_at: Date.now() + duration,
    is_temp: true
  };

  minerData.farms.push(tempFarm);
  
  // Обновляем UI
  updateMinerUI();
  
  // Показываем уведомление
  showNotification('🎬 Ad Miner активирован на 10 минут!', 'success');
  
  // Запускаем майнинг
  startMiningLoop();
  
  // Автоматически удаляем ферму после истечения времени
  setTimeout(() => {
    const index = minerData.farms.findIndex(f => f.type === type && f.is_temp);
    if (index !== -1) {
      minerData.farms.splice(index, 1);
      updateMinerUI();
      showNotification('⏰ Ad Miner завершил работу', 'info');
    }
  }, duration);
}
```

### 6. Backend endpoint для активации Ad Miner

```javascript
// POST /api/miner/activate-ad-miner
router.post('/activate-ad-miner', async (req, res) => {
  try {
    const { telegram_id, miner_type, ad_id } = req.body;
    
    // Валидация
    if (!telegram_id || !miner_type || !ad_id) {
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
    const { data: user } = await supabase
      .from('nodeon_users')
      .select('*')
      .eq('telegram_id', telegram_id)
      .single();

    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    // Получаем данные майнера
    const { data: minerData } = await supabase
      .from('nodeon_miner_data')
      .select('*')
      .eq('user_id', user.id)
      .single();

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
```

### 7. Расчет производства с учетом логики

```javascript
function calculateGasPerMinute() {
  if (!minerData || !minerData.farms) return;

  let totalProduction = 0;
  const farmCounts = {};
  let nuclearBonus = 0;
  
  // Считаем количество каждого типа
  minerData.farms.forEach(farm => {
    if (farm.is_temp && Date.now() > farm.expires_at) {
      return; // Пропускаем просроченные временные фермы
    }
    
    farmCounts[farm.type] = (farmCounts[farm.type] || 0) + 1;
  });

  // Применяем логику для каждого типа
  Object.entries(farmCounts).forEach(([type, count]) => {
    const baseProduction = farmTypes.find(f => f.id === type)?.baseGasPerMinute || 0;
    
    if (type === 'quantum_computer') {
      // QC: Квадр. рост (1=50, 2=125, 3=225)
      const bonus = Math.pow(1.5, count - 1);
      totalProduction += baseProduction * count * bonus;
    } else if (type === 'mining_cluster') {
      // Cluster: +20% за каждый
      const bonus = 1 + (count - 1) * 0.2;
      totalProduction += baseProduction * count * bonus;
    } else if (type === 'nuclear_reactor') {
      // Nuclear: Бонус ко всем фермам
      nuclearBonus = 0.25; // +25%
      totalProduction += baseProduction * count;
    } else if (type === 'mining_pool') {
      // Pool: +5% за каждый GPU или CPU
      const gpuCount = farmCounts['gpu_farm'] || 0;
      const cpuCount = farmCounts['cpu_miner'] || 0;
      const bonus = 1 + (gpuCount + cpuCount) * 0.05;
      totalProduction += baseProduction * count * bonus;
    } else {
      // Стандартная логика
      totalProduction += baseProduction * count;
    }
  });
  
  // Применяем бонус Nuclear Reactor
  if (nuclearBonus > 0) {
    totalProduction = totalProduction * (1 + nuclearBonus);
  }
  
  minerData.gasPerMinute = totalProduction;
}
```

### 8. Конфигурация для фронтенда

```javascript
const farmTypes = [
  // ... существующие ...
  {
    id: 'quantum_computer',
    name: 'Quantum Computer',
    icon: '⚛️',
    description: 'Квантовый компьютер - чем больше, тем лучше!',
    baseGasPerMinute: 50,
    baseCost: 10000,
    energyCost: 10,
    unlockLevel: 7,
    logic: 'quadratic_growth' // Квадр. рост
  },
  {
    id: 'mining_cluster',
    name: 'Mining Cluster',
    icon: '🔗',
    description: 'Кластер - каждый следующий дает бонус +20%!',
    baseGasPerMinute: 12,
    baseCost: 500,
    energyCost: 6,
    unlockLevel: 4,
    logic: 'percentage_bonus' // +20% за каждый
  },
  {
    id: 'nuclear_reactor',
    name: 'Nuclear Reactor',
    icon: '☢️',
    description: 'Ядерный реактор - дает +25% ко всем фермам!',
    baseGasPerMinute: 80,
    baseCost: 15000,
    energyCost: 30,
    unlockLevel: 8,
    logic: 'global_bonus' // +25% ко всем
  },
  {
    id: 'solar_farm',
    name: 'Solar Farm',
    icon: '☀️',
    description: 'Солнечная ферма - не тратит энергию!',
    baseGasPerMinute: 4,
    baseCost: 150,
    energyCost: 0, // Не потребляет энергию
    unlockLevel: 2,
    logic: 'no_energy' // Не потребляет энергию
  },
  {
    id: 'mining_pool',
    name: 'Mining Pool',
    icon: '🏊',
    description: 'Майнинг пул - работает лучше с GPU/CPU!',
    baseGasPerMinute: 25,
    baseCost: 2000,
    energyCost: 12,
    unlockLevel: 5,
    logic: 'synergy_bonus' // +5% за GPU/CPU
  },
  {
    id: 'cloud_mining',
    name: 'Cloud Mining',
    icon: '☁️',
    description: 'Облачный майнинг - не тратит энергию!',
    baseGasPerMinute: 40,
    baseCost: 5000,
    energyCost: 0, // Не потребляет энергию
    unlockLevel: 6,
    logic: 'no_energy' // Не потребляет энергию
  },
  {
    id: 'ad_miner_1',
    name: 'Ad Miner (10 min)',
    icon: '📺',
    description: 'За просмотр рекламы - 10 минут майнинга!',
    baseGasPerMinute: 3,
    baseCost: 0, // Бесплатно
    energyCost: 5,
    unlockLevel: 0, // Всегда доступен
    logic: 'temp_10min' // Временный на 10 минут
  },
  {
    id: 'ad_miner_2',
    name: 'Ad Miner (15 min)',
    icon: '🎬',
    description: 'За просмотр рекламы - 15 минут майнинга!',
    baseGasPerMinute: 5,
    baseCost: 0, // Бесплатно
    energyCost: 8,
    unlockLevel: 0, // Всегда доступен
    logic: 'temp_15min' // Временный на 15 минут
  }
];
```

## API Endpoints для добавления

### 1. GET /api/miner/ad-config
Получение конфигурации рекламы

### 2. POST /api/miner/activate-ad-miner
Активация Ad Miner после просмотра рекламы

### 3. GET /api/miner/ad-status
Статус рекламных майнеров (время до истечения)

## Инструкция по интеграции Яндекса

### Шаг 1: Регистрация
1. Перейдите на https://partner.yandex.ru/
2. Зарегистрируйтесь как партнер
3. Подайте заявку на Ads API
4. Получите App ID и Publisher ID

### Шаг 2: Добавление SDK
Добавить в `index.html` перед закрывающим `</body>`:
```html
<script src="https://yastatic.net/advads2/ads_sdk.js"></script>
```

### Шаг 3: Инициализация
В начале `index.html` после загрузки:
```javascript
if (window.YandexAds) {
  window.yandexAds = await window.YandexAds.create({
    appId: 'YOUR_APP_ID',
    publisherId: 'YOUR_PUBLISHER_ID'
  });
}
```

### Шаг 4: Показ рекламы
```javascript
async function showYandexAd(forMiner) {
  const ad = await window.yandexAds.createRewardedAd({
    adUnitId: forMiner === 1 ? 'AD_UNIT_1' : 'AD_UNIT_2',
    onRewarded: (reward) => {
      // Активировать майнер через API
      activateAdMiner(forMiner);
    }
  });
  await ad.show();
}
```

### Шаг 5: Backend
Добавить endpoint в `miner.js`:
```javascript
router.post('/activate-ad-miner', ...);
```

## Тестирование

### Тестовый режим Яндекс
1. В личном кабинете включите тестовый режим
2. Тестовая реклама будет показываться для разработчиков
3. Проверьте все типы рекламы

### Проверка интеграции
1. Открыть Mini App
2. Найти "Ad Miner" кнопки
3. Нажать на кнопку
4. Должна открыться реклама
5. После просмотра активируется майнер
6. Майнер работает 10-15 минут
7. Gas зачисляется автоматически

## Важно

⚠️ **Ограничения Яндекс.Дзен Ads:**
- Минимальный таймаут между показами: 30 секунд
- Требуется валидация приложения
- Может потребоваться модерация рекламы

⚠️ **Возможные проблемы:**
- SDK может не загрузиться в Telegram Mini App
- Нужно добавить домен в белый список
- Требуется HTTPS для продакшена

## Альтернативы

Если Яндекс.Дзен не подходит:
1. **AdMob** (Google) - для мобильных
2. **Adfox** (Яндекс) - для веба
3. **Teads** - видео реклама
4. **Собственная система** - показывать случайные промо











