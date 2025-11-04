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

-- Создание индексов для быстрого поиска
CREATE INDEX IF NOT EXISTS idx_localization_text_id ON nodeon_localization(text_id);
CREATE INDEX IF NOT EXISTS idx_localization_updated_at ON nodeon_localization(updated_at);

-- Добавление комментариев к таблице
COMMENT ON TABLE nodeon_localization IS 'Таблица локализации для всех текстов приложения';
COMMENT ON COLUMN nodeon_localization.text_id IS 'Уникальный идентификатор текста (например: buttons.buy_pro)';
COMMENT ON COLUMN nodeon_localization.ru IS 'Русский текст (обязательный)';
COMMENT ON COLUMN nodeon_localization.en IS 'Английский текст';
COMMENT ON COLUMN nodeon_localization.es IS 'Испанский текст';
COMMENT ON COLUMN nodeon_localization.de IS 'Немецкий текст';
COMMENT ON COLUMN nodeon_localization.fr IS 'Французский текст';
COMMENT ON COLUMN nodeon_localization.it IS 'Итальянский текст';
COMMENT ON COLUMN nodeon_localization.pt IS 'Португальский текст';
COMMENT ON COLUMN nodeon_localization.ar IS 'Арабский текст';
COMMENT ON COLUMN nodeon_localization.hi IS 'Хинди текст';
COMMENT ON COLUMN nodeon_localization.ja IS 'Японский текст';
COMMENT ON COLUMN nodeon_localization.ko IS 'Корейский текст';
COMMENT ON COLUMN nodeon_localization.zh IS 'Китайский текст';













