-- Создание таблицы локализации в Supabase
-- Выполните этот SQL в Supabase Dashboard -> SQL Editor

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













