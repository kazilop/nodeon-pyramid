#!/usr/bin/env python3
"""
Скрипт для загрузки файлов на сервер и перезапуска
"""

import os
import subprocess
import paramiko
from scp import SCPClient

# Параметры сервера
SERVER_HOST = "147.45.110.220"
SERVER_USER = "root"
SERVER_PATH = "/root/nodeon"  # Исправлен путь на актуальный

def upload_file(ssh_client, local_path, remote_path):
    """Загрузка файла на сервер"""
    try:
        with SCPClient(ssh_client.get_transport()) as scp:
            scp.put(local_path, remote_path)
            print(f"✅ Загружено: {local_path} -> {remote_path}")
            return True
    except Exception as e:
        print(f"❌ Ошибка загрузки {local_path}: {e}")
        return False

def run_ssh_command(ssh_client, command):
    """Выполнение команды на сервере"""
    try:
        stdin, stdout, stderr = ssh_client.exec_command(command)
        output = stdout.read().decode()
        errors = stderr.read().decode()
        
        if output:
            print(output)
        if errors:
            print(f"Ошибки: {errors}")
        
        return True
    except Exception as e:
        print(f"❌ Ошибка выполнения команды: {e}")
        return False

def main():
    print("🚀 Начало деплоя на сервер...")
    print("=" * 60)
    
    # Подключение к серверу
    try:
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(SERVER_HOST, username=SERVER_USER)
        print(f"✅ Подключено к {SERVER_HOST}")
    except Exception as e:
        print(f"❌ Ошибка подключения: {e}")
        return
    
    # Список файлов для загрузки
    files_to_upload = [
        ("dist/index.html", f"{SERVER_PATH}/public/index.html"),
        ("server-deployment/routes/pro.js", f"{SERVER_PATH}/routes/pro.js"),
        ("server-deployment/routes/payments.js", f"{SERVER_PATH}/routes/payments.js"),
        ("server-deployment/server.js", f"{SERVER_PATH}/server.js"),
    ]
    
    # Загрузка файлов
    for local, remote in files_to_upload:
        if os.path.exists(local):
            upload_file(ssh, local, remote)
        else:
            print(f"⚠️ Файл не найден: {local}")
    
    # Перезапуск сервера
    print("\n🔄 Перезапуск сервера...")
    run_ssh_command(ssh, f"cd {SERVER_PATH}; pm2 restart nodeon-pyramid")
    
    # Проверка статуса
    print("\n📊 Статус сервера:")
    run_ssh_command(ssh, "pm2 status nodeon-pyramid")
    
    # Логи
    print("\n📋 Последние логи:")
    run_ssh_command(ssh, f"pm2 logs nodeon-pyramid --lines 20 --nostream")
    
    ssh.close()
    print("\n✅ Деплой завершен!")

if __name__ == "__main__":
    main()







