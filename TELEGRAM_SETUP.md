# 🚀 Подключение Telegram Mini App

## 📋 Пошаговая инструкция

### 1. Создай репозиторий на GitHub
1. Перейди на [github.com](https://github.com)
2. Нажми **"New repository"**
3. Название: `nodeon-pyramid`
4. Сделай репозиторий **Public**
5. Нажми **"Create repository"**

### 2. Загрузи файл на GitHub
1. В созданном репозитории нажми **"uploading an existing file"**
2. Перетащи файл `index.html` в репозиторий
3. Напиши commit message: "Add NodeOn Pyramid Mini App"
4. Нажми **"Commit changes"**

### 3. Включи GitHub Pages
1. В репозитории перейди в **Settings**
2. Прокрути вниз до раздела **Pages**
3. В разделе **Source** выбери **"Deploy from a branch"**
4. Выбери **"main"** branch
5. Выбери **"/ (root)"** folder
6. Нажми **"Save"**

### 4. Получи URL приложения
После настройки GitHub Pages у тебя будет URL вида:
```
https://твой-username.github.io/nodeon-pyramid
```

### 5. Настрой Telegram Bot

#### 5.1. Открой BotFather
1. Перейди в Telegram
2. Найди бота [@BotFather](https://t.me/BotFather)
3. Нажми **"/start"**

#### 5.2. Создай нового бота (если еще не создан)
1. Нажми **"/newbot"**
2. Введи имя бота: `NodeOn Pyramid Bot`
3. Введи username: `nodeon_pyramid_bot` (или любой свободный)
4. Скопируй **Bot Token**

#### 5.3. Настрой Mini App
1. Нажми **"/newapp"**
2. Выбери своего бота из списка
3. Введи название: `NodeOn Pyramid`
4. Введи описание: `Реферальная игра с монетами NDN`
5. Загрузи иконку (любое изображение)
6. Введи URL: `https://твой-username.github.io/nodeon-pyramid`
7. Нажми **"Create"**

### 6. Проверь работу
1. Найди своего бота в Telegram
2. Нажми **"/start"**
3. Нажми кнопку **"Open App"** или **"Launch Mini App"**
4. Должно открыться твое приложение!

## 🔧 Альтернативный способ (если GitHub Pages не работает)

### Используй Netlify
1. Перейди на [netlify.com](https://netlify.com)
2. Войди через GitHub
3. Нажми **"New site from Git"**
4. Выбери свой репозиторий `nodeon-pyramid`
5. Нажми **"Deploy site"**
6. Получи URL вида: `https://random-name.netlify.app`
7. Используй этот URL в BotFather

## 🎯 Готово!

После выполнения всех шагов у тебя будет:
- ✅ Рабочий Telegram бот
- ✅ Telegram Mini App
- ✅ Красивый интерфейс
- ✅ Все функции приложения

## 📱 Тестирование

1. Открой бота в Telegram
2. Нажми **"/start"**
3. Нажми кнопку для запуска Mini App
4. Проверь все вкладки: Главная, Правила, Статистика
5. Убедись, что интерфейс адаптивный

## 🚨 Если что-то не работает

1. **Проверь URL** - он должен быть доступен в браузере
2. **Проверь настройки бота** - Mini App должен быть правильно настроен
3. **Проверь консоль** - открой Developer Tools в браузере
4. **Попробуй другой хостинг** - Netlify, Vercel, Railway

## 📞 Поддержка

Если нужна помощь, проверь:
- [Telegram Bot API](https://core.telegram.org/bots/api)
- [Telegram Web Apps](https://core.telegram.org/bots/webapps)
- [GitHub Pages](https://pages.github.com)
