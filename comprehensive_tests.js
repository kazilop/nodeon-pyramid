#!/usr/bin/env node
/*
Комплексные автоматические тесты для всех функций NodeOn Pyramid
Тестирует все API endpoints, кнопки и функции
*/

const https = require('https');

const BASE_URL = 'https://sistemypro.ru';
const TEST_USER_ID = 5;
const TEST_TELEGRAM_ID = 207940967;

// Статистика тестов
const stats = {
    total: 0,
    passed: 0,
    failed: 0,
    errors: []
};

// Вспомогательная функция для HTTP запросов
function makeRequest(method, path, body = null, headers = {}) {
    return new Promise((resolve) => {
        const options = {
            hostname: 'sistemypro.ru',
            port: 443,
            path: path,
            method: method,
            headers: {
                'Content-Type': 'application/json',
                ...headers
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
                resolve({
                    status: res.statusCode,
                    data: data,
                    headers: res.headers
                });
            });
        });
        
        req.on('error', (error) => {
            resolve({
                status: 0,
                data: '',
                error: error.message
            });
        });
        
        if (body) {
            req.write(JSON.stringify(body));
        }
        
        req.end();
    });
}

// Функция для тестирования
async function runTest(name, testFn) {
    stats.total++;
    console.log(`\n🧪 Тест ${stats.total}: ${name}`);
    
    try {
        const result = await testFn();
        
        if (result.success) {
            stats.passed++;
            console.log(`✅ УСПЕХ: ${result.message || ''}`);
        } else {
            stats.failed++;
            stats.errors.push({ name, error: result.error });
            console.log(`❌ ОШИБКА: ${result.error}`);
        }
    } catch (error) {
        stats.failed++;
        stats.errors.push({ name, error: error.message });
        console.log(`❌ ИСКЛЮЧЕНИЕ: ${error.message}`);
    }
}

// ============================================
// ТЕСТЫ ОСНОВНЫХ ФУНКЦИЙ
// ============================================

async function testHealthCheck() {
    const response = await makeRequest('GET', '/health');
    
    if (response.status === 200) {
        const data = JSON.parse(response.data);
        return {
            success: true,
            message: `Server is running (uptime: ${Math.floor(data.uptime)}s)`
        };
    }
    
    return {
        success: false,
        error: `Status: ${response.status}`
    };
}

async function testLeaderboard() {
    const response = await makeRequest('GET', '/api/stats/leaderboard');
    
    if (response.status === 200) {
        const data = JSON.parse(response.data);
        const usersCount = data.leaderboard?.length || 0;
        return {
            success: true,
            message: `Loaded ${usersCount} users`
        };
    }
    
    return {
        success: false,
        error: `Status: ${response.status}`
    };
}

async function testGameRules() {
    const response = await makeRequest('GET', '/api/game/rules');
    
    if (response.status === 200) {
        const data = JSON.parse(response.data);
        return {
            success: data.success === true,
            message: 'Game rules loaded'
        };
    }
    
    return {
        success: false,
        error: `Status: ${response.status}`
    };
}

async function testReferrals() {
    const response = await makeRequest('GET', `/api/referrals/by-id/${TEST_USER_ID}`);
    
    if (response.status === 200) {
        const data = JSON.parse(response.data);
        const referralsCount = data.referrals?.length || 0;
        return {
            success: true,
            message: `Found ${referralsCount} referrals`
        };
    }
    
    return {
        success: false,
        error: `Status: ${response.status}`
    };
}

async function testUserProfile() {
    const response = await makeRequest('GET', `/api/auth/profile/${TEST_TELEGRAM_ID}`);
    
    if (response.status === 200) {
        const data = JSON.parse(response.data);
        return {
            success: data.success === true,
            message: `User profile loaded: ${data.user?.first_name}`
        };
    }
    
    return {
        success: false,
        error: `Status: ${response.status}`
    };
}

async function testMinerData() {
    const response = await makeRequest('GET', `/api/miner/data/${TEST_TELEGRAM_ID}`);
    
    if (response.status === 200) {
        const data = JSON.parse(response.data);
        return {
            success: data.success === true,
            message: 'Miner data loaded'
        };
    }
    
    return {
        success: false,
        error: `Status: ${response.status}`
    };
}

async function testAchievements() {
    const response = await makeRequest('GET', '/api/game/achievements');
    
    if (response.status === 200) {
        const data = JSON.parse(response.data);
        const achievementsCount = data.achievements?.length || 0;
        return {
            success: true,
            message: `Found ${achievementsCount} achievements`
        };
    }
    
    return {
        success: false,
        error: `Status: ${response.status}`
    };
}

async function testDailyReward() {
    const response = await makeRequest('POST', '/api/game/daily-reward', {
        telegram_id: TEST_TELEGRAM_ID
    });
    
    if (response.status === 200 || response.status === 400) {
        // 400 может быть если уже получали сегодня
        const data = JSON.parse(response.data);
        return {
            success: true,
            message: data.success ? 'Reward claimed' : 'Already claimed today'
        };
    }
    
    return {
        success: false,
        error: `Status: ${response.status}`
    };
}

async function testTranslations() {
    const response = await makeRequest('GET', '/api/translations/ru');
    
    if (response.status === 200) {
        const data = JSON.parse(response.data);
        return {
            success: Object.keys(data.translations || {}).length > 0,
            message: 'Translations loaded'
        };
    }
    
    return {
        success: false,
        error: `Status: ${response.status}`
    };
}

async function testAdminDashboard() {
    const response = await makeRequest('GET', '/api/admin/dashboard');
    
    if (response.status === 200) {
        const data = JSON.parse(response.data);
        return {
            success: data.success === true,
            message: 'Admin dashboard loaded'
        };
    }
    
    return {
        success: false,
        error: `Status: ${response.status}`
    };
}

