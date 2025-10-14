-- Добавляем колонки для отслеживания Stars в таблицу nodeon_server_wallet
ALTER TABLE nodeon_server_wallet 
ADD COLUMN total_stars_received DECIMAL DEFAULT 0,
ADD COLUMN total_stars_sent DECIMAL DEFAULT 0;

-- Обновляем существующую запись, устанавливая значения по умолчанию
UPDATE nodeon_server_wallet 
SET 
    total_stars_received = 0,
    total_stars_sent = 0
WHERE id = 1;

