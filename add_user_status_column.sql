-- Добавляем колонку user_status в таблицу nodeon_users
ALTER TABLE nodeon_users 
ADD COLUMN user_status VARCHAR(20) DEFAULT 'user' NOT NULL;

-- Добавляем индексы для быстрого поиска по статусу
CREATE INDEX idx_nodeon_users_user_status ON nodeon_users(user_status);

-- Обновляем существующих пользователей
UPDATE nodeon_users SET user_status = 'developer' WHERE id = 5; -- Fish
UPDATE nodeon_users SET user_status = 'user' WHERE id IN (3, 4, 7, 14); -- Остальные

-- Создаем таблицу для заявок на обмен NDN на Stars
CREATE TABLE IF NOT EXISTS exchange_requests (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES nodeon_users(id),
    amount_ndn DECIMAL(15,2) NOT NULL,
    amount_stars INTEGER NOT NULL,
    telegram_username VARCHAR(255) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending' NOT NULL, -- pending, approved, rejected, completed
    description TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    processed_at TIMESTAMP,
    processed_by INTEGER REFERENCES nodeon_users(id),
    notes TEXT
);

-- Добавляем индексы для заявок на обмен
CREATE INDEX idx_exchange_requests_user_id ON exchange_requests(user_id);
CREATE INDEX idx_exchange_requests_status ON exchange_requests(status);
CREATE INDEX idx_exchange_requests_created_at ON exchange_requests(created_at);

-- Создаем таблицу для админских действий
CREATE TABLE IF NOT EXISTS admin_actions (
    id SERIAL PRIMARY KEY,
    admin_id INTEGER NOT NULL REFERENCES nodeon_users(id),
    action_type VARCHAR(50) NOT NULL, -- exchange_approve, exchange_reject, user_ban, etc.
    target_user_id INTEGER REFERENCES nodeon_users(id),
    target_id INTEGER, -- ID заявки или другого объекта
    description TEXT NOT NULL,
    data JSONB, -- Дополнительные данные в JSON
    created_at TIMESTAMP DEFAULT NOW()
);

-- Добавляем индексы для админских действий
CREATE INDEX idx_admin_actions_admin_id ON admin_actions(admin_id);
CREATE INDEX idx_admin_actions_action_type ON admin_actions(action_type);
CREATE INDEX idx_admin_actions_created_at ON admin_actions(created_at);

