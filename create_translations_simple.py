#!/usr/bin/env python3
import requests
import json
import os

# Supabase конфигурация
SUPABASE_URL = "https://ahxwpzgltlzlvrtrbanm.supabase.co"
SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoeHdwemdsdGx6bHZydHJiYW5tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1MDMxNDksImV4cCI6MjA3NTA3OTE0OX0.h4sMVhVwvRUiHgbevDgv9W1G2S__uDWPUSCiXdrEy4E"

def create_translations_table():
    """Создание таблицы переводов через SQL"""
    print("Creating translations table...")
    
    # Создаем таблицу через SQL Editor в Supabase
    # Пока что просто проверим, существует ли таблица
    response = requests.get(
        f"{SUPABASE_URL}/rest/v1/nodeon_translations?select=*&limit=1",
        headers={
            "apikey": SUPABASE_ANON_KEY,
            "Authorization": f"Bearer {SUPABASE_ANON_KEY}"
        }
    )
    
    if response.status_code == 200:
        print("Translations table already exists")
        return True
    elif response.status_code == 404:
        print("Translations table does not exist. Please create it manually in Supabase SQL Editor:")
        print("""
CREATE TABLE nodeon_translations (
    id SERIAL PRIMARY KEY,
    language VARCHAR(10) NOT NULL,
    key_path VARCHAR(255) NOT NULL,
    value TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(language, key_path)
);

CREATE INDEX idx_translations_language ON nodeon_translations(language);
CREATE INDEX idx_translations_key_path ON nodeon_translations(key_path);
        """)
        return False
    else:
        print(f"Error checking table: {response.status_code}")
        return False

def load_translations_from_file(language):
    """Загрузка переводов из файла"""
    file_path = f"locales/{language}.json"
    if not os.path.exists(file_path):
        print(f"File {file_path} not found")
        return None
    
    with open(file_path, 'r', encoding='utf-8') as f:
        return json.load(f)

def flatten_translations(translations, prefix=""):
    """Преобразование вложенных переводов в плоскую структуру"""
    result = {}
    for key, value in translations.items():
        new_key = f"{prefix}.{key}" if prefix else key
        if isinstance(value, dict):
            result.update(flatten_translations(value, new_key))
        else:
            result[new_key] = value
    return result

def insert_translations(language, translations):
    """Вставка переводов в базу данных"""
    print(f"Inserting translations for language {language}...")
    
    flattened = flatten_translations(translations)
    
    # Подготавливаем данные для вставки
    data = []
    for key_path, value in flattened.items():
        data.append({
            "language": language,
            "key_path": key_path,
            "value": str(value)
        })
    
    # Вставляем данные
    response = requests.post(
        f"{SUPABASE_URL}/rest/v1/nodeon_translations",
        headers={
            "apikey": SUPABASE_ANON_KEY,
            "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
            "Content-Type": "application/json"
        },
        json=data
    )
    
    if response.status_code == 201:
        print(f"Translations for {language} inserted successfully ({len(data)} records)")
        return True
    else:
        print(f"Error inserting translations for {language}: {response.status_code}")
        print(response.text)
        return False

def main():
    """Основная функция"""
    print("Starting translations table creation and data loading...")
    
    # Проверяем таблицу
    if not create_translations_table():
        print("Please create the table manually first")
        return
    
    # Загружаем переводы для всех языков
    languages = ["ru", "en", "es", "de", "fr", "ar", "hi", "it", "ja", "ko", "pt", "zh"]
    
    for lang in languages:
        translations = load_translations_from_file(lang)
        if translations:
            insert_translations(lang, translations)
        else:
            print(f"Skipping language {lang}")
    
    print("Translations loading completed!")

if __name__ == "__main__":
    main()












