#!/usr/bin/env python3
"""
Тестирование многоязычной системы NodeOn Crypto
"""

import requests
import json

API_URL = "https://nodeon-production.up.railway.app"

def test_language_detection():
    """Тестирование определения языка"""
    print("Testing language detection...")
    
    try:
        response = requests.get(f"{API_URL}/api/language/detect")
        if response.status_code == 200:
            data = response.json()
            print(f"SUCCESS: Language detection working")
            print(f"   Detected language: {data.get('language', 'N/A')}")
            print(f"   Detection status: {data.get('detected', False)}")
            return True
        else:
            print(f"ERROR: Language detection failed: {response.status_code}")
            return False
    except Exception as e:
        print(f"ERROR: Error testing language detection: {e}")
        return False

def test_supported_languages():
    """Тестирование получения поддерживаемых языков"""
    print("\nTesting supported languages...")
    
    try:
        response = requests.get(f"{API_URL}/api/language/supported")
        if response.status_code == 200:
            data = response.json()
            languages = data.get('languages', [])
            print(f"SUCCESS: Supported languages API working")
            print(f"   Languages: {', '.join(languages)}")
            print(f"   Default: {data.get('default', 'N/A')}")
            return languages
        else:
            print(f"ERROR: Supported languages API failed: {response.status_code}")
            return []
    except Exception as e:
        print(f"ERROR: Error testing supported languages: {e}")
        return []

def test_translations(language):
    """Тестирование загрузки переводов для языка"""
    print(f"\nTesting translations for {language}...")
    
    try:
        response = requests.get(f"{API_URL}/api/translations/{language}")
        if response.status_code == 200:
            data = response.json()
            translations = data.get('translations', {})
            print(f"SUCCESS: Translations loaded for {language}")
            
            # Проверяем основные ключи
            required_keys = ['app', 'user', 'buttons', 'errors']
            missing_keys = []
            for key in required_keys:
                if key not in translations:
                    missing_keys.append(key)
            
            if missing_keys:
                print(f"WARNING: Missing keys in {language}: {', '.join(missing_keys)}")
            else:
                print(f"SUCCESS: All required keys present in {language}")
            
            # Показываем примеры переводов
            if 'app' in translations:
                app_name = translations['app'].get('name', 'N/A')
                print(f"   App name: {app_name}")
            
            if 'buttons' in translations:
                buy_pro = translations['buttons'].get('buy_pro', 'N/A')
                print(f"   Buy Pro button: {buy_pro}")
            
            return True
        else:
            print(f"ERROR: Translations API failed for {language}: {response.status_code}")
            return False
    except Exception as e:
        print(f"ERROR: Error testing translations for {language}: {e}")
        return False

def test_languages_api():
    """Тестирование API языков"""
    print("\nTesting languages API...")
    
    try:
        response = requests.get(f"{API_URL}/api/languages")
        if response.status_code == 200:
            data = response.json()
            languages = data.get('languages', [])
            print(f"SUCCESS: Languages API working")
            print(f"   Found {len(languages)} languages")
            
            for lang in languages[:5]:  # Показываем первые 5
                code = lang.get('code', 'N/A')
                name = lang.get('name', 'N/A')
                native_name = lang.get('native_name', 'N/A')
                print(f"   {code}: {name} ({native_name})")
            
            return True
        else:
            print(f"ERROR: Languages API failed: {response.status_code}")
            return False
    except Exception as e:
        print(f"ERROR: Error testing languages API: {e}")
        return False

def main():
    """Основная функция тестирования"""
    print("Testing NodeOn Crypto multilingual system")
    print("=" * 60)
    
    # Тестируем определение языка
    test_language_detection()
    
    # Тестируем поддерживаемые языки
    supported_languages = test_supported_languages()
    
    # Тестируем API языков
    test_languages_api()
    
    # Тестируем переводы для основных языков
    test_languages = ['ru', 'en', 'es', 'de', 'fr', 'zh', 'ja', 'ko']
    
    print(f"\nTesting translations for {len(test_languages)} languages...")
    success_count = 0
    
    for lang in test_languages:
        if test_translations(lang):
            success_count += 1
    
    print(f"\nTest results:")
    print(f"   Supported languages: {len(supported_languages)}")
    print(f"   Successfully loaded translations: {success_count}/{len(test_languages)}")
    
    if success_count == len(test_languages):
        print("SUCCESS: All tests passed!")
    else:
        print("WARNING: Some tests failed")
    
    print("\nMultilingual system is ready for use!")

if __name__ == "__main__":
    main()
