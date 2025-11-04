const express = require('express');
const router = express.Router();
const { createClient } = require('@supabase/supabase-js');
require('dotenv').config({ path: '../../.env' });

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_ANON_KEY
);

// GET /api/localization/:lang - Получить все переводы для языка
router.get('/:lang', async (req, res) => {
  try {
    const { lang } = req.params;
    console.log(`🌐 Запрос переводов для языка: ${lang}`);
    
    // Проверяем поддерживаемые языки
    const supportedLanguages = ['ru', 'en', 'es', 'de', 'fr', 'it', 'pt', 'ar', 'hi', 'ja', 'ko', 'zh'];
    if (!supportedLanguages.includes(lang)) {
      return res.status(400).json({ 
        error: 'Unsupported language',
        supported: supportedLanguages 
      });
    }
    
    // Получаем переводы из базы данных
    const { data: translations, error } = await supabase
      .from('nodeon_localization')
      .select(`text_id, ru, ${lang}`)
      .not('ru', 'is', null);
    
    if (error) {
      console.error('Ошибка получения переводов:', error);
      return res.status(500).json({ error: 'Failed to fetch translations' });
    }
    
    // Преобразуем в объект для удобства использования
    const result = {};
    translations.forEach(item => {
      // Используем перевод для языка, если есть, иначе русский
      result[item.text_id] = item[lang] || item.ru;
    });
    
    console.log(`✅ Загружено ${Object.keys(result).length} переводов для ${lang}`);
    
    res.json({
      success: true,
      language: lang,
      translations: result,
      count: Object.keys(result).length
    });
    
  } catch (error) {
    console.error('Ошибка API локализации:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// GET /api/localization/:lang/:text_id - Получить конкретный перевод
router.get('/:lang/:text_id', async (req, res) => {
  try {
    const { lang, text_id } = req.params;
    console.log(`🔍 Запрос перевода: ${text_id} для языка: ${lang}`);
    
    const { data: translation, error } = await supabase
      .from('nodeon_localization')
      .select(`text_id, ru, ${lang}`)
      .eq('text_id', text_id)
      .single();
    
    if (error) {
      console.error('Ошибка получения перевода:', error);
      return res.status(404).json({ error: 'Translation not found' });
    }
    
    const result = translation[lang] || translation.ru;
    
    res.json({
      success: true,
      text_id: text_id,
      language: lang,
      translation: result
    });
    
  } catch (error) {
    console.error('Ошибка API локализации:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// GET /api/localization/supported - Получить список поддерживаемых языков
router.get('/supported', async (req, res) => {
  try {
    const supportedLanguages = [
      { code: 'ru', name: 'Русский', flag: '🇷🇺' },
      { code: 'en', name: 'English', flag: '🇺🇸' },
      { code: 'es', name: 'Español', flag: '🇪🇸' },
      { code: 'de', name: 'Deutsch', flag: '🇩🇪' },
      { code: 'fr', name: 'Français', flag: '🇫🇷' },
      { code: 'it', name: 'Italiano', flag: '🇮🇹' },
      { code: 'pt', name: 'Português', flag: '🇵🇹' },
      { code: 'ar', name: 'العربية', flag: '🇸🇦' },
      { code: 'hi', name: 'हिन्दी', flag: '🇮🇳' },
      { code: 'ja', name: '日本語', flag: '🇯🇵' },
      { code: 'ko', name: '한국어', flag: '🇰🇷' },
      { code: 'zh', name: '中文', flag: '🇨🇳' }
    ];
    
    res.json({
      success: true,
      languages: supportedLanguages
    });
    
  } catch (error) {
    console.error('Ошибка API поддерживаемых языков:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// POST /api/localization/update - Обновить перевод (для админов)
router.post('/update', async (req, res) => {
  try {
    const { text_id, language, translation } = req.body;
    
    if (!text_id || !language || !translation) {
      return res.status(400).json({ error: 'Missing required fields' });
    }
    
    console.log(`📝 Обновление перевода: ${text_id} для ${language}`);
    
    const updateData = {};
    updateData[language] = translation;
    
    const { data, error } = await supabase
      .from('nodeon_localization')
      .update(updateData)
      .eq('text_id', text_id)
      .select();
    
    if (error) {
      console.error('Ошибка обновления перевода:', error);
      return res.status(500).json({ error: 'Failed to update translation' });
    }
    
    res.json({
      success: true,
      message: 'Translation updated successfully',
      data: data[0]
    });
    
  } catch (error) {
    console.error('Ошибка API обновления перевода:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

module.exports = router;













