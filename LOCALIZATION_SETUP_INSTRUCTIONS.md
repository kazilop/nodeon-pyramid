# 🌐 ИНСТРУКЦИЯ: Настройка системы локализации

## ❌ ПРОБЛЕМА: API локализации не работает

**Симптомы:**
- API `/api/localization/en` возвращает HTML вместо JSON
- Переводы не работают на английском языке
- Не все тексты переводятся

**Причина:** Таблица `nodeon_localization` не создана в Supabase

## ✅ РЕШЕНИЕ: Создание таблицы локализации

### Шаг 1: Создать таблицу в Supabase

1. **Откройте Supabase Dashboard:**
   - Перейдите на https://supabase.com/dashboard
   - Выберите ваш проект

2. **Откройте SQL Editor:**
   - В левом меню нажмите "SQL Editor"
   - Нажмите "New query"

3. **Выполните SQL запрос:**
   ```sql
   -- Создание таблицы локализации
   CREATE TABLE IF NOT EXISTS nodeon_localization (
       id SERIAL PRIMARY KEY,
       text_id VARCHAR(100) NOT NULL UNIQUE,
       ru TEXT NOT NULL,
       en TEXT,
       es TEXT,
       de TEXT,
       fr TEXT,
       it TEXT,
       pt TEXT,
       ar TEXT,
       hi TEXT,
       ja TEXT,
       ko TEXT,
       zh TEXT,
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );

   -- Создание индексов
   CREATE INDEX IF NOT EXISTS idx_localization_text_id ON nodeon_localization(text_id);
   CREATE INDEX IF NOT EXISTS idx_localization_updated_at ON nodeon_localization(updated_at);
   ```

4. **Нажмите "Run"** для выполнения запроса

### Шаг 2: Заполнить таблицу данными

1. **В том же SQL Editor выполните:**
   ```sql
   -- Вставка базовых переводов
   INSERT INTO nodeon_localization (text_id, ru, en, es) VALUES
   ('app.name', '🚀 NodeOn Crypto', '🚀 NodeOn Crypto', '🚀 NodeOn Crypto'),
   ('app.description', 'Крипто игра с монетами NDN', 'Crypto game with NDN coins', 'Juego de cripto con monedas NDN'),
   ('tabs.core', '🏠 Основное', '🏠 Main', '🏠 Principal'),
   ('tabs.game', '🎮 Игра', '🎮 Game', '🎮 Juego'),
   ('tabs.miner', '⛏️ NDN Miner', '⛏️ NDN Miner', '⛏️ NDN Miner'),
   ('user.balance_ndn', 'NDN Баланс', 'NDN Balance', 'Saldo NDN'),
   ('user.balance_stars', 'Stars Баланс', 'Stars Balance', 'Saldo Stars'),
   ('buttons.buy_pro', '💎 Купить Pro статус', '💎 Buy Pro Status', '💎 Comprar Estado Pro'),
   ('buttons.buy_ndn', '⭐ Купить NDN за Telegram Stars', '⭐ Buy NDN for Telegram Stars', '⭐ Comprar NDN por Telegram Stars'),
   ('buttons.exchange', '⭐ Обменять NDN на Stars', '⭐ Exchange NDN for Stars', '⭐ Intercambiar NDN por Stars'),
   ('buttons.transfer_ndn', '💸 Перевести NDN', '💸 Transfer NDN', '💸 Transferir NDN'),
   ('buttons.referrals', '👥 Мои рефералы', '👥 My Referrals', '👥 Mis Referidos'),
   ('buttons.leaderboard', '🏆 Таблица лидеров', '🏆 Leaderboard', '🏆 Tabla de Lideres'),
   ('buttons.rules', '📋 Правила игры', '📋 Game Rules', '📋 Reglas del Juego'),
   ('pro.title', 'Pro Статус', 'Pro Status', 'Estado Pro'),
   ('pro.cost', 'Стоимость: 1000 NDN', 'Cost: 1000 NDN', 'Costo: 1000 NDN'),
   ('miner.title', 'NDN Майнер', 'NDN Miner', 'NDN Miner'),
   ('miner.energy', 'Энергия', 'Energy', 'Energia'),
   ('miner.gas', 'Газ', 'Gas', 'Gas'),
   ('game.title', 'Игра', 'Game', 'Juego'),
   ('game.achievements', 'Достижения', 'Achievements', 'Logros'),
   ('game.daily_reward', 'Ежедневная награда', 'Daily Reward', 'Recompensa Diaria'),
   ('referrals.title', 'Мои рефералы', 'My Referrals', 'Mis Referidos'),
   ('referrals.total', 'Всего рефералов', 'Total Referrals', 'Total Referidos'),
   ('leaderboard.title', '🏆 Таблица лидеров', '🏆 Leaderboard', '🏆 Tabla de Lideres'),
   ('leaderboard.subtitle', 'Топ игроков по балансу NDN', 'Top players by NDN balance', 'Mejores jugadores por saldo NDN'),
   ('rules.title', '📋 Правила игры', '📋 Game Rules', '📋 Reglas del Juego'),
   ('admin.title', 'Админ панель', 'Admin Panel', 'Panel de Admin'),
   ('admin.users', 'Всего пользователей', 'Total Users', 'Total Usuarios'),
   ('admin.pro_users', 'Pro пользователей', 'Pro Users', 'Usuarios Pro'),
   ('admin.wallet', 'Серверный кошелек', 'Server Wallet', 'Billetera del Servidor')
   ON CONFLICT (text_id) DO UPDATE SET
       ru = EXCLUDED.ru,
       en = EXCLUDED.en,
       es = EXCLUDED.es,
       updated_at = CURRENT_TIMESTAMP;
   ```

