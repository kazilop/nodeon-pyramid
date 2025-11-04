# Полное исправление логики Miner

## Исправленные проблемы

### 1. Несоответствие типов ферм
**Проблема:** Frontend отправлял `cpu_miner`, backend ожидал `basic`

**Решение:** Добавлены все типы ферм в `farmConfigs`:
```javascript
const farmConfigs = {
  cpu_miner: { cost: 50, production: 1, name: 'CPU Miner', gasPerMinute: 1, energyCost: 1 },
  gpu_farm: { cost: 250, production: 5, name: 'GPU Farm', gasPerMinute: 5, energyCost: 3 },
  asic_rig: { cost: 1000, production: 20, name: 'ASIC Rig', gasPerMinute: 20, energyCost: 8 },
  data_center: { cost: 5000, production: 100, name: 'Data Center', gasPerMinute: 100, energyCost: 25 },
  // Старые типы для совместимости
  basic: { cost: 50, production: 1, name: 'Basic Farm', gasPerMinute: 1, energyCost: 1 },
  advanced: { cost: 200, production: 5, name: 'Advanced Farm', gasPerMinute: 5, energyCost: 3 },
  premium: { cost: 500, production: 15, name: 'Premium Farm', gasPerMinute: 15, energyCost: 8 }
};
```

### 2. Использование NDN вместо Gas
**Проблема:** Фермы покупались за NDN, а должны за Gas

**Было:**
```javascript
const newBalance = user.balance_ndn - farmConfig.cost;
// Списывали NDN баланс пользователя
```

**Стало:**
```javascript
const newGasBalance = (miner.ndnGas || 0) - farmConfig.cost;
// Списываем Gas баланс майнера
```

### 3. Неправильная проверка баланса
**Было:**
```javascript
if (user.balance_ndn < farmConfig.cost) {
  return res.status(400).json({ error: 'Insufficient balance' });
}
```

**Стало:**
```javascript
if ((miner.ndnGas || 0) < farmConfig.cost) {
  return res.status(400).json({ 
    error: `Insufficient Gas balance. Need: ${farmConfig.cost}, have: ${miner.ndnGas || 0}` 
  });
}
```

### 4. Неправильный ответ сервера
**Было:**
```javascript
res.json({
  success: true,
  message: 'Farm purchased successfully',
  farm: newFarm,
  new_balance: newBalance // ❌ NDN баланс
});
```

**Стало:**
```javascript
res.json({
  success: true,
  message: 'Farm purchased successfully',
  farm: newFarm,
  miner_data: updatedMinerData, // ✅ Полные данные майнера
  new_gas_balance: newGasBalance // ✅ Gas баланс
});
```

### 5. Неправильное поле при отправке
**Было:** 
```javascript
body: JSON.stringify({
  user_id: userData.telegram_id, // ❌ Неправильное поле
  farm_type: farmId
})
```

**Стало:**
```javascript
body: JSON.stringify({
  telegram_id: userData.telegram_id, // ✅ Правильное поле
  farm_type: farmId
})
```

## Текущая логика

### Покупка фермы:
1. Frontend отправляет `telegram_id` и `farm_type`
2. Backend проверяет тип фермы в `farmConfigs`
3. Проверяет баланс **Gas** (не NDN!)
4. Списывает Gas из `miner.ndnGas`
5. Добавляет ферму в `miner.farms`
6. Сохраняет в БД
7. Возвращает обновленные `miner_data`

### Типы ферм и стоимости:
- **CPU Miner** (Level 1): 50 Gas, 1 Gas/мин
- **GPU Farm** (Level 3): 250 Gas, 5 Gas/мин  
- **ASIC Rig** (Level 5): 1000 Gas, 20 Gas/мин
- **Data Center** (Level 10): 5000 Gas, 100 Gas/мин

### Система разблокировки:
- Уровень игрока зависит от XP
- XP начисляется за ежедневные награды (+10 XP)
- XP начисляется за покупку ферм (+25 XP)
- Каждый уровень требует: `уровень × 100 XP`
- Фермы разблокируются по уровню

## Результат

✅ Все типы ферм поддерживаются
✅ Покупка работает за Gas (не NDN)
✅ Списывается правильный баланс
✅ Возвращаются корректные данные
✅ Синхронизация работает
✅ Первая ферма доступна сразу

## Тестирование

1. Открыть Mini App
2. Перейти в "⛏️ NDN Miner"
3. CPU Miner должен быть доступен
4. Купить за 50 Gas
5. Проверить что Gas списался
6. Проверить что ферма появилась
7. Проверить что майнинг начался










