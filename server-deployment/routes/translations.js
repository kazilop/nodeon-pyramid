const express = require('express');
const fs = require('fs');
const path = require('path');
const router = express.Router();

// GET /api/translations/:lang - Получение переводов по языку
router.get('/:lang', async (req, res) => {
  try {
    const { lang } = req.params;
    
    console.log(`Getting translations for language: ${lang}`);

    // Путь к файлу переводов (с фолбэками на корень проекта)
    const candidatePaths = [
      path.join(__dirname, '..', 'locales', `${lang}.json`),
      path.join(__dirname, '..', '..', 'locales', `${lang}.json`),
      path.join(process.cwd(), 'locales', `${lang}.json`)
    ];

    const translationsPath = candidatePaths.find(p => fs.existsSync(p));

    // Проверяем существование файла
    if (!translationsPath || !fs.existsSync(translationsPath)) {
      console.log(`Translation file not found for ${lang}. Tried:`, candidatePaths);
      return res.status(404).json({ error: 'Translation not found' });
    }

    // Читаем файл переводов
    const translations = JSON.parse(fs.readFileSync(translationsPath, 'utf8'));

    res.json({
      success: true,
      translations: translations
    });

  } catch (error) {
    console.error('Translations error:', error);
    res.status(500).json({ error: 'Failed to get translations' });
  }
});

module.exports = router;
