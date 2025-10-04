# 🚀 Инструкции по настройке продакшн системы NodeOn Pyramid

## ✅ Текущий статус: 4/6 компонентов работают

### ✅ Работающие компоненты:
- **Railway Backend** - API работает
- **GitHub Pages Frontend** - фронтенд доступен
- **Telegram Auth** - авторизация работает
- **Leaderboard** - таблица лидеров работает

### ⚠️ Требуют настройки:
- **Stars Functionality** - нужна настройка базы данных
- **Referral System** - нужна настройка базы данных

---

## 📋 Пошаговая настройка

### 1. 🔧 Настройка базы данных Supabase

1. **Откройте Supabase Dashboard:**
   - Перейдите на https://supabase.com/dashboard
   - Войдите в проект `ahxwpzgltlzlvrtrbanm`

2. **Выполните SQL скрипт:**
   - Откройте SQL Editor
   - Скопируйте содержимое файла `SETUP_PRODUCTION_DATABASE.sql`
   - Вставьте в SQL Editor
   - Нажмите "Run" для выполнения

3. **Проверьте создание таблиц:**
   ```sql
   SELECT table_name FROM information_schema.tables 
   WHERE table_schema = 'public' AND table_name LIKE 'nodeon_%';
   ```

### 2. 🤖 Настройка Telegram бота

1. **Создайте бота:**
   - Откройте @BotFather в Telegram
   - Создайте нового бота командой `/newbot`
   - Получите токен бота

2. **Настройте Mini App:**
   - Используйте команду `/newapp`
   - Выберите вашего бота
   - Укажите URL: `https://kazilop.github.io/nodeon-pyramid/`
   - Укажите название: `NodeOn Pyramid`
   - Укажите описание: `Реферальная игра с монетами NDN`

3. **Настройте webhook:**
   ```bash
   python setup_webhook_final.py
   ```

### 3. 🔑 Настройка переменных окружения

Обновите переменные в Railway:

1. **Откройте Railway Dashboard:**
   - Перейдите на https://railway.app/dashboard
   - Выберите проект `nodeon`

2. **Добавьте переменные:**
   ```
   TELEGRAM_BOT_TOKEN=ваш_токен_бота
   TELEGRAM_BOT_USERNAME=имя_вашего_бота
   SECRET_KEY=ваш_секретный_ключ
   DEVELOPER_TELEGRAM_ID=207940967
   ```

### 4. 🧪 Тестирование системы

После настройки базы данных запустите:

```bash
python check_production_system.py
```

Должны получить: **6/6 компонентов работают** ✅

---

## 🌐 URL системы

- **Фронтенд:** https://kazilop.github.io/nodeon-pyramid/
- **API:** https://nodeon-production.up.railway.app/api
- **Telegram бот:** @ваш_бот_username

---

## 📱 Тестирование в Telegram

1. **Откройте бота в Telegram**
2. **Нажмите кнопку "Запустить приложение"**
3. **Проверьте:**
   - Отображается имя пользователя
   - Показывается баланс NDN
   - Работает покупка Pro статуса
   - Работает реферальная система

---

## 🔧 Устранение проблем

### Если Stars не работает:
- Проверьте выполнение SQL скрипта
- Убедитесь, что таблица `nodeon_stars_config` создана
- Проверьте функции `get_stars_config()`

### Если рефералы не работают:
- Проверьте таблицу `nodeon_referral_stats`
- Убедитесь, что функции `get_user_referrals()` и `validate_referral_link()` созданы

### Если API возвращает 500:
- Проверьте логи Railway: `railway logs`
- Убедитесь, что все переменные окружения настроены

---

## ✅ Финальная проверка

После выполнения всех шагов система должна работать на 100%:

- ✅ **Авторизация** - только через Telegram
- ✅ **База данных** - все таблицы и функции созданы
- ✅ **Stars** - покупка и вывод NDN
- ✅ **Рефералы** - система рефералов работает
- ✅ **Frontend** - красивый интерфейс
- ✅ **API** - все endpoints работают

**🎉 Система готова к использованию!**
