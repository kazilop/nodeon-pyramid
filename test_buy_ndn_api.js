#!/usr/bin/env node
/*
Тест API покупки NDN за Stars
*/

const https = require('https');

function testBuyNDNAPI() {
    console.log('Тестирование API покупки NDN за Stars...');
    
    // Тест 1: Создание счета
    testCreateInvoice();
}

function testCreateInvoice() {
    console.log('\n1. Тест создания счета для покупки NDN:');
    
    const postData = JSON.stringify({
        amount_ndn: 100,
        description: 'Покупка 100 NDN за 100 Telegram Stars'
    });
    
    const options = {
        hostname: 'sistemypro.ru',
        port: 443,
        path: '/api/payments/create-invoice',
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Content-Length': Buffer.byteLength(postData)
        }
    };
    
    const req = https.request(options, (res) => {
        console.log(`Статус: ${res.statusCode}`);
        console.log(`Заголовки:`, res.headers);
        
        let data = '';
        res.on('data', (chunk) => {
            data += chunk;
        });
        
        res.on('end', () => {
            console.log('Ответ:', data);
            try {
                const jsonData = JSON.parse(data);
                console.log('JSON ответ:', JSON.stringify(jsonData, null, 2));
            } catch (e) {
                console.log('Не JSON ответ:', data);
            }
        });
    });
    
    req.on('error', (e) => {
        console.error('Ошибка запроса:', e.message);
    });
    
    req.write(postData);
    req.end();
}

testBuyNDNAPI();











