import requests

# Тест API профиля пользователя
response = requests.get("https://nodeon-pyramid.netlify.app/api/user/profile", 
                       headers={"Authorization": "tma user=%7B%22id%22%3A207940967%7D"})
print(f"Status: {response.status_code}")
print(f"Response: {response.text[:500]}")

# Тест данных майнера
response2 = requests.get("https://nodeon-pyramid.netlify.app/api/miner/data/207940967")
print(f"\nMiner Status: {response2.status_code}")
print(f"Miner Response: {response2.text[:500]}")




