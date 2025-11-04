#!/usr/bin/env node
/*
Тест покупки NDN за Stars
*/

const https = require('https');

function testBuyNDNStars() {
    console.log('Тестирование покупки NDN за Stars...');
    
    // Тест 1: Создание счета без авторизации (ожидаем 401)
    testCreateInvoiceWithoutAuth();
    
    // Тест 2: Создание счета с фиктивной авторизацией
    setTimeout(() => {
        testCreateInvoiceWithMockAuth();
    }, 2000);
}

function testCreateInvoiceWithoutAuth() {
    console.log('\n1. Тест создания счета без авторизации (ожидаем ошибку):');
    
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
        
        let data = '';
        res.on('data', (chunk) => {
            data += chunk;
        });
        
        res.on('end', () => {
            console.log('Ответ:', data);
        });
    });
    
    req.on('error', (e) => {
        console.error('Ошибка:', e.message);
    });
    
    req.write(postData);
    req.end();
}

function testCreateInvoiceWithMockAuth() {
    console.log('\n2. Тест создания счета с фиктивной авторизацией:');
    
    // Симулируем initData для пользователя 207940967
    const mockInitData = 'user=%7B%22id%22%3A207940967%2C%22first_name%22%3A%22Fish%22%2C%22username%22%3A%22NobodyYety%22%7D&auth_date=1697000000&hash=mock_hash';
    
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
            'Authorization': `tma ${mockInitData}`,
            'Content-Length': Buffer.byteLength(postData)
        }
    };
    
    const req = https.request(options, (res) => {
        console.log(`Статус: ${res.statusCode}`);
        
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
        console.error('Ошибка:', e.message);
    });
    
    req.write(postData);
    req.end();
}

testBuyNDNStars();












