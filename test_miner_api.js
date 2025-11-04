#!/usr/bin/env node
/*
Тест API майнера
*/

const https = require('https');

function testMinerAPI() {
    console.log('Тестирование API майнера...');
    
    // Тест 1: Получение данных майнера
    testGetMinerData();
    
    // Тест 2: Покупка фермы
    setTimeout(() => {
        testBuyFarm();
    }, 2000);
    
    // Тест 3: Сохранение состояния
    setTimeout(() => {
        testSaveState();
    }, 4000);
}

function testGetMinerData() {
    console.log('\n1. Тест получения данных майнера:');
    
    const options = {
        hostname: 'sistemypro.ru',
        port: 443,
        path: '/api/miner/data/207940967',
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    };
    
    const req = https.request(options, (res) => {
        console.log(`Статус: ${res.statusCode}`);
        
        let data = '';
        res.on('data', (chunk) => {
            data += chunk;
        });
        
        res.on('end', () => {
            console.log('Ответ:', data.substring(0, 200) + '...');
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
    
    req.end();
}

function testBuyFarm() {
    console.log('\n2. Тест покупки фермы:');
    
    const postData = JSON.stringify({
        telegram_id: 207940967,
        farm_type: 'cpu_miner'
    });
    
    const options = {
        hostname: 'sistemypro.ru',
        port: 443,
        path: '/api/miner/buy-farm',
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

function testSaveState() {
    console.log('\n3. Тест сохранения состояния:');
    
    const postData = JSON.stringify({
        telegram_id: 207940967,
        miner_data: {
            ndnGas: 3000,
            energy: 100,
            maxEnergy: 100,
            gasPerMinute: 10,
            farms: [
                { type: 'cpu_miner', level: 1, purchased_at: Date.now() }
            ],
            upgrades: { speed: 0, efficiency: 0, automation: 0 },
            totalGasEarned: 3000,
            lastEnergyRefill: Date.now(),
            lastUpdate: Date.now()
        }
    });
    
    const options = {
        hostname: 'sistemypro.ru',
        port: 443,
        path: '/api/miner/save-state',
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

testMinerAPI();












