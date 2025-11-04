#!/usr/bin/env python3
"""
Скрипт для создания данных локализации из существующих JSON файлов
"""

import json
import os
from pathlib import Path

def load_existing_translations():
    """Загружает существующие переводы из JSON файлов"""
    translations = {}
    
    # Список языков
    languages = ['ru', 'en', 'es', 'de', 'fr', 'it', 'pt', 'ar', 'hi', 'ja', 'ko', 'zh']
    
    for lang in languages:
        file_path = Path(f'locales/{lang}.json')
        if file_path.exists():
            try:
                with open(file_path, 'r', encoding='utf-8') as f:
                    data = json.load(f)
                    translations[lang] = data
                print(f"Загружен {lang}.json: {len(data)} записей")
            except Exception as e:
                print(f"Ошибка загрузки {lang}.json: {e}")
        else:
            print(f"Файл {lang}.json не найден")
    
    return translations

def create_localization_records(translations):
    """Создает записи для таблицы локализации"""
    records = []
    
    # Берем русский как основной язык
    ru_data = translations.get('ru', {})
    
    def flatten_dict(d, prefix=''):
        """Рекурсивно разворачивает вложенные словари"""
        items = []
        for key, value in d.items():
            new_key = f"{prefix}.{key}" if prefix else key
            if isinstance(value, dict):
                items.extend(flatten_dict(value, new_key))
            else:
                items.append((new_key, value))
        return items
    
    # Разворачиваем вложенные словари
    flattened_ru = flatten_dict(ru_data)
    
    for text_id, ru_text in flattened_ru:
        # Пропускаем не-строковые значения
        if not isinstance(ru_text, str):
            continue
            
        record = {
            'text_id': text_id,
            'ru': ru_text
        }
        
        # Добавляем переводы для других языков
        for lang in ['en', 'es', 'de', 'fr', 'it', 'pt', 'ar', 'hi', 'ja', 'ko', 'zh']:
            if lang in translations:
                # Ищем перевод в развернутом словаре
                flattened_lang = flatten_dict(translations[lang])
                lang_dict = dict(flattened_lang)
                if text_id in lang_dict and isinstance(lang_dict[text_id], str):
                    record[lang] = lang_dict[text_id]
                else:
                    record[lang] = None
            else:
                record[lang] = None
        
        records.append(record)
    
    return records

def generate_sql_inserts(records):
    """Генерирует SQL INSERT запросы"""
    sql_queries = []
    
    for record in records:
        # Экранируем кавычки
        ru_text = record['ru'].replace("'", "''") if record['ru'] else ''
        
        # Создаем SQL запрос
        columns = ['text_id', 'ru']
        values = [f"'{record['text_id']}'", f"'{ru_text}'"]
        
        for lang in ['en', 'es', 'de', 'fr', 'it', 'pt', 'ar', 'hi', 'ja', 'ko', 'zh']:
            if record.get(lang):
                columns.append(lang)
                escaped_text = record[lang].replace("'", "''")
                values.append(f"'{escaped_text}'")
        
        columns_str = ', '.join(columns)
        values_str = ', '.join(values)
        
        sql = f"""INSERT INTO nodeon_localization ({columns_str}) 
                  VALUES ({values_str})
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;"""
        
        sql_queries.append(sql)
    
    return sql_queries

def main():
    """Основная функция"""
    print("Создание данных локализации...")
    
    # Загружаем существующие переводы
    translations = load_existing_translations()
    
    if not translations:
        print("Не найдены файлы переводов!")
        return
    
    # Создаем записи
    records = create_localization_records(translations)
    print(f"Создано {len(records)} записей для локализации")
    
    # Генерируем SQL
    sql_queries = generate_sql_inserts(records)
    
    # Сохраняем SQL файл
    with open('insert_localization_from_json.sql', 'w', encoding='utf-8') as f:
        f.write("-- SQL запросы для вставки локализации из JSON файлов\n")
        f.write("-- Сгенерировано автоматически\n\n")
        for query in sql_queries:
            f.write(query + "\n")
    
    print("Файл создан: insert_localization_from_json.sql")
    
    # Показываем статистику по языкам
    print("\nСтатистика по языкам:")
    for lang, data in translations.items():
        print(f"  {lang}: {len(data)} записей")

if __name__ == "__main__":
    main()
