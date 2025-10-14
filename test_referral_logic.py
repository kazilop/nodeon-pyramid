# Тестовый скрипт для проверки логики подсчета уровней рефералов

# Пример данных
user_id = 5
referrals = [
    {"id": 4, "name": "Александр", "referral_path": "5,4"},
    {"id": 16, "name": "Мария", "referral_path": "5,4,16"},
    {"id": 3, "name": "Станислав", "referral_path": "5,3"},
    {"id": 7, "name": "Ser", "referral_path": "5,7"},
    {"id": 14, "name": "Artem", "referral_path": "5,14"},
]

print(f"Проверка рефералов для пользователя ID {user_id}:\n")

for ref in referrals:
    referral_path = ref["referral_path"]
    path_parts = [int(x) for x in referral_path.split(',')]
    
    if user_id in path_parts:
        user_position = path_parts.index(user_id)
        ref_id = ref["id"]
        
        if ref_id in path_parts:
            ref_position = path_parts.index(ref_id)
            level = ref_position - user_position
            
            print(f"{ref['name']} (ID: {ref_id})")
            print(f"  Path: {referral_path} -> {path_parts}")
            print(f"  User position: {user_position}, Ref position: {ref_position}")
            print(f"  Level: {level}")
            print()


