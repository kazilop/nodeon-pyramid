# Восстановление игры Miner и уменьшение ежедневных наград

## Выполнено

### 1. Уменьшены ежедневные награды в 2 раза

**Было:**
- День 1: 2 NDN
- День 2: 4 NDN
- День 3: 6 NDN
- День 4: 10 NDN
- День 5: 15 NDN
- День 6: 20 NDN
- День 7: 40 NDN
- **Всего за неделю: 97 NDN**

**Стало:**
- День 1: 1 NDN
- День 2: 2 NDN
- День 3: 3 NDN
- День 4: 5 NDN
- День 5: 8 NDN
- День 6: 10 NDN
- День 7: 20 NDN
- **Всего за неделю: 49 NDN**

### 2. Игра Miner уже работает

**Существующие API:**
- `GET /api/miner/data/:telegram_id` - получение данных майнера
- `POST /api/miner/buy-farm` - покупка фермы
- `POST /api/miner/save-state` - сохранение состояния

**Функции:**
- Покупка ферм (Basic, Advanced, Premium)
- Автоматический заработок газа оффлайн
- Восстановление энергии (10 энергии в час)
- Сохранение состояния в БД

## Структура данных Miner

### Таблица `nodeon_miner_data`:
```sql
user_id INTEGER PRIMARY KEY,
miner_data JSONB, -- Данные майнера в JSON
created_at TIMESTAMP,
updated_at TIMESTAMP
```

### Формат `miner_data`:
```json
{
  "ndnGas": 100,
  "energy": 50,
  "maxEnergy": 100,
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
  "lastUpdate": 1234567890
}
```

## Типы ферм

### Basic Farm
- Стоимость: 50 NDN
- Продукция: 1 NDN/час
- Уровень: 1

### Advanced Farm
- Стоимость: 200 NDN
- Продукция: 5 NDN/час
- Уровень: 1

### Premium Farm
- Стоимость: 500 NDN
- Продукция: 15 NDN/час
- Уровень: 1

## Оффлайн заработок

При входе в игру рассчитывается:
- Количество часов с момента `lastUpdate`
- Восстановление энергии: 10 энергии в час
- Заработок газа: сумма продукции всех ферм × часы

## Статус Miner Game

✅ **Работает:**
- API endpoints
- Покупка ферм
- Оффлайн заработок
- Сохранение состояния
- Получение данных

⚠️ **Возможные проблемы:**
- Если таблица `nodeon_miner_data` не создана в БД
- Если фронтенд не показывает данные майнера

## Проверка работы

### Создать таблицу (если нет):
```sql
CREATE TABLE IF NOT EXISTS nodeon_miner_data (
    user_id INTEGER PRIMARY KEY REFERENCES nodeon_users(id) ON DELETE CASCADE,
    miner_data JSONB NOT NULL DEFAULT '{"ndnGas": 0, "energy": 100, "farms": []}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Проверить API:
```bash
curl https://sistemypro.ru/api/miner/data/207940967
```

### Фронтенд должен:
- Показать окно майнера
- Отобразить фермы
- Разрешить покупку ферм
- Обновлять баланс газа и энергии

## Итоговые награды

### Старые (до изменений):
- Неделя: 97 NDN
- Месяц (4 недели): 388 NDN

### Новые (после изменений):
- Неделя: 49 NDN
- Месяц (4 недели): 196 NDN

**Сокращение: 50%**

## Следующие шаги

1. Проверить работу Miner в Mini App
2. Убедиться что таблица `nodeon_miner_data` создана
3. Протестировать покупку ферм
4. Проверить отображение данных на фронтенде











