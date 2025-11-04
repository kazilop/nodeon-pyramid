const fs = require('fs');
const path = require('path');

exports.handler = async (event, context) => {
  const { httpMethod, path: eventPath } = event;
  
  // Извлекаем язык из пути функции
  const pathParts = eventPath.split('/');
  const language = pathParts[pathParts.length - 1];

  try {
    if (httpMethod === 'OPTIONS') {
      return {
        statusCode: 200,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Headers': 'Content-Type',
          'Access-Control-Allow-Methods': 'GET, OPTIONS'
        }
      };
    }

    if (httpMethod === 'GET' && language) {
      const translationsPath = path.resolve(__dirname, `../../locales/${language}.json`);
      console.log(`Attempting to load translations from: ${translationsPath}`);

      if (fs.existsSync(translationsPath)) {
        const translations = JSON.parse(fs.readFileSync(translationsPath, 'utf8'));
        return {
          statusCode: 200,
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
          },
          body: JSON.stringify({ success: true, language: language, translations: translations })
        };
      } else {
        console.warn(`Translations file not found for language: ${language}`);
        return {
          statusCode: 404,
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
          },
          body: JSON.stringify({ success: false, error: `Translations not found for language: ${language}` })
        };
      }
    }

    return {
      statusCode: 404,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Translations endpoint not found' })
    };

  } catch (error) {
    console.error('Translations function error:', error);
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ error: 'Internal Server Error' })
    };
  }
};




