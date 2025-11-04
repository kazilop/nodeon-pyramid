#!/usr/bin/env node
/*
Тест API платежей
*/

const https = require('https');

function testPaymentsAPI() {
    console.log('Тестирование API платежей...');
    
    const postData = JSON.stringify({
        amount_ndn: 100,
        description: 'Test purchase'
    });
    
    const options = {
        hostname: 'sistemypro.ru',
        port: 443,
        path: '/api/payments/create-invoice',
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': 'tma user=%7B%22id%22%3A207940967%2C%22first_name%22%3A%22Test%22%2C%22last_name%22%3A%22User%22%2C%22username%22%3A%22testuser%22%7D',
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

testPaymentsAPI();
