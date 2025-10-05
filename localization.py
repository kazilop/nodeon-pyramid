#!/usr/bin/env python3
"""
Система локализации для NodeOn Crypto
"""

import json
import os
from typing import Dict, Any, Optional

class Localization:
    def __init__(self, default_language: str = "ru"):
        self.default_language = default_language
        self.translations = {}
        self.load_translations()
    
    def load_translations(self):
        """Загрузка переводов из файлов"""
        locales_dir = "locales"
        
        if not os.path.exists(locales_dir):
            print(f"❌ Директория {locales_dir} не найдена")
            return
        
        for filename in os.listdir(locales_dir):
            if filename.endswith('.json'):
                language = filename[:-5]  # Убираем .json
                filepath = os.path.join(locales_dir, filename)
                
                try:
                    with open(filepath, 'r', encoding='utf-8') as f:
                        self.translations[language] = json.load(f)
                    print(f"✅ Загружен язык: {language}")
                except Exception as e:
                    print(f"❌ Ошибка загрузки {language}: {e}")
    
    def get_language_from_telegram_user(self, telegram_user: Dict[str, Any]) -> str:
        """Определение языка пользователя из данных Telegram"""
        if not telegram_user:
            return self.default_language
        
        # Получаем язык из Telegram
        language_code = telegram_user.get('language_code', '')
        
        # Маппинг языков Telegram на наши языки
        language_mapping = {
            'ru': 'ru',
            'en': 'en',
            'es': 'es',
            'de': 'de',
            'uk': 'ru',  # Украинский -> русский
            'be': 'ru',  # Белорусский -> русский
            'kz': 'ru',  # Казахский -> русский
            'uz': 'ru',  # Узбекский -> русский
        }
        
        # Проверяем полный код языка
        if language_code in language_mapping:
            return language_mapping[language_code]
        
        # Проверяем только первые 2 символа
        short_code = language_code[:2] if language_code else ''
        if short_code in language_mapping:
            return language_mapping[short_code]
        
        # По умолчанию русский
        return self.default_language
    
    def t(self, key: str, language: str = None, **kwargs) -> str:
        """Получение перевода по ключу"""
        if language is None:
            language = self.default_language
        
        # Получаем перевод
        translation = self._get_nested_value(self.translations.get(language, {}), key)
        
        # Если перевод не найден, пробуем язык по умолчанию
        if translation is None and language != self.default_language:
            translation = self._get_nested_value(self.translations.get(self.default_language, {}), key)
        
        # Если и там нет, возвращаем ключ
        if translation is None:
            return key
        
        # Заменяем параметры в строке
        if kwargs:
            try:
                return translation.format(**kwargs)
            except:
                return translation
        
        return translation
    
    def _get_nested_value(self, data: Dict, key: str) -> Optional[str]:
        """Получение значения по вложенному ключу (например, 'user.balance_ndn')"""
        keys = key.split('.')
        current = data
        
        for k in keys:
            if isinstance(current, dict) and k in current:
                current = current[k]
            else:
                return None
        
        return current if isinstance(current, str) else None
    
    def get_available_languages(self) -> list:
        """Получение списка доступных языков"""
        return list(self.translations.keys())
    
    def get_language_info(self, language: str) -> Dict[str, str]:
        """Получение информации о языке"""
        if language not in self.translations:
            return {}
        
        app_info = self.translations[language].get('app', {})
        return {
            'name': app_info.get('name', 'NodeOn Crypto'),
            'description': app_info.get('description', ''),
            'tagline': app_info.get('tagline', '')
        }

# Глобальный экземпляр локализации
i18n = Localization()

def get_user_language(telegram_user: Dict[str, Any]) -> str:
    """Получение языка пользователя"""
    return i18n.get_language_from_telegram_user(telegram_user)

def translate(key: str, language: str = None, **kwargs) -> str:
    """Функция для перевода"""
    return i18n.t(key, language, **kwargs)

# Примеры использования:
if __name__ == "__main__":
    # Тестирование системы локализации
    print("🌍 Тестирование системы локализации")
    print("=" * 50)
    
    # Доступные языки
    print(f"Доступные языки: {i18n.get_available_languages()}")
    
    # Тестовые переводы
    test_keys = [
        "app.name",
        "welcome.title",
        "user.balance_ndn",
        "buttons.buy_pro",
        "pro.benefits.0"
    ]
    
    for lang in i18n.get_available_languages():
        print(f"\n📝 Язык: {lang}")
        for key in test_keys:
            translation = i18n.t(key, lang)
            print(f"   {key}: {translation}")
    
    # Тест определения языка пользователя
    print(f"\n🔍 Тест определения языка:")
    test_users = [
        {"language_code": "ru"},
        {"language_code": "en"},
        {"language_code": "es"},
        {"language_code": "de"},
        {"language_code": "uk"},
        {"language_code": "fr"},
    ]
    
    for user in test_users:
        detected_lang = i18n.get_language_from_telegram_user(user)
        print(f"   {user['language_code']} -> {detected_lang}")
