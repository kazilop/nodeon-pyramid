#!/usr/bin/env python3
"""
Скрипт для извлечения всех текстов из HTML и создания записей локализации в БД
"""

import re
import json
from pathlib import Path

def extract_texts_from_html(html_file):
    """Извлекает все тексты из HTML файла"""
    texts = {}
    
    with open(html_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Паттерны для поиска текстов
    patterns = [
        # data-i18n атрибуты
        (r'data-i18n="([^"]+)"', 'i18n'),
        # Тексты в кнопках
        (r'<button[^>]*>([^<]+)</button>', 'button'),
        # Тексты в заголовках
        (r'<h[1-6][^>]*>([^<]+)</h[1-6]>', 'heading'),
        # Тексты в div с классом
        (r'<div[^>]*class="[^"]*title[^"]*"[^>]*>([^<]+)</div>', 'title'),
        # Тексты в span
        (r'<span[^>]*>([^<]+)</span>', 'span'),
        # Тексты в label
        (r'<label[^>]*>([^<]+)</label>', 'label'),
        # Тексты в placeholder
        (r'placeholder="([^"]+)"', 'placeholder'),
        # Тексты в title атрибутах
        (r'title="([^"]+)"', 'title_attr'),
        # Тексты в alt атрибутах
        (r'alt="([^"]+)"', 'alt'),
        # Тексты в JavaScript строках
        (r'["\']([А-Яа-яЁё\s\w\.,!?\-:;]+)["\']', 'js_string'),
    ]
    
    for pattern, category in patterns:
        matches = re.findall(pattern, content, re.IGNORECASE)
        for match in matches:
            # Очищаем текст
            text = match.strip()
            if len(text) > 2 and not text.startswith(('http', 'data:', 'var ', 'function', 'class ', 'id ')):
                # Создаем ID для текста
                text_id = create_text_id(text, category)
                if text_id not in texts:
                    texts[text_id] = {
                        'text': text,
                        'category': category,
                        'context': get_context(content, text)
                    }
    
    return texts

def create_text_id(text, category):
    """Создает уникальный ID для текста"""
    # Убираем специальные символы и создаем ID
    clean_text = re.sub(r'[^\w\s]', '', text.lower())
    words = clean_text.split()[:3]  # Берем первые 3 слова
    
    if category == 'i18n':
        # Для data-i18n используем существующий ID
        return text
    elif category == 'button':
        return f"buttons.{'_'.join(words)}"
    elif category == 'heading':
        return f"headings.{'_'.join(words)}"
    elif category == 'title':
        return f"titles.{'_'.join(words)}"
    elif category == 'placeholder':
        return f"placeholders.{'_'.join(words)}"
    elif category == 'label':
        return f"labels.{'_'.join(words)}"
    else:
        return f"texts.{'_'.join(words)}"

def get_context(content, text):
    """Получает контекст вокруг текста"""
    # Находим позицию текста в контенте
    pos = content.find(text)
    if pos != -1:
        start = max(0, pos - 100)
        end = min(len(content), pos + len(text) + 100)
        return content[start:end].replace('\n', ' ').strip()
    return ""

def generate_sql_inserts(texts):
    """Генерирует SQL INSERT запросы"""
    sql_queries = []
    
    for text_id, data in texts.items():
        # Экранируем кавычки в тексте
        ru_text = data['text'].replace("'", "''")
        
        sql = f"""INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('{text_id}', '{ru_text}', '{data['category']}', '{data['context'][:200]}')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;"""
        sql_queries.append(sql)
    
    return sql_queries

def main():
    """Основная функция"""
    html_file = Path('server-deployment/public/index.html')
    
    if not html_file.exists():
        print(f"Файл {html_file} не найден!")
        return
    
    print("Извлекаем тексты из HTML...")
    texts = extract_texts_from_html(html_file)
    
    print(f"Найдено {len(texts)} текстов для локализации")
    
    # Сохраняем в JSON для просмотра
    with open('extracted_texts.json', 'w', encoding='utf-8') as f:
        json.dump(texts, f, ensure_ascii=False, indent=2)
    
    # Генерируем SQL запросы
    sql_queries = generate_sql_inserts(texts)
    
    # Сохраняем SQL файл
    with open('insert_localization.sql', 'w', encoding='utf-8') as f:
        f.write("-- SQL запросы для вставки текстов локализации\n")
        f.write("-- Сгенерировано автоматически\n\n")
        for query in sql_queries:
            f.write(query + "\n")
    
    print("Файлы созданы:")
    print("  - extracted_texts.json - JSON с извлеченными текстами")
    print("  - insert_localization.sql - SQL запросы для БД")
    
    # Показываем статистику
    categories = {}
    for text_data in texts.values():
        cat = text_data['category']
        categories[cat] = categories.get(cat, 0) + 1
    
    print("\nСтатистика по категориям:")
    for cat, count in sorted(categories.items()):
        print(f"  {cat}: {count}")

if __name__ == "__main__":
    main()
