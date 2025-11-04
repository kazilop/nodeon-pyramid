# Исправление ошибки 400 в игре Miner

## Проблема
При попытке купить майнер возникала ошибка 400 "Insufficient Gas balance"

## Причина
1. Новым пользователям создавались данные майнера с `ndnGas: 0`
2. Не хватало Gas для покупки первой фермы (стоимость 50 Gas)
3. Ответ от `/api/miner/data` не содержал полные данные майнера

## Решение

### 1. Выдача стартового Gas
**Было:**
```javascript
const initialMinerData = {
  ndnGas: 0, // ❌ Невозможно купить первую ферму
  ...
};
```

**Стало:**
```javascript
const initialMinerData = {
  ndnGas: 100, // ✅ Стартовый Gas для покупки 2 ферм
  ...
};
```

### 2. Исправление ответа API
**Было:**
```javascript
res.json({
  success: true,
  miner: { // ❌ Неправильное поле
    gas: newGas,
    ...
  }
});
```

**Стало:**
```javascript
res.json({
  success: true,
  miner_data: { // ✅ Правильное поле
    ndnGas: newGas,
    energy: newEnergy,
    ...
  }
});
```

## Что изменилось

### Стартовый Gas
- Новые пользователи получают 100 Gas
- Могут купить 2 CPU Miner (50 Gas каждый)
- Или 1 CPU Miner + немного еще

### API Response
- Возвращаются полные данные майнера в `miner_data`
- Frontend может корректно обработать данные
- Синхронизация работает правильно

## Тестирование

1. Открыть Mini App
2. Перейти в "⛏️ NDN Miner"
3. Проверить что Gas = 100
4. Купить CPU Miner за 50 Gas
5. Проверить что Gas = 50
6. Купить еще один CPU Miner
7. Проверить что Gas = 0
8. Проверить что фермы работают

## Новые майнеры

Все 10 новых майнеров добавлены:
- CPU Miner, GPU Farm, ASIC Rig, Data Center (базовые)
- Solar Farm, Mining Cluster, Mining Pool (с бонусами)
- Cloud Mining, Quantum Computer (особые)
- Nuclear Reactor (глобальный бонус)

## Следующие шаги

1. Протестировать покупку майнеров
2. Проверить работу специальной логики
3. Интегрировать Яндекс.Дзен рекламу для Ad Miners











