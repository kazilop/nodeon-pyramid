-- Добавление таблиц для достижений и магазинов в NodeOn Crypto

-- 1. Таблица достижений
CREATE TABLE IF NOT EXISTS nodeon_achievements (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    icon VARCHAR(100) DEFAULT '🏆',
    category VARCHAR(50) DEFAULT 'general', -- general, trading, referral, social, special
    requirement_type VARCHAR(50) NOT NULL, -- balance, transactions, referrals, purchases, custom
    requirement_value DECIMAL(15,2) DEFAULT 0,
    reward_ndn DECIMAL(15,2) DEFAULT 0,
    reward_stars DECIMAL(15,2) DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Таблица пользовательских достижений
CREATE TABLE IF NOT EXISTS nodeon_user_achievements (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES nodeon_users(id) ON DELETE CASCADE,
    achievement_id INTEGER REFERENCES nodeon_achievements(id) ON DELETE CASCADE,
    progress DECIMAL(15,2) DEFAULT 0,
    is_completed BOOLEAN DEFAULT false,
    completed_at TIMESTAMP NULL,
    claimed_reward BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, achievement_id)
);

-- 3. Таблица магазинов
CREATE TABLE IF NOT EXISTS nodeon_shops (
    id SERIAL PRIMARY KEY,
    owner_id INTEGER REFERENCES nodeon_users(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    category VARCHAR(100) DEFAULT 'general', -- general, digital, physical, services
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Таблица товаров в магазинах
CREATE TABLE IF NOT EXISTS nodeon_shop_items (
    id SERIAL PRIMARY KEY,
    shop_id INTEGER REFERENCES nodeon_shops(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price_ndn DECIMAL(15,2) NOT NULL,
    price_stars DECIMAL(15,2) DEFAULT 0,
    item_type VARCHAR(50) DEFAULT 'digital', -- digital, physical, service
    category VARCHAR(100) DEFAULT 'general', -- congratulations, merchandise, services, etc.
    image_url VARCHAR(500),
    is_available BOOLEAN DEFAULT true,
    stock_quantity INTEGER DEFAULT -1, -- -1 = unlimited
    sold_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Таблица заказов
CREATE TABLE IF NOT EXISTS nodeon_orders (
    id SERIAL PRIMARY KEY,
    buyer_id INTEGER REFERENCES nodeon_users(id) ON DELETE CASCADE,
    shop_id INTEGER REFERENCES nodeon_shops(id) ON DELETE CASCADE,
    item_id INTEGER REFERENCES nodeon_shop_items(id) ON DELETE CASCADE,
    quantity INTEGER DEFAULT 1,
    total_price_ndn DECIMAL(15,2) NOT NULL,
    total_price_stars DECIMAL(15,2) DEFAULT 0,
    status VARCHAR(50) DEFAULT 'pending', -- pending, confirmed, shipped, delivered, cancelled
    delivery_info JSONB, -- адрес, контакты, специальные инструкции
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 6. Таблица отзывов о товарах
CREATE TABLE IF NOT EXISTS nodeon_item_reviews (
    id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES nodeon_orders(id) ON DELETE CASCADE,
    buyer_id INTEGER REFERENCES nodeon_users(id) ON DELETE CASCADE,
    item_id INTEGER REFERENCES nodeon_shop_items(id) ON DELETE CASCADE,
    rating INTEGER CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Индексы для оптимизации
CREATE INDEX IF NOT EXISTS idx_user_achievements_user_id ON nodeon_user_achievements(user_id);
CREATE INDEX IF NOT EXISTS idx_user_achievements_achievement_id ON nodeon_user_achievements(achievement_id);
CREATE INDEX IF NOT EXISTS idx_user_achievements_completed ON nodeon_user_achievements(is_completed);

CREATE INDEX IF NOT EXISTS idx_shops_owner_id ON nodeon_shops(owner_id);
CREATE INDEX IF NOT EXISTS idx_shops_category ON nodeon_shops(category);
CREATE INDEX IF NOT EXISTS idx_shops_active ON nodeon_shops(is_active);

CREATE INDEX IF NOT EXISTS idx_shop_items_shop_id ON nodeon_shop_items(shop_id);
CREATE INDEX IF NOT EXISTS idx_shop_items_category ON nodeon_shop_items(category);
CREATE INDEX IF NOT EXISTS idx_shop_items_available ON nodeon_shop_items(is_available);

CREATE INDEX IF NOT EXISTS idx_orders_buyer_id ON nodeon_orders(buyer_id);
CREATE INDEX IF NOT EXISTS idx_orders_shop_id ON nodeon_orders(shop_id);
CREATE INDEX IF NOT EXISTS idx_orders_status ON nodeon_orders(status);

CREATE INDEX IF NOT EXISTS idx_reviews_item_id ON nodeon_item_reviews(item_id);
CREATE INDEX IF NOT EXISTS idx_reviews_buyer_id ON nodeon_item_reviews(buyer_id);

-- Вставка базовых достижений
INSERT INTO nodeon_achievements (name, description, icon, category, requirement_type, requirement_value, reward_ndn, reward_stars) VALUES
-- Достижения по балансу
('Первые NDN', 'Получите первые 100 NDN', '💰', 'trading', 'balance', 100, 50, 0),
('Накопитель', 'Накопите 1000 NDN', '💎', 'trading', 'balance', 1000, 200, 0),
('Богач', 'Накопите 10000 NDN', '👑', 'trading', 'balance', 10000, 1000, 0),
('Миллионер', 'Накопите 100000 NDN', '🏆', 'trading', 'balance', 100000, 10000, 0),

-- Достижения по транзакциям
('Покупатель', 'Совершите 10 покупок', '🛒', 'trading', 'transactions', 10, 100, 0),
('Торговец', 'Совершите 100 покупок', '💼', 'trading', 'transactions', 100, 500, 0),
('Магнат', 'Совершите 1000 покупок', '🏢', 'trading', 'transactions', 1000, 2000, 0),

-- Достижения по рефералам
('Приглашатель', 'Пригласите первого друга', '👥', 'referral', 'referrals', 1, 100, 0),
('Лидер команды', 'Пригласите 10 друзей', '👑', 'referral', 'referrals', 10, 500, 0),
('Магнат рефералов', 'Пригласите 100 друзей', '🏆', 'referral', 'referrals', 100, 2000, 0),

-- Достижения по Pro статусу
('Pro пользователь', 'Купите Pro статус', '⭐', 'special', 'purchases', 1, 0, 100),
('Владелец магазина', 'Откройте свой магазин', '🏪', 'special', 'purchases', 1, 0, 200),

-- Достижения по социальной активности
('Первый отзыв', 'Оставьте первый отзыв', '💬', 'social', 'custom', 1, 50, 0),
('Критик', 'Оставьте 10 отзывов', '📝', 'social', 'custom', 10, 200, 0),
('Эксперт', 'Оставьте 50 отзывов', '🎓', 'social', 'custom', 50, 500, 0);

-- RPC функции для работы с достижениями
CREATE OR REPLACE FUNCTION get_user_achievements(user_telegram_id BIGINT)
RETURNS TABLE (
    achievement_id INTEGER,
    name VARCHAR(255),
    description TEXT,
    icon VARCHAR(100),
    category VARCHAR(50),
    progress DECIMAL(15,2),
    requirement_value DECIMAL(15,2),
    is_completed BOOLEAN,
    completed_at TIMESTAMP,
    claimed_reward BOOLEAN,
    reward_ndn DECIMAL(15,2),
    reward_stars DECIMAL(15,2)
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        a.id as achievement_id,
        a.name,
        a.description,
        a.icon,
        a.category,
        COALESCE(ua.progress, 0) as progress,
        a.requirement_value,
        COALESCE(ua.is_completed, false) as is_completed,
        ua.completed_at,
        COALESCE(ua.claimed_reward, false) as claimed_reward,
        a.reward_ndn,
        a.reward_stars
    FROM nodeon_achievements a
    LEFT JOIN nodeon_user_achievements ua ON a.id = ua.achievement_id 
        AND ua.user_id = (SELECT id FROM nodeon_users WHERE telegram_id = user_telegram_id)
    WHERE a.is_active = true
    ORDER BY a.category, a.requirement_value;
END;
$$ LANGUAGE plpgsql;

-- RPC функция для обновления прогресса достижений
CREATE OR REPLACE FUNCTION update_achievement_progress(
    user_telegram_id BIGINT,
    achievement_type VARCHAR(50),
    increment_value DECIMAL(15,2) DEFAULT 1
)
RETURNS TABLE (
    achievement_id INTEGER,
    name VARCHAR(255),
    is_newly_completed BOOLEAN,
    reward_ndn DECIMAL(15,2),
    reward_stars DECIMAL(15,2)
) AS $$
DECLARE
    user_id_var INTEGER;
    achievement_record RECORD;
    new_progress DECIMAL(15,2);
    is_completed_var BOOLEAN;
BEGIN
    -- Получаем ID пользователя
    SELECT id INTO user_id_var FROM nodeon_users WHERE telegram_id = user_telegram_id;
    
    IF user_id_var IS NULL THEN
        RETURN;
    END IF;
    
    -- Обновляем прогресс для всех достижений данного типа
    FOR achievement_record IN 
        SELECT a.id, a.requirement_value, a.reward_ndn, a.reward_stars, a.name
        FROM nodeon_achievements a
        WHERE a.requirement_type = achievement_type AND a.is_active = true
    LOOP
        -- Получаем текущий прогресс
        SELECT COALESCE(progress, 0) INTO new_progress
        FROM nodeon_user_achievements 
        WHERE user_id = user_id_var AND achievement_id = achievement_record.id;
        
        -- Увеличиваем прогресс
        new_progress := new_progress + increment_value;
        
        -- Проверяем, выполнено ли достижение
        is_completed_var := new_progress >= achievement_record.requirement_value;
        
        -- Вставляем или обновляем запись
        INSERT INTO nodeon_user_achievements (user_id, achievement_id, progress, is_completed, completed_at)
        VALUES (user_id_var, achievement_record.id, new_progress, is_completed_var, 
                CASE WHEN is_completed_var AND NOT EXISTS(
                    SELECT 1 FROM nodeon_user_achievements 
                    WHERE user_id = user_id_var AND achievement_id = achievement_record.id AND is_completed = true
                ) THEN CURRENT_TIMESTAMP ELSE NULL END)
        ON CONFLICT (user_id, achievement_id) 
        DO UPDATE SET 
            progress = new_progress,
            is_completed = is_completed_var,
            completed_at = CASE WHEN is_completed_var AND NOT ua.is_completed THEN CURRENT_TIMESTAMP ELSE ua.completed_at END
        FROM nodeon_user_achievements ua
        WHERE ua.user_id = user_id_var AND ua.achievement_id = achievement_record.id;
        
        -- Возвращаем информацию о достижении, если оно было выполнено
        IF is_completed_var AND NOT EXISTS(
            SELECT 1 FROM nodeon_user_achievements 
            WHERE user_id = user_id_var AND achievement_id = achievement_record.id AND is_completed = true
        ) THEN
            achievement_id := achievement_record.id;
            name := achievement_record.name;
            is_newly_completed := true;
            reward_ndn := achievement_record.reward_ndn;
            reward_stars := achievement_record.reward_stars;
            RETURN NEXT;
        END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- RPC функция для открытия магазина
CREATE OR REPLACE FUNCTION open_shop(
    user_telegram_id BIGINT,
    shop_name VARCHAR(255),
    shop_description TEXT,
    shop_category VARCHAR(100) DEFAULT 'general'
)
RETURNS TABLE (
    success BOOLEAN,
    message TEXT,
    shop_id INTEGER
) AS $$
DECLARE
    user_id_var INTEGER;
    user_balance DECIMAL(15,2);
    shop_cost DECIMAL(15,2) := 10000; -- 10,000 NDN для открытия магазина
    new_shop_id INTEGER;
BEGIN
    -- Получаем ID пользователя и его баланс
    SELECT id, balance_ndn INTO user_id_var, user_balance
    FROM nodeon_users 
    WHERE telegram_id = user_telegram_id;
    
    IF user_id_var IS NULL THEN
        RETURN QUERY SELECT false, 'Пользователь не найден', 0;
        RETURN;
    END IF;
    
    -- Проверяем баланс
    IF user_balance < shop_cost THEN
        RETURN QUERY SELECT false, 'Недостаточно NDN для открытия магазина (требуется 10,000 NDN)', 0;
        RETURN;
    END IF;
    
    -- Проверяем, нет ли уже магазина у пользователя
    IF EXISTS(SELECT 1 FROM nodeon_shops WHERE owner_id = user_id_var AND is_active = true) THEN
        RETURN QUERY SELECT false, 'У вас уже есть активный магазин', 0;
        RETURN;
    END IF;
    
    -- Создаем магазин
    INSERT INTO nodeon_shops (owner_id, name, description, category)
    VALUES (user_id_var, shop_name, shop_description, shop_category)
    RETURNING id INTO new_shop_id;
    
    -- Списываем NDN
    UPDATE nodeon_users 
    SET balance_ndn = balance_ndn - shop_cost
    WHERE id = user_id_var;
    
    -- Создаем транзакцию
    INSERT INTO nodeon_transactions (user_id, type, amount_ndn, description)
    VALUES (user_id_var, 'shop_opening', -shop_cost, 'Открытие магазина: ' || shop_name);
    
    RETURN QUERY SELECT true, 'Магазин успешно открыт!', new_shop_id;
END;
$$ LANGUAGE plpgsql;

-- RPC функция для получения магазинов пользователя
CREATE OR REPLACE FUNCTION get_user_shops(user_telegram_id BIGINT)
RETURNS TABLE (
    shop_id INTEGER,
    name VARCHAR(255),
    description TEXT,
    category VARCHAR(100),
    is_active BOOLEAN,
    created_at TIMESTAMP,
    items_count BIGINT,
    total_sales BIGINT
) AS $$
DECLARE
    user_id_var INTEGER;
BEGIN
    -- Получаем ID пользователя
    SELECT id INTO user_id_var FROM nodeon_users WHERE telegram_id = user_telegram_id;
    
    IF user_id_var IS NULL THEN
        RETURN;
    END IF;
    
    RETURN QUERY
    SELECT 
        s.id as shop_id,
        s.name,
        s.description,
        s.category,
        s.is_active,
        s.created_at,
        COUNT(si.id) as items_count,
        COALESCE(SUM(si.sold_count), 0) as total_sales
    FROM nodeon_shops s
    LEFT JOIN nodeon_shop_items si ON s.id = si.shop_id
    WHERE s.owner_id = user_id_var
    GROUP BY s.id, s.name, s.description, s.category, s.is_active, s.created_at
    ORDER BY s.created_at DESC;
END;
$$ LANGUAGE plpgsql;

-- RPC функция для добавления товара в магазин
CREATE OR REPLACE FUNCTION add_shop_item(
    user_telegram_id BIGINT,
    shop_id INTEGER,
    item_name VARCHAR(255),
    item_description TEXT,
    price_ndn DECIMAL(15,2),
    price_stars DECIMAL(15,2) DEFAULT 0,
    item_type VARCHAR(50) DEFAULT 'digital',
    item_category VARCHAR(100) DEFAULT 'general',
    image_url VARCHAR(500) DEFAULT NULL,
    stock_quantity INTEGER DEFAULT -1
)
RETURNS TABLE (
    success BOOLEAN,
    message TEXT,
    item_id INTEGER
) AS $$
DECLARE
    user_id_var INTEGER;
    shop_owner_id INTEGER;
    new_item_id INTEGER;
BEGIN
    -- Получаем ID пользователя
    SELECT id INTO user_id_var FROM nodeon_users WHERE telegram_id = user_telegram_id;
    
    IF user_id_var IS NULL THEN
        RETURN QUERY SELECT false, 'Пользователь не найден', 0;
        RETURN;
    END IF;
    
    -- Проверяем, что магазин принадлежит пользователю
    SELECT owner_id INTO shop_owner_id FROM nodeon_shops WHERE id = shop_id;
    
    IF shop_owner_id IS NULL THEN
        RETURN QUERY SELECT false, 'Магазин не найден', 0;
        RETURN;
    END IF;
    
    IF shop_owner_id != user_id_var THEN
        RETURN QUERY SELECT false, 'У вас нет прав на этот магазин', 0;
        RETURN;
    END IF;
    
    -- Добавляем товар
    INSERT INTO nodeon_shop_items (
        shop_id, name, description, price_ndn, price_stars, 
        item_type, category, image_url, stock_quantity
    )
    VALUES (
        shop_id, item_name, item_description, price_ndn, price_stars,
        item_type, item_category, image_url, stock_quantity
    )
    RETURNING id INTO new_item_id;
    
    RETURN QUERY SELECT true, 'Товар успешно добавлен!', new_item_id;
END;
$$ LANGUAGE plpgsql;

-- RPC функция для покупки товара
CREATE OR REPLACE FUNCTION buy_shop_item(
    buyer_telegram_id BIGINT,
    item_id INTEGER,
    quantity INTEGER DEFAULT 1
)
RETURNS TABLE (
    success BOOLEAN,
    message TEXT,
    order_id INTEGER
) AS $$
DECLARE
    buyer_id_var INTEGER;
    buyer_balance DECIMAL(15,2);
    item_record RECORD;
    total_price DECIMAL(15,2);
    new_order_id INTEGER;
BEGIN
    -- Получаем ID покупателя и его баланс
    SELECT id, balance_ndn INTO buyer_id_var, buyer_balance
    FROM nodeon_users 
    WHERE telegram_id = buyer_telegram_id;
    
    IF buyer_id_var IS NULL THEN
        RETURN QUERY SELECT false, 'Покупатель не найден', 0;
        RETURN;
    END IF;
    
    -- Получаем информацию о товаре
    SELECT si.*, s.owner_id, s.name as shop_name
    INTO item_record
    FROM nodeon_shop_items si
    JOIN nodeon_shops s ON si.shop_id = s.id
    WHERE si.id = item_id AND si.is_available = true;
    
    IF item_record.id IS NULL THEN
        RETURN QUERY SELECT false, 'Товар не найден или недоступен', 0;
        RETURN;
    END IF;
    
    -- Проверяем количество на складе
    IF item_record.stock_quantity > 0 AND item_record.stock_quantity < quantity THEN
        RETURN QUERY SELECT false, 'Недостаточно товара на складе', 0;
        RETURN;
    END IF;
    
    -- Вычисляем общую стоимость
    total_price := item_record.price_ndn * quantity;
    
    -- Проверяем баланс покупателя
    IF buyer_balance < total_price THEN
        RETURN QUERY SELECT false, 'Недостаточно NDN для покупки', 0;
        RETURN;
    END IF;
    
    -- Создаем заказ
    INSERT INTO nodeon_orders (buyer_id, shop_id, item_id, quantity, total_price_ndn, total_price_stars)
    VALUES (buyer_id_var, item_record.shop_id, item_id, quantity, total_price, item_record.price_stars * quantity)
    RETURNING id INTO new_order_id;
    
    -- Списываем NDN с покупателя
    UPDATE nodeon_users 
    SET balance_ndn = balance_ndn - total_price
    WHERE id = buyer_id_var;
    
    -- Зачисляем NDN владельцу магазина
    UPDATE nodeon_users 
    SET balance_ndn = balance_ndn + total_price
    WHERE id = item_record.owner_id;
    
    -- Обновляем количество проданных товаров
    UPDATE nodeon_shop_items 
    SET sold_count = sold_count + quantity,
        stock_quantity = CASE 
            WHEN stock_quantity > 0 THEN stock_quantity - quantity 
            ELSE stock_quantity 
        END
    WHERE id = item_id;
    
    -- Создаем транзакции
    INSERT INTO nodeon_transactions (user_id, type, amount_ndn, description)
    VALUES 
        (buyer_id_var, 'shop_purchase', -total_price, 'Покупка: ' || item_record.name),
        (item_record.owner_id, 'shop_sale', total_price, 'Продажа: ' || item_record.name);
    
    RETURN QUERY SELECT true, 'Товар успешно куплен!', new_order_id;
END;
$$ LANGUAGE plpgsql;

-- Обновляем функцию обновления статистики для включения достижений
CREATE OR REPLACE FUNCTION update_user_stats(user_telegram_id BIGINT)
RETURNS VOID AS $$
DECLARE
    user_id_var INTEGER;
    user_balance DECIMAL(15,2);
    user_transactions INTEGER;
    user_referrals INTEGER;
BEGIN
    -- Получаем ID пользователя
    SELECT id INTO user_id_var FROM nodeon_users WHERE telegram_id = user_telegram_id;
    
    IF user_id_var IS NULL THEN
        RETURN;
    END IF;
    
    -- Получаем статистику
    SELECT balance_ndn INTO user_balance FROM nodeon_users WHERE id = user_id_var;
    SELECT COUNT(*) INTO user_transactions FROM nodeon_transactions WHERE user_id = user_id_var;
    SELECT COUNT(*) INTO user_referrals FROM nodeon_users WHERE inviter_id = user_id_var;
    
    -- Обновляем достижения
    PERFORM update_achievement_progress(user_telegram_id, 'balance', user_balance);
    PERFORM update_achievement_progress(user_telegram_id, 'transactions', user_transactions);
    PERFORM update_achievement_progress(user_telegram_id, 'referrals', user_referrals);
END;
$$ LANGUAGE plpgsql;

COMMENT ON TABLE nodeon_achievements IS 'Таблица достижений в игре';
COMMENT ON TABLE nodeon_user_achievements IS 'Прогресс пользователей по достижениям';
COMMENT ON TABLE nodeon_shops IS 'Магазины пользователей';
COMMENT ON TABLE nodeon_shop_items IS 'Товары в магазинах';
COMMENT ON TABLE nodeon_orders IS 'Заказы товаров';
COMMENT ON TABLE nodeon_item_reviews IS 'Отзывы о товарах';

