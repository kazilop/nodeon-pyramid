# Исправление создания пользователей

## Проблема
Новые пользователи не добавлялись в базу данных при запуске приложения

## Причина
1. Endpoint `/api/user/create` был не зарегистрирован в `server.js`
2. Endpoint `/api/user/profile` отсутствовал
3. Frontend вызывал `/api/user/create`, но маршрут не существовал

## Решение

### 1. Добавлен alias для `/api/user`
**Файл:** `server-deployment/server.js`

```javascript
app.use('/api/users', usersRoutes);
app.use('/api/user', usersRoutes); // ✅ Alias для /api/user/create и /api/user/profile
```

### 2. Добавлен endpoint `/api/user/profile`
**Файл:** `server-deployment/routes/users.js`

**Функционал:**
- Получает `Authorization: tma {initData}`
- Извлекает `telegram_id` из `initData`
- Ищет пользователя в БД
- Возвращает данные пользователя

**Код:**
```javascript
router.get('/profile', async (req, res) => {
  const authHeader = req.headers.authorization;
  const initData = authHeader.substring(4);
  const urlParams = new URLSearchParams(initData);
  const userParam = urlParams.get('user');
  const user = JSON.parse(decodeURIComponent(userParam));
  const telegram_id = user.id;

  const { data: userData, error } = await supabase
    .from('nodeon_users')
    .select('*')
    .eq('telegram_id', telegram_id)
    .single();

  if (error) {
    return res.status(404).json({ error: 'User not found' });
  }

  res.json({ success: true, user: userData });
});
```

### 3. Endpoint `/api/user/create` уже был
**Файл:** `server-deployment/routes/users.js`

**Функционал:**
- Принимает `telegram_id`, `username`, `first_name`, `last_name`, `referral_code`
- Проверяет существование пользователя
- Обрабатывает реферальный код
- Создает пользователя со стартовым балансом 100 NDN

## Flow создания пользователя

1. **Пользователь открывает Mini App**
   - Telegram передает `initData` с данными пользователя
   - Frontend вызывает `/api/auth/profile/${telegram_id}`

2. **Если пользователь не найден (404)**
   - Frontend вызывает `/api/user/create` с данными пользователя
   - Backend проверяет существование
   - Если не существует - создает нового пользователя

3. **Создание пользователя**
   - Проверяется реферальный код
   - Ищется инвайтер
   - Создается пользователь с `inviter_id`

4. **Результат**
   - Пользователь создан в БД
   - Получен стартовый баланс 100 NDN
   - Установлена связь с инвайтером

## Проверка

Попросите пользователей перезапустить Mini App:

1. Закрыть Mini App
2. Открыть бота в Telegram: `@pro_stars_bot`
3. Нажать кнопку "Играть"
4. Пользователь автоматически создастся в БД

## Endpoints

### GET /api/user/profile
- **Авторизация:** `Authorization: tma {initData}`
- **Ответ:** Данные пользователя

### POST /api/user/create
- **Body:** 
  ```json
  {
    "telegram_id": "123456789",
    "username": "username",
    "first_name": "Имя",
    "last_name": "Фамилия",
    "referral_code": "ref_5"
  }
  ```
- **Ответ:** Созданный пользователь

## Важно

- Пользователи создаются автоматически при первом запуске
- Стартовый баланс: 100 NDN
- Реферальные коды обрабатываются автоматически
- В БД устанавливается связь с инвайтером

## База данных

### Таблица `nodeon_users`
```sql
CREATE TABLE nodeon_users (
  id SERIAL PRIMARY KEY,
  telegram_id BIGINT UNIQUE,
  username VARCHAR,
  first_name VARCHAR,
  last_name VARCHAR,
  balance_ndn DECIMAL DEFAULT 100,
  is_pro BOOLEAN DEFAULT false,
  referral_link VARCHAR,
  inviter_id INT REFERENCES nodeon_users(id),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
```

### Пример данных
```
ID: 21
Telegram: 123456789
Name: Имя Пользователя
Balance: 100 NDN
Pro: false
Inviter: ID 5 (если есть реферальный код)
```

## Troubleshooting

Если пользователь не создается:

1. Проверьте логи: `pm2 logs nodeon-pyramid`
2. Убедитесь что endpoint `/api/user/create` доступен
3. Проверьте подключение к Supabase
4. Убедитесь что `telegram_id` уникален











