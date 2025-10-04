#!/usr/bin/env python3
"""
Тестирование всех API endpoints
"""

import requests
import json

RAILWAY_URL = "https://nodeon-production.up.railway.app"

def test_endpoint(method, url, params=None, data=None):
    """Тестирование одного endpoint"""
    try:
        if method == "GET":
            response = requests.get(url, params=params, timeout=10)
        elif method == "POST":
            response = requests.post(url, params=params, json=data, timeout=10)
        
        print(f"   {method} {url}")
        print(f"      Статус: {response.status_code}")
        
        if response.status_code == 200:
            try:
                result = response.json()
                print(f"      ✅ Ответ: {json.dumps(result, ensure_ascii=False)[:100]}...")
            except:
                print(f"      ✅ Ответ: {response.text[:100]}...")
        else:
            print(f"      ❌ Ошибка: {response.text[:100]}...")
        
        return response.status_code == 200
        
    except Exception as e:
        print(f"   {method} {url}")
        print(f"      ❌ Исключение: {e}")
        return False

def main():
    print("🧪 Тестирование всех API endpoints")
    print("=" * 50)
    
    # Тестовые данные
    test_init_data = "test_data"
    real_init_data = "query_id=AAFn7WQMAAAAAGftZAym8xM1&user=%7B%22id%22%3A207940967%2C%22first_name%22%3A%22Fish%22%2C%22last_name%22%3A%22%22%2C%22username%22%3A%22NobodyYety%22%2C%22language_code%22%3A%22ru%22%2C%22is_premium%22%3Atrue%2C%22allows_write_to_pm%22%3Atrue%2C%22photo_url%22%3A%22https%253A%2F%2Ft.me%2Fi%2Fuserpic%2F320%2F6ZhmPb8VHMum-L3NuklXZIDjzwG5z3nmsPstk-j-X0Q.svg%22%7D&auth_date=1759589048&signature=IqcrTmc5udIux2TmYoFNRRGldsGj5cEgCzErhV9F9P8Em2Ep0QjsA6Er_CisvlqQhud44DH32KCjkadeiQ9EBQ&hash=f84de7979f9569a5d320a66bea2ae7682d39b2e9d7fadc1026a4f7c66c7c313f"
    
    endpoints = [
        # Основные endpoints
        ("GET", f"{RAILWAY_URL}/", None, None),
        ("GET", f"{RAILWAY_URL}/test", None, None),
        ("GET", f"{RAILWAY_URL}/api/test", None, None),
        
        # API endpoints с тестовыми данными
        ("GET", f"{RAILWAY_URL}/api/user/profile", {"init_data": test_init_data}, None),
        ("POST", f"{RAILWAY_URL}/api/pro/buy", {"init_data": test_init_data}, None),
        ("POST", f"{RAILWAY_URL}/api/ndn/buy", {"init_data": test_init_data, "amount_ndn": 100}, None),
        ("POST", f"{RAILWAY_URL}/api/ndn/withdraw", {"init_data": test_init_data, "amount_ndn": 50}, None),
        ("GET", f"{RAILWAY_URL}/api/stats/leaderboard", None, None),
        ("GET", f"{RAILWAY_URL}/api/stats/transactions", {"init_data": test_init_data}, None),
        
        # API endpoints с реальными данными Telegram
        ("GET", f"{RAILWAY_URL}/api/user/profile", {"init_data": real_init_data}, None),
    ]
    
    success_count = 0
    total_count = len(endpoints)
    
    for method, url, params, data in endpoints:
        if test_endpoint(method, url, params, data):
            success_count += 1
        print()
    
    print("📊 Результаты тестирования:")
    print(f"   Успешно: {success_count}/{total_count}")
    print(f"   Процент: {(success_count/total_count)*100:.1f}%")
    
    if success_count == total_count:
        print("   🎉 Все endpoints работают!")
    else:
        print("   ⚠️  Некоторые endpoints не работают")

if __name__ == "__main__":
    main()