2. **Нажмите "Run"** для выполнения запроса

### Шаг 3: Перезапустить сервер

1. **Подключитесь к серверу:**
   ```bash
   ssh sistemypro
   ```

2. **Перезапустите приложение:**
   ```bash
   pm2 restart nodeon
   ```

3. **Проверьте статус:**
   ```bash
   pm2 status
   ```

### Шаг 4: Проверить работу

1. **Откройте сайт:** https://sistemypro.ru

2. **Проверьте API локализации:**
   - Откройте https://sistemypro.ru/api/localization/en
   - Должен вернуться JSON с переводами

3. **Проверьте переключение языков:**
   - Выберите английский язык в селекторе
   - Все тексты должны перевестись на английский

## 🔧 ДОПОЛНИТЕЛЬНЫЕ ИСПРАВЛЕНИЯ

### Если переводы все еще не работают:

1. **Проверьте консоль браузера:**
   - Откройте Developer Tools (F12)
   - Посмотрите на ошибки в консоли

2. **Проверьте загрузку переводов:**
   ```javascript
   // В консоли браузера выполните:
   console.log(window.translations);
   console.log(window.currentLanguage);
   ```

3. **Принудительно загрузите переводы:**
   ```javascript
   // В консоли браузера выполните:
   loadTranslations('en');
   ```

### Если нужно добавить больше переводов:

1. **Добавьте новые записи в Supabase:**
   ```sql
   INSERT INTO nodeon_localization (text_id, ru, en, es) VALUES
   ('новый.текст', 'Русский текст', 'English text', 'Texto español')
   ON CONFLICT (text_id) DO UPDATE SET
       ru = EXCLUDED.ru,
       en = EXCLUDED.en,
       es = EXCLUDED.es;
   ```

2. **Добавьте data-i18n атрибут в HTML:**
   ```html
   <button data-i18n="новый.текст">Русский текст</button>
   ```

## 📊 ПРОВЕРКА РЕЗУЛЬТАТА

После выполнения всех шагов:

✅ **API локализации работает** - возвращает JSON  
✅ **Английский язык переводится** - все тексты на английском  
✅ **Меню кнопок переводится** - кнопки имеют data-i18n  
✅ **Вкладка "Игра" переводится** - вкладки имеют data-i18n  
✅ **Все тексты переводятся** - полная локализация  

## 🎉 ГОТОВО!

Система локализации будет полностью работать после создания таблицы в Supabase!