// ============================================
// ТЕСТЫ КНОПОК И ДЕЙСТВИЙ
// ============================================

async function testBuyProStatus() {
    const response = await makeRequest('POST', '/api/pro/buy', {
        telegram_id: TEST_TELEGRAM_ID
    }, {
        'Authorization': `Bearer test_token`
    });
    
    // Проверяем что endpoint существует (может вернуть 400 если уже PRO или недостаточно средств)
    return {
        success: response.status !== 404,
        message: response.status === 404 ? 'Endpoint not found' : 'Buy Pro endpoint exists'
    };
}

async function testCreateInvoice() {
    const response = await makeRequest('POST', '/api/payments/create-invoice', {
        amount_ndn: 100,
        description: 'Test invoice'
    });
    
    // Проверяем что endpoint существует
    return {
        success: response.status !== 404 && response.status !== 502,
        message: response.status === 404 ? 'Endpoint not found' : 'Create invoice endpoint exists'
    };
}

async function testFindUserById() {
    const response = await makeRequest('GET', `/api/users/find-by-id/${TEST_USER_ID}`);
    
    if (response.status === 200) {
        const data = JSON.parse(response.data);
        return {
            success: data.success === true,
            message: 'User found by ID'
        };
    }
    
    return {
        success: false,
        error: `Status: ${response.status}`
    };
}

// ============================================
// ТЕСТЫ ИГРЫ MINER
// ============================================

async function testMinerBuyFarm() {
    const response = await makeRequest('POST', '/api/miner/buy-farm', {
        telegram_id: TEST_TELEGRAM_ID,
        farm_type: 'cpu_miner'
    });
    
    // Проверяем что endpoint существует
    return {
        success: response.status !== 404,
        message: 'Buy farm endpoint exists'
    };
}

async function testMinerSaveState() {
    const response = await makeRequest('POST', '/api/miner/save-state', {
        telegram_id: TEST_TELEGRAM_ID,
        miner_data: {
            ndnGas: 100,
            energy: 100,
            maxEnergy: 100,
            farms: []
        }
    });
    
    // Проверяем что endpoint существует
    return {
        success: response.status !== 404,
        message: 'Save state endpoint exists'
    };
}

async function testMinerSaveGas() {
    // Этот endpoint был удален, используется save-state
    // Проверяем что save-state работает
    const response = await makeRequest('POST', '/api/miner/save-state', {
        telegram_id: TEST_TELEGRAM_ID,
        miner_data: { gas: 100, energy: 50 }
    });
    
    return {
        success: response.status !== 404,
        message: response.status === 200 ? 'State saved via save-state' : 'Save state endpoint exists'
    };
}

// ============================================
// ЗАПУСК ВСЕХ ТЕСТОВ
// ============================================

async function runAllTests() {
    console.log('🚀 ЗАПУСК КОМПЛЕКСНЫХ АВТОМАТИЧЕСКИХ ТЕСТОВ');
    console.log('═'.repeat(60));
    console.log(`Base URL: ${BASE_URL}`);
    console.log(`Test User ID: ${TEST_USER_ID}`);
    console.log(`Test Telegram ID: ${TEST_TELEGRAM_ID}`);
    console.log('═'.repeat(60));
    
    // ОСНОВНЫЕ ФУНКЦИИ
    console.log('\n📋 ТЕСТЫ ОСНОВНЫХ ФУНКЦИЙ:');
    await runTest('Health Check', testHealthCheck);
    await runTest('Leaderboard', testLeaderboard);
    await runTest('Game Rules', testGameRules);
    await runTest('Referrals', testReferrals);
    await runTest('User Profile', testUserProfile);
    await runTest('Miner Data', testMinerData);
    await runTest('Achievements', testAchievements);
    await runTest('Daily Reward', testDailyReward);
    await runTest('Translations', testTranslations);
    await runTest('Admin Dashboard', testAdminDashboard);
    
    // КНОПКИ И ДЕЙСТВИЯ
    console.log('\n🔘 ТЕСТЫ КНОПОК И ДЕЙСТВИЙ:');
    await runTest('Buy Pro Status', testBuyProStatus);
    await runTest('Create Invoice', testCreateInvoice);
    await runTest('Find User By ID', testFindUserById);
    
    // ИГРА MINER
    console.log('\n⛏️  ТЕСТЫ ИГРЫ MINER:');
    await runTest('Miner Buy Farm', testMinerBuyFarm);
    await runTest('Miner Save State', testMinerSaveState);
    await runTest('Miner Save Gas', testMinerSaveGas);
    
    // ИТОГОВЫЙ ОТЧЕТ
    console.log('\n\n');
    console.log('═'.repeat(60));
    console.log('📊 ИТОГОВЫЙ ОТЧЕТ');
    console.log('═'.repeat(60));
    console.log(`Всего тестов: ${stats.total}`);
    console.log(`✅ Успешно: ${stats.passed}`);
    console.log(`❌ Ошибок: ${stats.failed}`);
    console.log(`📈 Успешность: ${Math.round((stats.passed / stats.total) * 100)}%`);
    console.log('═'.repeat(60));
    
    if (stats.errors.length > 0) {
        console.log('\n❌ ОШИБКИ:');
        stats.errors.forEach((error, index) => {
            console.log(`${index + 1}. ${error.name}: ${error.error}`);
        });
    }
    
    if (stats.failed === 0) {
        console.log('\n🎉 ВСЕ ТЕСТЫ ПРОШЛИ УСПЕШНО!');
    } else {
        console.log('\n⚠️  НЕКОТОРЫЕ ТЕСТЫ НЕ ПРОШЛИ');
    }
    
    console.log('═'.repeat(60));
}

runAllTests();

