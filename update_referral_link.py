#!/usr/bin/env python3
import requests
import json

# Supabase конфигурация
SUPABASE_URL = "https://ahxwpzgltlzlvrtrbanm.supabase.co"
SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoeHdwemdsdGx6bHZydHJiYW5tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1MDMxNDksImV4cCI6MjA3NTA3OTE0OX0.h4sMVhVwvRUiHgbevDgv9W1G2S__uDWPUSCiXdrEy4E"

def update_referral_link(user_id, referral_link):
    """Обновление реферальной ссылки пользователя"""
    print(f"Updating referral link for user {user_id}...")
    
    response = requests.patch(
        f"{SUPABASE_URL}/rest/v1/nodeon_users?id=eq.{user_id}",
        headers={
            "apikey": SUPABASE_ANON_KEY,
            "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
            "Content-Type": "application/json"
        },
        json={"referral_link": referral_link}
    )
    
    if response.status_code == 200:
        print(f"Referral link updated successfully for user {user_id}")
        return True
    else:
        print(f"Error updating referral link: {response.status_code}")
        print(response.text)
        return False

def main():
    """Основная функция"""
    print("Updating referral links...")
    
    # Обновляем реферальную ссылку для пользователя ID 5
    update_referral_link(5, "https://t.me/pro_stars_bot?startapp=ref_5")
    
    print("Referral link update completed!")

if __name__ == "__main__":
    main()












