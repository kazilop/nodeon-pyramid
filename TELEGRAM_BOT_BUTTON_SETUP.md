# 🤖 Настройка кнопки Telegram бота

## 🚀 Правильная ссылка для кнопки

### ✅ Рабочая ссылка:
```
https://nodeon-production.up.railway.app/
```

## 🛠 Как настроить кнопку в Telegram боте

### 1. Через BotFather
1. Откройте [@BotFather](https://t.me/BotFather) в Telegram
2. Отправьте команду `/mybots`
3. Выберите вашего бота
4. Нажмите `Bot Settings` → `Menu Button`
5. Выберите `Configure Menu Button`
6. Введите текст кнопки: `🚀 Запустить игру`
7. Введите URL: `https://nodeon-production.up.railway.app/`
8. Нажмите `Send`

### 2. Через код (если у вас есть доступ к коду бота)
```python
from telegram import InlineKeyboardButton, InlineKeyboardMarkup

# Создание кнопки
keyboard = [
    [InlineKeyboardButton("🚀 Запустить игру", web_app=WebAppInfo(url="https://nodeon-production.up.railway.app/"))]
]
reply_markup = InlineKeyboardMarkup(keyboard)

# Отправка сообщения с кнопкой
bot.send_message(chat_id=chat_id, text="Добро пожаловать в NodeOn Crypto!", reply_markup=reply_markup)
```

### 3. Через команду /setmenubutton
```
/setmenubutton
```
Затем следуйте инструкциям BotFather.

## 🎮 Что происходит при нажатии кнопки

1. **Открывается Telegram Mini App** с игровым интерфейсом
2. **Загружается красивый дизайн** с анимациями
3. **Инициализируется Telegram WebApp SDK**
4. **Пользователь может**:
   - Покупать Pro статус
   - Покупать NDN за Stars
   - Выводить NDN
   - Просматривать баланс

## 🔧 Проверка работы

### 1. Проверьте ссылку в браузере
Откройте: https://nodeon-production.up.railway.app/

Должна загрузиться страница с:
- ✅ Анимированным фоном
- ✅ Логотипом "🚀 NodeOn Crypto"
- ✅ Кнопками для покупки
- ✅ Балансами NDN и Stars

### 2. Проверьте в Telegram
1. Откройте бота в Telegram
2. Нажмите кнопку "🚀 Запустить игру"
3. Должно открыться Mini App с игровым интерфейсом

## 🚨 Возможные проблемы

### Проблема: "Ошибка сервера"
**Решение**: 
1. Проверьте, что ссылка правильная: `https://nodeon-production.up.railway.app/`
2. Убедитесь, что нет лишних символов в URL
3. Проверьте, что бот настроен правильно

### Проблема: "Не удается загрузить"
**Решение**:
1. Проверьте интернет-соединение
2. Попробуйте обновить страницу
3. Проверьте логи Railway: `railway logs`

### Проблема: "Ошибка авторизации"
**Решение**:
1. Убедитесь, что открываете через Telegram Mini App
2. Не открывайте ссылку в обычном браузере
3. Проверьте, что бот правильно настроен

## 📱 Поддерживаемые платформы

### ✅ Работает на:
- **Telegram Desktop** (Windows, macOS, Linux)
- **Telegram Mobile** (iOS, Android)
- **Telegram Web** (браузер)

### ❌ Не работает на:
- Обычных браузерах (без Telegram)
- Старых версиях Telegram

## 🎯 Дополнительные настройки

### Изменение текста кнопки
Можете использовать любой текст:
- `🚀 Запустить игру`
- `🎮 Играть`
- `💰 NodeOn Crypto`
- `🚀 Начать`

### Изменение URL
Если измените домен Railway, обновите URL в настройках бота.

## 🎉 Результат

После правильной настройки:
1. ✅ Кнопка появляется в боте
2. ✅ При нажатии открывается Mini App
3. ✅ Загружается красивый игровой интерфейс
4. ✅ Все функции работают

**Ссылка для кнопки: `https://nodeon-production.up.railway.app/`** 🚀

