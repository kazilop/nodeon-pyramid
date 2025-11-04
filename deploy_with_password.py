#!/usr/bin/env python3
"""
Скрипт для деплоя на сервер с авторизацией по паролю
"""

import os
import subprocess

# Параметры сервера
SERVER_HOST = "147.45.110.220"
SERVER_USER = "root"
SERVER_PASSWORD = "cogZE.f+5-^BN6"
REMOTE_PATH = "/root/nodeon"

def upload_file(local_path, remote_path):
    """Загрузка файла на сервер через plink с паролем"""
    try:
        # Используем WinSCP или plink для загрузки
        cmd = f"echo y | plink -ssh -pw {SERVER_PASSWORD} {SERVER_USER}@{SERVER_HOST} 'cat > {remote_path}' < {local_path}"
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
        
        if result.returncode == 0:
            print(f"✅ Загружено: {local_path}")
            return True
        else:
            print(f"❌ Ошибка: {result.stderr}")
            return False
    except Exception as e:
        print(f"❌ Ошибка загрузки: {e}")
        return False

def run_ssh_command(command):
    """Выполнение команды на сервере"""
    try:
        # Используем sshpass или plink для выполнения команды с паролем
        cmd = f"sshpass -p '{SERVER_PASSWORD}' ssh -o StrictHostKeyChecking=no {SERVER_USER}@{SERVER_HOST} '{command}'"
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
        
        if result.stdout:
            print(result.stdout)
        if result.stderr:
            print(f"Ошибки: {result.stderr}")
        
        return result.returncode == 0
    except Exception as e:
        print(f"❌ Ошибка выполнения команды: {e}")
        return False

def main():
    print("🚀 Начало деплоя на сервер...")
    print("=" * 60)
    
    # Список файлов для загрузки
    files_to_upload = [
        ("server-deployment/routes/pro.js", f"{REMOTE_PATH}/routes/pro.js"),
        ("server-deployment/routes/payments.js", f"{REMOTE_PATH}/routes/payments.js"),
        ("server-deployment/server.js", f"{REMOTE_PATH}/server.js"),
        ("server-deployment/public/index.html", f"{REMOTE_PATH}/public/index.html"),
    ]
    
    # Загрузка файлов
    uploaded = 0
    for local, remote in files_to_upload:
        if os.path.exists(local):
            if upload_file(local, remote):
                uploaded += 1
        else:
            print(f"⚠️ Файл не найден: {local}")
    
    print(f"\n📊 Загружено файлов: {uploaded}/{len(files_to_upload)}")
    
    # Перезапуск сервера
    if uploaded > 0:
        print("\n🔄 Перезапуск сервера...")
        run_ssh_command("cd /root/nodeon && pm2 restart nodeon-pyramid")
        
        # Проверка статуса
        print("\n📊 Статус сервера:")
        run_ssh_command("pm2 status nodeon-pyramid")
        
        # Логи
        print("\n📋 Последние логи:")
        run_ssh_command("pm2 logs nodeon-pyramid --lines 20 --nostream")
    
    print("\n✅ Деплой завершен!")

if __name__ == "__main__":
    main()










