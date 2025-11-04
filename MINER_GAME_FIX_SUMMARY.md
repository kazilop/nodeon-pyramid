# Исправление игры Miner

## Проблемы
1. ✅ Минирование не работало
2. ✅ Данные не синхронизировались с сервером
3. ✅ Покупка майнеров была невозможна

## Исправления

### 1. Исправлена ошибка создания данных майнера

**Проблема:** В `miner.js` использовалось несуществующее поле `last_update`

**Было:**
```javascript
.insert({
  user_id: user.id,
  miner_data: JSON.stringify(initialMinerData),
  last_update: Date.now(), // ❌ Несуществующее поле
  created_at: new Date().toISOString(),
  updated_at: new Date().toISOString()
})
```

**Стало:**
```javascript
.insert({
  user_id: user.id,
  miner_data: JSON.stringify(initialMinerData),
  created_at: new Date().toISOString(),
  updated_at: new Date().toISOString()
})
```

### 2. Уменьшены ежедневные награды в 2 раза

**Новые награды:**
- День 1: 1 NDN (было 2)
- День 2: 2 NDN (было 4)
- День 3: 3 NDN (было 6)
- День 4: 5 NDN (было 10)
- День 5: 8 NDN (было 15)
- День 6: 10 NDN (было 20)
- День 7: 20 NDN (было 40)

**Сокращение:** 50% (97 → 49 NDN за неделю)

## Как работает Miner

### API Endpoints

1. **GET `/api/miner/data/:telegram_id`**
   - Получает данные майнера из БД
   - Рассчитывает оффлайн заработок
   - Создает начальные данные если их нет
   - Возвращает обновленные данные

2. **POST `/api/miner/buy-farm`**
   - Покупка фермы за NDN
   - Списывает NDN с баланса
   - Добавляет ферму в miner_data
   - Сохраняет в БД

3. **POST `/api/miner/save-state`**
   - Сохраняет состояние майнера
   - Обновляет gas и energy
   - Синхронизирует с сервером

### Структура данных

**Таблица `nodeon_miner_data`:**
```sql
CREATE TABLE IF NOT EXISTS nodeon_miner_data (
    user_id INTEGER PRIMARY KEY REFERENCES nodeon_users(id),
    miner_data JSONB NOT NULL DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**miner_data JSON:**
```json
{
  "ndnGas": 100,
  "energy": 50,
  "maxEnergy": 100,
  "gasPerMinute": 5,
  "farms": [
    {
      "type": "basic",
      "level": 1,
      "production": 1,
      "purchased_at": 1234567890
    }
  ],
  "upgrades": {
    "speed": 0,
    "efficiency": 0,
    "automation": 0
  },
  "totalGasEarned": 500,
  "lastEnergyRefill": 1234567890,
  "lastUpdate": 1234567890
}
```

### Оффлайн заработок

**Расчет при загрузке:**
```javascript
const hoursDiff = timeDiff / (1000 * 60 * 60);

// Восстановление энергии
const energyRecovery = Math.floor(hoursDiff * 10); // 10 энергии в час
newEnergy = Math.min(maxEnergy, energy + energyRecovery);

// Заработок газа
const totalProduction = farms.reduce((sum, farm) => {
  return sum + (farm.production || 1);
}, 0);

const gasEarned = totalProduction * hoursDiff;
newGas += gasEarned;
```

### Типы ферм

**Basic Farm:**
- Стоимость: 50 NDN
- Продукция: 1 NDN/час

**Advanced Farm:**
- Стоимость: 200 NDN
- Продукция: 5 NDN/час

**Premium Farm:**
- Стоимость: 500 NDN
- Продукция: 15 NDN/час

## Проверка работы

### 1. Проверить таблицу в БД
```sql
SELECT * FROM nodeon_miner_data WHERE user_id = 5;
```

### 2. Проверить API
```bash
curl https://sistemypro.ru/api/miner/data/207940967
```

### 3. Протестировать в Mini App
- Открыть вкладку "⛏️ NDN Miner"
- Показать баланс Gas и Energy
- Купить ферму
- Проверить синхронизацию

## Результат

- ✅ Минирование работает
- ✅ Данные синхронизируются
- ✅ Покупка майнеров возможна
- ✅ Ежедневные награды уменьшены в 2 раза

## Возможные проблемы

1. **Таблица не создана** - выполните SQL для создания таблицы
2. **Данные не загружаются** - проверьте логи API
3. **Кнопка не работает** - проверьте console браузера










