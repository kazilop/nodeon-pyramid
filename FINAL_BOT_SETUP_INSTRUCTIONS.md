# 🤖 NodeOn Crypto - Финальные инструкции по настройке бота

## 🚀 Полная настройка Telegram бота

### 1. Настройка кнопки запуска Mini App

#### Через BotFather
1. Откройте [@BotFather](https://t.me/BotFather) в Telegram
2. Отправьте команду `/mybots`
3. Выберите вашего бота
4. Нажмите `Bot Settings` → `Menu Button`
5. Выберите `Configure Menu Button`
6. Введите текст кнопки: `🚀 Запустить игру`
7. Введите URL: `https://nodeon-production.up.railway.app/`
8. Нажмите `Send`

### 2. Проверка настроек

#### Убедитесь, что:
- ✅ URL правильный: `https://nodeon-production.up.railway.app/`
- ✅ Кнопка называется: `🚀 Запустить игру`
- ✅ Бот активен и работает

### 3. Тестирование

#### В мобильном приложении Telegram
1. Найдите вашего бота
2. Нажмите кнопку "🚀 Запустить игру"
3. Должно открыться Mini App
4. Проверьте, что загружаются реальные данные

#### Ожидаемые результаты
- **Заголовок**: "Добро пожаловать, [Ваше имя]!"
- **Баланс NDN**: Реальные данные
- **Баланс Stars**: Реальные данные
- **Pro статус**: Реальный статус
- **Нет тестовых кнопок**

## 🔧 Технические детали

### Авторизация
- **Формат**: `Authorization: tma ${initData}`
- **Стандарт**: Согласно [официальной документации Telegram](https://docs.telegram-mini-apps.com/platform/authorizing-user)
- **Безопасность**: Правильная валидация данных

### API Endpoints
- **Профиль**: `GET /api/user/profile`
- **Покупка Pro**: `POST /api/user/buy-pro`
- **Покупка NDN**: `POST /api/payments/buy-ndn`
- **Вывод NDN**: `POST /api/user/withdraw`
- **Правила игры**: `GET /api/game-rules`
- **Лидерборд**: `GET /api/stats/leaderboard`
- **Рефералы**: `GET /api/referrals/{user_id}`

### База данных
- **Supabase**: https://supabase.com/dashboard/project/ahxwpzgltlzlvrtrbanm
- **Таблицы**: `nodeon_users`, `nodeon_transactions`, `nodeon_referral_stats`
- **Серверный кошелек**: 1 млрд NDN для продажи

## 🎮 Функции игры

### Основные возможности
- ✅ **Покупка NDN** за Telegram Stars
- ✅ **Pro статус** за 1000 NDN
- ✅ **Реферальная система** до 7 уровней
- ✅ **Вывод NDN** другим игрокам
- ✅ **Таблица лидеров**
- ✅ **Правила игры**

### Реферальная система
- **1-й уровень**: 200 NDN с покупки Pro
- **2-7 уровни**: по 150 NDN с покупки Pro
- **Комиссия разработчика**: 200 NDN

### Курс обмена
- **1 Star = 1 NDN**
- **Минимум покупки**: 100 NDN
- **Максимум покупки**: 10000 NDN

## 🚀 Развертывание

### Railway
- **URL**: https://nodeon-production.up.railway.app/
- **Статус**: ✅ Работает
- **Логи**: `railway logs --tail 20`

### Supabase
- **Проект**: ahxwpzgltlzlvrtrbanm
- **Статус**: ✅ Подключен
- **Таблицы**: ✅ Созданы

## 🔍 Отладка

### Если не загружаются реальные данные
1. **Проверьте платформу**: Откройте в мобильном Telegram
2. **Проверьте URL**: В настройках бота
3. **Проверьте логи**: В консоли и Railway
4. **Проверьте авторизацию**: Формат `tma ${initData}`

### Проверка в консоли
```javascript
// Должны быть такие логи:
Telegram WebApp данные: {
  platform: "ios", // или "android"
  initData: "есть",
  user: {id: 123456789, first_name: "Ваше имя"}
}

Response status: 200
Получены данные пользователя: {id: 1, first_name: "Ваше имя", ...}
```

### Проверка логов Railway
```bash
railway logs --tail 20
```

Должны быть логи:
```
✅ Successfully verified Telegram user: Ваше имя (@username) ID: 123456789
INFO: GET /api/user/profile HTTP/1.1 200 OK
```

## 🎉 Готово к использованию!

### Что работает
- ✅ **Telegram Mini App** - загружает реальные данные
- ✅ **Авторизация** - согласно официальной документации
- ✅ **Все функции** - покупки, вывод, рефералы
- ✅ **База данных** - подключена и работает
- ✅ **Серверный кошелек** - 1 млрд NDN для продажи

### Ссылки
- **Игра**: https://nodeon-production.up.railway.app/
- **База данных**: https://supabase.com/dashboard/project/ahxwpzgltlzlvrtrbanm
- **Документация**: https://docs.telegram-mini-apps.com/platform/authorizing-user

**NodeOn Crypto готов к запуску!** 🚀🎮✨

---

**Дата настройки**: 2024-01-01  
**Версия**: 2.5.0  
**Статус**: ✅ Полностью готов к использованию


