# PowerShell deployment script for Windows
# NodeOn Pyramid v1.2.0

Write-Host "Deploying NodeOn Pyramid v1.2.0..." -ForegroundColor Cyan

# Step 1: Check changes
Write-Host "`nChecking changes..." -ForegroundColor Yellow
git status

# Step 2: Add all changes
Write-Host "`nAdding changes..." -ForegroundColor Yellow
git add .

# Step 3: Commit
Write-Host "`nCommitting..." -ForegroundColor Yellow
$commitMessage = @"
Release v1.2.0 - Major Update: Game Mechanics

Features:
- 30 achievements in 7 categories
- 7 quests (4 daily + 3 weekly)
- Animated fortune wheel
- 7-rank system with bonuses
- 4 boosts for miner
- Balanced economy: 100 NDN/week max

Fixes:
- Username saving for users without Telegram username
- Gas/min display in miner
- Achievement text colors
- Referral system (referral_path, referral_level)

Stats:
- +8 API endpoints
- +1000 lines frontend (CSS + JS)
- +600 lines backend
- 25+ files modified

Economy:
- Daily rewards: 49 NDN/week
- Daily quests: 28 NDN/week
- Weekly quests: 9 NDN/week
- Fortune wheel: 14 NDN/week
- Total: 100 NDN/week
"@

git commit -m $commitMessage

# Step 4: Create tag
Write-Host "`nCreating tag v1.2.0..." -ForegroundColor Yellow
git tag -a v1.2.0 -m "Version 1.2.0 - Game Mechanics Update"

# Step 5: Push to repository
Write-Host "`nPushing to repository..." -ForegroundColor Yellow
git push origin main
git push origin v1.2.0

Write-Host "`nDeployment completed!" -ForegroundColor Green
Write-Host "`nNext steps:" -ForegroundColor Cyan
Write-Host "1. Connect to server: ssh user@your-server"
Write-Host "2. Pull changes: cd /path/to/nodeon ; git pull"
Write-Host "3. Restart server: pm2 restart nodeon-pyramid"
Write-Host "4. Check logs: pm2 logs nodeon-pyramid"
Write-Host "`nVersion 1.2.0 is ready!" -ForegroundColor Green
