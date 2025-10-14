# Обновление реферальной системы

## Проблема
Текущая система подсчета рефералов работает медленно и неправильно определяет уровни рефералов.

## Решение
Добавляем новые колонки в таблицу `nodeon_users` для быстрого доступа к реферальным данным.

## Шаги обновления

### 1. Добавить колонки в Supabase
Выполните SQL скрипт `add_referral_columns.sql` в Supabase Dashboard:

```sql
-- Добавляем колонки для упрощения работы с реферальной системой
ALTER TABLE nodeon_users 
ADD COLUMN all_referrals INTEGER[] DEFAULT '{}';

ALTER TABLE nodeon_users 
ADD COLUMN referrals_by_level JSONB DEFAULT '{}';

ALTER TABLE nodeon_users 
ADD COLUMN total_referrals_count INTEGER DEFAULT 0;

ALTER TABLE nodeon_users 
ADD COLUMN pro_referrals_count INTEGER DEFAULT 0;

ALTER TABLE nodeon_users 
ADD COLUMN regular_referrals_count INTEGER DEFAULT 0;

ALTER TABLE nodeon_users 
ADD COLUMN total_referral_earnings DECIMAL DEFAULT 0;

-- Создаем индексы для быстрого поиска
CREATE INDEX idx_nodeon_users_all_referrals ON nodeon_users USING GIN (all_referrals);
CREATE INDEX idx_nodeon_users_referrals_by_level ON nodeon_users USING GIN (referrals_by_level);

-- Обновляем существующих пользователей
UPDATE nodeon_users 
SET 
    all_referrals = '{}',
    referrals_by_level = '{}',
    total_referrals_count = 0,
    pro_referrals_count = 0,
    regular_referrals_count = 0,
    total_referral_earnings = 0
WHERE all_referrals IS NULL;
```

### 2. Заполнить данные
Запустите скрипт `update_referral_data.py` для заполнения новых колонок:

```bash
python update_referral_data.py
```

### 3. Деплой обновленного кода
Задеплойте обновленный `main.py`:

```bash
railway up
```

## Новые колонки

- `all_referrals` - массив ID всех рефералов пользователя
- `referrals_by_level` - JSON объект с рефералами по уровням
- `total_referrals_count` - общее количество рефералов
- `pro_referrals_count` - количество PRO рефералов
- `regular_referrals_count` - количество обычных рефералов
- `total_referral_earnings` - общий заработок с рефералов

## Преимущества

1. **Быстрый доступ** - не нужно каждый раз вычислять рефералов
2. **Правильные уровни** - уровни вычисляются один раз при создании
3. **Кэширование** - данные обновляются только при изменениях
4. **Индексы** - быстрый поиск по рефералам

## Обновление данных

Данные автоматически обновляются при:
- Создании нового пользователя
- Покупке PRO статуса
- Вызове функции `update_user_referrals_data()`

