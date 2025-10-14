-- Добавляем колонки для упрощения работы с реферальной системой

-- Добавляем колонку для хранения всех рефералов пользователя (массив ID)
ALTER TABLE nodeon_users 
ADD COLUMN all_referrals INTEGER[] DEFAULT '{}';

-- Добавляем колонку для хранения рефералов по уровням (JSON)
ALTER TABLE nodeon_users 
ADD COLUMN referrals_by_level JSONB DEFAULT '{}';

-- Добавляем колонку для хранения общего количества рефералов
ALTER TABLE nodeon_users 
ADD COLUMN total_referrals_count INTEGER DEFAULT 0;

-- Добавляем колонку для хранения количества PRO рефералов
ALTER TABLE nodeon_users 
ADD COLUMN pro_referrals_count INTEGER DEFAULT 0;

-- Добавляем колонку для хранения количества обычных рефералов
ALTER TABLE nodeon_users 
ADD COLUMN regular_referrals_count INTEGER DEFAULT 0;

-- Добавляем колонку для хранения общего заработка с рефералов
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

