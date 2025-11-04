#!/bin/bash

echo "🚀 Deploying NodeOn Pyramid v1.2.0..."

# Шаг 1: Проверка изменений
echo "📋 Checking changes..."
git status

# Шаг 2: Добавление всех изменений
echo "➕ Adding changes..."
git add .

# Шаг 3: Коммит
echo "💾 Committing..."
git commit -m "🎉 Release v1.2.0 - Major Update: Game Mechanics

✨ Features:
- 30 achievements in 7 categories
- 7 quests (4 daily + 3 weekly)
- Animated fortune wheel
- 7-rank system with bonuses
- 4 boosts for miner
- Balanced economy: 100 NDN/week max

🔧 Fixes:
- Username saving for users without Telegram username
- Gas/min display in miner
- Achievement text colors
- Referral system (referral_path, referral_level)

📊 Stats:
- +8 API endpoints
- +1000 lines frontend (CSS + JS)
- +600 lines backend
- 25+ files modified

🎯 Economy:
- Daily rewards: 49 NDN/week
- Daily quests: 28 NDN/week
- Weekly quests: 9 NDN/week
- Fortune wheel: 14 NDN/week
- Total: 100 NDN/week ✅"

# Шаг 4: Тег версии
echo "🏷️ Creating tag v1.2.0..."
git tag -a v1.2.0 -m "Version 1.2.0 - Game Mechanics Update"

# Шаг 5: Push в репозиторий
echo "⬆️ Pushing to repository..."
git push origin main
git push origin v1.2.0

echo ""
echo "✅ Deployment script completed!"
echo ""
echo "📝 Next steps:"
echo "1. Connect to server: ssh user@your-server"
echo "2. Pull changes: cd /path/to/nodeon && git pull"
echo "3. Restart server: pm2 restart nodeon-pyramid"
echo "4. Check logs: pm2 logs nodeon-pyramid"
echo ""
echo "🎉 Version 1.2.0 is ready!"

