#!/usr/bin/env python3
import requests

# Простой тест покупки майнера
url = "https://nodeon-pyramid.netlify.app/api/miner/buy-farm"
data = {"user_id": 207940967, "farm_type": "basic"}

try:
    response = requests.post(url, json=data, timeout=10)
    print(f"Status: {response.status_code}")
    print(f"Response: {response.text}")
except Exception as e:
    print(f"Error: {e}")




