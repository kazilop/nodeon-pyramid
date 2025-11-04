# Скрипт для загрузки файла pro.js на сервер
$server = "root@147.45.110.220"
$localFile = "server-deployment\routes\pro.js"
$remotePath = "/var/www/nodeon-pyramid/routes/pro.js"

Write-Host "Загрузка файла pro.js на сервер..." -ForegroundColor Yellow

scp $localFile "$server`:$remotePath"

Write-Host "Перезапуск сервера..." -ForegroundColor Yellow

ssh $server "cd /var/www/nodeon-pyramid; pm2 restart nodeon-pyramid; sleep 2; pm2 logs nodeon-pyramid --lines 10"










