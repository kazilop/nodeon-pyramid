// Анализ API endpoints без Supabase

// Список всех API endpoints, которые вызываются во фронтенде
const frontendEndpoints = [
    '/api/game/claim-daily-reward',
    '/api/miner/check-tables',
    '/api/miner/buy-farm',
    '/api/miner/save-state',
    '/api/miner/save-gas',
    '/api/language/supported',
    '/api/language/detect',
    '/api/user/create',
    '/api/user/profile',
    '/api/admin/dashboard',
    '/api/admin/exchange-requests',
    '/api/pro/buy',
    '/api/payments/create-invoice',
    '/api/payments/exchange-request',
    '/api/user/withdraw',
    '/api/stats/leaderboard',
    '/api/game/rules',
    '/api/shops/open',
    '/api/transfers/ndn'
];

// Список реальных endpoints на сервере (из проверки)
const realEndpoints = [
    '/api/health',
    '/api/auth/profile/:telegram_id',
    '/api/referrals/by-id/:id',
    '/api/stats/leaderboard',
    '/api/translations/:lang',
    '/api/game/rules',
    '/api/miner/data/:telegram_id',
    '/api/admin/dashboard'
];

console.log('🔍 Анализ API endpoints:');
console.log('\n📋 Endpoints, вызываемые во фронтенде:');
frontendEndpoints.forEach((endpoint, index) => {
    console.log(`${index + 1}. ${endpoint}`);
});

console.log('\n✅ Реальные endpoints на сервере:');
realEndpoints.forEach((endpoint, index) => {
    console.log(`${index + 1}. ${endpoint}`);
});

console.log('\n❌ Проблемные endpoints (вызываются во фронтенде, но не существуют на сервере):');
const problematicEndpoints = frontendEndpoints.filter(frontend => {
    return !realEndpoints.some(real => {
        // Простая проверка совпадения
        if (real.includes(':')) {
            // Если endpoint содержит параметр, проверяем базовую часть
            const baseReal = real.split('/:')[0];
            const baseFrontend = frontend.split('/').slice(0, -1).join('/');
            return baseReal === baseFrontend;
        }
        return real === frontend;
    });
});

problematicEndpoints.forEach((endpoint, index) => {
    console.log(`${index + 1}. ${endpoint}`);
});

console.log('\n🔧 Рекомендации по исправлению:');
console.log('1. Создать недостающие endpoints на сервере');
console.log('2. Или изменить вызовы во фронтенде на существующие endpoints');
console.log('3. Проверить параметры и структуру ответов');
