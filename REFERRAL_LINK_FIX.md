# Исправление реферальных ссылок

## Проблема
При переходе по реферальной ссылке `https://t.me/pro_stars_bot?startapp=ref_5` пользователи не регистрировались в базе данных

## Причина
1. Не был реализован endpoint `/api/user/create` для создания пользователей
2. Реферальный код не передавался при создании пользователя
3. Реферальный код не извлекался из параметров Telegram WebApp

## Решение

### 1. Создан endpoint `/api/user/create`
**Файл:** `server-deployment/routes/users.js`

**Функционал:**
- Принимает `telegram_id`, `username`, `first_name`, `last_name`, `referral_code`
- Проверяет существование пользователя (возвращает существующего)
- Обрабатывает реферальный код:
  - Извлекает ID из формата `ref_ID`
  - Ищет инвайтера по ID или `telegram_id`
  - Устанавливает `inviter_id` для нового пользователя
- Создает пользователя со стартовым балансом 100 NDN

**Код:**
```javascript
router.post('/create', async (req, res) => {
  const { telegram_id, username, first_name, last_name, referral_code } = req.body;
  
  // Проверка существования
  const { data: existingUser } = await supabase
    .from('nodeon_users')
    .select('*')
    .eq('telegram_id', telegram_id)
    .single();
  
  if (existingUser) {
    return res.json({ success: true, user: existingUser });
  }
  
  // Обработка реферального кода
  let inviter_id = null;
  if (referral_code) {
    const refId = referral_code.replace('ref_', '');
    const { data: inviter } = await supabase
      .from('nodeon_users')
      .select('*')
      .or(`id.eq.${refId},telegram_id.eq.${refId}`)
      .limit(1)
      .single();
    
    if (inviter) {
      inviter_id = inviter.id;
    }
  }
  
  // Создание пользователя
  const { data: newUser } = await supabase
    .from('nodeon_users')
    .insert({
      telegram_id,
      username: username || '',
      first_name: first_name || 'Пользователь',
      last_name: last_name || '',
      balance_ndn: 100,
      is_pro: false,
      referral_link: `ref_${telegram_id}`,
      inviter_id,
      created_at: new Date().toISOString(),
      updated_at: new Date().toISOString()
    })
    .select()
    .single();
  
  res.json({ success: true, user: newUser });
});
```

### 2. Обновлен frontend для передачи referral_code
**Файл:** `server-deployment/public/index.html`

**Изменение:**
```javascript
const createResponse = await fetch('/api/user/create', {
  method: 'POST',
  body: JSON.stringify({
    telegram_id: unsafeUser.id,
    username: unsafeUser.username || '',
    first_name: unsafeUser.first_name || 'Пользователь',
    last_name: unsafeUser.last_name || '',
    referral_code: referralToken // ✅ Добавлено
  })
});
```

### 3. Извлечение реферального кода
**Файл:** `server-deployment/public/index.html`

**Функция `extractReferralToken()`:**
- Ищет параметр `start_param` в `tg.initData`
- Проверяет что параметр начинается с `ref_`
- Возвращает реферальный код

**Код:**
```javascript
function extractReferralToken() {
  try {
    const initData = tg.initData;
    if (initData) {
      const urlParams = new URLSearchParams(initData);
      const startParam = urlParams.get('start_param');
      if (startParam && startParam.startsWith('ref_')) {
        return startParam;
      }
    }
    return null;
  } catch (error) {
    console.error('Error extracting referral token:', error);
    return null;
  }
}
```

## Как это работает

### 1. Реферальная ссылка
**Формат:** `https://t.me/pro_stars_bot?startapp=ref_5`
- `ref_5` - реферальный код (ID инвайтера)

### 2. Пользователь переходит по ссылке
- Telegram открывает Mini App
- Параметр `ref_5` передается в `tg.initData` как `start_param`

### 3. Извлечение кода
- Frontend извлекает `start_param` из `tg.initData`
- Сохраняет в переменную `referralToken`

### 4. Создание пользователя
- Frontend вызывает `/api/user/create` с `referral_code: referralToken`
- Backend находит инвайтера по ID из реферального кода
- Создает пользователя с `inviter_id = ID инвайтера`

### 5. Результат
- Новый пользователь зарегистрирован
- Связь с инвайтером установлена через `inviter_id`
- Можно отслеживать рефералов и начислять бонусы

## Тестирование

### Тест 1: Прямая ссылка
1. Открыть `https://t.me/pro_stars_bot?startapp=ref_5`
2. Запустить приложение
3. Проверить что пользователь создан в БД
4. Проверить что `inviter_id = 5`

### Тест 2: Через бота
1. Написать боту `/start ref_5`
2. Открыть Mini App
3. Проверить что реферальный код обработан

### Тест 3: Без реферального кода
1. Открыть `https://t.me/pro_stars_bot`
2. Запустить приложение
3. Проверить что пользователь создан без `inviter_id`

## База данных

### Таблица `nodeon_users`
```sql
CREATE TABLE nodeon_users (
  id INT PRIMARY KEY,
  telegram_id BIGINT UNIQUE,
  inviter_id INT REFERENCES nodeon_users(id),
  referral_link VARCHAR(255),
  ...
);
```

### Связи
- `inviter_id` -> `id` (самосвязка)
- Один пользователь может пригласить много пользователей
- Каждый пользователь имеет одного инвайтера

## Следующие шаги

1. ✅ Реферальная система работает
2. ⏳ Добавить начисление бонусов при регистрации
3. ⏳ Добавить начисление бонусов при покупке Pro статуса
4. ⏳ Показать статистику рефералов в интерфейсе











