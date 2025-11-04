#!/usr/bin/env node
/*
Скрипт для обновления фронтенда для работы с API локализации
*/

const fs = require('fs');
const path = require('path');

function updateFrontendLocalization() {
    const htmlFile = path.join(__dirname, 'server-deployment/public/index.html');
    
    if (!fs.existsSync(htmlFile)) {
        console.log('Файл index.html не найден!');
        return;
    }
    
    let content = fs.readFileSync(htmlFile, 'utf8');
    
    // Добавляем глобальную переменную для переводов
    const translationsScript = `
    <script>
        // Глобальная переменная для переводов
        window.translations = {};
        window.currentLanguage = 'ru';
        
        // Функция для загрузки переводов
        async function loadTranslations(lang = 'ru') {
            try {
                console.log('🌐 Загрузка переводов для языка:', lang);
                const response = await fetch(\`/api/localization/\${lang}\`);
                const data = await response.json();
                
                if (data.success) {
                    window.translations = data.translations;
                    window.currentLanguage = lang;
                    console.log(\`✅ Загружено \${data.count} переводов для \${lang}\`);
                    
                    // Применяем переводы к странице
                    applyTranslations();
                } else {
                    console.error('Ошибка загрузки переводов:', data.error);
                }
            } catch (error) {
                console.error('Ошибка загрузки переводов:', error);
            }
        }
        
        // Функция для получения перевода
        function t(key, fallback = '') {
            return window.translations[key] || fallback || key;
        }
        
        // Функция для применения переводов к странице
        function applyTranslations() {
            // Обновляем элементы с data-i18n
            document.querySelectorAll('[data-i18n]').forEach(element => {
                const key = element.getAttribute('data-i18n');
                const translation = t(key);
                if (translation && translation !== key) {
                    element.textContent = translation;
                }
            });
            
            // Обновляем placeholder атрибуты
            document.querySelectorAll('[data-i18n-placeholder]').forEach(element => {
                const key = element.getAttribute('data-i18n-placeholder');
                const translation = t(key);
                if (translation && translation !== key) {
                    element.placeholder = translation;
                }
            });
            
            // Обновляем title атрибуты
            document.querySelectorAll('[data-i18n-title]').forEach(element => {
                const key = element.getAttribute('data-i18n-title');
                const translation = t(key);
                if (translation && translation !== key) {
                    element.title = translation;
                }
            });
        }
        
        // Функция для переключения языка
        async function switchLanguage(lang) {
            await loadTranslations(lang);
            
            // Обновляем селектор языка
            const languageSelect = document.getElementById('languageSelect');
            if (languageSelect) {
                languageSelect.value = lang;
            }
            
            // Сохраняем выбранный язык
            localStorage.setItem('selectedLanguage', lang);
            
            // Обновляем интерфейс
            updateLanguageDisplay(lang);
        }
        
        // Функция для обновления отображения языка
        function updateLanguageDisplay(lang) {
            const languageNames = {
                'ru': 'Русский',
                'en': 'English',
                'es': 'Español',
                'de': 'Deutsch',
                'fr': 'Français',
                'it': 'Italiano',
                'pt': 'Português',
                'ar': 'العربية',
                'hi': 'हिन्दी',
                'ja': '日本語',
                'ko': '한국어',
                'zh': '中文'
            };
            
            const currentLanguageDisplay = document.getElementById('currentLanguageDisplay');
            if (currentLanguageDisplay) {
                currentLanguageDisplay.textContent = languageNames[lang] || lang;
            }
        }
        
        // Инициализация при загрузке страницы
        document.addEventListener('DOMContentLoaded', async function() {
            // Загружаем сохраненный язык или используем русский по умолчанию
            const savedLanguage = localStorage.getItem('selectedLanguage') || 'ru';
            await loadTranslations(savedLanguage);
            updateLanguageDisplay(savedLanguage);
        });
    </script>`;
    
    // Вставляем скрипт перед закрывающим тегом head
    const headCloseIndex = content.indexOf('</head>');
    if (headCloseIndex !== -1) {
        content = content.slice(0, headCloseIndex) + translationsScript + '\n    ' + content.slice(headCloseIndex);
    }
    
    // Обновляем функцию переключения языка
    const oldToggleLanguage = /function toggleLanguage\(\) \{[\s\S]*?\}/;
    const newToggleLanguage = `function toggleLanguage() {
            const languageSelect = document.getElementById('languageSelect');
            if (languageSelect) {
                const selectedLang = languageSelect.value;
                switchLanguage(selectedLang);
            }
        }`;
    
    content = content.replace(oldToggleLanguage, newToggleLanguage);
    
    // Обновляем селектор языка для использования новой функции
    content = content.replace(
        /onchange="toggleLanguage\(\)"/g,
        'onchange="switchLanguage(this.value)"'
    );
    
    // Сохраняем обновленный файл
    fs.writeFileSync(htmlFile, content, 'utf8');
    
    console.log('✅ Фронтенд обновлен для работы с API локализации');
    console.log('📋 Изменения:');
    console.log('  - Добавлена глобальная переменная window.translations');
    console.log('  - Добавлена функция loadTranslations()');
    console.log('  - Добавлена функция t() для получения переводов');
    console.log('  - Добавлена функция applyTranslations()');
    console.log('  - Обновлена функция переключения языка');
    console.log('  - Добавлена автоматическая загрузка переводов при старте');
}

// Запускаем обновление
updateFrontendLocalization();
