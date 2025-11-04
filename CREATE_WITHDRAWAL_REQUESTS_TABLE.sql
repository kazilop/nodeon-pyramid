-- Создание таблицы для заявок на вывод Stars

CREATE TABLE IF NOT EXISTS nodeon_withdrawal_requests (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES nodeon_users(id) ON DELETE CASCADE,
    telegram_id BIGINT NOT NULL,
    telegram_username VARCHAR(255),
    amount_ndn DECIMAL(10,2) NOT NULL,
    amount_stars DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) DEFAULT 'pending' NOT NULL, -- 'pending', 'approved', 'rejected', 'completed'
    days_since_deposit INTEGER, -- Количество дней с момента последнего ввода Stars
    last_deposit_date TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    reviewed_at TIMESTAMP WITH TIME ZONE,
    completed_at TIMESTAMP WITH TIME ZONE,
    admin_notes TEXT,
    reviewed_by INTEGER REFERENCES nodeon_users(id) ON DELETE SET NULL -- ID админа, который рассмотрел заявку
);

-- Индексы для оптимизации
CREATE INDEX IF NOT EXISTS idx_withdrawal_requests_user_id ON nodeon_withdrawal_requests(user_id);
CREATE INDEX IF NOT EXISTS idx_withdrawal_requests_status ON nodeon_withdrawal_requests(status);
CREATE INDEX IF NOT EXISTS idx_withdrawal_requests_created_at ON nodeon_withdrawal_requests(created_at);
CREATE INDEX IF NOT EXISTS idx_withdrawal_requests_telegram_id ON nodeon_withdrawal_requests(telegram_id);

-- Добавляем колонку для отслеживания последней покупки Stars
ALTER TABLE nodeon_users 
ADD COLUMN IF NOT EXISTS last_stars_deposit_date TIMESTAMP WITH TIME ZONE;

-- Функция для проверки возможности вывода
CREATE OR REPLACE FUNCTION can_withdraw_stars(p_user_id INTEGER)
RETURNS JSON AS $$
DECLARE
    user_record RECORD;
    last_deposit_date TIMESTAMP WITH TIME ZONE;
    days_passed INTEGER;
    can_withdraw BOOLEAN;
    error_message TEXT;
BEGIN
    -- Получаем данные пользователя
    SELECT * INTO user_record FROM nodeon_users WHERE id = p_user_id;
    
    IF NOT FOUND THEN
        RETURN json_build_object('success', false, 'error', 'User not found');
    END IF;
    
    -- Получаем дату последнего ввода Stars
    last_deposit_date := user_record.last_stars_deposit_date;
    
    IF last_deposit_date IS NULL THEN
        RETURN json_build_object(
            'success', false, 
            'can_withdraw', false,
            'error', 'No Stars deposits found',
            'message', 'Вы можете выводить Stars только после ввода их в систему'
        );
    END IF;
    
    -- Вычисляем сколько дней прошло
    days_passed := EXTRACT(DAY FROM NOW() - last_deposit_date);
    
    can_withdraw := days_passed >= 21;
    
    RETURN json_build_object(
        'success', true,
        'can_withdraw', can_withdraw,
        'days_passed', days_passed,
        'days_required', 21,
        'last_deposit_date', last_deposit_date,
        'message', CASE 
            WHEN can_withdraw THEN 'Вывод доступен'
            ELSE format('Осталось ждать %s дней', 21 - days_passed)
        END
    );
END;
$$ LANGUAGE plpgsql;











