#!/usr/bin/env node
/*
Скрипт для автоматического тестирования всех API endpoints
*/

const https = require('https');

const BASE_URL = 'https://sistemypro.ru';

// Тест пользователя (для рефералов)
const TEST_USER_ID = 5;

async function testEndpoint(name, path, method = 'GET', body = null) {
    return new Promise((resolve) => {
        console.log(`\n🧪 Тест: ${name}`);
        console.log(`📡 ${method} ${path}`);
        
        const options = {
            hostname: 'sistemypro.ru',
            port: 443,
            path: path,
            method: method,
            headers: {
                'Content-Type': 'application/json'
            }
        };
        
        if (body) {
            const postData = JSON.stringify(body);
            options.headers['Content-Length'] = Buffer.byteLength(postData);
        }
        
        const req = https.request(options, (res) => {
            let data = '';
            
            res.on('data', (chunk) => {
                data += chunk;
            });
            
            res.on('end', () => {
                const status = res.statusCode;
                const isSuccess = status >= 200 && status < 300;
                
                console.log(`Статус: ${status}`);
                
                try {
                    const jsonData = JSON.parse(data);
                    if (isSuccess && jsonData.success) {
                        console.log(`✅ УСПЕХ`);
                        console.log(JSON.stringify(jsonData, null, 2).substring(0, 200));
                    } else {
                        console.log(`❌ ОШИБКА`);
                        console.log(JSON.stringify(jsonData, null, 2));
                    }
                } catch (e) {
                    console.log(`⚠️  НЕ JSON ответ:`, data.substring(0, 200));
                }
                
                resolve({
                    name,
                    status,
                    success: isSuccess
                });
            });
        });
        
        req.on('error', (error) => {
            console.log(`❌ ОШИБКА СЕТИ:`, error.message);
            resolve({
                name,
                status: 0,
                success: false
            });
        });
        
        if (body) {
            req.write(JSON.stringify(body));
        }
        
        req.end();
    });
}

async function runTests() {
    console.log('🚀 Запуск автоматических тестов API...\n');
    
    const results = [];
    
    // Тест 1: Лидерборд
    results.push(await testEndpoint(
        'Лидерборд',
        '/api/stats/leaderboard'
    ));
    
    // Тест 2: Правила игры
    results.push(await testEndpoint(
        'Правила игры',
        '/api/game/rules'
    ));
    
    // Тест 3: Рефералы (по ID пользователя 5)
    results.push(await testEndpoint(
        'Рефералы',
        `/api/referrals/by-id/${TEST_USER_ID}`
    ));
    
    // Тест 4: Health check
    results.push(await testEndpoint(
        'Health Check',
        '/health'
    ));
    
    // Итоговый отчет
    console.log('\n\n📊 ИТОГОВЫЙ ОТЧЕТ:');
    console.log('═'.repeat(50));
    
    const successful = results.filter(r => r.success).length;
    const total = results.length;
    
    results.forEach(result => {
        const icon = result.success ? '✅' : '❌';
        console.log(`${icon} ${result.name}: ${result.status}`);
    });
    
    console.log('\n' + '═'.repeat(50));
    console.log(`✅ Успешно: ${successful}/${total}`);
    console.log(`❌ Ошибок: ${total - successful}/${total}`);
    
    if (successful === total) {
        console.log('\n🎉 ВСЕ ТЕСТЫ ПРОШЛИ УСПЕШНО!');
    } else {
        console.log('\n⚠️  НЕКОТОРЫЕ ТЕСТЫ НЕ ПРОШЛИ');
    }
}

runTests();












