import os
from dotenv import load_dotenv

load_dotenv()

print("Testing environment variables...")
print(f"SUPABASE_URL: {os.getenv('SUPABASE_URL')}")
print(f"SUPABASE_ANON_KEY: {os.getenv('SUPABASE_ANON_KEY')[:20] if os.getenv('SUPABASE_ANON_KEY') else 'NOT SET'}")
print("Done!")

