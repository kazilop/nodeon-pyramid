// Тестируем функцию форматирования чисел
function formatNumber(num) {
    if (num >= 1000000) {
        return (num / 1000000).toFixed(1) + 'M';
    } else if (num >= 1000) {
        return (num / 1000).toFixed(1) + 'K';
    }
    return num.toFixed(0);
}

console.log('🧮 Тестируем форматирование чисел:');
console.log('1000002098 →', formatNumber(1000002098));
console.log('1000000 →', formatNumber(1000000));
console.log('100000 →', formatNumber(100000));
console.log('1000 →', formatNumber(1000));
console.log('100 →', formatNumber(100));
console.log('10 →', formatNumber(10));











