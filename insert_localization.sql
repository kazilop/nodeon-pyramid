-- SQL запросы для вставки текстов локализации
-- Сгенерировано автоматически

INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('app.name', 'app.name', 'i18n', '">         <!-- Заголовок -->         <div class="header">             <div class="logo" data-i18n="app.name">🚀 NodeOn Crypto</div>             <div class="subtitle" data-i18n="app.description">Крипто')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('app.description', 'app.description', 'i18n', 'lass="logo" data-i18n="app.name">🚀 NodeOn Crypto</div>             <div class="subtitle" data-i18n="app.description">Крипто игра с монетами NDN</div>             <div class="language-selector">       ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('tabs.core', 'tabs.core', 'i18n', 's-header">                 <button class="tab-button active" onclick="switchTab('core')" data-i18n="tabs.core">                     🏠 Основное                 </button>                 <button class="')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('tabs.game', 'tabs.game', 'i18n', '</button>                 <button class="tab-button" onclick="switchTab('game')" data-i18n="tabs.game">                     🎮 Игра                 </button>                 <button class="tab-button" ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('tabs.miner', 'tabs.miner', 'i18n', '</button>                 <button class="tab-button" onclick="switchTab('miner')" data-i18n="tabs.miner">                     ⛏️ NDN Miner                 </button>             </div>         </div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('user.balance_ndn', 'user.balance_ndn', 'i18n', 'tion">             <div class="balance-item">                 <div class="balance-label" data-i18n="user.balance_ndn">NDN Баланс</div>                 <div class="balance-value" id="ndnBalance">0.00</')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.buy_pro', 'buttons.buy_pro', 'i18n', '<div class="card">             <button class="button button-primary" onclick="buyPro()" data-i18n="buttons.buy_pro">                 💎 Купить Pro статус             </button>             <button class')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.buy_ndn', 'buttons.buy_ndn', 'i18n', '</button>             <button class="button button-secondary" onclick="buyNDN()" data-i18n="buttons.buy_ndn">                 ⭐ Купить NDN за Telegram Stars             </button>             <button c')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.exchange', 'buttons.exchange', 'i18n', '</button>             <button class="button button-success" onclick="exchangeNDN()" data-i18n="buttons.exchange">                 ⭐ Обменять NDN на Stars             </button>             <button clas')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.transfer_ndn', 'buttons.transfer_ndn', 'i18n', '</button>             <button class="button button-info" onclick="transferNDN()" data-i18n="buttons.transfer_ndn">                 💸 Перевести NDN             </button>         </div>          <!-- До')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.achievements', 'buttons.achievements', 'i18n', 's="card">             <button class="button button-primary" onclick="showAchievements()" data-i18n="buttons.achievements">                 🏆 Достижения             </button>             <button class=')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.shops', 'buttons.shops', 'i18n', '</button>             <button class="button button-secondary" onclick="showShops()" data-i18n="buttons.shops">                 🏪 Магазины             </button>             <button class="button button')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.referrals', 'buttons.referrals', 'i18n', '</button>             <button class="button button-success" onclick="showReferrals()" data-i18n="buttons.referrals">                 👥 Мои рефералы             </button>         </div>          <!-- P')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.invite_friends', 'buttons.invite_friends', 'i18n', 'lay: none;">             <button class="button button-success" onclick="inviteFriends()" data-i18n="buttons.invite_friends">                 📤 Пригласить друзей             </button>         </div>   ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.leaderboard', 'buttons.leaderboard', 'i18n', 'ss="card">             <button class="button button-primary" onclick="showLeaderboard()" data-i18n="buttons.leaderboard">                 🏆 Таблица лидеров             </button>             <button cl')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.rules', 'buttons.rules', 'i18n', '</button>             <button class="button button-secondary" onclick="showRules()" data-i18n="buttons.rules">                 📋 Правила игры             </button>         </div>          <!-- Игровой')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('user.user_id', 'user.user_id', 'i18n', '="card">             <div class="user-id-section">                 <div class="id-label" data-i18n="user.user_id">🎮 Ваш игровой ID:</div>                 <div class="id-container">                    ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('user.user_id_hint', 'user.user_id_hint', 'i18n', 'ck="copyUserId()">📋</button>                 </div>                 <div class="id-hint" data-i18n="user.user_id_hint">Используйте этот ID для переводов другим игрокам</div>             </div>        ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('game.daily_rewards', 'game.daily_rewards', 'i18n', '<!-- Ежедневные награды -->             <div class="game-card">                 <h3 data-i18n="game.daily_rewards">🎁 Ежедневные награды</h3>                 <p data-i18n="game.daily_rewards_desc">Захо')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('game.daily_rewards_desc', 'game.daily_rewards_desc', 'i18n', '<h3 data-i18n="game.daily_rewards">🎁 Ежедневные награды</h3>                 <p data-i18n="game.daily_rewards_desc">Заходите каждый день и получайте бонусы! (прокрутите для просмотра всех дней)</p>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('game.achievements', 'game.achievements', 'i18n', '<!-- Достижения -->             <div class="game-card">                 <h3 data-i18n="game.achievements">🏆 Достижения</h3>                 <p data-i18n="game.achievements_desc">Выполняйте задачи и по')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('game.achievements_desc', 'game.achievements_desc', 'i18n', '>                 <h3 data-i18n="game.achievements">🏆 Достижения</h3>                 <p data-i18n="game.achievements_desc">Выполняйте задачи и получайте награды!</p>                 <div id="achievem')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('game.player_level', 'game.player_level', 'i18n', '<!-- Уровень игрока -->             <div class="game-card">                 <h3 data-i18n="game.player_level">⭐ Уровень игрока</h3>                 <div class="level-progress">                     <di')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('game.level', 'game.level', 'i18n', 'el-progress">                     <div class="level-info">                         <span data-i18n="game.level">Уровень <span id="playerLevel">1</span></span>                         <span><span id="c')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('game.xp', 'game.xp', 'i18n', '<span><span id="currentXP">0</span> / <span id="nextLevelXP">100</span> <span data-i18n="game.xp">XP</span></span>                     </div>                     <div class="level-bar">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('game.statistics', 'game.statistics', 'i18n', '<!-- Статистика игры -->             <div class="game-card">                 <h3 data-i18n="game.statistics">📊 Статистика</h3>                 <div class="stats-grid">                     <div class="')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('game.days_played', 'game.days_played', 'i18n', '<div class="stat-info">                             <div class="stat-label" data-i18n="game.days_played">Дней в игре</div>                             <div class="stat-value" id="daysPlayed">0</div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('game.achievements_count', 'game.achievements_count', 'i18n', '<div class="stat-info">                             <div class="stat-label" data-i18n="game.achievements_count">Достижений</div>                             <div class="stat-value" id="achievementsCou')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('game.total_earned', 'game.total_earned', 'i18n', '<div class="stat-info">                             <div class="stat-label" data-i18n="game.total_earned">Заработано NDN</div>                             <div class="stat-value" id="totalEarned">0</d')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('game.total_referrals', 'game.total_referrals', 'i18n', '<div class="stat-info">                             <div class="stat-label" data-i18n="game.total_referrals">Приглашено</div>                             <div class="stat-value" id="totalReferrals">0<')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.stats.ndn_gas', 'miner.stats.ndn_gas', 'i18n', '<div class="miner-stat-info">                         <div class="miner-stat-label" data-i18n="miner.stats.ndn_gas">NDN Gas</div>                         <div class="miner-stat-value" id="ndnGasBalanc')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.stats.energy', 'miner.stats.energy', 'i18n', '<div class="miner-stat-info">                         <div class="miner-stat-label" data-i18n="miner.stats.energy">Энергия</div>                         <div class="miner-stat-value" id="energyLevel">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.stats.gas_per_minute', 'miner.stats.gas_per_minute', 'i18n', '<div class="miner-stat-info">                         <div class="miner-stat-label" data-i18n="miner.stats.gas_per_minute">Gas/мин</div>                         <div class="miner-stat-value" id="gasPe')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.stats.next_event', 'miner.stats.next_event', 'i18n', '<div class="miner-stat-info">                         <div class="miner-stat-label" data-i18n="miner.stats.next_event">След. событие</div>                         <div class="miner-stat-value" id="nex')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.sync.button', 'miner.sync.button', 'i18n', '<button class="sync-button" onclick="forceSyncMinerData()">                     🔄 <span data-i18n="miner.sync.button">Синхронизировать</span>                 </button>             </div>              ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.energy.refill_button', 'miner.energy.refill_button', 'i18n', 'll-button" id="energyRefillButton" onclick="refillEnergy()">                     ⚡ <span data-i18n="miner.energy.refill_button">Пополнить энергию</span>                 </button>                 <div ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.energy.next_refill', 'miner.energy.next_refill', 'i18n', '<div class="energy-refill-info" id="energyRefillInfo">                     <span data-i18n="miner.energy.next_refill">Следующее пополнение через:</span> <span id="nextRefillTime">3:00:00</span>       ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.shop.title', 'miner.shop.title', 'i18n', '>              <!-- Магазин -->             <div class="miner-shop">                 <h3 data-i18n="miner.shop.title">🛒 Магазин</h3>                 <div class="shop-items" id="shopItems">            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.leaderboard.title', 'miner.leaderboard.title', 'i18n', '!-- Рейтинг майнеров -->             <div class="miner-leaderboard">                 <h3 data-i18n="miner.leaderboard.title">🏆 Рейтинг майнеров</h3>                 <div class="leaderboard-table" id="')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('pro.cost', 'pro.cost', 'i18n', '="buttons.buy_pro">💎 Купить Pro статус</div>                 <div class="modal-subtitle" data-i18n="pro.cost">Стоимость: 1000 NDN</div>             </div>             <div class="form-group">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.confirm', 'buttons.confirm', 'i18n', 'uttons">                 <button class="button button-primary" onclick="confirmBuyPro()" data-i18n="buttons.confirm">Подтвердить</button>                 <button class="button button-secondary" onclic')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.cancel', 'buttons.cancel', 'i18n', '<button class="button button-secondary" onclick="closeModal('buyProModal')" data-i18n="buttons.cancel">Отмена</button>             </div>         </div>     </div>      <!-- Модальное окно покупки NDN')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('payment.rate', 'payment.rate', 'i18n', 'uy_ndn">⭐ Купить NDN за Telegram Stars</div>                 <div class="modal-subtitle" data-i18n="payment.rate">Курс: 1 NDN = 1 Telegram Star</div>                 <div class="modal-subtitle" style=')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('payment.stars_info', 'payment.stars_info', 'i18n', '<div class="modal-subtitle" style="font-size: 0.8rem; color: #666; margin-top: 5px;" data-i18n="payment.stars_info">                     💡 Stars поступают на баланс бота и могут быть выведены в TON')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('transfer.amount', 'transfer.amount', 'i18n', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="transfer.amount">Количество NDN:</label>                 <input type="number" class="form-input" id="nd')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('payment.stars_cost', 'payment.stars_cost', 'i18n', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="payment.stars_cost">Стоимость в Stars:</label>                 <div class="balance-value" id="starsCost')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.buy', 'buttons.buy', 'i18n', '<div class="card">             <button class="button button-primary" onclick="buyPro()" data-i18n="buttons.buy_pro">                 💎 Купить Pro статус             </button>             <button class')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('exchange.stars_info', 'exchange.stars_info', 'i18n', '<div class="modal-subtitle" style="font-size: 0.8rem; color: #666; margin-top: 5px;" data-i18n="exchange.stars_info">                     💡 NDN списываются с вашего счета, Stars поступают в Telegram')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('exchange.username', 'exchange.username', 'i18n', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="exchange.username">Ваш Telegram username:</label>                 <input type="text" class="form-input"')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('exchange.receive_stars', 'exchange.receive_stars', 'i18n', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="exchange.receive_stars">Получите Stars:</label>                 <div class="balance-value" id="exchange')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.withdraw_ndn', 'buttons.withdraw_ndn', 'i18n', 'ontent">             <div class="modal-header">                 <div class="modal-title" data-i18n="buttons.withdraw_ndn">💰 Вывести NDN</div>                 <div class="modal-subtitle" data-i18n="wit')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('withdraw.minimum', 'withdraw.minimum', 'i18n', 'n="buttons.withdraw_ndn">💰 Вывести NDN</div>                 <div class="modal-subtitle" data-i18n="withdraw.minimum">Минимальная сумма: 100 NDN</div>             </div>             <div class="form-g')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('withdraw.recipient_id', 'withdraw.recipient_id', 'i18n', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="withdraw.recipient_id">Telegram ID получателя:</label>                 <input type="text" class="form-i')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.withdraw', 'buttons.withdraw', 'i18n', 'ontent">             <div class="modal-header">                 <div class="modal-title" data-i18n="buttons.withdraw_ndn">💰 Вывести NDN</div>                 <div class="modal-subtitle" data-i18n="wit')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('achievements.description', 'achievements.description', 'i18n', '8n="buttons.achievements">🏆 Достижения</div>                 <div class="modal-subtitle" data-i18n="achievements.description">Выполняйте задачи и получайте награды!</div>             </div>           ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.back', 'buttons.back', 'i18n', '<button class="button button-secondary" onclick="closeModal('achievementsModal')" data-i18n="buttons.back">← Назад</button>             </div>         </div>     </div>      <!-- Модальное окно магази')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.description', 'shops.description', 'i18n', '" data-i18n="buttons.shops">🏪 Магазины</div>                 <div class="modal-subtitle" data-i18n="shops.description">Откройте свой магазин за 10,000 NDN!</div>             </div>             <div cl')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.open_shop', 'shops.open_shop', 'i18n', 'ons">                 <button class="button button-primary" onclick="showOpenShopForm()" data-i18n="shops.open_shop">🏪 Открыть магазин</button>                 <button class="button button-secondary" ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.cost', 'shops.cost', 'i18n', '8n="shops.open_shop">🏪 Открыть магазин</div>                 <div class="modal-subtitle" data-i18n="shops.cost">Стоимость: 10,000 NDN</div>             </div>             <div class="form-group">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.shop_name', 'shops.shop_name', 'i18n', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.shop_name">Название магазина:</label>                 <input type="text" class="form-input" id="s')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.shop_description', 'shops.shop_description', 'i18n', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.shop_description">Описание:</label>                 <textarea class="form-input" id="shopDescript')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.category', 'shops.category', 'i18n', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.category">Категория:</label>                 <select class="form-input" id="shopCategory">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.categories.general', 'shops.categories.general', 'i18n', 'select class="form-input" id="shopCategory">                     <option value="general" data-i18n="shops.categories.general">Общие товары</option>                     <option value="digital" data-i18')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.categories.digital', 'shops.categories.digital', 'i18n', 'ps.categories.general">Общие товары</option>                     <option value="digital" data-i18n="shops.categories.digital">Цифровые товары</option>                     <option value="physical" data')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.categories.physical', 'shops.categories.physical', 'i18n', 'ategories.digital">Цифровые товары</option>                     <option value="physical" data-i18n="shops.categories.physical">Физические товары</option>                     <option value="services" d')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.categories.services', 'shops.categories.services', 'i18n', 'gories.physical">Физические товары</option>                     <option value="services" data-i18n="shops.categories.services">Услуги</option>                     <option value="congratulations" data-')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.categories.congratulations', 'shops.categories.congratulations', 'i18n', 'categories.services">Услуги</option>                     <option value="congratulations" data-i18n="shops.categories.congratulations">Поздравления</option>                     <option value="merchandi')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.categories.merchandise', 'shops.categories.merchandise', 'i18n', 's.congratulations">Поздравления</option>                     <option value="merchandise" data-i18n="shops.categories.merchandise">Мерч</option>                 </select>             </div>            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.add_item', 'shops.add_item', 'i18n', 'ontent">             <div class="modal-header">                 <div class="modal-title" data-i18n="shops.add_item">📦 Добавить товар</div>                 <div class="modal-subtitle" data-i18n="shops.')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.add_item_description', 'shops.add_item_description', 'i18n', 'i18n="shops.add_item">📦 Добавить товар</div>                 <div class="modal-subtitle" data-i18n="shops.add_item_description">Добавьте товар в ваш магазин</div>             </div>             <div c')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.item_name', 'shops.item_name', 'i18n', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.item_name">Название товара:</label>                 <input type="text" class="form-input" id="ite')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.item_description', 'shops.item_description', 'i18n', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.item_description">Описание:</label>                 <textarea class="form-input" id="itemDescript')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.price_ndn', 'shops.price_ndn', 'i18n', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.price_ndn">Цена в NDN:</label>                 <input type="number" class="form-input" id="itemPr')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.price_stars', 'shops.price_stars', 'i18n', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.price_stars">Цена в Stars:</label>                 <input type="number" class="form-input" id="it')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.item_type', 'shops.item_type', 'i18n', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.item_type">Тип товара:</label>                 <select class="form-input" id="itemType">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.types.digital', 'shops.types.digital', 'i18n', '<select class="form-input" id="itemType">                     <option value="digital" data-i18n="shops.types.digital">Цифровой</option>                     <option value="physical" data-i18n="shops.ty')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.types.physical', 'shops.types.physical', 'i18n', '18n="shops.types.digital">Цифровой</option>                     <option value="physical" data-i18n="shops.types.physical">Физический</option>                     <option value="service" data-i18n="sho')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.types.service', 'shops.types.service', 'i18n', 'n="shops.types.physical">Физический</option>                     <option value="service" data-i18n="shops.types.service">Услуга</option>                 </select>             </div>             <div c')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.image_url', 'shops.image_url', 'i18n', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.image_url">Ссылка на изображение:</label>                 <input type="url" class="form-input" id')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('shops.stock', 'shops.stock', 'i18n', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.stock">Количество на складе (-1 = безлимит):</label>                 <input type="number" class="')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.invite_description', 'referrals.invite_description', 'i18n', 'ns.invite_friends">📤 Пригласить друзей</div>                 <div class="modal-subtitle" data-i18n="referrals.invite_description">Поделитесь ссылкой и зарабатывайте с каждого реферала!</div>          ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.your_link', 'referrals.your_link', 'i18n', 'nt">                     <div class="referral-link-section">                         <h3 data-i18n="referrals.your_link">🔗 Ваша реферальная ссылка:</h3>                         <div class="link-contai')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.copy', 'buttons.copy', 'i18n', '<button class="button button-primary" onclick="copyReferralLink()" data-i18n="buttons.copy">📋 Копировать</button>                             <button class="button button-secondary" onclick=')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.show_link', 'referrals.show_link', 'i18n', '<button class="button button-secondary" onclick="showLinkModal()" data-i18n="referrals.show_link">👁️ Показать ссылку</button>                         </div>                     </div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.invite_methods', 'referrals.invite_methods', 'i18n', 'v>                                  <div class="invite-methods">                     <h3 data-i18n="referrals.invite_methods">📱 Способы приглашения:</h3>                     <div class="method-buttons')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.select_contact', 'referrals.select_contact', 'i18n', '<button class="button button-success" onclick="inviteToTelegramContact()" data-i18n="referrals.select_contact">                             📱 Выбрать контакт из Telegram                         </butt')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.share_telegram', 'referrals.share_telegram', 'i18n', '<button class="button button-primary" onclick="shareViaTelegram()" data-i18n="referrals.share_telegram">                             🌐 Поделиться в Telegram                         </button>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.copy_link', 'referrals.copy_link', 'i18n', '<button class="button button-secondary" onclick="shareViaOther()" data-i18n="referrals.copy_link">                             🔗 Скопировать ссылку                         </button>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.how_to_earn', 'referrals.how_to_earn', 'i18n', 'iv>                                  <div class="referral-info">                     <h3 data-i18n="referrals.how_to_earn">💰 Как зарабатывать:</h3>                     <div class="info-grid">         ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.step1', 'referrals.step1', 'i18n', '<div class="info-icon">1️⃣</div>                             <div class="info-text" data-i18n="referrals.step1">Друг переходит по вашей ссылке</div>                         </div>                     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.step2', 'referrals.step2', 'i18n', '<div class="info-icon">2️⃣</div>                             <div class="info-text" data-i18n="referrals.step2">Регистрируется в игре</div>                         </div>                         <div ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.step3', 'referrals.step3', 'i18n', '<div class="info-icon">3️⃣</div>                             <div class="info-text" data-i18n="referrals.step3">Покупает PRO статус</div>                         </div>                         <div cl')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.step4', 'referrals.step4', 'i18n', '<div class="info-icon">4️⃣</div>                             <div class="info-text" data-i18n="referrals.step4">Вы получаете 200 NDN</div>                         </div>                         <div c')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.step5', 'referrals.step5', 'i18n', '<div class="info-icon">5️⃣</div>                             <div class="info-text" data-i18n="referrals.step5">Зарабатываете до 7 уровней в глубину</div>                         </div>               ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('transfer.title', 'transfer.title', 'i18n', 'ontent">             <div class="modal-header">                 <div class="modal-title" data-i18n="transfer.title">💸 Перевести NDN</div>                 <div class="modal-subtitle" data-i18n="transfe')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('transfer.instructions', 'transfer.instructions', 'i18n', '-i18n="transfer.title">💸 Перевести NDN</div>                 <div class="modal-subtitle" data-i18n="transfer.instructions">Выберите получателя и введите сумму</div>             </div>             <div')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('transfer.recipient', 'transfer.recipient', 'i18n', 'ansfer-content">                 <div class="recipient-section">                     <h3 data-i18n="transfer.recipient">👤 Получатель:</h3>                     <div class="recipient-info" id="recipient')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.change', 'buttons.change', 'i18n', '<button class="button button-secondary" onclick="changeRecipient()" data-i18n="buttons.change">Изменить</button>                         </div>                     </div>                     <d')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.find_player', 'buttons.find_player', 'i18n', '<button class="button button-primary" id="findRecipientBtn" onclick="findRecipient()" data-i18n="buttons.find_player">                             🔍 Найти игрока                         </button>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('transfer.balance', 'transfer.balance', 'i18n', '1">                         <div class="balance-info">                             <span data-i18n="transfer.balance">Ваш баланс:</span> <span id="transferBalance">0</span> NDN                        ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('transfer.confirm', 'transfer.confirm', 'i18n', 'ass="button button-success" id="confirmTransferBtn" onclick="confirmTransfer()" disabled data-i18n="transfer.confirm">                     💸 Перевести                 </button>                 <button')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.farms.${farm.id}', 'miner.farms.${farm.id}', 'i18n', '<div class="farm-icon">${farm.icon}</div>                         <div class="farm-name" data-i18n="miner.farms.${farm.id}">${farm.name}</div>                         <div class="farm-description" dat')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.farms.${farm.id}_desc', 'miner.farms.${farm.id}_desc', 'i18n', 'rms.${farm.id}">${farm.name}</div>                         <div class="farm-description" data-i18n="miner.farms.${farm.id}_desc">${farm.description}</div>                         <div class="farm-stat')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.farms.gas_per_min', 'miner.farms.gas_per_min', 'i18n', '/div>                         <div class="farm-stats">                             <span data-i18n="miner.farms.gas_per_min">Gas/мин</span>: ${farm.baseGasPerMinute}                             <span ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.farms.energy_cost', 'miner.farms.energy_cost', 'i18n', '.gas_per_min">Gas/мин</span>: ${farm.baseGasPerMinute}                             <span data-i18n="miner.farms.energy_cost">Энергия</span>: ${farm.energyCost}                         </div>          ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.farms.quantity', 'miner.farms.quantity', 'i18n', '/div>                         <div class="farm-stats">                             <span data-i18n="miner.farms.quantity">Количество</span>: ${farmCount}                             <span data-i18n="m')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.farms.cost', 'miner.farms.cost', 'i18n', '"miner.farms.quantity">Количество</span>: ${farmCount}                             <span data-i18n="miner.farms.cost">Стоимость</span>: ${farm.baseCost} Gas                         </div>             ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.sync.waiting', 'miner.sync.waiting', 'i18n', 'syncButton.disabled = true;                 syncButton.innerHTML = '⏳ <span data-i18n="miner.sync.waiting">Синхронизация...</span>';                 console.log('🔒 Кнопка заблокирована');             ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.leaderboard.rank', 'miner.leaderboard.rank', 'i18n', '<thead>                         <tr>                             <th data-i18n="miner.leaderboard.rank">Место</th>                             <th data-i18n="miner.leaderboard.player">Игрок</th>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.leaderboard.player', 'miner.leaderboard.player', 'i18n', '<th data-i18n="miner.leaderboard.rank">Место</th>                             <th data-i18n="miner.leaderboard.player">Игрок</th>                             <th data-i18n="miner.leaderboard.gas_earne')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.leaderboard.gas_earned', 'miner.leaderboard.gas_earned', 'i18n', '<th data-i18n="miner.leaderboard.player">Игрок</th>                             <th data-i18n="miner.leaderboard.gas_earned">Gas заработано</th>                             <th data-i18n="miner.leader')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.leaderboard.farms_count', 'miner.leaderboard.farms_count', 'i18n', '-i18n="miner.leaderboard.gas_earned">Gas заработано</th>                             <th data-i18n="miner.leaderboard.farms_count">Ферм</th>                             <th data-i18n="miner.leaderboar')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.leaderboard.level', 'miner.leaderboard.level', 'i18n', '<th data-i18n="miner.leaderboard.farms_count">Ферм</th>                             <th data-i18n="miner.leaderboard.level">Уровень</th>                         </tr>                     </thead>     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('miner.energy.waiting', 'miner.energy.waiting', 'i18n', 'se {                 button.disabled = true;                 button.innerHTML = '⏰ <span data-i18n="miner.energy.waiting">Ожидание...</span>';                 info.style.display = 'block';')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.description', 'referrals.description', 'i18n', 'tons.referrals">👥 Мои рефералы</div>                         <div class="modal-subtitle" data-i18n="referrals.description">Награды начисляются только когда рефералы покупают PRO статус</div>          ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.total', 'referrals.total', 'i18n', '<div class="stat-info">                                     <div class="stat-label" data-i18n="referrals.total">Всего рефералов</div>                                     <div class="stat-value">${tota')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.regular', 'referrals.regular', 'i18n', '<div class="stat-info">                                     <div class="stat-label" data-i18n="referrals.regular">Обычных</div>                                     <div class="stat-value">${regularRef')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.pro', 'referrals.pro', 'i18n', '<div class="stat-info">                                     <div class="stat-label" data-i18n="referrals.pro">PRO</div>                                     <div class="stat-value">${proReferrals}</div')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.earnings', 'referrals.earnings', 'i18n', '<div class="stat-info">                                     <div class="stat-label" data-i18n="referrals.earnings">Заработано</div>                                     <div class="stat-value">${earnin')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.level_stats', 'referrals.level_stats', 'i18n', '<div class="referral-levels">                         <h3 data-i18n="referrals.level_stats">📊 Статистика по уровням:</h3>                         ${data.referralStats && data.referralStats.l')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.level', 'referrals.level', 'i18n', '<div class="referral-levels">                         <h3 data-i18n="referrals.level_stats">📊 Статистика по уровням:</h3>                         ${data.referralStats && data.referralS')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.referrals_count', 'referrals.referrals_count', 'i18n', '"level-stats">                                                 <span class="level-count" data-i18n="referrals.referrals_count" data-count="${stat.total_referrals}">${stat.total_referrals} рефералов</s')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.no_level_stats', 'referrals.no_level_stats', 'i18n', '`).join('') :                             '<div class="no-referrals" data-i18n="referrals.no_level_stats">Статистика по уровням пока недоступна</div>'                         }                     </d')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.referrals_list', 'referrals.referrals_list', 'i18n', '<div class="referrals-content">                         <h3 data-i18n="referrals.referrals_list">👥 Список рефералов по уровням:</h3>                         ${Object.keys(referralsByLevel).length')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.level_with_count', 'referrals.level_with_count', 'i18n', '<div class="level-section">                                     <h4 data-i18n="referrals.level_with_count" data-level="${level}" data-count="${referralsByLevel[level].length}">📊 ${level} уровень (${re')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('referrals.no_referrals', 'referrals.no_referrals', 'i18n', '`).join('') :                             '<div class="no-referrals" data-i18n="referrals.no_referrals">У вас пока нет рефералов</div>'                         }                     </div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.основное', '🏠 Основное', 'button', 'on class="tab-button active" onclick="switchTab('core')" data-i18n="tabs.core">                     🏠 Основное                 </button>                 <button class="tab-button" onclick="switchTab('')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.игра', '🎮 Игра', 'button', '<button class="tab-button" onclick="switchTab('game')" data-i18n="tabs.game">                     🎮 Игра                 </button>                 <button class="tab-button" onclick="switchTab('miner'')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.ndn_miner', '⛏️ NDN Miner', 'button', '<button class="tab-button" onclick="switchTab('miner')" data-i18n="tabs.miner">                     ⛏️ NDN Miner                 </button>             </div>         </div>          <!-- Вкладка Core ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.купить_pro_статус', '💎 Купить Pro статус', 'button', 'utton class="button button-primary" onclick="buyPro()" data-i18n="buttons.buy_pro">                 💎 Купить Pro статус             </button>             <button class="button button-secondary" onclic')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.купить_ndn_за', '⭐ Купить NDN за Telegram Stars', 'button', 'ton class="button button-secondary" onclick="buyNDN()" data-i18n="buttons.buy_ndn">                 ⭐ Купить NDN за Telegram Stars             </button>             <button class="button button-succes')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.обменять_ndn_на', '⭐ Обменять NDN на Stars', 'button', 'class="button button-success" onclick="exchangeNDN()" data-i18n="buttons.exchange">                 ⭐ Обменять NDN на Stars             </button>             <button class="button button-info" onclick')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.перевести_ndn', '💸 Перевести NDN', 'button', 'lass="button button-info" onclick="transferNDN()" data-i18n="buttons.transfer_ndn">                 💸 Перевести NDN             </button>         </div>          <!-- Дополнительные функции -->       ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.достижения', '🏆 Достижения', 'button', 'tton button-primary" onclick="showAchievements()" data-i18n="buttons.achievements">                 🏆 Достижения             </button>             <button class="button button-secondary" onclick="show')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.магазины', '🏪 Магазины', 'button', 'on class="button button-secondary" onclick="showShops()" data-i18n="buttons.shops">                 🏪 Магазины             </button>             <button class="button button-success" onclick="showRefe')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.мои_рефералы', '👥 Мои рефералы', 'button', 'ss="button button-success" onclick="showReferrals()" data-i18n="buttons.referrals">                 👥 Мои рефералы             </button>         </div>          <!-- PRO функции (только для PRO пользо')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.пригласить_друзей', '📤 Пригласить друзей', 'button', 'utton button-success" onclick="inviteFriends()" data-i18n="buttons.invite_friends">                 📤 Пригласить друзей             </button>         </div>          <!-- Дополнительные функции 2 --> ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.таблица_лидеров', '🏆 Таблица лидеров', 'button', 'button button-primary" onclick="showLeaderboard()" data-i18n="buttons.leaderboard">                 🏆 Таблица лидеров             </button>             <button class="button button-secondary" onclick=')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.правила_игры', '📋 Правила игры', 'button', 'on class="button button-secondary" onclick="showRules()" data-i18n="buttons.rules">                 📋 Правила игры             </button>         </div>          <!-- Игровой ID (внизу) -->         <!-')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.заявки_на_обмен', '💰 Заявки на обмен', 'button', 'k="showExchangeRequests()" id="exchangeRequestsBtn" style="display: none;">                         💰 Заявки на обмен                     </button>                     <button class="button button-adm')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.управление_пользователями', '👥 Управление пользователями', 'button', 'click="showUserManagement()" id="userManagementBtn" style="display: none;">                         👥 Управление пользователями                     </button>                     <button class="button ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.аналитика', '📊 Аналитика', 'button', '-admin" onclick="showAnalytics()" id="analyticsBtn" style="display: none;">                         📊 Аналитика                     </button>                 </div>             </div>         </div>  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.сбросить_тестовые_данные', '🔄 Сбросить тестовые данные', 'button', 'e;">             <button class="button button-secondary" onclick="resetTestData()">                 🔄 Сбросить тестовые данные             </button>             <button class="button button-success" o')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.добавить_тестовые_stars', '⭐ Добавить тестовые Stars', 'button', 'button>             <button class="button button-success" onclick="addTestMoney()">                 ⭐ Добавить тестовые Stars             </button>         </div>          <!-- Загрузка -->         <d')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.скорость', 'Скорость', 'button', 's-tabs">                     <button class="upgrade-tab active" onclick="switchUpgradeTab('speed')">Скорость</button>                     <button class="upgrade-tab" onclick="switchUpgradeTab('efficie')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.эффективность', 'Эффективность', 'button', 'ь</button>                     <button class="upgrade-tab" onclick="switchUpgradeTab('efficiency')">Эффективность</button>                     <button class="upgrade-tab" onclick="switchUpgradeTab('au')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.автоматизация', 'Автоматизация', 'button', 'ь</button>                     <button class="upgrade-tab" onclick="switchUpgradeTab('automation')">Автоматизация</button>                     <button class="upgrade-tab" onclick="switchUpgradeTab('pr')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.премиум', 'Премиум', 'button', 'ация</button>                     <button class="upgrade-tab" onclick="switchUpgradeTab('premium')">Премиум</button>                 </div>                 <div class="upgrades-content" id="upgradesCo')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.подтвердить', 'Подтвердить', 'button', '<button class="button button-primary" onclick="confirmBuyPro()" data-i18n="buttons.confirm">Подтвердить</button>                 <button class="button button-secondary" onclick="closeModal('buyProModa')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.отмена', 'Отмена', 'button', 'tton class="button button-secondary" onclick="closeModal('buyProModal')" data-i18n="buttons.cancel">Отмена</button>             </div>         </div>     </div>      <!-- Модальное окно покупки NDN --')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.купить', 'Купить', 'button', 'ton class="button button-primary" onclick="buyPro()" data-i18n="buttons.buy_pro">                 💎 Купить Pro статус             </button>             <button class="button button-secondary" onclick=')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.обменять', 'Обменять', 'button', 'ass="button button-success" onclick="exchangeNDN()" data-i18n="buttons.exchange">                 ⭐ Обменять NDN на Stars             </button>             <button class="button button-info" onclick="')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.вывести', 'Вывести', 'button', 'v class="modal-header">                 <div class="modal-title" data-i18n="buttons.withdraw_ndn">💰 Вывести NDN</div>                 <div class="modal-subtitle" data-i18n="withdraw.minimum">Минимальн')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.назад', '← Назад', 'button', 'class="button button-secondary" onclick="closeModal('achievementsModal')" data-i18n="buttons.back">← Назад</button>             </div>         </div>     </div>      <!-- Модальное окно магазинов --> ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.открыть_магазин', '🏪 Открыть магазин', 'button', '<button class="button button-primary" onclick="showOpenShopForm()" data-i18n="shops.open_shop">🏪 Открыть магазин</button>                 <button class="button button-secondary" onclick="closeModal('s')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.добавить_товар', 'Добавить товар', 'button', '<div class="modal-header">                 <div class="modal-title" data-i18n="shops.add_item">📦 Добавить товар</div>                 <div class="modal-subtitle" data-i18n="shops.add_item_description"')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.копировать', '📋 Копировать', 'button', '<button class="button button-primary" onclick="copyReferralLink()" data-i18n="buttons.copy">📋 Копировать</button>                             <button class="button button-secondary" onclick="showLinkM')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.показать_ссылку', '👁️ Показать ссылку', 'button', '<button class="button button-secondary" onclick="showLinkModal()" data-i18n="referrals.show_link">👁️ Показать ссылку</button>                         </div>                     </div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.выбрать_контакт_из', '📱 Выбрать контакт из Telegram', 'button', 'click="inviteToTelegramContact()" data-i18n="referrals.select_contact">                             📱 Выбрать контакт из Telegram                         </button>                         <button clas')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.поделиться_в_telegram', '🌐 Поделиться в Telegram', 'button', 'ary" onclick="shareViaTelegram()" data-i18n="referrals.share_telegram">                             🌐 Поделиться в Telegram                         </button>                         <button class="but')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.скопировать_ссылку', '🔗 Скопировать ссылку', 'button', 'n-secondary" onclick="shareViaOther()" data-i18n="referrals.copy_link">                             🔗 Скопировать ссылку                         </button>                     </div>                 </')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.изменить', 'Изменить', 'button', '<button class="button button-secondary" onclick="changeRecipient()" data-i18n="buttons.change">Изменить</button>                         </div>                     </div>                     <div clas')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.найти_игрока', '🔍 Найти игрока', 'button', 'ecipientBtn" onclick="findRecipient()" data-i18n="buttons.find_player">                             🔍 Найти игрока                         </button>                     </div>                 </div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.перевести', '💸 Перевести', 'button', 'lass="button button-info" onclick="transferNDN()" data-i18n="buttons.transfer_ndn">                 💸 Перевести NDN             </button>         </div>          <!-- Дополнительные функции -->       ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.canunlock_заблокировано_canafford', '${!canUnlock ? ''Заблокировано'' : canAfford ? ''Купить'' : ''Недостаточно Gas''}', 'button', '${!canAfford || !canUnlock ? 'disabled' : ''}>                             ${!canUnlock ? 'Заблокировано' : canAfford ? 'Купить' : 'Недостаточно Gas'}                         </button>                ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.получить_майнер', 'Получить майнер', 'button', 'e; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer;">                         Получить майнер                     </button>                 </div>             `;                 ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.isunlocked_куплено_ismaxlevel', '${isUnlocked ? ''Куплено'' : isMaxLevel ? ''Макс. уровень'' : canAfford ? ''Купить'' : ''Недостаточно Gas''}', 'button', '${!canAfford || isUnlocked || isMaxLevel ? 'disabled' : ''}>                             ${isUnlocked ? 'Куплено' : isMaxLevel ? 'Макс. уровень' : canAfford ? 'Купить' : 'Недостаточно Gas'}           ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.isactive_активен_canafford', '${isActive ? ''Активен'' : canAfford ? ''Активировать'' : ''Недостаточно Gas''}', 'button', '"` : ''}                                 ${isActive ? 'disabled' : ''}>                             ${isActive ? 'Активен' : canAfford ? 'Активировать' : 'Недостаточно Gas'}                         </')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.iscompleted_выполнено_cancomplete', '${isCompleted ? ''Выполнено'' : canComplete ? ''Получить награду'' : ''В процессе''}', 'button', '''}                                 ${!canComplete ? 'disabled' : ''}>                             ${isCompleted ? 'Выполнено' : canComplete ? 'Получить награду' : 'В процессе'}                       ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.одобрить', '✅ Одобрить', 'button', 'ccess" onclick="approveExchangeRequest(${req.id})">                                                 ✅ Одобрить                                             </button>                                    ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.отклонить', '❌ Отклонить', 'button', 'danger" onclick="rejectExchangeRequest(${req.id})">                                                 ❌ Отклонить                                             </button>                                   ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.получить_награду', 'Получить награду', 'button', 'mplete ? 'disabled' : ''}>                             ${isCompleted ? 'Выполнено' : canComplete ? 'Получить награду' : 'В процессе'}                         </button>                     </div>      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.просмотреть_товары', '👀 Просмотреть товары', 'button', '"button button-secondary" onclick="viewShopItems(${shop.shop_id})">                                 👀 Просмотреть товары                             </button>                         </div>           ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.копировать_автоматически', '📋 Копировать автоматически', 'button', 'uttons">                         <button class="button button-primary" onclick="copyReferralLink()">📋 Копировать автоматически</button>                         <button class="button button-secondary" ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.закрыть', 'Закрыть', 'button', 'ElementById(modalId).style.display = 'block';             playSound('click');         }          // Закрыть модальное окно         // Показать модальное окно         function showModal(modalId) {')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('buttons.выбрать', 'Выбрать', 'button', 'ick="inviteToTelegramContact()" data-i18n="referrals.select_contact">                             📱 Выбрать контакт из Telegram                         </button>                         <button class=')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.серверный_кошелек', '💰 Серверный кошелек', 'heading', '<div id="walletStats" class="wallet-stats" style="display: none;">                     <h4>💰 Серверный кошелек</h4>                     <div class="stats-grid">                         <div class="sta')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.статистика_системы', '📊 Статистика системы', 'heading', '<div id="systemStats" class="system-stats" style="display: none;">                     <h4>📊 Статистика системы</h4>                     <div class="stats-grid">                         <div class="st')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.ежедневные_награды', '🎁 Ежедневные награды', 'heading', 'награды -->             <div class="game-card">                 <h3 data-i18n="game.daily_rewards">🎁 Ежедневные награды</h3>                 <p data-i18n="game.daily_rewards_desc">Заходите каждый день')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.достижения', '🏆 Достижения', 'heading', 'tton button-primary" onclick="showAchievements()" data-i18n="buttons.achievements">                 🏆 Достижения             </button>             <button class="button button-secondary" onclick="show')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.уровень_игрока', '⭐ Уровень игрока', 'heading', 'нь игрока -->             <div class="game-card">                 <h3 data-i18n="game.player_level">⭐ Уровень игрока</h3>                 <div class="level-progress">                     <div class="l')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.статистика', '📊 Статистика', 'heading', '<div id="systemStats" class="system-stats" style="display: none;">                     <h4>📊 Статистика системы</h4>                     <div class="stats-grid">                         <div class="st')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.фермы_майнинга', '🏭 Фермы майнинга', 'heading', 'div>              <!-- Фермы майнинга -->             <div class="miner-farms">                 <h3>🏭 Фермы майнинга</h3>                 <div class="farms-grid" id="farmsGrid">                     <!')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.улучшения', '🔧 Улучшения', 'heading', '</div>              <!-- Улучшения -->             <div class="miner-upgrades">                 <h3>🔧 Улучшения</h3>                 <div class="upgrades-tabs">                     <button class="upgr')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.бусты', '💎 Бусты', 'heading', '<!-- Бусты -->             <div class="miner-boosts" style="display: none;">                 <h3>💎 Бусты</h3>                 <div class="boosts-grid" id="boostsGrid">                     <!-- Будет з')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.особые_майнеры', '🌟 Особые майнеры', 'heading', 'обые майнеры -->             <div class="miner-special" style="display: none;">                 <h3>🌟 Особые майнеры</h3>                 <div class="special-miners-grid" id="specialMinersGrid">      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.квесты', '📋 Квесты', 'heading', '<!-- Квесты -->             <div class="miner-quests" style="display: none;">                 <h3>📋 Квесты</h3>                 <div class="quests-list" id="questsList">                     <!-- Будет')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.магазин', '🛒 Магазин', 'heading', '- Магазин -->             <div class="miner-shop">                 <h3 data-i18n="miner.shop.title">🛒 Магазин</h3>                 <div class="shop-items" id="shopItems">                     <!-- Буде')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.рейтинг_майнеров', '🏆 Рейтинг майнеров', 'heading', '<div class="miner-leaderboard">                 <h3 data-i18n="miner.leaderboard.title">🏆 Рейтинг майнеров</h3>                 <div class="leaderboard-table" id="leaderboardTable">                   ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.ваша_реферальная_ссылка', '🔗 Ваша реферальная ссылка:', 'heading', '<div class="referral-link-section">                         <h3 data-i18n="referrals.your_link">🔗 Ваша реферальная ссылка:</h3>                         <div class="link-container">                    ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.способы_приглашения', '📱 Способы приглашения:', 'heading', '<div class="invite-methods">                     <h3 data-i18n="referrals.invite_methods">📱 Способы приглашения:</h3>                     <div class="method-buttons">                         <button c')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.как_зарабатывать', '💰 Как зарабатывать:', 'heading', '<div class="referral-info">                     <h3 data-i18n="referrals.how_to_earn">💰 Как зарабатывать:</h3>                     <div class="info-grid">                         <div class="info-item')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.получатель', '👤 Получатель:', 'heading', '<div class="recipient-section">                     <h3 data-i18n="transfer.recipient">👤 Получатель:</h3>                     <div class="recipient-info" id="recipientInfo" style="display: none;">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.сумма_перевода', '💰 Сумма перевода:', 'heading', '<div class="amount-section">                     <h3 data-i18n="transfer.amount">💰 Сумма перевода:</h3>                     <div class="amount-input-container">                         <input type="')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.сводка_перевода', '📋 Сводка перевода:', 'heading', '<div class="transfer-summary" id="transferSummary" style="display: none;">                     <h3>📋 Сводка перевода:</h3>                     <div class="summary-item">                         <span>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.реклама', '📺 Реклама', 'heading', 'padding: 20px; border-radius: 10px; text-align: center; max-width: 400px;">                     <h3>📺 Реклама</h3>                     <p>Смотрите рекламу для получения ${miner.name}</p>              ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.статистика_по_уровням', '📊 Статистика по уровням:', 'heading', '<div class="referral-levels">                         <h3 data-i18n="referrals.level_stats">📊 Статистика по уровням:</h3>                         ${data.referralStats && data.referralStats.length > 0 ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.список_рефералов_по', '👥 Список рефералов по уровням:', 'heading', '<div class="referrals-content">                         <h3 data-i18n="referrals.referrals_list">👥 Список рефералов по уровням:</h3>                         ${Object.keys(referralsByLevel).length > 0 ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.level_уровень_referralsbylevellevellength', '📊 ${level} уровень (${referralsByLevel[level].length} рефералов):', 'heading', 'n="referrals.level_with_count" data-level="${level}" data-count="${referralsByLevel[level].length}">📊 ${level} уровень (${referralsByLevel[level].length} рефералов):</h4>                              ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.ruleshow_to_playtitle', '${rules.how_to_play.title}', 'heading', '<div class="rule-section">                                 <h3 class="section-title">${rules.how_to_play.title}</h3>                                 <div class="section-content">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.rulesrewardstitle', '${rules.rewards.title}', 'heading', '<div class="rule-section">                                 <h3 class="section-title">${rules.rewards.title}</h3>                                 <div class="section-content">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.rulesfeaturestitle', '${rules.features.title}', 'heading', '<div class="rule-section">                                 <h3 class="section-title">${rules.features.title}</h3>                                 <div class="section-content">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.rulestipstitle', '${rules.tips.title}', 'heading', '<div class="rule-section">                                 <h3 class="section-title">${rules.tips.title}</h3>                                 <div class="section-content">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('headings.categorynamescategory_category', '${categoryNames[category] || category}', 'heading', 'html += `                     <div class="achievement-category">                         <h3>${categoryNames[category] || category}</h3>                         <div class="achievement-list">         ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.крипто_игра_с', 'Крипто игра с монетами NDN', 'title', 'i18n="app.name">🚀 NodeOn Crypto</div>             <div class="subtitle" data-i18n="app.description">Крипто игра с монетами NDN</div>             <div class="language-selector">                 <select')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.админ_панель', '🛡️ Админ панель', 'title', 'lay: none;">             <div class="admin-panel-section">                 <div class="admin-title">🛡️ Админ панель</div>                 <div class="admin-status" id="adminStatus">Загрузка...</div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.купить_pro_статус', '💎 Купить Pro статус', 'title', 'utton class="button button-primary" onclick="buyPro()" data-i18n="buttons.buy_pro">                 💎 Купить Pro статус             </button>             <button class="button button-secondary" onclic')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.стоимость_1000_ndn', 'Стоимость: 1000 NDN', 'title', 'buy_pro">💎 Купить Pro статус</div>                 <div class="modal-subtitle" data-i18n="pro.cost">Стоимость: 1000 NDN</div>             </div>             <div class="form-group">                 <l')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.купить_ndn_за', '⭐ Купить NDN за Telegram Stars', 'title', 'ton class="button button-secondary" onclick="buyNDN()" data-i18n="buttons.buy_ndn">                 ⭐ Купить NDN за Telegram Stars             </button>             <button class="button button-succes')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.курс_1_ndn', 'Курс: 1 NDN = 1 Telegram Star', 'title', 'ть NDN за Telegram Stars</div>                 <div class="modal-subtitle" data-i18n="payment.rate">Курс: 1 NDN = 1 Telegram Star</div>                 <div class="modal-subtitle" style="font-size: 0.')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.stars_поступают_на', '💡 Stars поступают на баланс бота и могут быть выведены в TON', 'title', 'nt-size: 0.8rem; color: #666; margin-top: 5px;" data-i18n="payment.stars_info">                     💡 Stars поступают на баланс бота и могут быть выведены в TON                 </div>             </di')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.обменять_ndn_на', '⭐ Обменять NDN на Telegram Stars', 'title', '<div class="modal-header">                 <div class="modal-title" data-i18n="buttons.exchange">⭐ Обменять NDN на Telegram Stars</div>                 <div class="modal-subtitle" data-i18n="payment.r')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.ndn_списываются_с', '💡 NDN списываются с вашего счета, Stars поступают в Telegram', 'title', 't-size: 0.8rem; color: #666; margin-top: 5px;" data-i18n="exchange.stars_info">                     💡 NDN списываются с вашего счета, Stars поступают в Telegram                 </div>             </di')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.вывести_ndn', '💰 Вывести NDN', 'title', 'div class="modal-header">                 <div class="modal-title" data-i18n="buttons.withdraw_ndn">💰 Вывести NDN</div>                 <div class="modal-subtitle" data-i18n="withdraw.minimum">Минимал')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.минимальная_сумма_100', 'Минимальная сумма: 100 NDN', 'title', 'w_ndn">💰 Вывести NDN</div>                 <div class="modal-subtitle" data-i18n="withdraw.minimum">Минимальная сумма: 100 NDN</div>             </div>             <div class="form-group">            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.достижения', '🏆 Достижения', 'title', 'tton button-primary" onclick="showAchievements()" data-i18n="buttons.achievements">                 🏆 Достижения             </button>             <button class="button button-secondary" onclick="show')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.выполняйте_задачи_и', 'Выполняйте задачи и получайте награды!', 'title', 'ta-i18n="game.achievements">🏆 Достижения</h3>                 <p data-i18n="game.achievements_desc">Выполняйте задачи и получайте награды!</p>                 <div id="achievementsList">              ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.магазины', '🏪 Магазины', 'title', 'on class="button button-secondary" onclick="showShops()" data-i18n="buttons.shops">                 🏪 Магазины             </button>             <button class="button button-success" onclick="showRefe')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.откройте_свой_магазин', 'Откройте свой магазин за 10,000 NDN!', 'title', 's.shops">🏪 Магазины</div>                 <div class="modal-subtitle" data-i18n="shops.description">Откройте свой магазин за 10,000 NDN!</div>             </div>             <div class="modal-body" id')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.открыть_магазин', '🏪 Открыть магазин', 'title', '<button class="button button-primary" onclick="showOpenShopForm()" data-i18n="shops.open_shop">🏪 Открыть магазин</button>                 <button class="button button-secondary" onclick="closeModal('s')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.стоимость_10000_ndn', 'Стоимость: 10,000 NDN', 'title', 'en_shop">🏪 Открыть магазин</div>                 <div class="modal-subtitle" data-i18n="shops.cost">Стоимость: 10,000 NDN</div>             </div>             <div class="form-group">                 ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.добавить_товар', '📦 Добавить товар', 'title', '<div class="modal-header">                 <div class="modal-title" data-i18n="shops.add_item">📦 Добавить товар</div>                 <div class="modal-subtitle" data-i18n="shops.add_item_description"')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.добавьте_товар_в', 'Добавьте товар в ваш магазин', 'title', 'вить товар</div>                 <div class="modal-subtitle" data-i18n="shops.add_item_description">Добавьте товар в ваш магазин</div>             </div>             <div class="form-group">          ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.пригласить_друзей', '📤 Пригласить друзей', 'title', 'utton button-success" onclick="inviteFriends()" data-i18n="buttons.invite_friends">                 📤 Пригласить друзей             </button>         </div>          <!-- Дополнительные функции 2 --> ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.поделитесь_ссылкой_и', 'Поделитесь ссылкой и зарабатывайте с каждого реферала!', 'title', 'ь друзей</div>                 <div class="modal-subtitle" data-i18n="referrals.invite_description">Поделитесь ссылкой и зарабатывайте с каждого реферала!</div>             </div>             <div cla')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.перевести_ndn', '💸 Перевести NDN', 'title', 'lass="button button-info" onclick="transferNDN()" data-i18n="buttons.transfer_ndn">                 💸 Перевести NDN             </button>         </div>          <!-- Дополнительные функции -->       ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.выберите_получателя_и', 'Выберите получателя и введите сумму', 'title', '💸 Перевести NDN</div>                 <div class="modal-subtitle" data-i18n="transfer.instructions">Выберите получателя и введите сумму</div>             </div>             <div class="transfer-conten')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.achievementtitle', '${achievement.title}', 'title', '<div class="achievement-info">                                     <div class="achievement-title">${achievement.title}</div>                                     <div class="achievement-description">${')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.eventname', '${event.name}', 'title', '/div>                     <div class="funny-text">                         <div class="funny-title">${event.name}</div>                         <div class="funny-description">${event.description}</div')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.достижение', '🏆 ДОСТИЖЕНИЕ!', 'title', '<div class="achievement-text">                         <div class="achievement-title">🏆 ДОСТИЖЕНИЕ!</div>                         <div class="achievement-name">${achievement.name}</div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.заявки_на_обмен', '💰 Заявки на обмен NDN', 'title', 't">                     <div class="modal-header">                         <div class="modal-title">💰 Заявки на обмен NDN</div>                         <div class="modal-subtitle">Управление заявками ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.управление_заявками_на', 'Управление заявками на обмен NDN на Telegram Stars', 'title', 'class="modal-title">💰 Заявки на обмен NDN</div>                         <div class="modal-subtitle">Управление заявками на обмен NDN на Telegram Stars</div>                     </div>                 ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.мои_рефералы', '👥 Мои рефералы', 'title', 'ss="button button-success" onclick="showReferrals()" data-i18n="buttons.referrals">                 👥 Мои рефералы             </button>         </div>          <!-- PRO функции (только для PRO пользо')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.награды_начисляются_только', 'Награды начисляются только когда рефералы покупают PRO статус', 'title', 'ефералы</div>                         <div class="modal-subtitle" data-i18n="referrals.description">Награды начисляются только когда рефералы покупают PRO статус</div>                     </div>      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.таблица_лидеров', '🏆 Таблица лидеров', 'title', 'button button-primary" onclick="showLeaderboard()" data-i18n="buttons.leaderboard">                 🏆 Таблица лидеров             </button>             <button class="button button-secondary" onclick=')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.топ_игроков_по', 'Топ игроков по балансу NDN', 'title', 'div class="modal-title">🏆 Таблица лидеров</div>                         <div class="modal-subtitle">Топ игроков по балансу NDN</div>                     </div>                     <div class="leaderbo')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.rulestitle', '${rules.title}', 'title', 'l">                     <div class="modal-header">                         <div class="modal-title">${rules.title}</div>                         <div class="modal-subtitle">${rules.description}</div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.rulesdescription', '${rules.description}', 'title', '<div class="modal-title">${rules.title}</div>                         <div class="modal-subtitle">${rules.description}</div>                     </div>                     <div class="modal-body">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.у_вас_нет', 'У вас нет магазинов', 'title', '<div class="no-data-icon">🏪</div>                         <div class="no-data-title">У вас нет магазинов</div>                         <div class="no-data-subtitle">Откройте свой первый магазин за 10,')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.откройте_свой_первый', 'Откройте свой первый магазин за 10,000 NDN!', 'title', 'ass="no-data-title">У вас нет магазинов</div>                         <div class="no-data-subtitle">Откройте свой первый магазин за 10,000 NDN!</div>                     </div>                 `;     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.ваша_реферальная_ссылка', '🔗 Ваша реферальная ссылка', 'title', '<div class="referral-link-section">                         <h3 data-i18n="referrals.your_link">🔗 Ваша реферальная ссылка:</h3>                         <div class="link-container">                    ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.выделите_и_скопируйте', 'Выделите и скопируйте ссылку вручную', 'title', 's="modal-title">🔗 Ваша реферальная ссылка</div>                         <div class="modal-subtitle">Выделите и скопируйте ссылку вручную</div>                     </div>                     <div class')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.выберите_контакт', '📱 Выберите контакт', 'title', 't">                     <div class="modal-header">                         <div class="modal-title">📱 Выберите контакт</div>                         <div class="modal-subtitle">Введите @username или н')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('titles.введите_username_или', 'Введите @username или номер телефона', 'title', 'iv class="modal-title">📱 Выберите контакт</div>                         <div class="modal-subtitle">Введите @username или номер телефона</div>                     </div>                     <div class')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.100', '100', 'span', 'a, Geneva, Verdana, sans-serif;             background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);             min-height: 100vh;             overflow-x: hidden;             position: relative')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.синхронизировать', 'Синхронизировать', 'span', 'c-button" onclick="forceSyncMinerData()">                     🔄 <span data-i18n="miner.sync.button">Синхронизировать</span>                 </button>             </div>              <!-- Кнопка пополн')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.пополнить_энергию', 'Пополнить энергию', 'span', 'utton" onclick="refillEnergy()">                     ⚡ <span data-i18n="miner.energy.refill_button">Пополнить энергию</span>                 </button>                 <div class="energy-refill-info" i')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.следующее_пополнение_через', 'Следующее пополнение через:', 'span', '-refill-info" id="energyRefillInfo">                     <span data-i18n="miner.energy.next_refill">Следующее пополнение через:</span> <span id="nextRefillTime">3:00:00</span>                 </div>  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.30000', '3:00:00', 'span', 'n data-i18n="miner.energy.next_refill">Следующее пополнение через:</span> <span id="nextRefillTime">3:00:00</span>                 </div>             </div>              <!-- Фермы майнинга -->       ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ваш_баланс', 'Ваш баланс:', 'span', '<div class="balance-info">                             <span data-i18n="transfer.balance">Ваш баланс:</span> <span id="transferBalance">0</span> NDN                         </div>                     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.получатель', 'Получатель:', 'span', '<div class="recipient-section">                     <h3 data-i18n="transfer.recipient">👤 Получатель:</h3>                     <div class="recipient-info" id="recipientInfo" style="display: none;">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.сумма', 'Сумма:', 'span', '</div>                     <div class="summary-item">                         <span>Сумма:</span>                         <span id="summaryAmount"></span> NDN                     </div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.комиссия', 'Комиссия:', 'span', '</div>                     <div class="summary-item">                         <span>Комиссия:</span>                         <span id="summaryFee">0</span> NDN                     </div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.итого_к_списанию', 'Итого к списанию:', 'span', '</div>                     <div class="summary-item total">                         <span>Итого к списанию:</span>                         <span id="summaryTotal"></span> NDN                     </div')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gasмин', 'Gas/мин', 'span', 'info">                         <div class="miner-stat-label" data-i18n="miner.stats.gas_per_minute">Gas/мин</div>                         <div class="miner-stat-value" id="gasPerSecond">0</div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.энергия', 'Энергия', 'span', 'er-stat-info">                         <div class="miner-stat-label" data-i18n="miner.stats.energy">Энергия</div>                         <div class="miner-stat-value" id="energyLevel">100/100</div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.количество', 'Количество', 'span', '<div class="form-group">                 <label class="form-label" data-i18n="transfer.amount">Количество NDN:</label>                 <input type="number" class="form-input" id="ndnAmount" data-i18n-')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.стоимость', 'Стоимость', 'span', 'buy_pro">💎 Купить Pro статус</div>                 <div class="modal-subtitle" data-i18n="pro.cost">Стоимость: 1000 NDN</div>             </div>             <div class="form-group">                 <l')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.синхронизация', 'Синхронизация...', 'span', 'ton.disabled = true;                 syncButton.innerHTML = '⏳ <span data-i18n="miner.sync.waiting">Синхронизация...</span>';                 console.log('🔒 Кнопка заблокирована');             } else ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ожидание', 'Ожидание...', 'span', 'utton.disabled = true;                 button.innerHTML = '⏰ <span data-i18n="miner.energy.waiting">Ожидание...</span>';                 info.style.display = 'block';                                  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.stattotal_referrals_рефералов', '${stat.total_referrals} рефералов', 'span', 'span class="level-count" data-i18n="referrals.referrals_count" data-count="${stat.total_referrals}">${stat.total_referrals} рефералов</span>                                                 <span class')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.stattotal_earningstofixed2_ndn', '+${stat.total_earnings.toFixed(2)} NDN', 'span', 'ass="level-reward" data-i18n="referrals.earnings" data-earnings="${stat.total_earnings.toFixed(2)}">+${stat.total_earnings.toFixed(2)} NDN</span>                                             </div>    ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.achievementprogressachievementrequirement_value', '${achievement.progress}/${achievement.requirement_value}', 'span', '</div>                                             <span class="progress-text">${achievement.progress}/${achievement.requirement_value}</span>                                         </div>           ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.achievementreward_ndn_ndn', '💰 ${achievement.reward_ndn} NDN', 'span', 'lass="achievement-reward">                                                 <span class="reward-ndn">💰 ${achievement.reward_ndn} NDN</span>                                                 <span class="')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.achievementreward_stars_stars', '⭐ ${achievement.reward_stars} Stars', 'span', 't.reward_ndn} NDN</span>                                                 <span class="reward-stars">⭐ ${achievement.reward_stars} Stars</span>                                                 ${!achiev')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.получено', '✅ Получено', 'span', '</button>                                                 ` : '<span class="claimed">✅ Получено</span>'}                                             </div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.товаров', 'Товаров:', 'span', '<div class="shop-stat">                                 <span class="stat-label">Товаров:</span>                                 <span class="stat-value">${shop.items_count}</span>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopitems_count', '${shop.items_count}', 'span', '<span class="stat-label">Товаров:</span>                                 <span class="stat-value">${shop.items_count}</span>                             </div>                             <div class="')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.продаж', 'Продаж:', 'span', '<div class="shop-stat">                                 <span class="stat-label">Продаж:</span>                                 <span class="stat-value">${shop.total_sales}</span>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shoptotal_sales', '${shop.total_sales}', 'span', '<span class="stat-label">Продаж:</span>                                 <span class="stat-value">${shop.total_sales}</span>                             </div>                             <div class="s')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.категория', 'Категория:', 'span', '<div class="form-group">                 <label class="form-label" data-i18n="shops.category">Категория:</label>                 <select class="form-input" id="shopCategory">                     <opti')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopcategory', '${shop.category}', 'span', '<span class="stat-label">Категория:</span>                                 <span class="stat-value">${shop.category}</span>                             </div>                         </div>           ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('labels.ваш_баланс_ndn', 'Ваш баланс NDN:', 'label', '<div class="form-group">                 <label class="form-label" data-i18n="user.balance_ndn">Ваш баланс NDN:</label>                 <div class="balance-value" id="modalNdnBalance">0.00</div>      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('labels.количество_ndn', 'Количество NDN:', 'label', '<div class="form-group">                 <label class="form-label" data-i18n="transfer.amount">Количество NDN:</label>                 <input type="number" class="form-input" id="ndnAmount" data-i18n-')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('labels.стоимость_в_stars', 'Стоимость в Stars:', 'label', '<div class="form-group">                 <label class="form-label" data-i18n="payment.stars_cost">Стоимость в Stars:</label>                 <div class="balance-value" id="starsCost">0</div>          ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('labels.количество_ndn_для', 'Количество NDN для обмена:', 'label', '<div class="form-group">                 <label class="form-label" data-i18n="transfer.amount">Количество NDN для обмена:</label>                 <input type="number" class="form-input" id="exchangeAm')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('labels.ваш_telegram_username', 'Ваш Telegram username:', 'label', '<div class="form-group">                 <label class="form-label" data-i18n="exchange.username">Ваш Telegram username:</label>                 <input type="text" class="form-input" id="exchangeUserna')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('labels.получите_stars', 'Получите Stars:', 'label', 'iv class="form-group">                 <label class="form-label" data-i18n="exchange.receive_stars">Получите Stars:</label>                 <div class="balance-value" id="exchangeStars">0</div>       ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('labels.telegram_id_получателя', 'Telegram ID получателя:', 'label', 'div class="form-group">                 <label class="form-label" data-i18n="withdraw.recipient_id">Telegram ID получателя:</label>                 <input type="text" class="form-input" id="recipientI')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('labels.название_магазина', 'Название магазина:', 'label', '<div class="form-group">                 <label class="form-label" data-i18n="shops.shop_name">Название магазина:</label>                 <input type="text" class="form-input" id="shopName" data-i18n-')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('labels.описание', 'Описание:', 'label', 'iv class="form-group">                 <label class="form-label" data-i18n="shops.shop_description">Описание:</label>                 <textarea class="form-input" id="shopDescription" data-i18n-placeh')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('labels.категория', 'Категория:', 'label', '<div class="form-group">                 <label class="form-label" data-i18n="shops.category">Категория:</label>                 <select class="form-input" id="shopCategory">                     <opti')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('labels.название_товара', 'Название товара:', 'label', '<div class="form-group">                 <label class="form-label" data-i18n="shops.item_name">Название товара:</label>                 <input type="text" class="form-input" id="itemName" data-i18n-pl')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('labels.цена_в_ndn', 'Цена в NDN:', 'label', '<div class="form-group">                 <label class="form-label" data-i18n="shops.price_ndn">Цена в NDN:</label>                 <input type="number" class="form-input" id="itemPriceNDN" placeholder')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('labels.цена_в_stars', 'Цена в Stars:', 'label', '<div class="form-group">                 <label class="form-label" data-i18n="shops.price_stars">Цена в Stars:</label>                 <input type="number" class="form-input" id="itemPriceStars" place')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('labels.тип_товара', 'Тип товара:', 'label', '<div class="form-group">                 <label class="form-label" data-i18n="shops.item_type">Тип товара:</label>                 <select class="form-input" id="itemType">                     <option')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('labels.ссылка_на_изображение', 'Ссылка на изображение:', 'label', '<div class="form-group">                 <label class="form-label" data-i18n="shops.image_url">Ссылка на изображение:</label>                 <input type="url" class="form-input" id="itemImageUrl" pla')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('labels.количество_на_складе', 'Количество на складе (-1 = безлимит):', 'label', '<div class="form-group">                 <label class="form-label" data-i18n="shops.stock">Количество на складе (-1 = безлимит):</label>                 <input type="number" class="form-input" id="ite')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('placeholders.transferamount', 'transfer.amount', 'placeholder', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="transfer.amount">Количество NDN:</label>                 <input type="number" class="form-input" id="nd')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('placeholders.введите_количество', 'Введите количество', 'placeholder', 'ype="number" class="form-input" id="ndnAmount" data-i18n-placeholder="transfer.amount" placeholder="Введите количество" min="1">             </div>             <div class="form-group">                ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('placeholders.username', '@username', 'placeholder', 'e:</label>                 <input type="text" class="form-input" id="exchangeUsername" placeholder="@username" value="@NobodyYety">             </div>             <div class="form-group">             ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('placeholders.withdrawrecipient_placeholder', 'withdraw.recipient_placeholder', 'placeholder', 'abel>                 <input type="text" class="form-input" id="recipientId" data-i18n-placeholder="withdraw.recipient_placeholder" placeholder="@username или ID">             </div>             <div ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('placeholders.username_или_id', '@username или ID', 'placeholder', 's="form-input" id="recipientId" data-i18n-placeholder="withdraw.recipient_placeholder" placeholder="@username или ID">             </div>             <div class="modal-buttons">                 <butto')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('placeholders.shopsshop_name', 'shops.shop_name', 'placeholder', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.shop_name">Название магазина:</label>                 <input type="text" class="form-input" id="s')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('placeholders.введите_название_магазина', 'Введите название магазина', 'placeholder', 't type="text" class="form-input" id="shopName" data-i18n-placeholder="shops.shop_name" placeholder="Введите название магазина">             </div>             <div class="form-group">                 ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('placeholders.shopsshop_description', 'shops.shop_description', 'placeholder', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.shop_description">Описание:</label>                 <textarea class="form-input" id="shopDescript')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('placeholders.опишите_ваш_магазин', 'Опишите ваш магазин', 'placeholder', 'class="form-input" id="shopDescription" data-i18n-placeholder="shops.shop_description" placeholder="Опишите ваш магазин" rows="3"></textarea>             </div>             <div class="form-group">   ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('placeholders.shopsitem_name', 'shops.item_name', 'placeholder', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.item_name">Название товара:</label>                 <input type="text" class="form-input" id="ite')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('placeholders.введите_название_товара', 'Введите название товара', 'placeholder', 't type="text" class="form-input" id="itemName" data-i18n-placeholder="shops.item_name" placeholder="Введите название товара">             </div>             <div class="form-group">                 <l')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('placeholders.shopsitem_description', 'shops.item_description', 'placeholder', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.item_description">Описание:</label>                 <textarea class="form-input" id="itemDescript')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('placeholders.опишите_товар', 'Опишите товар', 'placeholder', 'class="form-input" id="itemDescription" data-i18n-placeholder="shops.item_description" placeholder="Опишите товар" rows="3"></textarea>             </div>             <div class="form-group">         ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('placeholders.transferrecipient', 'transfer.recipient', 'placeholder', 'ansfer-content">                 <div class="recipient-section">                     <h3 data-i18n="transfer.recipient">👤 Получатель:</h3>                     <div class="recipient-info" id="recipient')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('placeholders.введите_игровой_id', 'Введите игровой ID получателя', 'placeholder', 't" class="form-input" id="recipientIdInput" data-i18n-placeholder="transfer.recipient" placeholder="Введите игровой ID получателя">                         <button class="button button-primary" id="fi')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('placeholders.введите_сумму_ndn', 'Введите сумму NDN', 'placeholder', 'number" class="form-input" id="transferAmount" data-i18n-placeholder="transfer.amount" placeholder="Введите сумму NDN" min="0.01" step="0.01">                         <div class="balance-info">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('placeholders.username_или_7xxxxxxxxxx', '@username или +7XXXXXXXXXX', 'placeholder', 'body">                         <input type="text" class="form-input" id="contactInput" placeholder="@username или +7XXXXXXXXXX">                     </div>                     <div class="modal-button')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.isclaimed_получено_isavailable', '${isClaimed ? ''Получено'' : isAvailable ? ''Доступно'' : isLocked ? ''Заблокировано'' : ''''}', 'title_attr', 'onclick="${isAvailable ? `claimDailyReward(${reward.day})` : ''}"                          title="${isClaimed ? 'Получено' : isAvailable ? 'Доступно' : isLocked ? 'Заблокировано' : ''}">              ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.leaderfirst_name', '${leader.first_name}', 'alt', '<div class="leader-avatar">                                         <img src="${profilePhoto}" alt="${leader.first_name}"                                               onerror="this.src='data:image/sv')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.utf8', 'UTF-8', 'js_string', '<!DOCTYPE html> <html lang="ru"> <head>     <meta charset="UTF-8">     <meta name="viewport" content="width=device-width, initial-scale=1.0">     <title>NodeOn Cryp')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.viewport', 'viewport', 'js_string', '<!DOCTYPE html> <html lang="ru"> <head>     <meta charset="UTF-8">     <meta name="viewport" content="width=device-width, initial-scale=1.0">     <title>NodeOn Crypto - Крипто Игра</title>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.segoe_ui', 'Segoe UI', 'js_string', 'padding: 0;             box-sizing: border-box;         }          body {             font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;             background: linear-gradient(135deg, #667')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.courier_new', 'Courier New', 'js_string', 'x;             border-radius: 8px;             border: 2px solid #4CAF50;             font-family: 'Courier New', monospace;             font-size: 14px;             word-break: break-all;            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.backgroundanimation', 'background-animation', 'js_string', 'flow-x: hidden;             position: relative;         }          /* Анимированный фон */         .background-animation {             position: fixed;             top: 0;             left: 0;        ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.particles', 'particles', 'js_string', '100% { background-position: 0% 50%; }         }          /* Плавающие частицы */         .particles {             position: fixed;             top: 0;             left: 0;             width: 100%;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.notificationcontainer', 'notificationContainer', 'js_string', '<div class="particles" id="particles"></div>      <!-- Контейнер для уведомлений -->     <div id="notificationContainer"></div>      <div class="container">         <!-- Заголовок -->         <div cla')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.container', 'container', 'js_string', 'nsform: translateY(-20px) rotate(180deg); opacity: 1; }         }          /* Контейнер */         .container {             max-width: 400px;             margin: 0 auto;             padding: 20px;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.header', 'header', 'js_string', 'тема вкладок */         .tabs-container {             margin-bottom: 20px;         }          .tabs-header {             display: flex;             background: rgba(255, 255, 255, 0.1);             bo')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.logo', 'logo', 'js_string', '(-50px); opacity: 0; }             to { transform: translateY(0); opacity: 1; }         }          .logo {             font-size: 2.5rem;             font-weight: bold;             color: #fff;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.appname', 'app.name', 'js_string', '">         <!-- Заголовок -->         <div class="header">             <div class="logo" data-i18n="app.name">🚀 NodeOn Crypto</div>             <div class="subtitle" data-i18n="app.description">Крипто')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.subtitle', 'subtitle', 'js_string', 'o { text-shadow: 2px 2px 4px rgba(0,0,0,0.3), 0 0 20px rgba(255,255,255,0.6); }         }          .subtitle {             color: rgba(255, 255, 255, 0.9);             font-size: 1.1rem;             m')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.appdescription', 'app.description', 'js_string', 'lass="logo" data-i18n="app.name">🚀 NodeOn Crypto</div>             <div class="subtitle" data-i18n="app.description">Крипто игра с монетами NDN</div>             <div class="language-selector">       ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.languageselector', 'language-selector', 'js_string', '255, 255, 0.9);             font-size: 1.1rem;             margin-bottom: 20px;         }          .language-selector {             margin-top: 15px;         }          .language-selector select {    ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.languageselect', 'languageSelect', 'js_string', 'о игра с монетами NDN</div>             <div class="language-selector">                 <select id="languageSelect" onchange="changeLanguage(this.value)">                     <option value="ru">🇷🇺 Рус')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.tabscontainer', 'tabs-container', 'js_string', 'position: relative;             z-index: 1;         }          /* Система вкладок */         .tabs-container {             margin-bottom: 20px;         }          .tabs-header {             display: f')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.tabsheader', 'tabs-header', 'js_string', '* Система вкладок */         .tabs-container {             margin-bottom: 20px;         }          .tabs-header {             display: flex;             background: rgba(255, 255, 255, 0.1);          ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.tabbutton_active', 'tab-button active', 'js_string', '<div class="tabs-container">             <div class="tabs-header">                 <button class="tab-button active" onclick="switchTab('core')" data-i18n="tabs.core">                     🏠 Основное')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.core', 'core', 'js_string', '<div class="tabs-header">                 <button class="tab-button active" onclick="switchTab('core')" data-i18n="tabs.core">                     🏠 Основное                 </button>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.tabscore', 'tabs.core', 'js_string', 's-header">                 <button class="tab-button active" onclick="switchTab('core')" data-i18n="tabs.core">                     🏠 Основное                 </button>                 <button class="')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.tabbutton', 'tab-button', 'js_string', '4px;             margin-bottom: 20px;             backdrop-filter: blur(10px);         }          .tab-button {             flex: 1;             padding: 12px 16px;             background: transparent')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.game', 'game', 'js_string', 'to { opacity: 1; transform: translateY(0); }         }          /* Игровые элементы */         .game-card {             background: linear-gradient(135deg, rgba(255, 255, 255, 0.1), rgba(255, 255, 255')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.tabsgame', 'tabs.game', 'js_string', '</button>                 <button class="tab-button" onclick="switchTab('game')" data-i18n="tabs.game">                     🎮 Игра                 </button>                 <button class="tab-button" ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.miner', 'miner', 'js_string', 'box-shadow: 0 4px 15px rgba(255, 215, 0, 0.4);         }          /* NDN Miner стили */         .miner-stats {             display: grid;             grid-template-columns: repeat(4, 1fr);            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.tabsminer', 'tabs.miner', 'js_string', '</button>                 <button class="tab-button" onclick="switchTab('miner')" data-i18n="tabs.miner">                     ⛏️ NDN Miner                 </button>             </div>         </div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.tabcontent_active', 'tab-content active', 'js_string', 'on>             </div>         </div>          <!-- Вкладка Core (Основное) -->         <div class="tab-content active" id="coreTab">             <!-- Баланс -->             <div class="balance-sectio')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.coretab', 'coreTab', 'js_string', '</div>          <!-- Вкладка Core (Основное) -->         <div class="tab-content active" id="coreTab">             <!-- Баланс -->             <div class="balance-section">             <div class="bal')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.balancesection', 'balance-section', 'js_string', '}             to { transform: translateY(0); opacity: 1; }         }          /* Баланс */         .balance-section {             text-align: center;             margin-bottom: 30px;         }        ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.balanceitem', 'balance-item', 'js_string', 'ance-section {             text-align: center;             margin-bottom: 30px;         }          .balance-item {             display: inline-block;             margin: 0 15px;             padding: 1')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.balancelabel', 'balance-label', 'js_string', '0%, 100% { transform: scale(1); }             50% { transform: scale(1.05); }         }          .balance-label {             font-size: 0.9rem;             opacity: 0.9;             margin-bottom: 5p')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.userbalance_ndn', 'user.balance_ndn', 'js_string', 'tion">             <div class="balance-item">                 <div class="balance-label" data-i18n="user.balance_ndn">NDN Баланс</div>                 <div class="balance-value" id="ndnBalance">0.00</')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.balancevalue', 'balance-value', 'js_string', 'font-size: 0.9rem;             opacity: 0.9;             margin-bottom: 5px;         }          .balance-value {             font-size: 1.5rem;             font-weight: bold;         }          /* Кно')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ndnbalance', 'ndnBalance', 'js_string', 'label" data-i18n="user.balance_ndn">NDN Баланс</div>                 <div class="balance-value" id="ndnBalance">0.00</div>             </div>         </div>           <!-- Основные кнопки -->         ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.card', 'card', 'js_string', 'o { opacity: 1; transform: translateY(0); }         }          /* Игровые элементы */         .game-card {             background: linear-gradient(135deg, rgba(255, 255, 255, 0.1), rgba(255, 255, 255,')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.button_buttonprimary', 'button button-primary', 'js_string', '</div>           <!-- Основные кнопки -->         <div class="card">             <button class="button button-primary" onclick="buyPro()" data-i18n="buttons.buy_pro">                 💎 Купить Pro стат')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.buttonsbuy_pro', 'buttons.buy_pro', 'js_string', '<div class="card">             <button class="button button-primary" onclick="buyPro()" data-i18n="buttons.buy_pro">                 💎 Купить Pro статус             </button>             <button class')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.button_buttonsecondary', 'button button-secondary', 'js_string', 'tons.buy_pro">                 💎 Купить Pro статус             </button>             <button class="button button-secondary" onclick="buyNDN()" data-i18n="buttons.buy_ndn">                 ⭐ Купить ND')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.buttonsbuy_ndn', 'buttons.buy_ndn', 'js_string', '</button>             <button class="button button-secondary" onclick="buyNDN()" data-i18n="buttons.buy_ndn">                 ⭐ Купить NDN за Telegram Stars             </button>             <button c')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.button_buttonsuccess', 'button button-success', 'js_string', 'n">                 ⭐ Купить NDN за Telegram Stars             </button>             <button class="button button-success" onclick="exchangeNDN()" data-i18n="buttons.exchange">                 ⭐ Обмен')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.buttonsexchange', 'buttons.exchange', 'js_string', '</button>             <button class="button button-success" onclick="exchangeNDN()" data-i18n="buttons.exchange">                 ⭐ Обменять NDN на Stars             </button>             <button clas')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.button_buttoninfo', 'button button-info', 'js_string', 'exchange">                 ⭐ Обменять NDN на Stars             </button>             <button class="button button-info" onclick="transferNDN()" data-i18n="buttons.transfer_ndn">                 💸 Пере')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.buttonstransfer_ndn', 'buttons.transfer_ndn', 'js_string', '</button>             <button class="button button-info" onclick="transferNDN()" data-i18n="buttons.transfer_ndn">                 💸 Перевести NDN             </button>         </div>          <!-- До')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.buttonsachievements', 'buttons.achievements', 'js_string', 's="card">             <button class="button button-primary" onclick="showAchievements()" data-i18n="buttons.achievements">                 🏆 Достижения             </button>             <button class=')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.buttonsshops', 'buttons.shops', 'js_string', '</button>             <button class="button button-secondary" onclick="showShops()" data-i18n="buttons.shops">                 🏪 Магазины             </button>             <button class="button button')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.buttonsreferrals', 'buttons.referrals', 'js_string', '</button>             <button class="button button-success" onclick="showReferrals()" data-i18n="buttons.referrals">                 👥 Мои рефералы             </button>         </div>          <!-- P')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.profunctionscard', 'proFunctionsCard', 'js_string', '</div>          <!-- PRO функции (только для PRO пользователей) -->         <div class="card" id="proFunctionsCard" style="display: none;">             <button class="button button-success" onclick="i')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.display_none', 'display: none;', 'js_string', ': rgba(255, 255, 255, 0.1);             color: white;         }          .tab-content {             display: none;             animation: fadeIn 0.3s ease-in-out;         }          .tab-content.activ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.buttonsinvite_friends', 'buttons.invite_friends', 'js_string', 'lay: none;">             <button class="button button-success" onclick="inviteFriends()" data-i18n="buttons.invite_friends">                 📤 Пригласить друзей             </button>         </div>   ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.buttonsleaderboard', 'buttons.leaderboard', 'js_string', 'ss="card">             <button class="button button-primary" onclick="showLeaderboard()" data-i18n="buttons.leaderboard">                 🏆 Таблица лидеров             </button>             <button cl')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.buttonsrules', 'buttons.rules', 'js_string', '</button>             <button class="button button-secondary" onclick="showRules()" data-i18n="buttons.rules">                 📋 Правила игры             </button>         </div>          <!-- Игровой')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.adminpanelcard', 'adminPanelCard', 'js_string', 'вой ID (внизу) -->         <!-- Админ панель (только для админов) -->         <div class="card" id="adminPanelCard" style="display: none;">             <div class="admin-panel-section">               ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.adminpanelsection', 'admin-panel-section', 'js_string', 'font-size: 12px;             margin-top: 5px;         }          /* Админ панель */         .admin-panel-section {             text-align: center;             padding: 20px;         }          .admin-')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.admintitle', 'admin-title', 'js_string', 'dmin-panel-section {             text-align: center;             padding: 20px;         }          .admin-title {             font-size: 18px;             font-weight: 700;             color: #ff6b35;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.adminstatus', 'admin-status', 'js_string', 'font-weight: 700;             color: #ff6b35;             margin-bottom: 10px;         }          .admin-status {             font-size: 14px;             color: #666;             margin-bottom: 15px;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.walletstats', 'walletStats', 'js_string', '>                                  <!-- Статистика серверного кошелька -->                 <div id="walletStats" class="wallet-stats" style="display: none;">                     <h4>💰 Серверный кошеле')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.statsgrid', 'stats-grid', 'js_string', 'ear-gradient(90deg, #FFD700, #FFA500);             transition: width 0.3s ease;         }          .stats-grid {             display: grid;             grid-template-columns: repeat(2, 1fr);          ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.statcard', 'stat-card', 'js_string', 'olumns: repeat(2, 1fr);             gap: 15px;             margin-bottom: 20px;         }          .stat-card {             background: rgba(255, 255, 255, 0.1);             border-radius: 12px;      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.staticon', 'stat-icon', 'js_string', 'background: rgba(255, 255, 255, 0.1);             transform: translateY(-1px);         }          .stat-icon {             font-size: 24px;             margin-right: 12px;         }          .stat-inf')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.statinfo', 'stat-info', 'js_string', '.stat-icon {             font-size: 24px;             margin-right: 12px;         }          .stat-info {             flex: 1;         }          .stat-label {             font-size: 12px;            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.statlabel', 'stat-label', 'js_string', 'radius: 8px;             transition: all 0.3s ease;             color: #000000;         }          .stat-label {             font-size: 12px;             opacity: 0.8;             margin-bottom: 4px;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.statvalue', 'stat-value', 'js_string', 'opacity: 0.8;             margin-bottom: 4px;             color: #333333;         }          .stat-value {             font-size: 18px;             font-weight: bold;             color: #000000;      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.walletbalance', 'walletBalance', 'js_string', 'div class="stat-label">Баланс NDN</div>                                 <div class="stat-value" id="walletBalance">0</div>                             </div>                         </div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.starsreceived', 'starsReceived', 'js_string', 'class="stat-label">Получено Stars</div>                                 <div class="stat-value" id="starsReceived">0</div>                             </div>                         </div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ndnexchanged', 'ndnExchanged', 'js_string', 'v class="stat-label">Обменено NDN</div>                                 <div class="stat-value" id="ndnExchanged">0</div>                             </div>                         </div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.starssent', 'starsSent', 'js_string', 'ass="stat-label">Отправлено Stars</div>                                 <div class="stat-value" id="starsSent">0</div>                             </div>                         </div>                ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.systemstats', 'systemStats', 'js_string', '</div>                                  <!-- Общая статистика -->                 <div id="systemStats" class="system-stats" style="display: none;">                     <h4>📊 Статистика системы</h4>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.totalusers', 'totalUsers', 'js_string', '="stat-label">Всего пользователей</div>                                 <div class="stat-value" id="totalUsers">0</div>                             </div>                         </div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.prousers', 'proUsers', 'js_string', 'ss="stat-label">PRO пользователей</div>                                 <div class="stat-value" id="proUsers">0</div>                             </div>                         </div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ndnincirculation', 'ndnInCirculation', 'js_string', 'class="stat-label">NDN в обороте</div>                                 <div class="stat-value" id="ndnInCirculation">0</div>                             </div>                         </div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.totalreferrals', 'totalReferrals', 'js_string', '<div class="stat-label">Рефералов</div>                                 <div class="stat-value" id="totalReferrals">0</div>                             </div>                         </div>           ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.adminbuttons', 'admin-buttons', 'js_string', 'font-size: 1.2em;             font-weight: bold;             color: #ff6b35;         }          .admin-buttons {             display: flex;             flex-direction: column;             gap: 10px;  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.button_buttonadmin', 'button button-admin', 'js_string', 'iv>                                  <div class="admin-buttons">                     <button class="button button-admin" onclick="showExchangeRequests()" id="exchangeRequestsBtn" style="display: none;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.exchangerequestsbtn', 'exchangeRequestsBtn', 'js_string', 'tons">                     <button class="button button-admin" onclick="showExchangeRequests()" id="exchangeRequestsBtn" style="display: none;">                         💰 Заявки на обмен              ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.usermanagementbtn', 'userManagementBtn', 'js_string', '/button>                     <button class="button button-admin" onclick="showUserManagement()" id="userManagementBtn" style="display: none;">                         👥 Управление пользователями      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.analyticsbtn', 'analyticsBtn', 'js_string', '</button>                     <button class="button button-admin" onclick="showAnalytics()" id="analyticsBtn" style="display: none;">                         📊 Аналитика                     </button>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.useridsection', 'user-id-section', 'js_string', 'or, #ffffff);             font-weight: 500;         }          /* Стили для игрового ID */         .user-id-section {             text-align: center;             padding: 20px;         }          .id-')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.idlabel', 'id-label', 'js_string', '.user-id-section {             text-align: center;             padding: 20px;         }          .id-label {             color: #000000;             font-size: 16px;             font-weight: 600;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.useruser_id', 'user.user_id', 'js_string', '="card">             <div class="user-id-section">                 <div class="id-label" data-i18n="user.user_id">🎮 Ваш игровой ID:</div>                 <div class="id-container">                    ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.idcontainer', 'id-container', 'js_string', 'font-size: 16px;             font-weight: 600;             margin-bottom: 10px;         }          .id-container {             display: flex;             align-items: center;             justify-conte')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.idvalue', 'id-value', 'js_string', 'ustify-content: center;             gap: 10px;             margin-bottom: 10px;         }          .id-value {             background: #ffffff;             color: #000000;             font-size: 18px;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.userid', 'userId', 'js_string', 'ID:</div>                 <div class="id-container">                     <div class="id-value" id="userId">-</div>                     <button class="button button-small" onclick="copyUserId()">📋</but')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.button_buttonsmall', 'button button-small', 'js_string', '">                     <div class="id-value" id="userId">-</div>                     <button class="button button-small" onclick="copyUserId()">📋</button>                 </div>                 <div c')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.idhint', 'id-hint', 'js_string', 'padding: 8px 12px;             font-size: 14px;             min-width: auto;         }          .id-hint {             color: var(--tg-theme-hint-color, #999999);             font-size: 12px;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.useruser_id_hint', 'user.user_id_hint', 'js_string', 'ck="copyUserId()">📋</button>                 </div>                 <div class="id-hint" data-i18n="user.user_id_hint">Используйте этот ID для переводов другим игрокам</div>             </div>        ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.testfunctions', 'testFunctions', 'js_string', '</div>          <!-- Тестовые функции (только в браузере) -->         <div class="card" id="testFunctions" style="display: none;">             <button class="button button-secondary" onclick="resetTes')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.loading', 'loading', 'js_string', '.notification.warning {             background: #ff9800;         }          /* Загрузка */         .loading {             display: none;             text-align: center;             padding: 20px;     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.spinner', 'spinner', 'js_string', 'display: none;             text-align: center;             padding: 20px;         }          .spinner {             width: 40px;             height: 40px;             border: 4px solid #f3f3f3;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.tabcontent', 'tab-content', 'js_string', ') {             background: rgba(255, 255, 255, 0.1);             color: white;         }          .tab-content {             display: none;             animation: fadeIn 0.3s ease-in-out;         }  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gametab', 'gameTab', 'js_string', '</div>         </div>          <!-- Вкладка Game (Игра) -->         <div class="tab-content" id="gameTab">             <!-- Напоминания -->             <div class="reminder-banner" id="dailyReminder" ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.reminderbanner', 'reminder-banner', 'js_string', '.notification-close:hover {             opacity: 1;         }          /* Напоминания */         .reminder-banner {             background: linear-gradient(135deg, #FFD700, #FFA500);             color')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.dailyreminder', 'dailyReminder', 'js_string', 'ontent" id="gameTab">             <!-- Напоминания -->             <div class="reminder-banner" id="dailyReminder" onclick="claimDailyReward(1)" style="display: none;">                 🎁 Не забудьте п')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gamecard', 'game-card', 'js_string', 'to { opacity: 1; transform: translateY(0); }         }          /* Игровые элементы */         .game-card {             background: linear-gradient(135deg, rgba(255, 255, 255, 0.1), rgba(255, 255, 255')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gamedaily_rewards', 'game.daily_rewards', 'js_string', '<!-- Ежедневные награды -->             <div class="game-card">                 <h3 data-i18n="game.daily_rewards">🎁 Ежедневные награды</h3>                 <p data-i18n="game.daily_rewards_desc">Захо')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gamedaily_rewards_desc', 'game.daily_rewards_desc', 'js_string', '<h3 data-i18n="game.daily_rewards">🎁 Ежедневные награды</h3>                 <p data-i18n="game.daily_rewards_desc">Заходите каждый день и получайте бонусы! (прокрутите для просмотра всех дней)</p>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.dailyrewardscontainer', 'daily-rewards-container', 'js_string', 'background: rgba(255, 255, 255, 0.5);         }          /* Индикатор прокрутки */         .daily-rewards-container::after {             content: "← Прокрутите для просмотра всех дней →";             ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.dailyrewards', 'daily-rewards', 'js_string', 'sform: translateY(-2px);             box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);         }          .daily-rewards {             display: flex;             gap: 8px;             margin-top: 15px;      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gameachievements', 'game.achievements', 'js_string', '<!-- Достижения -->             <div class="game-card">                 <h3 data-i18n="game.achievements">🏆 Достижения</h3>                 <p data-i18n="game.achievements_desc">Выполняйте задачи и по')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gameachievements_desc', 'game.achievements_desc', 'js_string', '>                 <h3 data-i18n="game.achievements">🏆 Достижения</h3>                 <p data-i18n="game.achievements_desc">Выполняйте задачи и получайте награды!</p>                 <div id="achievem')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.achievementslist', 'achievementsList', 'js_string', 'a-i18n="game.achievements_desc">Выполняйте задачи и получайте награды!</p>                 <div id="achievementsList">                     <!-- Будет заполнено JavaScript -->                 </div>   ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gameplayer_level', 'game.player_level', 'js_string', '<!-- Уровень игрока -->             <div class="game-card">                 <h3 data-i18n="game.player_level">⭐ Уровень игрока</h3>                 <div class="level-progress">                     <di')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.levelprogress', 'level-progress', 'js_string', 'ear-gradient(90deg, #667eea, #764ba2);             transition: width 0.3s ease;         }          .level-progress {             margin-top: 15px;         }          .level-info {             display:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.levelinfo', 'level-info', 'js_string', 'h 0.3s ease;         }          .level-progress {             margin-top: 15px;         }          .level-info {             display: flex;             justify-content: space-between;             marg')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gamelevel', 'game.level', 'js_string', 'el-progress">                     <div class="level-info">                         <span data-i18n="game.level">Уровень <span id="playerLevel">1</span></span>                         <span><span id="c')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.playerlevel', 'playerLevel', 'js_string', '<div class="level-info">                         <span data-i18n="game.level">Уровень <span id="playerLevel">1</span></span>                         <span><span id="currentXP">0</span> / <span id="nex')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.currentxp', 'currentXP', 'js_string', '"game.level">Уровень <span id="playerLevel">1</span></span>                         <span><span id="currentXP">0</span> / <span id="nextLevelXP">100</span> <span data-i18n="game.xp">XP</span></span>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.nextlevelxp', 'nextLevelXP', 'js_string', 'layerLevel">1</span></span>                         <span><span id="currentXP">0</span> / <span id="nextLevelXP">100</span> <span data-i18n="game.xp">XP</span></span>                     </div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gamexp', 'game.xp', 'js_string', '<span><span id="currentXP">0</span> / <span id="nextLevelXP">100</span> <span data-i18n="game.xp">XP</span></span>                     </div>                     <div class="level-bar">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.levelbar', 'level-bar', 'js_string', '.level-info span {             color: #000000;             font-weight: 500;         }          .level-bar {             height: 8px;             background: rgba(255, 255, 255, 0.1);             bord')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.levelbarfill', 'level-bar-fill', 'js_string', ', 255, 255, 0.1);             border-radius: 4px;             overflow: hidden;         }          .level-bar-fill {             height: 100%;             background: linear-gradient(90deg, #FFD700, #')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gamestatistics', 'game.statistics', 'js_string', '<!-- Статистика игры -->             <div class="game-card">                 <h3 data-i18n="game.statistics">📊 Статистика</h3>                 <div class="stats-grid">                     <div class="')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.statitem', 'stat-item', 'js_string', 'e-columns: repeat(2, 1fr);             gap: 12px;             margin-top: 15px;         }          .stat-item {             display: flex;             align-items: center;             padding: 12px;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gamedays_played', 'game.days_played', 'js_string', '<div class="stat-info">                             <div class="stat-label" data-i18n="game.days_played">Дней в игре</div>                             <div class="stat-value" id="daysPlayed">0</div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.daysplayed', 'daysPlayed', 'js_string', 'a-i18n="game.days_played">Дней в игре</div>                             <div class="stat-value" id="daysPlayed">0</div>                         </div>                     </div>                     <d')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gameachievements_count', 'game.achievements_count', 'js_string', '<div class="stat-info">                             <div class="stat-label" data-i18n="game.achievements_count">Достижений</div>                             <div class="stat-value" id="achievementsCou')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.achievementscount', 'achievementsCount', 'js_string', '="game.achievements_count">Достижений</div>                             <div class="stat-value" id="achievementsCount">0</div>                         </div>                     </div>                ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gametotal_earned', 'game.total_earned', 'js_string', '<div class="stat-info">                             <div class="stat-label" data-i18n="game.total_earned">Заработано NDN</div>                             <div class="stat-value" id="totalEarned">0</d')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.totalearned', 'totalEarned', 'js_string', '8n="game.total_earned">Заработано NDN</div>                             <div class="stat-value" id="totalEarned">0</div>                         </div>                     </div>                     <')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gametotal_referrals', 'game.total_referrals', 'js_string', '<div class="stat-info">                             <div class="stat-label" data-i18n="game.total_referrals">Приглашено</div>                             <div class="stat-value" id="totalReferrals">0<')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minertab', 'minerTab', 'js_string', '</div>         </div>          <!-- Вкладка NDN Miner -->         <div class="tab-content" id="minerTab">             <!-- Статистика майнинга -->             <div class="miner-stats">                ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerstats', 'miner-stats', 'js_string', 'box-shadow: 0 4px 15px rgba(255, 215, 0, 0.4);         }          /* NDN Miner стили */         .miner-stats {             display: grid;             grid-template-columns: repeat(4, 1fr);            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerstatitem', 'miner-stat-item', 'js_string', 'st-button:disabled {             opacity: 0.5;             cursor: not-allowed;         }          .miner-stat-item {             background: linear-gradient(135deg, rgba(255, 255, 255, 0.1), rgba(255')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerstaticon', 'miner-stat-icon', 'js_string', 'display: flex;             align-items: center;             color: #000000;         }          .miner-stat-icon {             font-size: 24px;             margin-right: 12px;         }          .miner')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerstatinfo', 'miner-stat-info', 'js_string', '.miner-stat-icon {             font-size: 24px;             margin-right: 12px;         }          .miner-stat-info {             flex: 1;         }          .miner-stat-label {             font-size:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerstatlabel', 'miner-stat-label', 'js_string', 'margin-right: 12px;         }          .miner-stat-info {             flex: 1;         }          .miner-stat-label {             font-size: 12px;             opacity: 0.8;             margin-bottom: ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerstatsndn_gas', 'miner.stats.ndn_gas', 'js_string', '<div class="miner-stat-info">                         <div class="miner-stat-label" data-i18n="miner.stats.ndn_gas">NDN Gas</div>                         <div class="miner-stat-value" id="ndnGasBalanc')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerstatvalue', 'miner-stat-value', 'js_string', 'opacity: 0.8;             margin-bottom: 4px;             color: #333333;         }          .miner-stat-value {             font-size: 18px;             font-weight: bold;             color: #000000;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ndngasbalance', 'ndnGasBalance', 'js_string', '-i18n="miner.stats.ndn_gas">NDN Gas</div>                         <div class="miner-stat-value" id="ndnGasBalance">100</div>                     </div>                 </div>                 <div clas')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerstatsenergy', 'miner.stats.energy', 'js_string', '<div class="miner-stat-info">                         <div class="miner-stat-label" data-i18n="miner.stats.energy">Энергия</div>                         <div class="miner-stat-value" id="energyLevel">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.energylevel', 'energyLevel', 'js_string', 'a-i18n="miner.stats.energy">Энергия</div>                         <div class="miner-stat-value" id="energyLevel">100/100</div>                     </div>                 </div>                 <div cl')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerstatsgas_per_minute', 'miner.stats.gas_per_minute', 'js_string', '<div class="miner-stat-info">                         <div class="miner-stat-label" data-i18n="miner.stats.gas_per_minute">Gas/мин</div>                         <div class="miner-stat-value" id="gasPe')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gaspersecond', 'gasPerSecond', 'js_string', 'miner.stats.gas_per_minute">Gas/мин</div>                         <div class="miner-stat-value" id="gasPerSecond">0</div>                     </div>                 </div>                 <div class="')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerstatsnext_event', 'miner.stats.next_event', 'js_string', '<div class="miner-stat-info">                         <div class="miner-stat-label" data-i18n="miner.stats.next_event">След. событие</div>                         <div class="miner-stat-value" id="nex')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.nexteventtime', 'nextEventTime', 'js_string', 'ner.stats.next_event">След. событие</div>                         <div class="miner-stat-value" id="nextEventTime">24:00:00</div>                     </div>                 </div>             </div>  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minersynccontrols', 'miner-sync-controls', 'js_string', 'argin-bottom: 20px;             text-align: center;             color: #000000;         }          .miner-sync-controls {             margin: 15px 0;             text-align: center;         }         ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.syncbutton', 'sync-button', 'js_string', 'ner-sync-controls {             margin: 15px 0;             text-align: center;         }          .sync-button {             background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minersyncbutton', 'miner.sync.button', 'js_string', '<button class="sync-button" onclick="forceSyncMinerData()">                     🔄 <span data-i18n="miner.sync.button">Синхронизировать</span>                 </button>             </div>              ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.energyrefillsection', 'energy-refill-section', 'js_string', 'ight: bold;             color: #000000;         }          /* Кнопка пополнения энергии */         .energy-refill-section {             background: linear-gradient(135deg, rgba(255, 255, 255, 0.1), rg')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.energyrefillbutton', 'energy-refill-button', 'js_string', 'transform: none;             box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);         }          .energy-refill-button {             background: linear-gradient(135deg, #ff6b6b, #ee5a24);             ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerenergyrefill_button', 'miner.energy.refill_button', 'js_string', 'll-button" id="energyRefillButton" onclick="refillEnergy()">                     ⚡ <span data-i18n="miner.energy.refill_button">Пополнить энергию</span>                 </button>                 <div ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.energyrefillinfo', 'energy-refill-info', 'js_string', 'cursor: not-allowed;             transform: none;             box-shadow: none;         }          .energy-refill-info {             font-size: 14px;             color: #333333;             margin-top')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerenergynext_refill', 'miner.energy.next_refill', 'js_string', '<div class="energy-refill-info" id="energyRefillInfo">                     <span data-i18n="miner.energy.next_refill">Следующее пополнение через:</span> <span id="nextRefillTime">3:00:00</span>       ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.nextrefilltime', 'nextRefillTime', 'js_string', '<span data-i18n="miner.energy.next_refill">Следующее пополнение через:</span> <span id="nextRefillTime">3:00:00</span>                 </div>             </div>              <!-- Фермы майнинга -->')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerfarms', 'miner-farms', 'js_string', 'y-refill-info span {             font-weight: bold;             color: #ff6b6b;         }          .miner-farms, .miner-upgrades, .miner-shop {             background: linear-gradient(135deg, rgba(255')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.farmsgrid', 'farms-grid', 'js_string', 'margin-bottom: 15px;             font-size: 18px;             font-weight: 600;         }          .farms-grid {             display: grid;             grid-template-columns: repeat(auto-fit, minmax(2')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerupgrades', 'miner-upgrades', 'js_string', 'span {             font-weight: bold;             color: #ff6b6b;         }          .miner-farms, .miner-upgrades, .miner-shop {             background: linear-gradient(135deg, rgba(255, 255, 255, 0.')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.upgradestabs', 'upgrades-tabs', 'js_string', 'background: #ccc;             cursor: not-allowed;             transform: none;         }          .upgrades-tabs {             display: flex;             gap: 10px;             margin-bottom: 20px;  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.upgradetab_active', 'upgrade-tab active', 'js_string', '<h3>🔧 Улучшения</h3>                 <div class="upgrades-tabs">                     <button class="upgrade-tab active" onclick="switchUpgradeTab('speed')">Скорость</button>                     <butto')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.speed', 'speed', 'js_string', '="upgrades-tabs">                     <button class="upgrade-tab active" onclick="switchUpgradeTab('speed')">Скорость</button>                     <button class="upgrade-tab" onclick="switchUpgradeTab')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.upgradetab', 'upgrade-tab', 'js_string', 'gap: 10px;             margin-bottom: 20px;             flex-wrap: wrap;         }          .upgrade-tab {             background: rgba(255, 255, 255, 0.1);             border: 1px solid rgba(255, 255')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.efficiency', 'efficiency', 'js_string', 'eed')">Скорость</button>                     <button class="upgrade-tab" onclick="switchUpgradeTab('efficiency')">Эффективность</button>                     <button class="upgrade-tab" onclick="switch')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.automation', 'automation', 'js_string', '">Эффективность</button>                     <button class="upgrade-tab" onclick="switchUpgradeTab('automation')">Автоматизация</button>                     <button class="upgrade-tab" onclick="switch')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.premium', 'premium', 'js_string', 'nslateY(-2px);             box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);         }          .shop-item.premium {             border: 2px solid #ffd700;             background: linear-gradient(135deg, rgb')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.upgradescontent', 'upgrades-content', 'js_string', 'k="switchUpgradeTab('premium')">Премиум</button>                 </div>                 <div class="upgrades-content" id="upgradesContent">                     <!-- Будет заполнено JavaScript -->     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerboosts', 'miner-boosts', 'js_string', 'ansform: scale(1);             }         }                  /* Стили для новых разделов */         .miner-boosts, .miner-special, .miner-quests {             margin-bottom: 20px;         }            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.boostsgrid', 'boosts-grid', 'js_string', 'oosts, .miner-special, .miner-quests {             margin-bottom: 20px;         }                  .boosts-grid, .special-miners-grid {             display: grid;             grid-template-columns: re')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerspecial', 'miner-special', 'js_string', '1);             }         }                  /* Стили для новых разделов */         .miner-boosts, .miner-special, .miner-quests {             margin-bottom: 20px;         }                  .boosts-g')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.specialminersgrid', 'special-miners-grid', 'js_string', 'special, .miner-quests {             margin-bottom: 20px;         }                  .boosts-grid, .special-miners-grid {             display: grid;             grid-template-columns: repeat(auto-fit,')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerquests', 'miner-quests', 'js_string', '}         }                  /* Стили для новых разделов */         .miner-boosts, .miner-special, .miner-quests {             margin-bottom: 20px;         }                  .boosts-grid, .special-mi')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.questslist', 'quests-list', 'js_string', 'on:hover {             box-shadow: 0 4px 15px rgba(255, 107, 107, 0.4);         }                  .quests-list {             display: flex;             flex-direction: column;             gap: 10px;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minershop', 'miner-shop', 'js_string', 'font-weight: bold;             color: #ff6b6b;         }          .miner-farms, .miner-upgrades, .miner-shop {             background: linear-gradient(135deg, rgba(255, 255, 255, 0.1), rgba(255, 255, ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minershoptitle', 'miner.shop.title', 'js_string', '>              <!-- Магазин -->             <div class="miner-shop">                 <h3 data-i18n="miner.shop.title">🛒 Магазин</h3>                 <div class="shop-items" id="shopItems">            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopitems', 'shop-items', 'js_string', 'background: #ccc;             cursor: not-allowed;             transform: none;         }          .shop-items {             display: grid;             grid-template-columns: repeat(auto-fit, minmax(2')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerleaderboard', 'miner-leaderboard', 'js_string', 'box-shadow: 0 4px 10px rgba(255, 215, 0, 0.3);         }          /* Рейтинг майнеров */         .miner-leaderboard {             background: linear-gradient(135deg, rgba(255, 255, 255, 0.1), rgba(255')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerleaderboardtitle', 'miner.leaderboard.title', 'js_string', '!-- Рейтинг майнеров -->             <div class="miner-leaderboard">                 <h3 data-i18n="miner.leaderboard.title">🏆 Рейтинг майнеров</h3>                 <div class="leaderboard-table" id="')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.leaderboardtable', 'leaderboard-table', 'js_string', 'margin-bottom: 15px;             font-size: 18px;             font-weight: 600;         }          .leaderboard-table {             overflow-x: auto;         }          .leaderboard-table table {     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.modal', 'modal', 'js_string', 'ground: linear-gradient(135deg, #218838, #1ea085);         }          /* Модальные окна */         .modal {             display: none;             position: fixed;             top: 0;             left')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.buypromodal', 'buyProModal', 'js_string', '/div>         </div>     </div>      <!-- Модальное окно покупки Pro -->     <div class="modal" id="buyProModal">         <div class="modal-content">             <div class="modal-header">            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.modalcontent', 'modal-content', 'js_string', 'frames fadeIn {             from { opacity: 0; }             to { opacity: 1; }         }          .modal-content {             position: absolute;             top: 50%;             left: 50%;        ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.modalheader', 'modal-header', 'js_string', '.modal-buttons .button {                 width: 100%;             }         }          .modal-header {             text-align: center;             margin-bottom: 20px;         }          .modal-title')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.modaltitle', 'modal-title', 'js_string', 'modal-header {             text-align: center;             margin-bottom: 20px;         }          .modal-title {             font-size: 1.5rem;             font-weight: bold;             color: #333;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.modalsubtitle', 'modal-subtitle', 'js_string', 'font-weight: bold;             color: #333;             margin-bottom: 10px;         }          .modal-subtitle {             color: #666;             font-size: 0.9rem;         }          .form-group')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.procost', 'pro.cost', 'js_string', '="buttons.buy_pro">💎 Купить Pro статус</div>                 <div class="modal-subtitle" data-i18n="pro.cost">Стоимость: 1000 NDN</div>             </div>             <div class="form-group">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.formgroup', 'form-group', 'js_string', '.modal-subtitle {             color: #666;             font-size: 0.9rem;         }          .form-group {             margin-bottom: 20px;         }          .form-label {             display: block;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.formlabel', 'form-label', 'js_string', 'size: 0.9rem;         }          .form-group {             margin-bottom: 20px;         }          .form-label {             display: block;             margin-bottom: 8px;             font-weight: bo')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.modalndnbalance', 'modalNdnBalance', 'js_string', 'data-i18n="user.balance_ndn">Ваш баланс NDN:</label>                 <div class="balance-value" id="modalNdnBalance">0.00</div>             </div>             <div class="modal-buttons">              ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.modalbuttons', 'modal-buttons', 'js_string', 'margin: 10px;                 overflow-y: auto;             }                          .modal-buttons {                 flex-direction: column;                 gap: 10px;                 position: sti')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.buttonsconfirm', 'buttons.confirm', 'js_string', 'uttons">                 <button class="button button-primary" onclick="confirmBuyPro()" data-i18n="buttons.confirm">Подтвердить</button>                 <button class="button button-secondary" onclic')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.buttonscancel', 'buttons.cancel', 'js_string', '<button class="button button-secondary" onclick="closeModal('buyProModal')" data-i18n="buttons.cancel">Отмена</button>             </div>         </div>     </div>      <!-- Модальное окно покупки NDN')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.buyndnmodal', 'buyNDNModal', 'js_string', '/div>         </div>     </div>      <!-- Модальное окно покупки NDN -->     <div class="modal" id="buyNDNModal">         <div class="modal-content">             <div class="modal-header">            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.paymentrate', 'payment.rate', 'js_string', 'uy_ndn">⭐ Купить NDN за Telegram Stars</div>                 <div class="modal-subtitle" data-i18n="payment.rate">Курс: 1 NDN = 1 Telegram Star</div>                 <div class="modal-subtitle" style=')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.paymentstars_info', 'payment.stars_info', 'js_string', '<div class="modal-subtitle" style="font-size: 0.8rem; color: #666; margin-top: 5px;" data-i18n="payment.stars_info">                     💡 Stars поступают на баланс бота и могут быть выведены в TON')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.transferamount', 'transfer.amount', 'js_string', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="transfer.amount">Количество NDN:</label>                 <input type="number" class="form-input" id="nd')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.number', 'number', 'js_string', 'justify-content: space-between;             align-items: center;         }          .level-number {             font-weight: bold;             color: #4CAF50;             font-size: 14px;         }')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.forminput', 'form-input', 'js_string', 'margin-bottom: 8px;             font-weight: bold;             color: #333;         }          .form-input {             width: 100%;             padding: 12px 15px;             border: 2px solid #e0e')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ndnamount', 'ndnAmount', 'js_string', 'ransfer.amount">Количество NDN:</label>                 <input type="number" class="form-input" id="ndnAmount" data-i18n-placeholder="transfer.amount" placeholder="Введите количество" min="1">        ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.введите_количество', 'Введите количество', 'js_string', 'ype="number" class="form-input" id="ndnAmount" data-i18n-placeholder="transfer.amount" placeholder="Введите количество" min="1">             </div>             <div class="form-group">                ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.paymentstars_cost', 'payment.stars_cost', 'js_string', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="payment.stars_cost">Стоимость в Stars:</label>                 <div class="balance-value" id="starsCost')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.starscost', 'starsCost', 'js_string', 'i18n="payment.stars_cost">Стоимость в Stars:</label>                 <div class="balance-value" id="starsCost">0</div>                 <div style="font-size: 0.8rem; color: #666; margin-top: 5px;" dat')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.buttonsbuy', 'buttons.buy', 'js_string', '<div class="card">             <button class="button button-primary" onclick="buyPro()" data-i18n="buttons.buy_pro">                 💎 Купить Pro статус             </button>             <button class')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.exchangendnmodal', 'exchangeNDNModal', 'js_string', '</div>     </div>      <!-- Модальное окно обмена NDN на Stars -->     <div class="modal" id="exchangeNDNModal">         <div class="modal-content">             <div class="modal-header">             ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.exchangestars_info', 'exchange.stars_info', 'js_string', '<div class="modal-subtitle" style="font-size: 0.8rem; color: #666; margin-top: 5px;" data-i18n="exchange.stars_info">                     💡 NDN списываются с вашего счета, Stars поступают в Telegram')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.exchangeamount', 'exchangeAmount', 'js_string', 'unt">Количество NDN для обмена:</label>                 <input type="number" class="form-input" id="exchangeAmount" data-i18n-placeholder="transfer.amount" placeholder="Введите количество" min="1" oni')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.exchangeusername', 'exchange.username', 'js_string', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="exchange.username">Ваш Telegram username:</label>                 <input type="text" class="form-input"')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.text', 'text', 'js_string', '}          .notification-icon {             font-size: 20px;         }          .notification-text {             flex: 1;             font-weight: 500;         }          .notification-close {')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.exchangereceive_stars', 'exchange.receive_stars', 'js_string', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="exchange.receive_stars">Получите Stars:</label>                 <div class="balance-value" id="exchange')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.exchangestars', 'exchangeStars', 'js_string', '18n="exchange.receive_stars">Получите Stars:</label>                 <div class="balance-value" id="exchangeStars">0</div>             </div>             <div class="modal-buttons">                 <b')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.withdrawmodal', 'withdrawModal', 'js_string', '</div>         </div>     </div>      <!-- Модальное окно вывода NDN -->     <div class="modal" id="withdrawModal">         <div class="modal-content">             <div class="modal-header">          ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.buttonswithdraw_ndn', 'buttons.withdraw_ndn', 'js_string', 'ontent">             <div class="modal-header">                 <div class="modal-title" data-i18n="buttons.withdraw_ndn">💰 Вывести NDN</div>                 <div class="modal-subtitle" data-i18n="wit')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.withdrawminimum', 'withdraw.minimum', 'js_string', 'n="buttons.withdraw_ndn">💰 Вывести NDN</div>                 <div class="modal-subtitle" data-i18n="withdraw.minimum">Минимальная сумма: 100 NDN</div>             </div>             <div class="form-g')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.withdrawamount', 'withdrawAmount', 'js_string', 'ransfer.amount">Количество NDN:</label>                 <input type="number" class="form-input" id="withdrawAmount" data-i18n-placeholder="transfer.amount" placeholder="Введите количество" min="100"> ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.withdrawrecipient_id', 'withdraw.recipient_id', 'js_string', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="withdraw.recipient_id">Telegram ID получателя:</label>                 <input type="text" class="form-i')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.recipientid', 'recipientId', 'js_string', 'pient_id">Telegram ID получателя:</label>                 <input type="text" class="form-input" id="recipientId" data-i18n-placeholder="withdraw.recipient_placeholder" placeholder="@username или ID">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.withdrawrecipient_placeholder', 'withdraw.recipient_placeholder', 'js_string', 'abel>                 <input type="text" class="form-input" id="recipientId" data-i18n-placeholder="withdraw.recipient_placeholder" placeholder="@username или ID">             </div>             <div ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.buttonswithdraw', 'buttons.withdraw', 'js_string', 'ontent">             <div class="modal-header">                 <div class="modal-title" data-i18n="buttons.withdraw_ndn">💰 Вывести NDN</div>                 <div class="modal-subtitle" data-i18n="wit')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.achievementsmodal', 'achievementsModal', 'js_string', '</div>         </div>     </div>      <!-- Модальное окно достижений -->     <div class="modal" id="achievementsModal">         <div class="modal-content">             <div class="modal-header">      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.achievementsdescription', 'achievements.description', 'js_string', '8n="buttons.achievements">🏆 Достижения</div>                 <div class="modal-subtitle" data-i18n="achievements.description">Выполняйте задачи и получайте награды!</div>             </div>           ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.modalbody', 'modal-body', 'js_string', ';             overflow-y: auto;             padding: 20px;         }                  .rules-modal .modal-body {             max-height: calc(90vh - 120px);             overflow-y: auto;             p')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.buttonsback', 'buttons.back', 'js_string', '<button class="button button-secondary" onclick="closeModal('achievementsModal')" data-i18n="buttons.back">← Назад</button>             </div>         </div>     </div>      <!-- Модальное окно магази')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopsmodal', 'shopsModal', 'js_string', '</div>         </div>     </div>      <!-- Модальное окно магазинов -->     <div class="modal" id="shopsModal">         <div class="modal-content">             <div class="modal-header">              ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopsdescription', 'shops.description', 'js_string', '" data-i18n="buttons.shops">🏪 Магазины</div>                 <div class="modal-subtitle" data-i18n="shops.description">Откройте свой магазин за 10,000 NDN!</div>             </div>             <div cl')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopslist', 'shopsList', 'js_string', 'кройте свой магазин за 10,000 NDN!</div>             </div>             <div class="modal-body" id="shopsList">                 <div class="loading">Загрузка магазинов...</div>             </div>     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopsopen_shop', 'shops.open_shop', 'js_string', 'ons">                 <button class="button button-primary" onclick="showOpenShopForm()" data-i18n="shops.open_shop">🏪 Открыть магазин</button>                 <button class="button button-secondary" ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.openshopmodal', 'openShopModal', 'js_string', '</div>     </div>      <!-- Модальное окно открытия магазина -->     <div class="modal" id="openShopModal">         <div class="modal-content">             <div class="modal-header">                 <')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopscost', 'shops.cost', 'js_string', '8n="shops.open_shop">🏪 Открыть магазин</div>                 <div class="modal-subtitle" data-i18n="shops.cost">Стоимость: 10,000 NDN</div>             </div>             <div class="form-group">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopsshop_name', 'shops.shop_name', 'js_string', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.shop_name">Название магазина:</label>                 <input type="text" class="form-input" id="s')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopname', 'shopName', 'js_string', 'ops.shop_name">Название магазина:</label>                 <input type="text" class="form-input" id="shopName" data-i18n-placeholder="shops.shop_name" placeholder="Введите название магазина">          ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.введите_название_магазина', 'Введите название магазина', 'js_string', 't type="text" class="form-input" id="shopName" data-i18n-placeholder="shops.shop_name" placeholder="Введите название магазина">             </div>             <div class="form-group">                 ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopsshop_description', 'shops.shop_description', 'js_string', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.shop_description">Описание:</label>                 <textarea class="form-input" id="shopDescript')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopdescription', 'shopDescription', 'js_string', 'ta-i18n="shops.shop_description">Описание:</label>                 <textarea class="form-input" id="shopDescription" data-i18n-placeholder="shops.shop_description" placeholder="Опишите ваш магазин" ro')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.опишите_ваш_магазин', 'Опишите ваш магазин', 'js_string', 'class="form-input" id="shopDescription" data-i18n-placeholder="shops.shop_description" placeholder="Опишите ваш магазин" rows="3"></textarea>             </div>             <div class="form-group">   ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopscategory', 'shops.category', 'js_string', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.category">Категория:</label>                 <select class="form-input" id="shopCategory">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.general', 'general', 'js_string', 'l>                 <select class="form-input" id="shopCategory">                     <option value="general" data-i18n="shops.categories.general">Общие товары</option>                     <option valu')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopscategoriesgeneral', 'shops.categories.general', 'js_string', 'select class="form-input" id="shopCategory">                     <option value="general" data-i18n="shops.categories.general">Общие товары</option>                     <option value="digital" data-i18')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.digital', 'digital', 'js_string', 'eral" data-i18n="shops.categories.general">Общие товары</option>                     <option value="digital" data-i18n="shops.categories.digital">Цифровые товары</option>                     <option v')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopscategoriesdigital', 'shops.categories.digital', 'js_string', 'ps.categories.general">Общие товары</option>                     <option value="digital" data-i18n="shops.categories.digital">Цифровые товары</option>                     <option value="physical" data')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.physical', 'physical', 'js_string', 'l" data-i18n="shops.categories.digital">Цифровые товары</option>                     <option value="physical" data-i18n="shops.categories.physical">Физические товары</option>                     <opti')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopscategoriesphysical', 'shops.categories.physical', 'js_string', 'ategories.digital">Цифровые товары</option>                     <option value="physical" data-i18n="shops.categories.physical">Физические товары</option>                     <option value="services" d')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.services', 'services', 'js_string', 'data-i18n="shops.categories.physical">Физические товары</option>                     <option value="services" data-i18n="shops.categories.services">Услуги</option>                     <option value="c')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopscategoriesservices', 'shops.categories.services', 'js_string', 'gories.physical">Физические товары</option>                     <option value="services" data-i18n="shops.categories.services">Услуги</option>                     <option value="congratulations" data-')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.congratulations', 'congratulations', 'js_string', '"services" data-i18n="shops.categories.services">Услуги</option>                     <option value="congratulations" data-i18n="shops.categories.congratulations">Поздравления</option>                 ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopscategoriescongratulations', 'shops.categories.congratulations', 'js_string', 'categories.services">Услуги</option>                     <option value="congratulations" data-i18n="shops.categories.congratulations">Поздравления</option>                     <option value="merchandi')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.merchandise', 'merchandise', 'js_string', 'ta-i18n="shops.categories.congratulations">Поздравления</option>                     <option value="merchandise" data-i18n="shops.categories.merchandise">Мерч</option>                 </select>       ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopscategoriesmerchandise', 'shops.categories.merchandise', 'js_string', 's.congratulations">Поздравления</option>                     <option value="merchandise" data-i18n="shops.categories.merchandise">Мерч</option>                 </select>             </div>            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.additemmodal', 'addItemModal', 'js_string', '</div>     </div>      <!-- Модальное окно добавления товара -->     <div class="modal" id="addItemModal">         <div class="modal-content">             <div class="modal-header">                 <d')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopsadd_item', 'shops.add_item', 'js_string', 'ontent">             <div class="modal-header">                 <div class="modal-title" data-i18n="shops.add_item">📦 Добавить товар</div>                 <div class="modal-subtitle" data-i18n="shops.')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopsadd_item_description', 'shops.add_item_description', 'js_string', 'i18n="shops.add_item">📦 Добавить товар</div>                 <div class="modal-subtitle" data-i18n="shops.add_item_description">Добавьте товар в ваш магазин</div>             </div>             <div c')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopsitem_name', 'shops.item_name', 'js_string', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.item_name">Название товара:</label>                 <input type="text" class="form-input" id="ite')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.itemname', 'itemName', 'js_string', 'shops.item_name">Название товара:</label>                 <input type="text" class="form-input" id="itemName" data-i18n-placeholder="shops.item_name" placeholder="Введите название товара">            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.введите_название_товара', 'Введите название товара', 'js_string', 't type="text" class="form-input" id="itemName" data-i18n-placeholder="shops.item_name" placeholder="Введите название товара">             </div>             <div class="form-group">                 <l')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopsitem_description', 'shops.item_description', 'js_string', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.item_description">Описание:</label>                 <textarea class="form-input" id="itemDescript')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.itemdescription', 'itemDescription', 'js_string', 'ta-i18n="shops.item_description">Описание:</label>                 <textarea class="form-input" id="itemDescription" data-i18n-placeholder="shops.item_description" placeholder="Опишите товар" rows="3"')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.опишите_товар', 'Опишите товар', 'js_string', 'class="form-input" id="itemDescription" data-i18n-placeholder="shops.item_description" placeholder="Опишите товар" rows="3"></textarea>             </div>             <div class="form-group">         ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopsprice_ndn', 'shops.price_ndn', 'js_string', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.price_ndn">Цена в NDN:</label>                 <input type="number" class="form-input" id="itemPr')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.itempricendn', 'itemPriceNDN', 'js_string', 'n="shops.price_ndn">Цена в NDN:</label>                 <input type="number" class="form-input" id="itemPriceNDN" placeholder="0" min="0" step="0.01">             </div>             <div class="form-g')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.001', '0.01', 'js_string', '<input type="number" class="form-input" id="itemPriceNDN" placeholder="0" min="0" step="0.01">             </div>             <div class="form-group">                 <label class="form-label"')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopsprice_stars', 'shops.price_stars', 'js_string', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.price_stars">Цена в Stars:</label>                 <input type="number" class="form-input" id="it')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.itempricestars', 'itemPriceStars', 'js_string', 'hops.price_stars">Цена в Stars:</label>                 <input type="number" class="form-input" id="itemPriceStars" placeholder="0" min="0" step="0.01">             </div>             <div class="form')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopsitem_type', 'shops.item_type', 'js_string', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.item_type">Тип товара:</label>                 <select class="form-input" id="itemType">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.itemtype', 'itemType', 'js_string', 'bel" data-i18n="shops.item_type">Тип товара:</label>                 <select class="form-input" id="itemType">                     <option value="digital" data-i18n="shops.types.digital">Цифровой</opt')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopstypesdigital', 'shops.types.digital', 'js_string', '<select class="form-input" id="itemType">                     <option value="digital" data-i18n="shops.types.digital">Цифровой</option>                     <option value="physical" data-i18n="shops.ty')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopstypesphysical', 'shops.types.physical', 'js_string', '18n="shops.types.digital">Цифровой</option>                     <option value="physical" data-i18n="shops.types.physical">Физический</option>                     <option value="service" data-i18n="sho')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.service', 'service', 'js_string', 'data-i18n="shops.categories.physical">Физические товары</option>                     <option value="services" data-i18n="shops.categories.services">Услуги</option>                     <option value="c')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopstypesservice', 'shops.types.service', 'js_string', 'n="shops.types.physical">Физический</option>                     <option value="service" data-i18n="shops.types.service">Услуга</option>                 </select>             </div>             <div c')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.itemcategory', 'itemCategory', 'js_string', 'label" data-i18n="shops.category">Категория:</label>                 <select class="form-input" id="itemCategory">                     <option value="congratulations" data-i18n="shops.categories.congr')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopsimage_url', 'shops.image_url', 'js_string', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.image_url">Ссылка на изображение:</label>                 <input type="url" class="form-input" id')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.url', 'url', 'js_string', '<div class="form-group">                 <label class="form-label" data-i18n="shops.image_url">Ссылка на изображение:</label>                 <input type="url" class="form-input" id="itemImageU')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.itemimageurl', 'itemImageUrl', 'js_string', '.image_url">Ссылка на изображение:</label>                 <input type="url" class="form-input" id="itemImageUrl" placeholder="https://example.com/image.jpg">             </div>             <div class')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopsstock', 'shops.stock', 'js_string', '</div>             <div class="form-group">                 <label class="form-label" data-i18n="shops.stock">Количество на складе (-1 = безлимит):</label>                 <input type="number" class="')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.itemstock', 'itemStock', 'js_string', 'ство на складе (-1 = безлимит):</label>                 <input type="number" class="form-input" id="itemStock" placeholder="-1" min="-1">             </div>             <div class="modal-buttons">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.invitefriendsmodal', 'inviteFriendsModal', 'js_string', '</div>     </div>      <!-- Модальное окно приглашения друзей -->     <div class="modal" id="inviteFriendsModal">         <div class="modal-content">             <div class="modal-header">            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralsinvite_description', 'referrals.invite_description', 'js_string', 'ns.invite_friends">📤 Пригласить друзей</div>                 <div class="modal-subtitle" data-i18n="referrals.invite_description">Поделитесь ссылкой и зарабатывайте с каждого реферала!</div>          ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.invitecontent', 'invite-content', 'js_string', '#000000 !important;         }          /* Стили для модального окна приглашения друзей */         .invite-content {             padding: 20px 0;         }          .referral-link-section {            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referrallinksection', 'referral-link-section', 'js_string', 'на приглашения друзей */         .invite-content {             padding: 20px 0;         }          .referral-link-section {             margin-bottom: 30px;         }          .referral-link-section h')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralsyour_link', 'referrals.your_link', 'js_string', 'nt">                     <div class="referral-link-section">                         <h3 data-i18n="referrals.your_link">🔗 Ваша реферальная ссылка:</h3>                         <div class="link-contai')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.linkcontainer', 'link-container', 'js_string', '-color, #ffffff);             margin-bottom: 15px;             font-size: 18px;         }          .link-container {             margin-bottom: 15px;         }          .link-actions {             dis')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referrallinkinput', 'referralLinkInput', 'js_string', '<div class="link-container">                             <input type="text" class="form-input" id="referralLinkInput" readonly>                         </div>                         <div class="link-')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.linkactions', 'link-actions', 'js_string', 'ze: 18px;         }          .link-container {             margin-bottom: 15px;         }          .link-actions {             display: flex;             gap: 10px;             justify-content: center')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.buttonscopy', 'buttons.copy', 'js_string', '<button class="button button-primary" onclick="copyReferralLink()" data-i18n="buttons.copy">📋 Копировать</button>                             <button class="button button-secondary" onclick=')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralsshow_link', 'referrals.show_link', 'js_string', '<button class="button button-secondary" onclick="showLinkModal()" data-i18n="referrals.show_link">👁️ Показать ссылку</button>                         </div>                     </div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.invitemethods', 'invite-methods', 'js_string', 'border-radius: 8px;             padding: 12px;             font-size: 14px;         }          .invite-methods {             margin-bottom: 30px;         }          .invite-methods h3 {             co')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralsinvite_methods', 'referrals.invite_methods', 'js_string', 'v>                                  <div class="invite-methods">                     <h3 data-i18n="referrals.invite_methods">📱 Способы приглашения:</h3>                     <div class="method-buttons')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.methodbuttons', 'method-buttons', 'js_string', '-color, #ffffff);             margin-bottom: 15px;             font-size: 18px;         }          .method-buttons {             display: flex;             gap: 10px;             flex-wrap: wrap;     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralsselect_contact', 'referrals.select_contact', 'js_string', '<button class="button button-success" onclick="inviteToTelegramContact()" data-i18n="referrals.select_contact">                             📱 Выбрать контакт из Telegram                         </butt')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralsshare_telegram', 'referrals.share_telegram', 'js_string', '<button class="button button-primary" onclick="shareViaTelegram()" data-i18n="referrals.share_telegram">                             🌐 Поделиться в Telegram                         </button>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralscopy_link', 'referrals.copy_link', 'js_string', '<button class="button button-secondary" onclick="shareViaOther()" data-i18n="referrals.copy_link">                             🔗 Скопировать ссылку                         </button>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralinfo', 'referral-info', 'js_string', '(-20px); opacity: 0; }             to { transform: translateX(0); opacity: 1; }         }          .referral-info {             flex: 1;         }          .referral-name {             font-weight: bo')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralshow_to_earn', 'referrals.how_to_earn', 'js_string', 'iv>                                  <div class="referral-info">                     <h3 data-i18n="referrals.how_to_earn">💰 Как зарабатывать:</h3>                     <div class="info-grid">         ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.infogrid', 'info-grid', 'js_string', '-color, #ffffff);             margin-bottom: 15px;             font-size: 18px;         }          .info-grid {             display: grid;             grid-template-columns: repeat(auto-fit, minmax(20')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.infoitem', 'info-item', 'js_string', '-template-columns: repeat(auto-fit, minmax(200px, 1fr));             gap: 15px;         }          .info-item {             display: flex;             align-items: center;             gap: 10px;      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.infoicon', 'info-icon', 'js_string', 'border-radius: 8px;             border: 1px solid rgba(255, 255, 255, 0.2);         }          .info-icon {             font-size: 24px;             min-width: 30px;         }          .info-text {')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.infotext', 'info-text', 'js_string', '.info-icon {             font-size: 24px;             min-width: 30px;         }          .info-text {             color: var(--tg-theme-text-color, #ffffff);             font-size: 14px;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralsstep1', 'referrals.step1', 'js_string', '<div class="info-icon">1️⃣</div>                             <div class="info-text" data-i18n="referrals.step1">Друг переходит по вашей ссылке</div>                         </div>                     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralsstep2', 'referrals.step2', 'js_string', '<div class="info-icon">2️⃣</div>                             <div class="info-text" data-i18n="referrals.step2">Регистрируется в игре</div>                         </div>                         <div ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralsstep3', 'referrals.step3', 'js_string', '<div class="info-icon">3️⃣</div>                             <div class="info-text" data-i18n="referrals.step3">Покупает PRO статус</div>                         </div>                         <div cl')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralsstep4', 'referrals.step4', 'js_string', '<div class="info-icon">4️⃣</div>                             <div class="info-text" data-i18n="referrals.step4">Вы получаете 200 NDN</div>                         </div>                         <div c')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralsstep5', 'referrals.step5', 'js_string', '<div class="info-icon">5️⃣</div>                             <div class="info-text" data-i18n="referrals.step5">Зарабатываете до 7 уровней в глубину</div>                         </div>               ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.transferndnmodal', 'transferNDNModal', 'js_string', 'div>         </div>     </div>      <!-- Модальное окно перевода NDN -->     <div class="modal" id="transferNDNModal">         <div class="modal-content">             <div class="modal-header">       ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.transfertitle', 'transfer.title', 'js_string', 'ontent">             <div class="modal-header">                 <div class="modal-title" data-i18n="transfer.title">💸 Перевести NDN</div>                 <div class="modal-subtitle" data-i18n="transfe')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.transferinstructions', 'transfer.instructions', 'js_string', '-i18n="transfer.title">💸 Перевести NDN</div>                 <div class="modal-subtitle" data-i18n="transfer.instructions">Выберите получателя и введите сумму</div>             </div>             <div')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.transfercontent', 'transfer-content', 'js_string', 'line-height: 1.4;         }          /* Стили для модального окна перевода NDN */         .transfer-content {             padding: 20px 0;         }          .recipient-section, .amount-section {')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.recipientsection', 'recipient-section', 'js_string', 'о окна перевода NDN */         .transfer-content {             padding: 20px 0;         }          .recipient-section, .amount-section {             margin-bottom: 30px;         }          .recipient-')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.transferrecipient', 'transfer.recipient', 'js_string', 'ansfer-content">                 <div class="recipient-section">                     <h3 data-i18n="transfer.recipient">👤 Получатель:</h3>                     <div class="recipient-info" id="recipient')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.recipientinfo', 'recipient-info', 'js_string', '<h3 data-i18n="transfer.recipient">👤 Получатель:</h3>                     <div class="recipient-info" id="recipientInfo" style="display: none;">                         <div class="recipient-card">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.recipientcard', 'recipient-card', 'js_string', '-color, #ffffff);             margin-bottom: 15px;             font-size: 18px;         }          .recipient-card {             display: flex;             align-items: center;             gap: 15px; ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.recipientavatar', 'recipient-avatar', 'js_string', 'border-radius: 8px;             border: 1px solid rgba(255, 255, 255, 0.2);         }          .recipient-avatar {             font-size: 32px;             width: 50px;             height: 50px;      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.recipientdetails', 'recipient-details', 'js_string', 'background: rgba(255, 255, 255, 0.2);             border-radius: 50%;         }          .recipient-details {             flex: 1;         }          .recipient-name {             color: var(--tg-them')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.recipientname', 'recipient-name', 'js_string', 'order-radius: 50%;         }          .recipient-details {             flex: 1;         }          .recipient-name {             color: var(--tg-theme-text-color, #ffffff);             font-size: 16px')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.buttonschange', 'buttons.change', 'js_string', '<button class="button button-secondary" onclick="changeRecipient()" data-i18n="buttons.change">Изменить</button>                         </div>                     </div>                     <d')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.recipientinputsection', 'recipient-input-section', 'js_string', 'font-size: 14px;             font-family: 'Courier New', monospace;         }          .recipient-input-section {             display: flex;             flex-direction: column;             gap: 10px; ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.recipientidinput', 'recipientIdInput', 'js_string', 'tion" id="recipientInputSection">                         <input type="text" class="form-input" id="recipientIdInput" data-i18n-placeholder="transfer.recipient" placeholder="Введите игровой ID получат')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.введите_игровой_id', 'Введите игровой ID получателя', 'js_string', 't" class="form-input" id="recipientIdInput" data-i18n-placeholder="transfer.recipient" placeholder="Введите игровой ID получателя">                         <button class="button button-primary" id="fi')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.findrecipientbtn', 'findRecipientBtn', 'js_string', '="Введите игровой ID получателя">                         <button class="button button-primary" id="findRecipientBtn" onclick="findRecipient()" data-i18n="buttons.find_player">                        ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.buttonsfind_player', 'buttons.find_player', 'js_string', '<button class="button button-primary" id="findRecipientBtn" onclick="findRecipient()" data-i18n="buttons.find_player">                             🔍 Найти игрока                         </button>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.amountsection', 'amount-section', 'js_string', '*/         .transfer-content {             padding: 20px 0;         }          .recipient-section, .amount-section {             margin-bottom: 30px;         }          .recipient-section h3, .amount-')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.amountinputcontainer', 'amount-input-container', 'js_string', '00000 !important;             border-color: #45a049;             outline: none;         }          .amount-input-container {             position: relative;         }          .amount-input-container ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.введите_сумму_ndn', 'Введите сумму NDN', 'js_string', 'number" class="form-input" id="transferAmount" data-i18n-placeholder="transfer.amount" placeholder="Введите сумму NDN" min="0.01" step="0.01">                         <div class="balance-info">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.balanceinfo', 'balance-info', 'js_string', 'ntainer .form-input {             width: 100%;             margin-bottom: 10px;         }          .balance-info {             color: var(--tg-theme-hint-color, #999999);             font-size: 14px;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.transferbalance', 'transfer.balance', 'js_string', '1">                         <div class="balance-info">                             <span data-i18n="transfer.balance">Ваш баланс:</span> <span id="transferBalance">0</span> NDN                        ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.transfersummary', 'transfer-summary', 'js_string', 'nt-color, #999999);             font-size: 14px;             text-align: right;         }          .transfer-summary {             background: rgba(255, 255, 255, 0.05);             border-radius: 8px')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.summaryitem', 'summary-item', 'js_string', '-color, #ffffff);             margin-bottom: 15px;             font-size: 16px;         }          .summary-item {             display: flex;             justify-content: space-between;             al')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.summaryrecipient', 'summaryRecipient', 'js_string', '="summary-item">                         <span>Получатель:</span>                         <span id="summaryRecipient"></span>                     </div>                     <div class="summary-item">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.summaryamount', 'summaryAmount', 'js_string', 'class="summary-item">                         <span>Сумма:</span>                         <span id="summaryAmount"></span> NDN                     </div>                     <div class="summary-item">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.summaryfee', 'summaryFee', 'js_string', 'ss="summary-item">                         <span>Комиссия:</span>                         <span id="summaryFee">0</span> NDN                     </div>                     <div class="summary-item tot')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.summaryitem_total', 'summary-item total', 'js_string', '<span id="summaryFee">0</span> NDN                     </div>                     <div class="summary-item total">                         <span>Итого к списанию:</span>                         <span ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.summarytotal', 'summaryTotal', 'js_string', 'em total">                         <span>Итого к списанию:</span>                         <span id="summaryTotal"></span> NDN                     </div>                 </div>             </div>      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.confirmtransferbtn', 'confirmTransferBtn', 'js_string', '>             <div class="modal-buttons">                 <button class="button button-success" id="confirmTransferBtn" onclick="confirmTransfer()" disabled data-i18n="transfer.confirm">              ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.transferconfirm', 'transfer.confirm', 'js_string', 'ass="button button-success" id="confirmTransferBtn" onclick="confirmTransfer()" disabled data-i18n="transfer.confirm">                     💸 Перевести                 </button>                 <button')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.cat_on_keyboard', 'cat_on_keyboard', 'js_string', '// Смешные события и бонусы         const funnyEvents = [             {                 id: 'cat_on_keyboard',                 name: 'Кот на клавиатуре!',                 description: 'Ваш кот случайн')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.кот_на_клавиатуре', 'Кот на клавиатуре!', 'js_string', 'const funnyEvents = [             {                 id: 'cat_on_keyboard',                 name: 'Кот на клавиатуре!',                 description: 'Ваш кот случайно нажал на кнопку "Турбо-режим"!',  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ваш_кот_случайно', 'Ваш кот случайно нажал на кнопку', 'js_string', 'id: 'cat_on_keyboard',                 name: 'Кот на клавиатуре!',                 description: 'Ваш кот случайно нажал на кнопку "Турбо-режим"!',                 icon: '🐱',                 effect: 's')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.effect', ',
                effect:', 'js_string', 'description: 'Ваш кот случайно нажал на кнопку "Турбо-режим"!',                 icon: '🐱',                 effect: 'speed_boost',                 duration: 30000, // 30 секунд                 message:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.майнеры_работают_в', 'Майнеры работают в 2 раза быстрее!', 'js_string', 'effect: 'speed_boost',                 duration: 30000, // 30 секунд                 message: 'Майнеры работают в 2 раза быстрее!'             },             {                 id: 'coffee_spill',     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.coffee_spill', 'coffee_spill', 'js_string', 'message: 'Майнеры работают в 2 раза быстрее!'             },             {                 id: 'coffee_spill',                 name: 'Пролитый кофе',                 description: 'Кофе попал на сервер')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.пролитый_кофе', 'Пролитый кофе', 'js_string', 'а быстрее!'             },             {                 id: 'coffee_spill',                 name: 'Пролитый кофе',                 description: 'Кофе попал на сервер, но почему-то улучшил производите')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.кофе_попал_на', 'Кофе попал на сервер, но почему-то улучшил производительность!', 'js_string', 'id: 'coffee_spill',                 name: 'Пролитый кофе',                 description: 'Кофе попал на сервер, но почему-то улучшил производительность!',                 icon: '☕',                 eff')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.bitcoin_halving', 'bitcoin_halving', 'js_string', 'message: 'Потребление энергии снижено на 50%!'             },             {                 id: 'bitcoin_halving',                 name: 'Bitcoin Halving',                 description: 'Случайно произ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.случайно_произошел_халвинг', 'Случайно произошел халвинг Bitcoin, все майнеры стали работать лучше!', 'js_string', 'id: 'bitcoin_halving',                 name: 'Bitcoin Halving',                 description: 'Случайно произошел халвинг Bitcoin, все майнеры стали работать лучше!',                 icon: '₿',        ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.все_майнеры_работают', 'Все майнеры работают в 3 раза эффективнее!', 'js_string', 'effect: 'all_boost',                 duration: 60000, // 1 минута                 message: 'Все майнеры работают в 3 раза эффективнее!'             },             {                 id: 'alien_tech',  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.alien_tech', 'alien_tech', 'js_string', 'age: 'Все майнеры работают в 3 раза эффективнее!'             },             {                 id: 'alien_tech',                 name: 'Инопланетная технология',                 description: 'Пришельц')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.инопланетная_технология', 'Инопланетная технология', 'js_string', 'эффективнее!'             },             {                 id: 'alien_tech',                 name: 'Инопланетная технология',                 description: 'Пришельцы поделились своими технологиями!', ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.пришельцы_поделились_своими', 'Пришельцы поделились своими технологиями!', 'js_string', 'id: 'alien_tech',                 name: 'Инопланетная технология',                 description: 'Пришельцы поделились своими технологиями!',                 icon: '👽',                 effect: 'free_ga')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.duration_0_message', ',
                duration: 0,
                message:', 'js_string', 'льцы поделились своими технологиями!',                 icon: '👽',                 effect: 'free_gas',                 duration: 0,                 message: 'Получено 1000 Gas от инопланетян!'         ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.miner_strike', 'miner_strike', 'js_string', 'message: 'Получено 1000 Gas от инопланетян!'             },             {                 id: 'miner_strike',                 name: 'Забастовка майнеров',                 description: 'Майнеры объявил')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.забастовка_майнеров', 'Забастовка майнеров', 'js_string', 'опланетян!'             },             {                 id: 'miner_strike',                 name: 'Забастовка майнеров',                 description: 'Майнеры объявили забастовку и требуют больше эне')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.майнеры_объявили_забастовку', 'Майнеры объявили забастовку и требуют больше энергии!', 'js_string', 'id: 'miner_strike',                 name: 'Забастовка майнеров',                 description: 'Майнеры объявили забастовку и требуют больше энергии!',                 icon: '✊',                 effect')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.майнеры_не_работают', 'Майнеры не работают, но потребляют энергию!', 'js_string', 'effect: 'energy_drain',                 duration: 20000, // 20 секунд                 message: 'Майнеры не работают, но потребляют энергию!'             }         ];                  let activeEvents ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.miner_last_event_time', 'miner_last_event_time', 'js_string', 'let activeEvents = [];         let lastEventTime = parseInt(localStorage.getItem('miner_last_event_time') || '0');                  // Система уровней и престижа         let prestigeData = {')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.first_miner', 'first_miner', 'js_string', '};                  // Система квестов         const quests = [             {                 id: 'first_miner',                 name: 'Первый майнер',                 description: 'Купите свой первый')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.первый_майнер', 'Первый майнер', 'js_string', 'ов         const quests = [             {                 id: 'first_miner',                 name: 'Первый майнер',                 description: 'Купите свой первый майнер',                 icon: '🌱',')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.купите_свой_первый', 'Купите свой первый майнер', 'js_string', 'id: 'first_miner',                 name: 'Первый майнер',                 description: 'Купите свой первый майнер',                 icon: '🌱',                 reward: { gas: 100, xp: 50 },            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gas_collector', 'gas_collector', 'js_string', 'rms.length >= 1,                 completed: false             },             {                 id: 'gas_collector',                 name: 'Собиратель',                 description: 'Накопите 1000 Gas'')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.собиратель', 'Собиратель', 'js_string', 'ted: false             },             {                 id: 'gas_collector',                 name: 'Собиратель',                 description: 'Накопите 1000 Gas',                 icon: '💰',           ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.накопите_1000_gas', 'Накопите 1000 Gas', 'js_string', 'id: 'gas_collector',                 name: 'Собиратель',                 description: 'Накопите 1000 Gas',                 icon: '💰',                 reward: { gas: 500, xp: 100 },                 con')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.mining_tycoon', 'mining_tycoon', 'js_string', 'sEarned >= 1000,                 completed: false             },             {                 id: 'mining_tycoon',                 name: 'Магнат',                 description: 'Купите 5 ферм',       ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.магнат', 'Магнат', 'js_string', 'ted: false             },             {                 id: 'mining_tycoon',                 name: 'Магнат',                 description: 'Купите 5 ферм',                 icon: '🏭',                 re')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.купите_5_ферм', 'Купите 5 ферм', 'js_string', 'id: 'mining_tycoon',                 name: 'Магнат',                 description: 'Купите 5 ферм',                 icon: '🏭',                 reward: { gas: 1000, xp: 200 },                 condit')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.energy_master', 'energy_master', 'js_string', 'rms.length >= 5,                 completed: false             },             {                 id: 'energy_master',                 name: 'Мастер энергии',                 description: 'Пополните энер')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.мастер_энергии', 'Мастер энергии', 'js_string', 'ted: false             },             {                 id: 'energy_master',                 name: 'Мастер энергии',                 description: 'Пополните энергию 10 раз',                 icon: '⚡',')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.пополните_энергию_10', 'Пополните энергию 10 раз', 'js_string', 'id: 'energy_master',                 name: 'Мастер энергии',                 description: 'Пополните энергию 10 раз',                 icon: '⚡',                 reward: { gas: 800, xp: 150 },         ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.speed_demon', 'speed_demon', 'js_string', 'gyRefills >= 10,                 completed: false             },             {                 id: 'speed_demon',                 name: 'Скоростной демон',                 description: 'Достигните 100')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.скоростной_демон', 'Скоростной демон', 'js_string', 'leted: false             },             {                 id: 'speed_demon',                 name: 'Скоростной демон',                 description: 'Достигните 100 Gas/мин',                 icon: '🚀',')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.icon', ',
                icon:', 'js_string', ''Кот на клавиатуре!',                 description: 'Ваш кот случайно нажал на кнопку "Турбо-режим"!',                 icon: '🐱',                 effect: 'speed_boost',                 duration: 30000,')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.miner_completed_quests', 'miner_completed_quests', 'js_string', 'se             }         ];                  let completedQuests = JSON.parse(localStorage.getItem('miner_completed_quests') || '[]');                  // Система бустов         const boosts = [      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.double_gas', 'double_gas', 'js_string', ']');                  // Система бустов         const boosts = [             {                 id: 'double_gas',                 name: 'Двойной Gas',                 description: 'Удваивает генерацию ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.двойной_gas', 'Двойной Gas', 'js_string', 'тов         const boosts = [             {                 id: 'double_gas',                 name: 'Двойной Gas',                 description: 'Удваивает генерацию Gas на 1 час',                 icon:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.удваивает_генерацию_gas', 'Удваивает генерацию Gas на 1 час', 'js_string', 'id: 'double_gas',                 name: 'Двойной Gas',                 description: 'Удваивает генерацию Gas на 1 час',                 icon: '💎',                 duration: 60 * 60 * 1000, // 1 час   ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gas_multiplier', 'gas_multiplier', 'js_string', 'icon: '💎',                 duration: 60 * 60 * 1000, // 1 час                 effect: 'gas_multiplier',                 value: 2,                 cost: 1000             },             {')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.energy_saver', 'energy_saver', 'js_string', 'value: 2,                 cost: 1000             },             {                 id: 'energy_saver',                 name: 'Энергосберегатель',                 description: 'Снижает потребление энер')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.энергосберегатель', 'Энергосберегатель', 'js_string', 'cost: 1000             },             {                 id: 'energy_saver',                 name: 'Энергосберегатель',                 description: 'Снижает потребление энергии на 50% на 2 часа',     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.energy_efficiency', 'energy_efficiency', 'js_string', 'icon: '🔋',                 duration: 2 * 60 * 60 * 1000, // 2 часа                 effect: 'energy_efficiency',                 value: 0.5,                 cost: 1500             },             {')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.speed_boost', 'speed_boost', 'js_string', 'ш кот случайно нажал на кнопку "Турбо-режим"!',                 icon: '🐱',                 effect: 'speed_boost',                 duration: 30000, // 30 секунд                 message: 'Майнеры работа')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.турборежим', 'Турбо-режим', 'js_string', 'name: 'Кот на клавиатуре!',                 description: 'Ваш кот случайно нажал на кнопку "Турбо-режим"!',                 icon: '🐱',                 effect: 'speed_boost',                 duration: ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.увеличивает_скорость_майнинга', 'Увеличивает скорость майнинга в 3 раза на 30 минут', 'js_string', 'id: 'speed_boost',                 name: 'Турбо-режим',                 description: 'Увеличивает скорость майнинга в 3 раза на 30 минут',                 icon: '⚡',                 duration: 30 * 60 ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.mining_speed', 'mining_speed', 'js_string', 'icon: '⚡',                 duration: 30 * 60 * 1000, // 30 минут                 effect: 'mining_speed',                 value: 3,                 cost: 800             }         ];                  l')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.quantum_miner', 'quantum_miner', 'js_string', 'Особые майнеры (только на сутки)         const specialMiners = [             {                 id: 'quantum_miner',                 name: 'Квантовый майнер',                 description: 'Сверхмощный ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.квантовый_майнер', 'Квантовый майнер', 'js_string', 'const specialMiners = [             {                 id: 'quantum_miner',                 name: 'Квантовый майнер',                 description: 'Сверхмощный майнер на 24 часа',                 icon:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.сверхмощный_майнер_на', 'Сверхмощный майнер на 24 часа', 'js_string', 'id: 'quantum_miner',                 name: 'Квантовый майнер',                 description: 'Сверхмощный майнер на 24 часа',                 icon: '🔮',                 gasPerMinute: 1000,             ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.time_warp_miner', 'time_warp_miner', 'js_string', 'cost: 5000,                 adRequired: true             },             {                 id: 'time_warp_miner',                 name: 'Машина времени',                 description: 'Майнер из будущег')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.машина_времени', 'Машина времени', 'js_string', 'ed: true             },             {                 id: 'time_warp_miner',                 name: 'Машина времени',                 description: 'Майнер из будущего на 24 часа',                 icon:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.майнер_из_будущего', 'Майнер из будущего на 24 часа', 'js_string', 'id: 'time_warp_miner',                 name: 'Машина времени',                 description: 'Майнер из будущего на 24 часа',                 icon: '⏰',                 gasPerMinute: 2000,             ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.galaxy_miner', 'galaxy_miner', 'js_string', 'cost: 10000,                 adRequired: true             },             {                 id: 'galaxy_miner',                 name: 'Галактический майнер',                 description: 'Майнер с друг')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.галактический_майнер', 'Галактический майнер', 'js_string', 'uired: true             },             {                 id: 'galaxy_miner',                 name: 'Галактический майнер',                 description: 'Майнер с другой планеты на 24 часа',           ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.майнер_с_другой', 'Майнер с другой планеты на 24 часа', 'js_string', 'id: 'galaxy_miner',                 name: 'Галактический майнер',                 description: 'Майнер с другой планеты на 24 часа',                 icon: '🌌',                 gasPerMinute: 5000,     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.first_farm', 'first_farm', 'js_string', '// Секретные достижения         const secretAchievements = [             {                 id: 'first_farm',                 name: 'Первый шаг',                 description: 'Купили первую ферму!',')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.первый_шаг', 'Первый шаг', 'js_string', 'const secretAchievements = [             {                 id: 'first_farm',                 name: 'Первый шаг',                 description: 'Купили первую ферму!',                 icon: '🌱',        ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.купили_первую_ферму', 'Купили первую ферму!', 'js_string', 'id: 'first_farm',                 name: 'Первый шаг',                 description: 'Купили первую ферму!',                 icon: '🌱',                 condition: (data) => data.farms && data.farms.leng')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.собиратель_gas', 'Собиратель Gas', 'js_string', 'reward: 50             },             {                 id: 'gas_collector',                 name: 'Собиратель Gas',                 description: 'Накопили 1000 Gas!',                 icon: '💰',      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.накопили_1000_gas', 'Накопили 1000 Gas!', 'js_string', 'id: 'gas_collector',                 name: 'Собиратель Gas',                 description: 'Накопили 1000 Gas!',                 icon: '💰',                 condition: (data) => data.totalGasEarned >= 1')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.магнат_майнинга', 'Магнат майнинга', 'js_string', 'eward: 100             },             {                 id: 'mining_tycoon',                 name: 'Магнат майнинга',                 description: 'Купили 10 ферм!',                 icon: '🏭',        ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.купили_10_ферм', 'Купили 10 ферм!', 'js_string', 'id: 'mining_tycoon',                 name: 'Магнат майнинга',                 description: 'Купили 10 ферм!',                 icon: '🏭',                 condition: (data) => data.farms && data.farms.l')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.пополнили_энергию_5', 'Пополнили энергию 5 раз!', 'js_string', 'id: 'energy_master',                 name: 'Мастер энергии',                 description: 'Пополнили энергию 5 раз!',                 icon: '⚡',                 condition: (data) => data.energyRefills')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.lucky_strike', 'lucky_strike', 'js_string', 'a.energyRefills >= 5,                 reward: 200             },             {                 id: 'lucky_strike',                 name: 'Удачливый удар',                 description: 'Получили 3 случ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.удачливый_удар', 'Удачливый удар', 'js_string', 'reward: 200             },             {                 id: 'lucky_strike',                 name: 'Удачливый удар',                 description: 'Получили 3 случайных события подряд!',               ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.получили_3_случайных', 'Получили 3 случайных события подряд!', 'js_string', 'id: 'lucky_strike',                 name: 'Удачливый удар',                 description: 'Получили 3 случайных события подряд!',                 icon: '🍀',                 condition: (data) => data.co')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.miner_achievements', 'miner_achievements', 'js_string', '}         ];                  let unlockedAchievements = JSON.parse(localStorage.getItem('miner_achievements') || '[]');                  // Данные майнера будут загружены с сервера в initializeMinerD')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.cpu_miner', 'cpu_miner', 'js_string', 'nerData()          // Фермы майнинга         const farmTypes = [             {                 id: 'cpu_miner',                 name: 'CPU Miner',                 icon: '💻',                 descriptio')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.description', ',
                description:', 'js_string', '= [             {                 id: 'cat_on_keyboard',                 name: 'Кот на клавиатуре!',                 description: 'Ваш кот случайно нажал на кнопку "Турбо-режим"!',                 ico')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gpu_farm', 'gpu_farm', 'js_string', 'energyCost: 1,                 unlockLevel: 1             },             {                 id: 'gpu_farm',                 name: 'GPU Farm',                 icon: '🎮',                 description: 'Мо')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.asic_rig', 'asic_rig', 'js_string', 'energyCost: 3,                 unlockLevel: 3             },             {                 id: 'asic_rig',                 name: 'ASIC Rig',                 icon: '⚡',                 description: 'Пр')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.data_center', 'data_center', 'js_string', 'energyCost: 8,                 unlockLevel: 5             },             {                 id: 'data_center',                 name: 'Data Center',                 icon: '🏢',                 descriptio')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.быстрый_процессор', 'Быстрый процессор', 'js_string', '// Улучшения         const upgradeTypes = {             speed: [                 { name: 'Быстрый процессор', description: '+10% скорости', cost: 50, effect: 0.1 },                 { name: 'Оптимизаци')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.оптимизация_кода', 'Оптимизация кода', 'js_string', 'Быстрый процессор', description: '+10% скорости', cost: 50, effect: 0.1 },                 { name: 'Оптимизация кода', description: '+25% скорости', cost: 150, effect: 0.25 },                 { name: ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.параллельные_вычисления', 'Параллельные вычисления', 'js_string', 'птимизация кода', description: '+25% скорости', cost: 150, effect: 0.25 },                 { name: 'Параллельные вычисления', description: '+50% скорости', cost: 400, effect: 0.5 }             ],     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.энергосбережение', 'Энергосбережение', 'js_string', 'орости', cost: 400, effect: 0.5 }             ],             efficiency: [                 { name: 'Энергосбережение', description: '-20% энергии', cost: 30, effect: 0.2 },                 { name: 'Ум')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.умное_охлаждение', 'Умное охлаждение', 'js_string', ''Энергосбережение', description: '-20% энергии', cost: 30, effect: 0.2 },                 { name: 'Умное охлаждение', description: '-40% энергии', cost: 100, effect: 0.4 },                 { name: 'Кв')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.квантовая_оптимизация', 'Квантовая оптимизация', 'js_string', ''Умное охлаждение', description: '-40% энергии', cost: 100, effect: 0.4 },                 { name: 'Квантовая оптимизация', description: '-60% энергии', cost: 300, effect: 0.6 }             ],        ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.автосбор', 'Авто-сбор', 'js_string', 'нергии', cost: 300, effect: 0.6 }             ],             automation: [                 { name: 'Авто-сбор', description: 'Автоматический сбор Gas', cost: 100, effect: 1 },                 { name: ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.автоматический_сбор_gas', 'Автоматический сбор Gas', 'js_string', ': 0.6 }             ],             automation: [                 { name: 'Авто-сбор', description: 'Автоматический сбор Gas', cost: 100, effect: 1 },                 { name: 'Умные алгоритмы', descrip')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.умные_алгоритмы', 'Умные алгоритмы', 'js_string', 'вто-сбор', description: 'Автоматический сбор Gas', cost: 100, effect: 1 },                 { name: 'Умные алгоритмы', description: 'Оптимизация майнинга', cost: 250, effect: 2 },                 { nam')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.оптимизация_майнинга', 'Оптимизация майнинга', 'js_string', 'ический сбор Gas', cost: 100, effect: 1 },                 { name: 'Умные алгоритмы', description: 'Оптимизация майнинга', cost: 250, effect: 2 },                 { name: 'ИИ управление', description:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ии_управление', 'ИИ управление', 'js_string', 'е алгоритмы', description: 'Оптимизация майнинга', cost: 250, effect: 2 },                 { name: 'ИИ управление', description: 'Полная автоматизация', cost: 500, effect: 3 }             ]         };')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.полная_автоматизация', 'Полная автоматизация', 'js_string', 'тимизация майнинга', cost: 250, effect: 2 },                 { name: 'ИИ управление', description: 'Полная автоматизация', cost: 500, effect: 3 }             ]         };          // Система вкладок  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.active', 'active', 'js_string', 'transition: all 0.3s ease;             position: relative;         }          .tab-button.active {             background: linear-gradient(135deg, #667eea, #764ba2);             color: white;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.контейнер_dailyrewards_не', 'Контейнер dailyRewards не найден', 'js_string', 'ocument.getElementById('dailyRewards');             if (!container) {                 console.warn('Контейнер dailyRewards не найден');                 return;             }              container.inn')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.claimed', 'claimed', 'js_string', '0;         }          .reward-day div {             color: #ffffff;         }          .reward-day.claimed {             background: linear-gradient(135deg, #4CAF50, #45a049);             border-color')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.available', 'available', 'js_string', 'adient(135deg, #4CAF50, #45a049);             border-color: #4CAF50;         }          .reward-day.available {             background: linear-gradient(135deg, #FFD700, #FFA500);             border-co')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.locked', 'locked', 'js_string', 'border-color: #FFD700;             animation: pulse 2s infinite;         }          .reward-day.locked {             opacity: 0.5;             cursor: not-allowed;         }          @keyframes pulse ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.доступно', 'Доступно', 'js_string', 'rd(${reward.day})` : ''}"                          title="${isClaimed ? 'Получено' : isAvailable ? 'Доступно' : isLocked ? 'Заблокировано' : ''}">                         <div class="reward-icon">${re')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.заблокировано', 'Заблокировано', 'js_string', '"                          title="${isClaimed ? 'Получено' : isAvailable ? 'Доступно' : isLocked ? 'Заблокировано' : ''}">                         <div class="reward-icon">${reward.icon}</div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.rewardicon', 'reward-icon', 'js_string', '0%, 100% { transform: scale(1); }             50% { transform: scale(1.05); }         }          .reward-icon {             font-size: 20px;             margin-bottom: 4px;         }          .reward-')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.rewardamount', 'reward-amount', 'js_string', '.reward-icon {             font-size: 20px;             margin-bottom: 4px;         }          .reward-amount {             font-size: 12px;             font-weight: bold;         }          .achievem')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.fontsize_10px_margintop', 'font-size: 10px; margin-top: 2px;', 'js_string', '<div class="reward-amount">${reward.amount}</div>                         <div style="font-size: 10px; margin-top: 2px;">День ${reward.day}</div>                         ${isClaimed ? '<div style="fon')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.награда_уже_получена', 'Награда уже получена!', 'js_string', 'ard(day) {             if (gameData.dailyRewards.includes(day)) {                 showNotification('Награда уже получена!', 'warning');                 return;             }              try {        ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.warning', 'warning', 'js_string', 'background: linear-gradient(135deg, #f44336, #d32f2f);         }          .notification.warning {             background: linear-gradient(135deg, #ff9800, #f57c00);         }          .notificati')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.post', 'POST', 'js_string', 'const response = await fetch('/api/game/claim-daily-reward', {                     method: 'POST',                     headers: {                         'Content-Type': 'application/json',')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.contenttype', 'Content-Type', 'js_string', 'ard', {                     method: 'POST',                     headers: {                         'Content-Type': 'application/json',                         'Authorization': `tma ${tg.initData || ''')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.success', 'success', 'js_string', '.notification.show {             transform: translateX(0);         }          .notification.success {             background: linear-gradient(135deg, #4CAF50, #45a049);         }          .notificati')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_получения_награды', 'Ошибка получения награды', 'js_string', 'playSound('success');                 } else {                     showNotification('Ошибка получения награды', 'error');                 }             } catch (error) {                 console.error(')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.error', 'error', 'js_string', 'background: linear-gradient(135deg, #4CAF50, #45a049);         }          .notification.error {             background: linear-gradient(135deg, #f44336, #d32f2f);         }          .notificati')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.error_claiming_daily', 'Error claiming daily reward:', 'js_string', 'награды', 'error');                 }             } catch (error) {                 console.error('Error claiming daily reward:', error);                 // Fallback - добавляем награду локально      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.контейнер_achievementslist_не', 'Контейнер achievementsList не найден', 'js_string', 'ent.getElementById('achievementsList');             if (!container) {                 console.warn('Контейнер achievementsList не найден');                 return;             }              try {    ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.authorization', 'Authorization', 'js_string', 'headers: {                         'Content-Type': 'application/json',                         'Authorization': `tma ${tg.initData || ''}`                     },                     body: JSON.stringi')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.completed', 'completed', 'js_string', 'e: 14px;             opacity: 0.8;             color: #333333;         }          .achievement-item.completed {             background: linear-gradient(135deg, rgba(76, 175, 80, 0.2), rgba(69, 160, 73')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.achievementicon', 'achievement-icon', 'js_string', 'rgba(69, 160, 73, 0.2));             border: 1px solid rgba(76, 175, 80, 0.3);         }          .achievement-icon {             font-size: 24px;             margin-right: 12px;         }          .a')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.achievementinfo', 'achievement-info', 'js_string', 'achievement-icon {             font-size: 24px;             margin-right: 12px;         }          .achievement-info {             flex: 1;         }          .achievement-title {             font-wei')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.achievementtitle', 'achievement-title', 'js_string', 'bottom: 8px;             transition: all 0.3s ease;             color: #000000;         }          .achievement-title {             font-weight: 600;             margin-bottom: 4px;             color:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.achievementdescription', 'achievement-description', 'js_string', 'font-weight: 600;             margin-bottom: 4px;             color: #000000;         }          .achievement-description {             font-size: 14px;             opacity: 0.8;             color: #3')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.achievementprogress', 'achievement-progress', 'js_string', 'chievement-description {             font-size: 14px;             opacity: 0.8;         }          .achievement-progress {             margin-top: 8px;             background: rgba(255, 255, 255, 0.1)')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.achievementprogressbar', 'achievement-progress-bar', 'js_string', 'height: 4px;             border-radius: 2px;             overflow: hidden;         }          .achievement-progress-bar {             height: 100%;             background: linear-gradient(90deg, #667e')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.textalign_right', 'text-align: right;', 'js_string', 'flow: hidden;             text-overflow: ellipsis;         }          .leader-balance {             text-align: right;             flex-shrink: 0;         }          .balance-ndn {             font-we')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.fontsize_12px_opacity', 'font-size: 12px; opacity: 0.8;', 'js_string', '<div style="text-align: right;">                                     <div style="font-size: 12px; opacity: 0.8;">${achievement.progress}/${achievement.max_progress}</div>                              ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.error_loading_achievements', 'Error loading achievements:', 'js_string', 'ievementsFallback();                 }             } catch (error) {                 console.error('Error loading achievements:', error);                 loadAchievementsFallback();             }     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.first_login', 'first_login', 'js_string', 'ievementsFallback() {             const achievements = [                 {                     id: 'first_login',                     title: 'Первые шаги',                     description: 'Войти в иг')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.первые_шаги', 'Первые шаги', 'js_string', 'hievements = [                 {                     id: 'first_login',                     title: 'Первые шаги',                     description: 'Войти в игру впервые',                     icon: '🎮'')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.войти_в_игру', 'Войти в игру впервые', 'js_string', 'id: 'first_login',                     title: 'Первые шаги',                     description: 'Войти в игру впервые',                     icon: '🎮',                     progress: userData ? 1 : 0,')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.pro_user', 'pro_user', 'js_string', 'ss: 1,                     reward: 50                 },                 {                     id: 'pro_user',                     title: 'Pro игрок',                     description: 'Купить Pro стат')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.pro_игрок', 'Pro игрок', 'js_string', '},                 {                     id: 'pro_user',                     title: 'Pro игрок',                     description: 'Купить Pro статус',                     icon: '💎',')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.купить_pro_статус', 'Купить Pro статус', 'js_string', 'ton class="button button-primary" onclick="buyPro()" data-i18n="buttons.buy_pro">                 💎 Купить Pro статус             </button>             <button class="button button-secondary" onclick=')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referral_master', 'referral_master', 'js_string', 's: 1,                     reward: 100                 },                 {                     id: 'referral_master',                     title: 'Мастер рефералов',                     description: 'П')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.мастер_рефералов', 'Мастер рефералов', 'js_string', '},                 {                     id: 'referral_master',                     title: 'Мастер рефералов',                     description: 'Пригласить 5 друзей',                     icon: '👥',')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.пригласить_5_друзей', 'Пригласить 5 друзей', 'js_string', ''referral_master',                     title: 'Мастер рефералов',                     description: 'Пригласить 5 друзей',                     icon: '👥',                     progress: Math.min(gameData')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.daily_player', 'daily_player', 'js_string', 's: 5,                     reward: 200                 },                 {                     id: 'daily_player',                     title: 'Ежедневный игрок',                     description: 'Захо')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ежедневный_игрок', 'Ежедневный игрок', 'js_string', '},                 {                     id: 'daily_player',                     title: 'Ежедневный игрок',                     description: 'Заходить в игру 7 дней подряд',                     icon: ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.заходить_в_игру', 'Заходить в игру 7 дней подряд', 'js_string', 'd: 'daily_player',                     title: 'Ежедневный игрок',                     description: 'Заходить в игру 7 дней подряд',                     icon: '📅',                     progress: Math.mi')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.элемент_playerlevel_не', 'Элемент playerLevel не найден', 'js_string', 'playerLevelElement.textContent = gameData.level;             } else {                 console.warn('Элемент playerLevel не найден');             }              if (currentXPElement) {                 ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.элемент_currentxp_не', 'Элемент currentXP не найден', 'js_string', 'currentXPElement.textContent = gameData.xp;             } else {                 console.warn('Элемент currentXP не найден');             }              if (nextLevelXPElement) {                 nextL')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.элемент_nextlevelxp_не', 'Элемент nextLevelXP не найден', 'js_string', 'nextLevelXPElement.textContent = xpForNextLevel;             } else {                 console.warn('Элемент nextLevelXP не найден');             }              if (levelProgressElement) {             ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.элемент_levelprogress_не', 'Элемент levelProgress не найден', 'js_string', 'ent.style.width = `${Math.min(progress, 100)}%`;             } else {                 console.warn('Элемент levelProgress не найден');             }              // Проверяем повышение уровня         ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.levelup', 'levelup', 'js_string', 'cation(`Поздравляем! Вы достигли ${gameData.level} уровня!`, 'success');                 playSound('levelup');             }         }          function loadGameStats() {             // Проверяем суще')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.элемент_daysplayed_не', 'Элемент daysPlayed не найден', 'js_string', 'Element.textContent = gameData.stats.daysPlayed;             } else {                 console.warn('Элемент daysPlayed не найден');             }              if (achievementsCountElement) {          ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.элемент_achievementscount_не', 'Элемент achievementsCount не найден', 'js_string', 'ment.textContent = gameData.achievements.length;             } else {                 console.warn('Элемент achievementsCount не найден');             }              if (totalEarnedElement) {         ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.элемент_totalearned_не', 'Элемент totalEarned не найден', 'js_string', 'lement.textContent = gameData.stats.totalEarned;             } else {                 console.warn('Элемент totalEarned не найден');             }              if (totalReferralsElement) {            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.элемент_totalreferrals_не', 'Элемент totalReferrals не найден', 'js_string', 'ent.textContent = gameData.stats.totalReferrals;             } else {                 console.warn('Элемент totalReferrals не найден');             }         }          function updateGameData() {    ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.lastlogin', 'lastLogin', 'js_string', 'als || 0;                                  // Увеличиваем счетчик дней в игре                 const lastLogin = localStorage.getItem('lastLogin');                 const today = new Date().toDateString')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.nodeon_game_data', 'nodeon_game_data', 'js_string', '// Загружаем сохраненные игровые данные                 const savedGameData = localStorage.getItem('nodeon_game_data');                 if (savedGameData) {                     try {                  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_загрузки_игровых', 'Ошибка загрузки игровых данных:', 'js_string', '{ ...gameData, ...parsed };                     } catch (e) {                         console.warn('Ошибка загрузки игровых данных:', e);                     }                 }                       ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.lastweeklyreset', 'lastWeeklyReset', 'js_string', '}          function checkWeeklyReset() {             const lastReset = localStorage.getItem('lastWeeklyReset');             const now = new Date();             const weekStart = new Date(now.setDate(n')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.nodeon_daily_rewards', 'nodeon_daily_rewards', 'js_string', 'localStorage.setItem('lastWeeklyReset', weekStartString);                 localStorage.setItem('nodeon_daily_rewards', JSON.stringify([]));                 console.log('🔄 Ежедневные награды сброшены -')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_загрузки_сохраненных', 'Ошибка загрузки сохраненных наград:', 'js_string', 'd);                     }                 }             } catch (e) {                 console.warn('Ошибка загрузки сохраненных наград:', e);                 gameData.dailyRewards = [];             } ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_сохранения_наград', 'Ошибка сохранения наград:', 'js_string', 'аграды сохранены:', gameData.dailyRewards);             } catch (e) {                 console.warn('Ошибка сохранения наград:', e);             }         }          function initializeGameData() {    ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.данные_пользователя_не', 'Данные пользователя не загружены. Перезагрузите страницу.', 'js_string', 'console.error('❌ Данные пользователя не загружены!');                 showNotification('Данные пользователя не загружены. Перезагрузите страницу.', 'error');                 return;             }     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_подключения_к', 'Ошибка подключения к базе данных. Обратитесь к администратору.', 'js_string', 'console.error('❌ Ошибка проверки таблиц БД');                     showNotification('Ошибка подключения к базе данных. Обратитесь к администратору.', 'error');                     return;              ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.таблица_майнера_не', 'Таблица майнера не создана. Обратитесь к администратору.', 'js_string', 'console.error('❌ Таблица nodeon_miner_data не существует');                     showNotification('Таблица майнера не создана. Обратитесь к администратору.', 'error');                     return;      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_проверки_базы', 'Ошибка проверки базы данных.', 'js_string', 'console.error('❌ Ошибка проверки таблиц:', error);                 showNotification('Ошибка проверки базы данных.', 'error');                 return;             }                          // Валидаци')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.last_known_time', 'last_known_time', 'js_string', 'const currentTime = Date.now();             const lastKnownTime = parseInt(localStorage.getItem('last_known_time') || currentTime.toString());             const timeDiff = Math.abs(currentTime - lastK')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.обнаружено_изменение_времени', 'Обнаружено изменение времени системы. Данные могут быть сброшены.', 'js_string', 'console.warn('⚠️ Подозрительное изменение времени системы');                 showNotification('Обнаружено изменение времени системы. Данные могут быть сброшены.', 'warning');             }            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.nodeon_miner_data', 'nodeon_miner_data', 'js_string', 'return;                 }                                  if (!tablesResult.tables.nodeon_miner_data) {                     console.error('❌ Таблица nodeon_miner_data не существует');')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_загрузки_локальных', 'Ошибка загрузки локальных данных майнера:', 'js_string', 'нные:', minerData);                         } catch (e) {                             console.warn('Ошибка загрузки локальных данных майнера:', e);                             // Если и локальные данн')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.элементы_майнера', 'Элементы майнера:', 'js_string', 'const gasPerSecond = document.getElementById('gasPerSecond');                          console.log('Элементы майнера:', {                 gasBalance: !!gasBalance,                 energyLevel: !!energ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gasbalancetextcontent', ', gasBalance.textContent,', 'js_string', 'ontent = Math.floor(gasValue).toLocaleString();                 console.log('✅ Gas баланс обновлен:', gasBalance.textContent, 'из данных:', gasValue);             } else {                 console.erro')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.готово', 'Готово!', 'js_string', 'if (timeUntilNextEvent <= 0) {                 nextEventElement.textContent = 'Готово!';                 return;             }                          const hours = Math.floor(timeUntil')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.farmicon', 'farm-icon', 'js_string', 'sform: translateY(-2px);             box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);         }          .farm-icon {             font-size: 32px;             margin-bottom: 10px;         }          .farm-n')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.farmname', 'farm-name', 'js_string', '.farm-icon {             font-size: 32px;             margin-bottom: 10px;         }          .farm-name {             font-weight: 600;             margin-bottom: 5px;             color: #000000;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.farmdescription', 'farm-description', 'js_string', 'font-weight: 600;             margin-bottom: 5px;             color: #000000;         }          .farm-description {             font-size: 14px;             opacity: 0.8;             margin-bottom: 1')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.farmstats', 'farm-stats', 'js_string', 'opacity: 0.8;             margin-bottom: 10px;             color: #333333;         }          .farm-stats {             display: flex;             justify-content: space-between;             margin-bo')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerfarmsgas_per_min', 'miner.farms.gas_per_min', 'js_string', '/div>                         <div class="farm-stats">                             <span data-i18n="miner.farms.gas_per_min">Gas/мин</span>: ${farm.baseGasPerMinute}                             <span ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerfarmsenergy_cost', 'miner.farms.energy_cost', 'js_string', '.gas_per_min">Gas/мин</span>: ${farm.baseGasPerMinute}                             <span data-i18n="miner.farms.energy_cost">Энергия</span>: ${farm.energyCost}                         </div>          ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerfarmsquantity', 'miner.farms.quantity', 'js_string', '/div>                         <div class="farm-stats">                             <span data-i18n="miner.farms.quantity">Количество</span>: ${farmCount}                             <span data-i18n="m')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerfarmscost', 'miner.farms.cost', 'js_string', '"miner.farms.quantity">Количество</span>: ${farmCount}                             <span data-i18n="miner.farms.cost">Стоимость</span>: ${farm.baseCost} Gas                         </div>             ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.farmbutton', 'farm-button', 'js_string', 'margin-bottom: 10px;             font-size: 12px;             color: #333333;         }          .farm-button {             background: linear-gradient(135deg, #667eea, #764ba2);             color: wh')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.disabled', 'disabled', 'js_string', 'box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);         }                  .boost-button:disabled, .special-miner-button:disabled {             opacity: 0.5;             cursor: not-allowed;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.купить', 'Купить', 'js_string', 'ton class="button button-primary" onclick="buyPro()" data-i18n="buttons.buy_pro">                 💎 Купить Pro статус             </button>             <button class="button button-secondary" onclick=')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.недостаточно_gas', 'Недостаточно Gas', 'js_string', 'sabled' : ''}>                             ${!canUnlock ? 'Заблокировано' : canAfford ? 'Купить' : 'Недостаточно Gas'}                         </button>                     </div>                 `;  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.данные_майнера_не', 'Данные майнера не загружены!', 'js_string', '{                 console.error('❌ Данные майнера не загружены');                 showNotification('Данные майнера не загружены!', 'error');                 return;             }                      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.currentgas', ', currentGas,', 'js_string', 'const currentGas = minerData.ndnGas || 0;             console.log('💰 Текущий Gas:', currentGas, 'Стоимость фермы:', farm.baseCost);                          if (currentGas < farm.baseCost) {')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.purchased', 'purchased', 'js_string', 'x);             }         }                  /* Анимация для ферм при покупке */         .farm-item.purchased {             animation: purchasePulse 0.6s ease-out;         }                  @keyframe')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.фермы', 'Фермы:', 'js_string', 'console.log('🔄 Пересчитываем генерацию Gas...');             console.log('Фермы:', minerData.farms);             console.log('Улучшения:', minerData.upgrades);             console.')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.улучшения', 'Улучшения:', 'js_string', 'ем генерацию Gas...');             console.log('Фермы:', minerData.farms);             console.log('Улучшения:', minerData.upgrades);             console.log('Активные бусты:', activeBoosts);         ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.активные_бусты', 'Активные бусты:', 'js_string', 'nerData.farms);             console.log('Улучшения:', minerData.upgrades);             console.log('Активные бусты:', activeBoosts);             console.log('Особые майнеры:', activeSpecialMiners);')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.особые_майнеры', 'Особые майнеры:', 'js_string', 'rData.upgrades);             console.log('Активные бусты:', activeBoosts);             console.log('Особые майнеры:', activeSpecialMiners);                          // Обычные фермы             minerD')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerdatagasperminute', ', minerData.gasPerMinute,', 'js_string', 'нергии: ${totalEnergy}`);             }                          console.log('📊 Итоговая генерация:', minerData.gasPerMinute, 'Gas/мин');         }          function startMiningLoop() {             //')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.начальная_генерация', 'Начальная генерация:', 'js_string', 'e();                          console.log('🚀 Запускаем цикл майнинга...');             console.log('Начальная генерация:', minerData.gasPerMinute, 'Gas/мин');                          let lastSaveTime')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.free_gas', 'free_gas', 'js_string', 'n: 'Пришельцы поделились своими технологиями!',                 icon: '👽',                 effect: 'free_gas',                 duration: 0,                 message: 'Получено 1000 Gas от инопланетян!'')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.all_boost', 'all_boost', 'js_string', 'нг Bitcoin, все майнеры стали работать лучше!',                 icon: '₿',                 effect: 'all_boost',                 duration: 60000, // 1 минута                 message: 'Все майнеры работ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.energy_drain', 'energy_drain', 'js_string', 'объявили забастовку и требуют больше энергии!',                 icon: '✊',                 effect: 'energy_drain',                 duration: 20000, // 20 секунд                 message: 'Майнеры не ра')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.efficiency_boost', 'efficiency_boost', 'js_string', 'вер, но почему-то улучшил производительность!',                 icon: '☕',                 effect: 'efficiency_boost',                 duration: 45000, // 45 секунд                 message: 'Потреблен')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.div', 'div', 'js_string', 'n: relative;             color: #ffffff;             flex-shrink: 0;         }          .reward-day div {             color: #ffffff;         }          .reward-day.claimed {             background: l')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.funnynotification', 'funny-notification', 'js_string', 'transform: translateX(100%);                 opacity: 0;             }         }                  .funny-notification-content {             display: flex;             align-items: center;             ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.funnynotificationcontent', 'funny-notification-content', 'js_string', 'transform: translateX(100%);                 opacity: 0;             }         }                  .funny-notification-content {             display: flex;             align-items: center;             ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.funnyicon', 'funny-icon', 'js_string', 'display: flex;             align-items: center;             gap: 10px;         }                  .funny-icon {             font-size: 24px;             animation: bounce 1s infinite;         }')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.funnytext', 'funny-text', 'js_string', 'font-size: 24px;             animation: bounce 1s infinite;         }                  .funny-text {             flex: 1;         }                  .funny-title {             font-weight: bold;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.funnytitle', 'funny-title', 'js_string', 'infinite;         }                  .funny-text {             flex: 1;         }                  .funny-title {             font-weight: bold;             font-size: 14px;             margin-bottom:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.funnydescription', 'funny-description', 'js_string', 'ght: bold;             font-size: 14px;             margin-bottom: 4px;         }                  .funny-description {             font-size: 12px;             opacity: 0.9;             margin-bottom')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.funnymessage', 'funny-message', 'js_string', 't-size: 12px;             opacity: 0.9;             margin-bottom: 4px;         }                  .funny-message {             font-size: 11px;             opacity: 0.8;             font-style: itali')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.slideoutright_05s_easein', 'slideOutRight 0.5s ease-in', 'js_string', 'аляем через 5 секунд             setTimeout(() => {                 notification.style.animation = 'slideOutRight 0.5s ease-in';                 setTimeout(() => {                     if (notification')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.achievementnotification', 'achievement-notification', 'js_string', 'const notification = document.createElement('div');             notification.className = 'achievement-notification';             notification.innerHTML = `                 <div class="achievement-cont')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.achievementcontent', 'achievement-content', 'js_string', 'me = 'achievement-notification';             notification.innerHTML = `                 <div class="achievement-content">                     <div class="achievement-icon">${achievement.icon}</div>   ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.achievementtext', 'achievement-text', 'js_string', '<div class="achievement-icon">${achievement.icon}</div>                     <div class="achievement-text">                         <div class="achievement-title">🏆 ДОСТИЖЕНИЕ!</div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.achievementname', 'achievement-name', 'js_string', 'er;         }                  .achievement-info {             flex: 1;         }                  .achievement-name {             font-weight: 600;             color: var(--tg-theme-text-color, #ffff')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.achievementreward', 'achievement-reward', 'js_string', ', #cccccc);             min-width: 60px;             text-align: right;         }                  .achievement-reward {             display: flex;             align-items: center;             gap: 1r')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.slideoutleft_05s_easein', 'slideOutLeft 0.5s ease-in', 'js_string', 'аляем через 6 секунд             setTimeout(() => {                 notification.style.animation = 'slideOutLeft 0.5s ease-in';                 setTimeout(() => {                     if (notification.')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.info', 'info', 'js_string', 'icon {             font-size: 24px;             margin-right: 12px;         }          .achievement-info {             flex: 1;         }          .achievement-title {             font-weight: 600;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.background_white_padding', 'background: white; padding: 20px; border-radius: 10px; text-align: center; max-width: 400px;', 'js_string', 'x: 10000;             `;                          adModal.innerHTML = `                 <div style="background: white; padding: 20px; border-radius: 10px; text-align: center; max-width: 400px;">      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.position_fixed', 'position: fixed', 'js_string', 'n: relative;         }          /* Анимированный фон */         .background-animation {             position: fixed;             top: 0;             left: 0;             width: 100%;             heigh')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.квест_еще_не', 'Квест еще не выполнен!', 'js_string', 'turn;                          if (!quest.condition(minerData)) {                 showNotification('Квест еще не выполнен!', 'error');                 return;             }                          //')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.style', 'style', 'js_string', '- Крипто Игра</title>     <script src="https://telegram.org/js/telegram-web-app.js"></script>     <style>         * {             margin: 0;             padding: 0;             box-sizing: border-box;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.unlocked', 'unlocked', 'js_string', 'a.consecutiveEvents >= 3,                 reward: 300             }         ];                  let unlockedAchievements = JSON.parse(localStorage.getItem('miner_achievements') || '[]');              ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.upgradeinfo', 'upgrade-info', 'js_string', 'nt: space-between;             align-items: center;             color: #000000;         }          .upgrade-info {             flex: 1;         }          .upgrade-name {             font-weight: 600;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.upgradename', 'upgrade-name', 'js_string', 'color: #000000;         }          .upgrade-info {             flex: 1;         }          .upgrade-name {             font-weight: 600;             margin-bottom: 5px;             color: #000000;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.upgradedescription', 'upgrade-description', 'js_string', 'font-weight: 600;             margin-bottom: 5px;             color: #000000;         }          .upgrade-description {             font-size: 12px;             opacity: 0.8;             margin-bottom')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.upgradecost', 'upgrade-cost', 'js_string', 'opacity: 0.8;             margin-bottom: 5px;             color: #333333;         }          .upgrade-cost {             font-size: 12px;             font-weight: bold;             color: #667eea;    ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.upgradebutton', 'upgrade-button', 'js_string', 'font-size: 12px;             font-weight: bold;             color: #667eea;         }          .upgrade-button {             background: linear-gradient(135deg, #667eea, #764ba2);             color: w')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.куплено', 'Куплено', 'js_string', 'nAfford || isUnlocked || isMaxLevel ? 'disabled' : ''}>                             ${isUnlocked ? 'Куплено' : isMaxLevel ? 'Макс. уровень' : canAfford ? 'Купить' : 'Недостаточно Gas'}')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.макс_уровень', 'Макс. уровень', 'js_string', 'isMaxLevel ? 'disabled' : ''}>                             ${isUnlocked ? 'Куплено' : isMaxLevel ? 'Макс. уровень' : canAfford ? 'Купить' : 'Недостаточно Gas'}                         </button>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.недостаточно_ndn_gas', 'Недостаточно NDN Gas!', 'js_string', 'Cost);                          if (currentGas < farm.baseCost) {                 showNotification(`Недостаточно NDN Gas! Нужно: ${farm.baseCost}, есть: ${Math.floor(currentGas)}`, 'error');          ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerfarms_minerupgrades_minerboosts', '.miner-farms, .miner-upgrades, .miner-boosts, .miner-special, .miner-quests, .miner-shop, .miner-leaderboard', 'js_string', 'witchMinerTab(tabName) {             // Скрываем все разделы             document.querySelectorAll('.miner-farms, .miner-upgrades, .miner-boosts, .miner-special, .miner-quests, .miner-shop, .miner-lea')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.none', 'none', 'js_string', 'flex: 1;             padding: 12px 16px;             background: transparent;             border: none;             color: rgba(255, 255, 255, 0.7);             font-size: 16px;             font-weigh')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.farms', 'farms', 'js_string', 'll-info span {             font-weight: bold;             color: #ff6b6b;         }          .miner-farms, .miner-upgrades, .miner-shop {             background: linear-gradient(135deg, rgba(255, 255,')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.block', 'block', 'js_string', 'animation: fadeIn 0.3s ease-in-out;         }          .tab-content.active {             display: block;         }          @keyframes fadeIn {             from { opacity: 0; transform: translateY(10p')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.upgrades', 'upgrades', 'js_string', 'font-weight: bold;             color: #ff6b6b;         }          .miner-farms, .miner-upgrades, .miner-shop {             background: linear-gradient(135deg, rgba(255, 255, 255, 0.1), rgba(255,')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.boosts', 'boosts', 'js_string', 'm: scale(1);             }         }                  /* Стили для новых разделов */         .miner-boosts, .miner-special, .miner-quests {             margin-bottom: 20px;         }                  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.special', 'special', 'js_string', '}         }                  /* Стили для новых разделов */         .miner-boosts, .miner-special, .miner-quests {             margin-bottom: 20px;         }                  .boosts-grid, .special')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.quests', 'quests', 'js_string', '}                  /* Стили для новых разделов */         .miner-boosts, .miner-special, .miner-quests {             margin-bottom: 20px;         }                  .boosts-grid, .special-miners-grid ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shop', 'shop', 'js_string', '-weight: bold;             color: #ff6b6b;         }          .miner-farms, .miner-upgrades, .miner-shop {             background: linear-gradient(135deg, rgba(255, 255, 255, 0.1), rgba(255, 255, 255,')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.leaderboard', 'leaderboard', 'js_string', 'shadow: 0 4px 10px rgba(255, 215, 0, 0.3);         }          /* Рейтинг майнеров */         .miner-leaderboard {             background: linear-gradient(135deg, rgba(255, 255, 255, 0.1), rgba(255, 25')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.boostitem', 'boost-item', 'js_string', 'nmax(250px, 1fr));             gap: 15px;             margin-top: 15px;         }                  .boost-item, .special-miner-item {             background: linear-gradient(135deg, rgba(255, 255, 255')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.boosticon', 'boost-icon', 'js_string', 'teY(-2px);             box-shadow: 0 4px 15px rgba(255, 255, 255, 0.1);         }                  .boost-icon, .special-miner-icon {             font-size: 32px;             margin-bottom: 10px;     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.boostname', 'boost-name', 'js_string', 'er-icon {             font-size: 32px;             margin-bottom: 10px;         }                  .boost-name, .special-miner-name {             font-size: 16px;             font-weight: bold;       ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.boostdescription', 'boost-description', 'js_string', '-weight: bold;             margin-bottom: 8px;             color: #fff;         }                  .boost-description, .special-miner-description {             font-size: 12px;             color: rgba')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.boostcost', 'boost-cost', 'js_string', 'color: rgba(255, 255, 255, 0.8);             margin-bottom: 10px;         }                  .boost-cost, .special-miner-cost {             font-size: 14px;             font-weight: bold;             ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.активен', 'Активен', 'js_string', '${isActive ? 'disabled' : ''}>                             ${isActive ? 'Активен' : canAfford ? 'Активировать' : 'Недостаточно Gas'}                         </button>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.активировать', 'Активировать', 'js_string', '${isActive ? 'disabled' : ''}>                             ${isActive ? 'Активен' : canAfford ? 'Активировать' : 'Недостаточно Gas'}                         </button>                     </div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.specialmineritem', 'special-miner-item', 'js_string', 'fr));             gap: 15px;             margin-top: 15px;         }                  .boost-item, .special-miner-item {             background: linear-gradient(135deg, rgba(255, 255, 255, 0.1), rgba(')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.specialminericon', 'special-miner-icon', 'js_string', 'box-shadow: 0 4px 15px rgba(255, 255, 255, 0.1);         }                  .boost-icon, .special-miner-icon {             font-size: 32px;             margin-bottom: 10px;         }                  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.specialminername', 'special-miner-name', 'js_string', 'font-size: 32px;             margin-bottom: 10px;         }                  .boost-name, .special-miner-name {             font-size: 16px;             font-weight: bold;             margin-bottom: 8')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.specialminerdescription', 'special-miner-description', 'js_string', 'margin-bottom: 8px;             color: #fff;         }                  .boost-description, .special-miner-description {             font-size: 12px;             color: rgba(255, 255, 255, 0.8);      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.specialminercost', 'special-miner-cost', 'js_string', 'rgba(255, 255, 255, 0.8);             margin-bottom: 10px;         }                  .boost-cost, .special-miner-cost {             font-size: 14px;             font-weight: bold;             color: ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.смотреть_рекламу', 'Смотреть рекламу', 'js_string', '${isActive ? 'disabled' : ''}>                             ${isActive ? 'Активен' : canAfford ? 'Смотреть рекламу' : 'Недостаточно Gas'}                         </button>                     </div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.questicon', 'quest-icon', 'js_string', 'a(76, 175, 80, 0.1));             border-color: rgba(76, 175, 80, 0.5);         }                  .quest-icon {             font-size: 24px;         }                  .quest-info {             flex:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.questinfo', 'quest-info', 'js_string', ';         }                  .quest-icon {             font-size: 24px;         }                  .quest-info {             flex: 1;         }                  .quest-name {             font-size: 14')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.questname', 'quest-name', 'js_string', 'ze: 24px;         }                  .quest-info {             flex: 1;         }                  .quest-name {             font-size: 14px;             font-weight: bold;             color: #fff;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.questdescription', 'quest-description', 'js_string', '-weight: bold;             color: #fff;             margin-bottom: 4px;         }                  .quest-description {             font-size: 12px;             color: rgba(255, 255, 255, 0.8);       ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.questreward', 'quest-reward', 'js_string', 'color: rgba(255, 255, 255, 0.8);             margin-bottom: 8px;         }                  .quest-reward {             font-size: 11px;             color: #ffd700;         }                  .quest-p')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.questprogress', 'quest-progress', 'js_string', 'quest-reward {             font-size: 11px;             color: #ffd700;         }                  .quest-progress {             font-size: 12px;             color: #4caf50;             font-weight: b')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.в_процессе', 'В процессе...', 'js_string', '${!isCompleted ? `<div class="quest-progress">${quest.condition(minerData) ? 'Готово!' : 'В процессе...'}</div>` : ''}                         </div>                         <button class="quest-butto')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.questbutton', 'quest-button', 'js_string', '-size: 12px;             color: #4caf50;             font-weight: bold;         }                  .quest-button {             background: linear-gradient(135deg, #4caf50 0%, #45a049 100%);           ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.выполнено', 'Выполнено', 'js_string', '${!canComplete ? 'disabled' : ''}>                             ${isCompleted ? 'Выполнено' : canComplete ? 'Получить награду' : 'В процессе'}                         </button>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.получить_награду', 'Получить награду', 'js_string', 'mplete ? 'disabled' : ''}>                             ${isCompleted ? 'Выполнено' : canComplete ? 'Получить награду' : 'В процессе'}                         </button>                     </div>      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.энергетический_напиток', 'Энергетический напиток', 'js_string', ') return;                          const shopItems = [                 {                     name: 'Энергетический напиток',                     icon: '⚡',                     description: 'Восстанавл')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.cost_25_currency', ',
                    cost: 25,
                    currency:', 'js_string', 'питок',                     icon: '⚡',                     description: 'Восстанавливает 50 энергии',                     cost: 25,                     currency: 'Gas',                     action: 're')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.action', ',
                    action:', 'js_string', 'ion: 'Восстанавливает 50 энергии',                     cost: 25,                     currency: 'Gas',                     action: 'restoreEnergy'                 },                 {                  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.премиум_ускоритель', 'Премиум ускоритель', 'js_string', 'action: 'restoreEnergy'                 },                 {                     name: 'Премиум ускоритель',                     icon: '🚀',                     description: '2x скорость на 1 час',')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.cost_100_currency', ',
                    cost: 100,
                    currency:', 'js_string', 'ускоритель',                     icon: '🚀',                     description: '2x скорость на 1 час',                     cost: 100,                     currency: 'NDN',                     action: 'sp')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.золотая_ферма', 'Золотая ферма', 'js_string', ',                     premium: true                 },                 {                     name: 'Золотая ферма',                     icon: '🏆',                     description: 'Эксклюзивная ферма'')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.cost_500_currency', ',
                    cost: 500,
                    currency:', 'js_string', 'Золотая ферма',                     icon: '🏆',                     description: 'Эксклюзивная ферма',                     cost: 500,                     currency: 'NDN',                     action: 'g')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopicon', 'shop-icon', 'js_string', 'ound: linear-gradient(135deg, rgba(255, 215, 0, 0.1), rgba(255, 215, 0, 0.05));         }          .shop-icon {             font-size: 32px;             margin-bottom: 10px;         }          .shop-n')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopcost', 'shop-cost', 'js_string', 'opacity: 0.8;             margin-bottom: 10px;             color: #333333;         }          .shop-cost {             font-size: 14px;             font-weight: bold;             margin-bottom: 10px;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gas', 'Gas', 'js_string', 'at-info">                         <div class="miner-stat-label" data-i18n="miner.stats.ndn_gas">NDN Gas</div>                         <div class="miner-stat-value" id="ndnGasBalance">100</div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ndn', 'NDN', 'js_string', 'translateY(-1px);             box-shadow: 0 4px 15px rgba(255, 215, 0, 0.4);         }          /* NDN Miner стили */         .miner-stats {             display: grid;             grid-template-column')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.недостаточно_ndn', 'Недостаточно NDN!', 'js_string', 'rrency === 'NDN' && (!userData || userData.balance_ndn < cost)) {                 showNotification('Недостаточно NDN!', 'error');                 return;             }                          // Выпо')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.restoreenergy', 'restoreEnergy', 'js_string', 'и',                     cost: 25,                     currency: 'Gas',                     action: 'restoreEnergy'                 },                 {                     name: 'Премиум ускоритель',')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.энергия_восстановлена', 'Энергия восстановлена!', 'js_string', 'a.energy + 50);                     minerData.ndnGas -= cost;                     showNotification('Энергия восстановлена!', 'success');                     break;                 case 'speedBoost':  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.speedboost', 'speedBoost', 'js_string', '',                     cost: 100,                     currency: 'NDN',                     action: 'speedBoost',                     premium: true                 },                 {                 ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ускоритель_активирован', 'Ускоритель активирован!', 'js_string', 'ost':                     // TODO: Реализовать временный буст                     showNotification('Ускоритель активирован!', 'success');                     break;                 case 'goldenFarm': ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.goldenfarm', 'goldenFarm', 'js_string', '',                     cost: 500,                     currency: 'NDN',                     action: 'goldenFarm',                     premium: true                 }             ];                     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.золотая_ферма_добавлена', 'Золотая ферма добавлена!', 'js_string', 'Farm':                     // TODO: Реализовать золотую ферму                     showNotification('Золотая ферма добавлена!', 'success');                     break;             }                     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_сохранения_данных', 'Ошибка сохранения данных майнера:', 'js_string', 'on_miner_data', JSON.stringify(minerData));             } catch (e) {                 console.warn('Ошибка сохранения данных майнера:', e);             }         }          async function saveMinerDat')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.suspicious', 'Suspicious', 'js_string', 'рвер отклонил данные, загружаем актуальные с сервера                     if (result.error.includes('Suspicious')) {                         showNotification('Обнаружено подозрительное поведение. Данны')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.обнаружено_подозрительное_поведение', 'Обнаружено подозрительное поведение. Данные сброшены.', 'js_string', 'if (result.error.includes('Suspicious')) {                         showNotification('Обнаружено подозрительное поведение. Данные сброшены.', 'error');                         await initializeMinerData')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_сохранения_gas', 'Ошибка сохранения Gas:', 'js_string', 'ole.log('✅ Gas сохранен на сервере');                 } else {                     console.error('❌ Ошибка сохранения Gas:', result.error);                     // Если сервер отклонил данные, загружае')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minersyncwaiting', 'miner.sync.waiting', 'js_string', 'syncButton.disabled = true;                 syncButton.innerHTML = '⏳ <span data-i18n="miner.sync.waiting">Синхронизация...</span>';                 console.log('🔒 Кнопка заблокирована');             ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.get', 'GET', 'js_string', 'ait fetch(`/api/miner/data/${userData.telegram_id}?t=${Date.now()}`, {                     method: 'GET',                     headers: {                         'Cache-Control': 'no-cache, no-store, m')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.cachecontrol', 'Cache-Control', 'js_string', 'w()}`, {                     method: 'GET',                     headers: {                         'Cache-Control': 'no-cache, no-store, must-revalidate',                         'Pragma': 'no-cache',')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.nocache_nostore_mustrevalidate', 'no-cache, no-store, must-revalidate', 'js_string', 'method: 'GET',                     headers: {                         'Cache-Control': 'no-cache, no-store, must-revalidate',                         'Pragma': 'no-cache',                         'Exp')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.pragma', 'Pragma', 'js_string', ''Cache-Control': 'no-cache, no-store, must-revalidate',                         'Pragma': 'no-cache',                         'Expires': '0'                     }                 });')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.nocache', 'no-cache', 'js_string', 'method: 'GET',                     headers: {                         'Cache-Control': 'no-cache, no-store, must-revalidate',                         'Pragma': 'no-cache',')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.expires', 'Expires', 'js_string', 'no-store, must-revalidate',                         'Pragma': 'no-cache',                         'Expires': '0'                     }                 });                                  console.log(')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.данные_синхронизированы_с', 'Данные синхронизированы с сервером', 'js_string', 'updateMinerUI();                     loadFarms();                     console.log('✅ Данные синхронизированы с сервером');                     showNotification('Данные синхронизированы с сервером', 's')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_синхронизации_данных', 'Ошибка синхронизации данных', 'js_string', 'console.error('❌ Ошибка синхронизации:', result.error);                     showNotification('Ошибка синхронизации данных', 'error');                 }             } catch (error) {                 co')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_синхронизации', 'Ошибка синхронизации', 'js_string', 'ронизированы с сервером', 'success');                 } else {                     console.error('❌ Ошибка синхронизации:', result.error);                     showNotification('Ошибка синхронизации да')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.cryptoking', 'CryptoKing', 'js_string', 'ковые данные для рейтинга             const leaderboardData = [                 { rank: 1, player: "CryptoKing", gasEarned: 15420, farms: 8, level: 12 },                 { rank: 2, player: "MiningMast')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.miningmaster', 'MiningMaster', 'js_string', 'player: "CryptoKing", gasEarned: 15420, farms: 8, level: 12 },                 { rank: 2, player: "MiningMaster", gasEarned: 12850, farms: 6, level: 10 },                 { rank: 3, player: "NDNHunter')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ndnhunter', 'NDNHunter', 'js_string', 'layer: "MiningMaster", gasEarned: 12850, farms: 6, level: 10 },                 { rank: 3, player: "NDNHunter", gasEarned: 9870, farms: 5, level: 8 },                 { rank: 4, player: "GasCollector"')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.gascollector', 'GasCollector', 'js_string', '3, player: "NDNHunter", gasEarned: 9870, farms: 5, level: 8 },                 { rank: 4, player: "GasCollector", gasEarned: 7650, farms: 4, level: 7 },                 { rank: 5, player: "BlockMiner"')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.blockminer', 'BlockMiner', 'js_string', 'player: "GasCollector", gasEarned: 7650, farms: 4, level: 7 },                 { rank: 5, player: "BlockMiner", gasEarned: 5430, farms: 3, level: 6 },                 { rank: 6, player: userData?.firs')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerleaderboardrank', 'miner.leaderboard.rank', 'js_string', '<thead>                         <tr>                             <th data-i18n="miner.leaderboard.rank">Место</th>                             <th data-i18n="miner.leaderboard.player">Игрок</th>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerleaderboardplayer', 'miner.leaderboard.player', 'js_string', '<th data-i18n="miner.leaderboard.rank">Место</th>                             <th data-i18n="miner.leaderboard.player">Игрок</th>                             <th data-i18n="miner.leaderboard.gas_earne')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerleaderboardgas_earned', 'miner.leaderboard.gas_earned', 'js_string', '<th data-i18n="miner.leaderboard.player">Игрок</th>                             <th data-i18n="miner.leaderboard.gas_earned">Gas заработано</th>                             <th data-i18n="miner.leader')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerleaderboardfarms_count', 'miner.leaderboard.farms_count', 'js_string', '-i18n="miner.leaderboard.gas_earned">Gas заработано</th>                             <th data-i18n="miner.leaderboard.farms_count">Ферм</th>                             <th data-i18n="miner.leaderboar')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerleaderboardlevel', 'miner.leaderboard.level', 'js_string', '<th data-i18n="miner.leaderboard.farms_count">Ферм</th>                             <th data-i18n="miner.leaderboard.level">Уровень</th>                         </tr>                     </thead>     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.you', 'you', 'js_string', 'aderboard-table .player-name {             font-weight: 500;         }          .leaderboard-table .you {             background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.rank', 'rank', 'js_string', 'r:hover {             background: rgba(255, 255, 255, 0.05);         }          .leaderboard-table .rank {             font-weight: bold;             color: #667eea;         }          .leaderboard-ta')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.playername', 'player-name', 'js_string', '{             font-weight: bold;             color: #667eea;         }          .leaderboard-table .player-name {             font-weight: 500;         }          .leaderboard-table .you {            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.timesincelastrefill', ', timeSinceLastRefill,', 'js_string', 'ta.lastEnergyRefill || now);                          console.log('⏰ Время с последнего пополнения:', timeSinceLastRefill, 'мс');             console.log('⏰ Кулдаун:', minerData.energyRefillCooldown, ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerdataenergyrefillcooldown', ', minerData.energyRefillCooldown,', 'js_string', ''⏰ Время с последнего пополнения:', timeSinceLastRefill, 'мс');             console.log('⏰ Кулдаун:', minerData.energyRefillCooldown, 'мс');                          if (timeSinceLastRefill >= (minerD')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.minerenergywaiting', 'miner.energy.waiting', 'js_string', 'se {                 button.disabled = true;                 button.innerHTML = '⏰ <span data-i18n="miner.energy.waiting">Ожидание...</span>';                 info.style.display = 'block';')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.notificationcontent', 'notification-content', 'js_string', 'ation.info {             background: linear-gradient(135deg, #2196F3, #1976D2);         }          .notification-content {             display: flex;             align-items: center;             gap: ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.notificationicon', 'notification-icon', 'js_string', 'display: flex;             align-items: center;             gap: 10px;         }          .notification-icon {             font-size: 20px;         }          .notification-text {             flex: 1;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.notificationtext', 'notification-text', 'js_string', 'gap: 10px;         }          .notification-icon {             font-size: 20px;         }          .notification-text {             flex: 1;             font-weight: 500;         }          .notificat')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.notificationclose', 'notification-close', 'js_string', '.notification-text {             flex: 1;             font-weight: 500;         }          .notification-close {             background: none;             border: none;             color: white;      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.show', 'show', 'js_string', 'max-width: 300px;             backdrop-filter: blur(10px);         }          .notification.show {             transform: translateX(0);         }          .notification.success {             back')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.notification', '.notification', 'js_string', 'font-weight: bold;             color: #fff;         }          /* Система уведомлений */         .notification {             position: fixed;             top: 20px;             right: 20px;           ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.выполните_первое_достижение', 'Выполните первое достижение - войдите в игру!', 'js_string', 'condition: userData ? 1 : 0,                     required: 1,                     message: 'Выполните первое достижение - войдите в игру!'                 },                 {                     id: ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.купите_pro_статус', 'Купите Pro статус и получите бонус!', 'js_string', 'userData && userData.is_pro ? 1 : 0,                     required: 1,                     message: 'Купите Pro статус и получите бонус!'                 },                 {                     id: 'r')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.level_up_reminder', 'level_up_reminder', 'js_string', 'if (xpNeeded <= 50 && xpNeeded > 0) {                 const reminderKey = 'level_up_reminder';                 const lastShown = localStorage.getItem(reminderKey);                 const today')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.tma', 'tma', 'js_string', ''Content-Type': 'application/json',                         'Authorization': `tma ${tg.initData || ''}`                     },                     body: JSON.stringify({')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.object', 'object', 'js_string', '}          .leader-avatar img {             width: 100%;             height: 100%;             object-fit: cover;             border-radius: 50%;         }          .leader-info {             flex: 1;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.string', 'string', 'js_string', ''Authorization': `tma ${tg.initData || ''}`                     },                     body: JSON.stringify({                         telegram_id: userData?.telegram_id,                         day: d')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.error_formatting_translation', 'Error formatting translation:', 'js_string', '] || match;                     });                 } catch (e) {                     console.warn('Error formatting translation:', e);                 }             }                          return ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.nodeon_language', 'nodeon_language', 'js_string', 'splay();                          // Сохраняем выбор пользователя             localStorage.setItem('nodeon_language', language);         }          function toggleLanguage() {             const newLan')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.currentlanguagedisplay', 'currentLanguageDisplay', 'js_string', '}          function updateLanguageDisplay() {             const display = document.getElementById('currentLanguageDisplay');             if (display) {                 display.textContent = currentLan')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.русский', 'Русский', 'js_string', 'd="languageSelect" onchange="changeLanguage(this.value)">                     <option value="ru">🇷🇺 Русский</option>                     <option value="en">🇺🇸 English</option>                     <opt')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.english', 'English', 'js_string', '<option value="ru">🇷🇺 Русский</option>                     <option value="en">🇺🇸 English</option>                     <option value="es">🇪🇸 Español</option>                     <option val')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.datai18n', 'data-i18n', 'js_string', '="container">         <!-- Заголовок -->         <div class="header">             <div class="logo" data-i18n="app.name">🚀 NodeOn Crypto</div>             <div class="subtitle" data-i18n="app.descript')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.datai18nplaceholder', 'data-i18n-placeholder', 'js_string', 'unt">Количество NDN:</label>                 <input type="number" class="form-input" id="ndnAmount" data-i18n-placeholder="transfer.amount" placeholder="Введите количество" min="1">             </div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.datai18ntitle', 'data-i18n-title', 'js_string', '});                          // Обновляем title'ы             document.querySelectorAll('[data-i18n-title]').forEach(element => {                 const key = element.getAttribute('data-i18n-title');')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.datai18nhtml', 'data-i18n-html', 'js_string', '// Обновляем innerHTML для элементов с HTML содержимым             document.querySelectorAll('[data-i18n-html]').forEach(element => {                 const key = element.getAttribute('data-i18n-html')')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.datalevel', 'data-level', 'js_string', '// Специальная обработка для элементов с данными                         if (element.hasAttribute('data-level') && element.hasAttribute('data-count')) {                             const level = eleme')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.datacount', 'data-count', 'js_string', 'в с данными                         if (element.hasAttribute('data-level') && element.hasAttribute('data-count')) {                             const level = element.getAttribute('data-level');')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.dataearnings', 'data-earnings', 'js_string', 'tContent = text.replace('{count}', count);                         } else if (element.hasAttribute('data-earnings')) {                             const earnings = element.getAttribute('data-earnings'')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.start_param', 'start_param', 'js_string', 'st urlParams = new URLSearchParams(initData);                     const startParam = urlParams.get('start_param');                     if (startParam && startParam.startsWith('ref_')) {               ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ref_', 'ref_', 'js_string', 'tParam = urlParams.get('start_param');                     if (startParam && startParam.startsWith('ref_')) {                         referralToken = startParam;                         console.log('🔗')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.error_extracting_referral', 'Error extracting referral token:', 'js_string', 'found');                 return null;             } catch (error) {                 console.error('Error extracting referral token:', error);                 return null;             }         }      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.particle', 'particle', 'js_string', '100% { background-position: 0% 50%; }         }          /* Плавающие частицы */         .particles {             position: fixed;             top: 0;             left: 0;             width: 100%;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.sparkle', 'sparkle', 'js_string', 'ard {                 padding: 20px;             }         }          /* Эффекты частиц */         .sparkle {             position: absolute;             width: 6px;             height: 6px;          ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.click', 'click', 'js_string', 'ntainer">             <div class="tabs-header">                 <button class="tab-button active" onclick="switchTab('core')" data-i18n="tabs.core">                     🏠 Основное                 </bu')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.flex', 'flex', 'js_string', 'container {             margin-bottom: 20px;         }          .tabs-header {             display: flex;             background: rgba(255, 255, 255, 0.1);             border-radius: 12px;            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.nodeon_test_user', 'nodeon_test_user', 'js_string', 'console.log('🧹 Очищаем старые данные из localStorage...');                 localStorage.removeItem('nodeon_test_user');                 localStorage.removeItem('nodeon_user_data');                    ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.nodeon_user_data', 'nodeon_user_data', 'js_string', 'localStorage.removeItem('nodeon_test_user');                 localStorage.removeItem('nodeon_user_data');                                  // Инициализация локализации                 console.log('🌐 И')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.unknown', 'unknown', 'js_string', 'm                 const initData = tg.initData;                 const isTelegram = tg.platform !== 'unknown' && tg.platform !== 'web' && initData && initData.trim() !== '';                            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.web', 'web', 'js_string', '">     <title>NodeOn Crypto - Крипто Игра</title>     <script src="https://telegram.org/js/telegram-web-app.js"></script>     <style>         * {             margin: 0;             padding: 0;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.telegram_webapp_данные', 'Telegram WebApp данные:', 'js_string', 'form !== 'web' && initData && initData.trim() !== '';                                  console.log('Telegram WebApp данные:', {                     platform: tg.platform,                     initData:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.есть', 'есть', 'js_string', '< farm.baseCost) {                 showNotification(`Недостаточно NDN Gas! Нужно: ${farm.baseCost}, есть: ${Math.floor(currentGas)}`, 'error');                 return;             }')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.нет', 'нет', 'js_string', '🚀 NodeOn Crypto</div>             <div class="subtitle" data-i18n="app.description">Крипто игра с монетами NDN</div>             <div class="language-selector">                 <select id="languageSel')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.telegram_режим_загружаем', 'Telegram режим: загружаем данные пользователя', 'js_string', '// Режим Telegram - используем реальные данные                     console.log('Telegram режим: загружаем данные пользователя');                     console.log('initData:', initData);')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.initdata', 'initData:', 'js_string', 'ole.log('Telegram WebApp данные:', {                     platform: tg.platform,                     initData: initData ? 'есть' : 'нет',                     user: tg.initDataUnsafe?.user,             ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.нет_данных_пользователя', 'Нет данных пользователя Telegram', 'js_string', 'if (!unsafeUser || !unsafeUser.id) {                             throw new Error('Нет данных пользователя Telegram');                         }                                                  // Испо')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.response_status', 'Response status:', 'js_string', 'on'                             }                         });                          console.log('Response status:', response.status);                                                  if (!response.')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.api_error', 'API Error:', 'js_string', 'const errorText = await response.text();                             console.error('API Error:', errorText);                                                          // Если пользователь не найд')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.пользователь_не_найден', 'Пользователь не найден, создаем нового...', 'js_string', 'if (response.status === 404) {                                 console.log('Пользователь не найден, создаем нового...');                                 const unsafeUser = tg.initDataUnsafe?.user;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.пользователь', 'Пользователь', 'js_string', 'if (response.status === 404) {                                 console.log('Пользователь не найден, создаем нового...');                                 const unsafeUser = tg.initDataUnsaf')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.пользователь_создан', 'Пользователь создан:', 'js_string', 'userData = createData.user;                                             console.log('Пользователь создан:', userData);                                             updateUI();')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.создание_не_удалось', 'Создание не удалось, пробуем загрузить пользователя...', 'js_string', '} else {                                             console.log('Создание не удалось, пробуем загрузить пользователя...');                                         }                                   ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.пользователь_загружен_после', 'Пользователь загружен после создания:', 'js_string', 'userData = retryData.user;                                                 console.log('Пользователь загружен после создания:', userData);                                                 updateUI();')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.получены_данные_от', 'Получены данные от API:', 'js_string', 'const responseData = await response.json();                         console.log('Получены данные от API:', responseData);                                                  if (responseData.success && r')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.неверный_формат_ответа', 'Неверный формат ответа от API', 'js_string', 'playSound('success');                         } else {                             throw new Error('Неверный формат ответа от API');                         }                     } catch (error) {    ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_загрузки_данных', 'Ошибка загрузки данных пользователя:', 'js_string', '}                                                          throw new Error(`Ошибка загрузки данных пользователя: ${response.status}`);                         }                          const response')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.используем_fallback_данные', 'Используем fallback данные из initDataUnsafe', 'js_string', 'if (unsafeUser && unsafeUser.id) {                             console.log('Используем fallback данные из initDataUnsafe');                             // Для пользователя 207940967 (NobodyYety) испол')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.developer', 'developer', 'js_string', 'color: #34495e;             font-size: 0.95rem;             font-weight: 500;         }          .developer-fee {             display: flex;             align-items: center;             margin-top: 12')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.user', 'user', 'js_string', 'weight: bold;             color: #333;             margin-bottom: 5px;         }          .referral-username {             color: #666;             font-size: 0.9rem;         }          .referral-bala')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.fallback_userdata_установлен', 'Fallback userData установлен:', 'js_string', '};                                                          console.log('Fallback userData установлен:', userData);                             updateUI();                             showNotification')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.найдены_данные_пользователя', 'Найдены данные пользователя в initDataUnsafe:', 'js_string', '?.user;                     if (unsafeUser && unsafeUser.id) {                         console.log('Найдены данные пользователя в initDataUnsafe:', unsafeUser);                                        ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.браузер_режим_создаем', 'Браузер режим: создаем тестового пользователя', 'js_string', '// Режим браузера - создаем тестового пользователя                     console.log('Браузер режим: создаем тестового пользователя');                                          // Пытаемся получить данны')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.загружены_сохраненные_данные', 'Загружены сохраненные данные пользователя', 'js_string', 'r) {                         userData = JSON.parse(savedUser);                         console.log('Загружены сохраненные данные пользователя');                     } else {                         //')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.test_user_', 'test_user_', 'js_string', 'gram_id: Math.floor(Math.random() * 1000000000) + 100000000,                             username: 'test_user_' + Math.floor(Math.random() * 1000),                             first_name: 'Тестовый',')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.тестовый', 'Тестовый', 'js_string', 'username: 'test_user_' + Math.floor(Math.random() * 1000),                             first_name: 'Тестовый',                             last_name: 'Пользователь',                             balanc')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.создан_новый_тестовый', 'Создан новый тестовый пользователь', 'js_string', 'Storage.setItem('nodeon_test_user', JSON.stringify(userData));                         console.log('Создан новый тестовый пользователь');                     }                                         ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.fallback_создаем_тестового', 'Fallback: создаем тестового пользователя', 'js_string', '// Fallback - создаем тестового пользователя                 console.log('Fallback: создаем тестового пользователя');                 userData = {                     id: 1,                     telegr')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.fallback_user', 'fallback_user', 'js_string', 'id: 1,                     telegram_id: 123456789,                     username: 'fallback_user',                     first_name: 'Пользователь',                     last_name: 'Fallback',')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.fallback', 'Fallback', 'js_string', '(error) {                 console.error('Error claiming daily reward:', error);                 // Fallback - добавляем награду локально                 const rewards = { 1: 2, 2: 4, 3: 6, 4: 10, 5: 1')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ref_fallback', 'ref_fallback', 'js_string', 'N покупается только за Stars                     is_pro: false,                     referral_link: 'ref_fallback'                 };                 updateUI();                 showNotification('Загру')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.загружены_базовые_данные', 'Загружены базовые данные пользователя', 'js_string', 'nk: 'ref_fallback'                 };                 updateUI();                 showNotification('Загружены базовые данные пользователя', 'warning');                 playSound('success');           ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.updateui_вызвана_userdata', 'updateUI вызвана, userData:', 'js_string', '}         }          // Обновление UI         function updateUI() {             console.log('updateUI вызвана, userData:', userData);             if (userData) {                 console.log('Обновляем')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.обновляем_ui_с', 'Обновляем UI с данными:', 'js_string', '('updateUI вызвана, userData:', userData);             if (userData) {                 console.log('Обновляем UI с данными:', {                     first_name: userData.first_name,                    ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.элементы_баланса', 'Элементы баланса:', 'js_string', 'Element = document.getElementById('modalNdnBalance');                                  console.log('Элементы баланса:', {                     ndnBalanceElement: !!ndnBalanceElement,                   ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.элемент_modalndnbalance_не', 'Элемент modalNdnBalance не найден!', 'js_string', '(userData.balance_ndn || 0).toFixed(2);                 } else {                     console.error('Элемент modalNdnBalance не найден!');                 }                                  // Обновляе')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.игровой_id_обновлен', 'Игровой ID обновлен:', 'js_string', 'userIdElement.textContent = userData.id || '-';                     console.log('Игровой ID обновлен:', userData.id || '-');                 } else {                     console.error('Элемент userId ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.элемент_userid_не', 'Элемент userId не найден!', 'js_string', 'вой ID обновлен:', userData.id || '-');                 } else {                     console.error('Элемент userId не найден!');                 }                                  // Обновляем заголов')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.pro_functions_debug', 'PRO Functions Debug:', 'js_string', 'const proFunctionsCard = document.getElementById('proFunctionsCard');                 console.log('PRO Functions Debug:', {                     userData_is_pro: userData.is_pro,                     pr')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.element_not_found', 'element not found', 'js_string', 'proFunctionsCard_current_display: proFunctionsCard ? proFunctionsCard.style.display : 'element not found'                 });                                  if (proFunctionsCard) {                  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.pro_functions_card', 'PRO Functions Card display set to:', 'js_string', 'oFunctionsCard.style.display = userData.is_pro ? 'block' : 'none';                     console.log('PRO Functions Card display set to:', proFunctionsCard.style.display);                 } else {      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.данные_пользователя_обновлены', 'Данные пользователя обновлены:', 'js_string', '// Показываем информацию о пользователе в консоли                 console.log('Данные пользователя обновлены:', {                     name: userData.first_name,                     username: userData.')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.разработчик', 'Разработчик', 'js_string', 'showAdminPanel({                         is_admin: true,                         status_name: 'Разработчик',                         user_id: userData.id                     });                 } else')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_проверки_админ', 'Ошибка проверки админ статуса:', 'js_string', 'тся разработчиком');                 }             } catch (error) {                 console.error('Ошибка проверки админ статуса:', error);             }         }          // Показать админ панель  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.error_loading_admin', 'Error loading admin dashboard:', 'js_string', '}                 }             } catch (error) {                 console.error('Error loading admin dashboard:', error);             }         }          // Обновить данные админ панели         funct')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_загрузки_заявок', 'Ошибка загрузки заявок', 'js_string', 'equestsModal(data.requests);                     } else {                         showNotification('Ошибка загрузки заявок', 'error');                     }                 } else {                   ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.нет_доступа_к', 'Нет доступа к заявкам', 'js_string', 'ок', 'error');                     }                 } else {                     showNotification('Нет доступа к заявкам', 'error');                 }             } catch (error) {                 co')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.error_loading_exchange', 'Error loading exchange requests:', 'js_string', 'заявкам', 'error');                 }             } catch (error) {                 console.error('Error loading exchange requests:', error);                 showNotification('Ошибка соединения', 'err')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_соединения', 'Ошибка соединения', 'js_string', 'console.error('Error loading exchange requests:', error);                 showNotification('Ошибка соединения', 'error');             }         }          // Модальное окно заявок на обмен         fun')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.exchangerequestscontent', 'exchange-requests-content', 'js_string', '{             transform: translateY(0);         }          /* Стили для заявок на обмен */         .exchange-requests-content {             max-height: 400px;             overflow-y: auto;         }  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.exchangerequestitem', 'exchange-request-item', 'js_string', 'requests-content {             max-height: 400px;             overflow-y: auto;         }          .exchange-request-item {             background: #f8f9fa;             border: 1px solid #e9ecef;     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.requestinfo', 'request-info', 'js_string', 'x;             justify-content: space-between;             align-items: center;         }          .request-info {             flex: 1;         }          .request-user {             font-weight: 600;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.requestuser', 'request-user', 'js_string', 'align-items: center;         }          .request-info {             flex: 1;         }          .request-user {             font-weight: 600;             color: #333;             margin-bottom: 5px;  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.requestamount', 'request-amount', 'js_string', 'font-weight: 600;             color: #333;             margin-bottom: 5px;         }          .request-amount {             font-size: 14px;             color: #666;             margin-bottom: 5px;   ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.requestdate', 'request-date', 'js_string', 'font-size: 14px;             color: #666;             margin-bottom: 5px;         }          .request-date {             font-size: 12px;             color: #999;             margin-bottom: 5px;      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ruru', 'ru-RU', 'js_string', '<div class="request-date">${new Date(req.created_at).toLocaleString('ru-RU')}</div>                                         <div class="request-status status-${req.status}">$')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.requestactions', 'request-actions', 'js_string', 'status-completed {             background: #d1ecf1;             color: #0c5460;         }          .request-actions {             display: flex;             gap: 8px;         }          .request-actio')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.pending', 'pending', 'js_string', 'px;             font-weight: 600;             text-transform: uppercase;         }          .status-pending {             background: #fff3cd;             color: #856404;         }          .status-ap')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.button_buttondanger', 'button button-danger', 'js_string', '</button>                                             <button class="button button-danger" onclick="rejectExchangeRequest(${req.id})">                                                 ❌ Откл')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.norequests', 'no-requests', 'js_string', 'ar-gradient(135deg, #c82333, #a71e2a);             transform: translateY(-2px);         }          .no-requests {             text-align: center;             color: #666;             font-style: itali')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ожидает', 'Ожидает', 'js_string', 'function getStatusText(status) {             const statusTexts = {                 'pending': 'Ожидает',                 'approved': 'Одобрена',                 'rejected': 'Отклонена',')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.approved', 'approved', 'js_string', 's-pending {             background: #fff3cd;             color: #856404;         }          .status-approved {             background: #d4edda;             color: #155724;         }          .status-r')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.одобрена', 'Одобрена', 'js_string', 'const statusTexts = {                 'pending': 'Ожидает',                 'approved': 'Одобрена',                 'rejected': 'Отклонена',                 'completed': 'Выполнена'             };')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.rejected', 'rejected', 'js_string', '-approved {             background: #d4edda;             color: #155724;         }          .status-rejected {             background: #f8d7da;             color: #721c24;         }          .status-c')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.отклонена', 'Отклонена', 'js_string', ''pending': 'Ожидает',                 'approved': 'Одобрена',                 'rejected': 'Отклонена',                 'completed': 'Выполнена'             };             return statusTexts[status] ||')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.выполнена', 'Выполнена', 'js_string', ''approved': 'Одобрена',                 'rejected': 'Отклонена',                 'completed': 'Выполнена'             };             return statusTexts[status] || status;         }          // Одобрит')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.заявка_одобрена', 'Заявка одобрена', 'js_string', 'response.json();                     if (data.success) {                         showNotification('Заявка одобрена', 'success');                         showExchangeRequests(); // Обновляем список')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_одобрения', 'Ошибка одобрения', 'js_string', 'вляем список                     } else {                         showNotification(data.message || 'Ошибка одобрения', 'error');                     }                 } else {                     show')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_сервера', 'Ошибка сервера', 'js_string', 'rror('❌ Ошибка HTTP:', response.status, response.statusText);                     showNotification(`Ошибка сервера: ${response.status}`, 'error');                     return;                 }')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.error_approving_request', 'Error approving request:', 'js_string', 'сервера', 'error');                 }             } catch (error) {                 console.error('Error approving request:', error);                 showNotification('Ошибка соединения', 'error');   ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.заявка_отклонена', 'Заявка отклонена', 'js_string', 'response.json();                     if (data.success) {                         showNotification('Заявка отклонена', 'success');                         showExchangeRequests(); // Обновляем список')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_отклонения', 'Ошибка отклонения', 'js_string', 'вляем список                     } else {                         showNotification(data.message || 'Ошибка отклонения', 'error');                     }                 } else {                     sho')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.error_rejecting_request', 'Error rejecting request:', 'js_string', 'сервера', 'error');                 }             } catch (error) {                 console.error('Error rejecting request:', error);                 showNotification('Ошибка соединения', 'error');   ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.функция_в_разработке', 'Функция в разработке', 'js_string', 'ние пользователями (заглушка)         function showUserManagement() {             showNotification('Функция в разработке', 'info');         }          // Аналитика (заглушка)         function showAnal')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.сначала_загрузите_данные', 'Сначала загрузите данные пользователя', 'js_string', 'статуса         function buyPro() {             if (!userData) {                 showNotification('Сначала загрузите данные пользователя', 'error');                 return;             }              ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.недостаточно_ndn_для', 'Недостаточно NDN для покупки Pro статуса', 'js_string', '}                          if (userData.balance_ndn < 1000) {                 showNotification('Недостаточно NDN для покупки Pro статуса', 'error');                 playSound('error');                ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_покупки_pro', 'Ошибка покупки Pro статуса', 'js_string', '})                 });                  if (!response.ok) {                     throw new Error('Ошибка покупки Pro статуса');                 }                  const result = await response.json(); ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.pro_статус_успешно', 'Pro статус успешно активирован!', 'js_string', '}                  const result = await response.json();                 showNotification('Pro статус успешно активирован!', 'success');                 playSound('success');                 createSpa')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.введите_корректное_количество', 'Введите корректное количество NDN', 'js_string', 'ById('ndnAmount').value;             if (!amount || amount < 1) {                 showNotification('Введите корректное количество NDN', 'error');                 return;             }              if ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.максимальная_сумма_10000', 'Максимальная сумма: 10,000 NDN', 'js_string', 'return;             }              if (amount > 10000) {                 showNotification('Максимальная сумма: 10,000 NDN', 'error');                 return;             }              try {          ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_создания_счета', 'Ошибка создания счета', 'js_string', 'const error = await response.json();                     throw new Error(error.detail || 'Ошибка создания счета');                 }                  const result = await response.json();')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ссылка_на_счет', 'Ссылка на счет не получена', 'js_string', ';                                  if (!result.invoice_link) {                     throw new Error('Ссылка на счет не получена');                 }                                  // Открываем счет ч')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.undefined', 'undefined', 'js_string', '// Инициализируем базовые поля если не существуют             if (minerData.ndnGas === undefined) minerData.ndnGas = 100;             if (minerData.energy === undefined) minerData.energy = 100;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.paid', 'paid', 'js_string', 'hideLoading();                                                  if (status === 'paid') {                             showNotification('✅ Платеж успешно завершен! NDN зачислены на ваш с')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.cancelled', 'cancelled', 'js_string', 'зователя                             loadUserData();                         } else if (status === 'cancelled') {                             showNotification('Платеж отменен', 'warning');')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.платеж_отменен', 'Платеж отменен', 'js_string', '} else if (status === 'cancelled') {                             showNotification('Платеж отменен', 'warning');                         } else if (status === 'failed') {')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.failed', 'failed', 'js_string', 'showNotification('Платеж отменен', 'warning');                         } else if (status === 'failed') {                             showNotification('Ошибка платежа', 'error');')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_платежа', 'Ошибка платежа', 'js_string', '} else if (status === 'failed') {                             showNotification('Ошибка платежа', 'error');                             playSound('error');                         }')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.счет_создан_в', 'Счет создан! В реальном Telegram откроется интерфейс оплаты.', 'js_string', 'lback для тестового режима                     hideLoading();                     showNotification('Счет создан! В реальном Telegram откроется интерфейс оплаты.', 'success');                     playS')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.недостаточно_ndn_на', 'Недостаточно NDN на балансе', 'js_string', ';             }              if (userData.balance_ndn < amount) {                 showNotification('Недостаточно NDN на балансе', 'error');                 return;             }              try {    ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_создания_заявки', 'Ошибка создания заявки', 'js_string', 'const error = await response.json();                     throw new Error(error.detail || 'Ошибка создания заявки');                 }                  const result = await response.json();            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.минимальная_сумма_вывода', 'Минимальная сумма вывода: 100 NDN', 'js_string', '').value;                          if (!amount || amount < 100) {                 showNotification('Минимальная сумма вывода: 100 NDN', 'error');                 return;             }                 ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.введите_id_получателя', 'Введите ID получателя', 'js_string', 'eturn;             }                          if (!recipientId) {                 showNotification('Введите ID получателя', 'error');                 return;             }              try {          ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_вывода_ndn', 'Ошибка вывода NDN', 'js_string', '})                 });                  if (!response.ok) {                     throw new Error('Ошибка вывода NDN');                 }                  const result = await response.json();          ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ndn_успешно_выведены', 'NDN успешно выведены!', 'js_string', '}                  const result = await response.json();                 showNotification('NDN успешно выведены!', 'success');                 playSound('success');                 createSparkles();')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.user_id_не', 'User ID не найден', 'js_string', ''click');                                  if (!userData.id) {                     throw new Error('User ID не найден');                 }                                  const response = await fetch')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_загрузки_рефералов', 'Ошибка загрузки рефералов', 'js_string', '}                 });                  if (!response.ok) {                     throw new Error('Ошибка загрузки рефералов');                 }                  const data = await response.json();     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_загрузки_лидерборда', 'Ошибка загрузки лидерборда', 'js_string', '}                 });                  if (!response.ok) {                     throw new Error('Ошибка загрузки лидерборда');                 }                  const data = await response.json();    ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_загрузки_правил', 'Ошибка загрузки правил', 'js_string', '}                 });                  if (!response.ok) {                     throw new Error('Ошибка загрузки правил');                 }                  const data = await response.json();        ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralsdescription', 'referrals.description', 'js_string', 'tons.referrals">👥 Мои рефералы</div>                         <div class="modal-subtitle" data-i18n="referrals.description">Награды начисляются только когда рефералы покупают PRO статус</div>          ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralstats', 'referral-stats', 'js_string', 'padding: 40px 20px;             color: #666;             font-style: italic;         }          .referral-stats {             margin-bottom: 20px;         }          .stats-grid {             display:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralstotal', 'referrals.total', 'js_string', '<div class="stat-info">                                     <div class="stat-label" data-i18n="referrals.total">Всего рефералов</div>                                     <div class="stat-value">${tota')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralsregular', 'referrals.regular', 'js_string', '<div class="stat-info">                                     <div class="stat-label" data-i18n="referrals.regular">Обычных</div>                                     <div class="stat-value">${regularRef')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralspro', 'referrals.pro', 'js_string', '<div class="stat-info">                                     <div class="stat-label" data-i18n="referrals.pro">PRO</div>                                     <div class="stat-value">${proReferrals}</div')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralsearnings', 'referrals.earnings', 'js_string', '<div class="stat-info">                                     <div class="stat-label" data-i18n="referrals.earnings">Заработано</div>                                     <div class="stat-value">${earnin')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referrallevels', 'referral-levels', 'js_string', '12px;             color: rgba(255, 255, 255, 0.6);             margin-top: 2px;         }          .referral-levels {             margin-bottom: 20px;         }          .referral-levels h3 {         ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralslevel_stats', 'referrals.level_stats', 'js_string', '<div class="referral-levels">                         <h3 data-i18n="referrals.level_stats">📊 Статистика по уровням:</h3>                         ${data.referralStats && data.referralStats.l')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.levelitem', 'level-item', 'js_string', '-color, #ffffff);             margin-bottom: 15px;             font-size: 16px;         }          .level-item {             background: rgba(255, 255, 255, 0.05);             border-radius: 8px;     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.levelnumber', 'level-number', 'js_string', 'x;             justify-content: space-between;             align-items: center;         }          .level-number {             font-weight: bold;             color: #4CAF50;             font-size: 14p')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralslevel', 'referrals.level', 'js_string', '<div class="referral-levels">                         <h3 data-i18n="referrals.level_stats">📊 Статистика по уровням:</h3>                         ${data.referralStats && data.referralS')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.leveldetails', 'level-details', 'js_string', 'vel="${stat.level}">${stat.level} уровень</div>                                         <div class="level-details">                                             <div class="level-stats">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.levelstats', 'level-stats', 'js_string', 'font-weight: bold;             color: #4CAF50;             font-size: 14px;         }          .level-stats {             display: flex;             gap: 15px;             font-size: 12px;         }')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.levelcount', 'level-count', 'js_string', 'display: flex;             gap: 15px;             font-size: 12px;         }          .level-count {             color: rgba(255, 255, 255, 0.7);         }          .level-reward {             color')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralsreferrals_count', 'referrals.referrals_count', 'js_string', '"level-stats">                                                 <span class="level-count" data-i18n="referrals.referrals_count" data-count="${stat.total_referrals}">${stat.total_referrals} рефералов</s')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.levelreward', 'level-reward', 'js_string', '}          .level-count {             color: rgba(255, 255, 255, 0.7);         }          .level-reward {             color: #4CAF50;             font-weight: bold;         }          .referral-date {')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.noreferrals', 'no-referrals', 'js_string', 'font-weight: bold;             color: #667eea;             font-size: 1.1rem;         }          .no-referrals {             text-align: center;             padding: 40px 20px;             color: #666')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralsno_level_stats', 'referrals.no_level_stats', 'js_string', '`).join('') :                             '<div class="no-referrals" data-i18n="referrals.no_level_stats">Статистика по уровням пока недоступна</div>'                         }                     </d')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralscontent', 'referrals-content', 'js_string', '50% { opacity: 1; transform: scale(1); }         }          /* Стили для рефералов */         .referrals-content {             max-height: 400px;             overflow-y: auto;             margin-botto')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralsreferrals_list', 'referrals.referrals_list', 'js_string', '<div class="referrals-content">                         <h3 data-i18n="referrals.referrals_list">👥 Список рефералов по уровням:</h3>                         ${Object.keys(referralsByLevel).length')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.levelsection', 'level-section', 'js_string', '11px;             color: rgba(255, 255, 255, 0.5);             margin-top: 2px;         }          .level-section {             margin-bottom: 20px;             padding: 15px;             background: ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralslevel_with_count', 'referrals.level_with_count', 'js_string', '<div class="level-section">                                     <h4 data-i18n="referrals.level_with_count" data-level="${level}" data-count="${referralsByLevel[level].length}">📊 ${level} уровень (${re')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralitem', 'referral-item', 'js_string', 'x-height: 400px;             overflow-y: auto;             margin-bottom: 20px;         }          .referral-item {             display: flex;             justify-content: space-between;             a')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralname', 'referral-name', 'js_string', 'ateX(0); opacity: 1; }         }          .referral-info {             flex: 1;         }          .referral-name {             font-weight: bold;             color: #333;             margin-bottom: 5')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referraldate', 'referral-date', 'js_string', '.level-reward {             color: #4CAF50;             font-weight: bold;         }          .referral-date {             font-size: 11px;             color: rgba(255, 255, 255, 0.5);             mar')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralbalance', 'referral-balance', 'js_string', '.referral-username {             color: #666;             font-size: 0.9rem;         }          .referral-balance {             font-weight: bold;             color: #667eea;             font-size: 1.')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referralsno_referrals', 'referrals.no_referrals', 'js_string', '`).join('') :                             '<div class="no-referrals" data-i18n="referrals.no_referrals">У вас пока нет рефералов</div>'                         }                     </div>')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.modalcontent_leaderboardmodal', 'modal-content leaderboard-modal', 'js_string', 'modal.style.display = 'block';             modal.innerHTML = `                 <div class="modal-content leaderboard-modal">                     <div class="modal-header">                         <div')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.leaderboardcontent', 'leaderboard-content', 'js_string', 'nt-size: 16px;             font-weight: 600;         }          /* Стили для лидерборда */         .leaderboard-content {             max-height: 400px;             overflow-y: auto;             margi')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.top', 'top-', 'js_string', 'city: 0; }             to { transform: translateX(0); opacity: 1; }         }          .leader-item.top-1 {             background: linear-gradient(135deg, #ffd700, #ffed4e);             border: 1px s')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.leaderrank', 'leader-rank', 'js_string', 'near-gradient(135deg, #cd7f32, #daa520);             border: 1px solid #cd7f32;         }          .leader-rank {             width: 24px;             height: 24px;             border-radius: 50%;    ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.leaderavatar', 'leader-avatar', 'js_string', 'top-3 .leader-rank {             background: #cd7f32;             color: white;         }          .leader-avatar {             width: 28px;             height: 28px;             border-radius: 50%;  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.leaderinfo', 'leader-info', 'js_string', 'height: 100%;             object-fit: cover;             border-radius: 50%;         }          .leader-info {             flex: 1;             min-width: 0;         }          .leader-name {         ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.leadername', 'leader-name', 'js_string', '}          .leader-info {             flex: 1;             min-width: 0;         }          .leader-name {             font-weight: 600;             color: #333;             font-size: 0.85rem;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.leaderbalance', 'leader-balance', 'js_string', 'ace: nowrap;             overflow: hidden;             text-overflow: ellipsis;         }          .leader-balance {             text-align: right;             flex-shrink: 0;         }          .bala')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.balancendn', 'balance-ndn', 'js_string', '.leader-balance {             text-align: right;             flex-shrink: 0;         }          .balance-ndn {             font-weight: 600;             color: #667eea;             font-size: 0.8rem;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.modalcontent_rulesmodal', 'modal-content rules-modal', 'js_string', 'modal.style.display = 'block';             modal.innerHTML = `                 <div class="modal-content rules-modal">                     <div class="modal-header">                         <div class')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.rulescontent', 'rules-content', 'js_string', 'px 0 0 0;             margin-top: 20px;             border-top: 1px solid #eee;         }          .rules-content {             margin-bottom: 20px;         }          .rule-section {             marg')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.rulesection', 'rule-section', 'js_string', 'olid #eee;         }          .rules-content {             margin-bottom: 20px;         }          .rule-section {             margin-bottom: 24px;             padding: 0;             background: tran')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.sectiontitle', 'section-title', 'js_string', 'ansparent;             border: none;             animation: fadeInUp 0.5s ease;         }          .section-title {             font-size: 1.2rem;             font-weight: 700;             color: #2c3')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.sectioncontent', 'section-content', 'js_string', 'padding-bottom: 8px;             border-bottom: 2px solid #667eea;         }          .section-content {             padding: 0;             background: transparent;         }          @keyframes fade')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.stepitem', 'step-item', 'js_string', 'reak-word;             overflow-wrap: break-word;         }          /* Стили для шагов */         .step-item {             display: flex;             align-items: flex-start;             margin-botto')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.stepnumber', 'step-number', 'js_string', 'items: flex-start;             margin-bottom: 12px;             padding: 8px 0;         }          .step-number {             width: 24px;             height: 24px;             border-radius: 50%;    ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.steptext', 'step-text', 'js_string', 'font-weight: 600;             margin-right: 12px;             flex-shrink: 0;         }          .step-text {             color: #34495e;             line-height: 1.5;             font-size: 0.95rem;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.rewarditem', 'reward-item', 'js_string', 'font-size: 0.95rem;             flex: 1;         }          /* Стили для наград */         .reward-item {             display: flex;             align-items: center;             margin-bottom: 8px;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.rewardtext', 'reward-text', 'js_string', '.reward-icon {             font-size: 1.2rem;             margin-right: 10px;         }          .reward-text {             color: #34495e;             font-size: 0.95rem;             font-weight: 500')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.developerfee', 'developer-fee', 'js_string', 'color: #34495e;             font-size: 0.95rem;             font-weight: 500;         }          .developer-fee {             display: flex;             align-items: center;             margin-top: 12')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.feeicon', 'fee-icon', 'js_string', 'fa;             border-radius: 6px;             border-left: 3px solid #667eea;         }          .fee-icon {             font-size: 1.1rem;             margin-right: 8px;         }          .fee-tex')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.feetext', 'fee-text', 'js_string', '.fee-icon {             font-size: 1.1rem;             margin-right: 8px;         }          .fee-text {             color: #2c3e50;             font-size: 0.9rem;             font-weight: 600;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.featuresgrid', 'features-grid', 'js_string', 'ont-size: 0.9rem;             font-weight: 600;         }          /* Стили для функций */         .features-grid {             display: grid;             grid-template-columns: repeat(auto-fit, minma')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.featureitem', 'feature-item', 'js_string', 'd-template-columns: repeat(auto-fit, minmax(200px, 1fr));             gap: 8px;         }          .feature-item {             padding: 8px 12px;             background: #f8f9fa;             border-ra')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.featuretext', 'feature-text', 'js_string', 'fa;             border-radius: 6px;             border-left: 3px solid #28a745;         }          .feature-text {             color: #34495e;             font-size: 0.9rem;             line-height: 1')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.tipitem', 'tip-item', 'js_string', 'ont-size: 0.9rem;             line-height: 1.4;         }          /* Стили для советов */         .tip-item {             display: flex;             align-items: flex-start;             margin-bottom')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.tipicon', 'tip-icon', 'js_string', 'items: flex-start;             margin-bottom: 10px;             padding: 8px 0;         }          .tip-icon {             font-size: 1.1rem;             margin-right: 10px;             margin-top: 2p')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.tiptext', 'tip-text', 'js_string', 'font-size: 1.1rem;             margin-right: 10px;             margin-top: 2px;         }          .tip-text {             color: #34495e;             font-size: 0.95rem;             line-height: 1.5;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_загрузки_достижений', 'Ошибка загрузки достижений', 'js_string', 'splayAchievements(data.achievements);                 } else {                     throw new Error('Ошибка загрузки достижений');                 }             } catch (error) {                 consol')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.nodata', 'no-data', 'js_string', '}                  /* ==================== МАГАЗИНЫ ==================== */                  .no-data {             text-align: center;             padding: 2rem;             color: var(--tg-theme-hin')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.trading', 'trading', 'js_string', 'Object.entries(groupedAchievements)) {                 const categoryNames = {                     'trading': '💰 Торговля',                     'referral': '👥 Рефералы',                     'special':')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.achievementcategory', 'achievement-category', 'js_string', '}         }          /* ==================== ДОСТИЖЕНИЯ ==================== */                  .achievement-category {             margin-bottom: 2rem;         }                  .achievement-catego')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.achievementlist', 'achievement-list', 'js_string', 'tom: 1rem;             font-size: 1.2rem;             font-weight: 600;         }                  .achievement-list {             display: flex;             flex-direction: column;             gap: 1')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.progressbar', 'progress-bar', 'js_string', '4px;             border-radius: 2px;             overflow: hidden;         }          .achievement-progress-bar {             height: 100%;             background: linear-gradient(90deg, #667eea, #764')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.progressfill', 'progress-fill', 'js_string', '55, 0.2);             border-radius: 4px;             overflow: hidden;         }                  .progress-fill {             height: 100%;             background: linear-gradient(90deg, #4CAF50, #8')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.progresstext', 'progress-text', 'js_string', 'ient(90deg, #4CAF50, #8BC34A);             transition: width 0.3s ease;         }                  .progress-text {             font-size: 0.8rem;             color: var(--tg-theme-hint-color, #cccccc')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.rewardndn', 'reward-ndn', 'js_string', 'lign-items: center;             gap: 1rem;             flex-wrap: wrap;         }                  .reward-ndn, .reward-stars {             background: rgba(255, 255, 255, 0.1);             padding: 0')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.rewardstars', 'reward-stars', 'js_string', 'enter;             gap: 1rem;             flex-wrap: wrap;         }                  .reward-ndn, .reward-stars {             background: rgba(255, 255, 255, 0.1);             padding: 0.25rem 0.5rem')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.error_claiming_achievement', 'Error claiming achievement:', 'js_string', 'награды', 'error');                 }             } catch (error) {                 console.error('Error claiming achievement:', error);                 showNotification('Ошибка получения награды', 'e')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_загрузки_магазинов', 'Ошибка загрузки магазинов', 'js_string', 'displayShops(data.shops);                 } else {                     throw new Error('Ошибка загрузки магазинов');                 }             } catch (error) {                 console.error('Erro')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.error_loading_shops', 'Error loading shops:', 'js_string', 'агрузки магазинов');                 }             } catch (error) {                 console.error('Error loading shops:', error);                 showNotification('Ошибка загрузки магазинов', 'error'')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.nodataicon', 'no-data-icon', 'js_string', 'padding: 2rem;             color: var(--tg-theme-hint-color, #cccccc);         }                  .no-data-icon {             font-size: 3rem;             margin-bottom: 1rem;         }               ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.nodatatitle', 'no-data-title', 'js_string', 'ta-icon {             font-size: 3rem;             margin-bottom: 1rem;         }                  .no-data-title {             font-size: 1.2rem;             font-weight: 600;             margin-bott')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.nodatasubtitle', 'no-data-subtitle', 'js_string', 'bottom: 0.5rem;             color: var(--tg-theme-text-color, #ffffff);         }                  .no-data-subtitle {             font-size: 0.9rem;         }                  .shop-item {           ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopitem', 'shop-item', 'js_string', 'background: #ccc;             cursor: not-allowed;             transform: none;         }          .shop-items {             display: grid;             grid-template-columns: repeat(auto-fit, minmax(2')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopheader', 'shop-header', 'js_string', 'ranslateY(-2px);             box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);         }                  .shop-header {             display: flex;             justify-content: space-between;             ali')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.inactive', 'inactive', 'js_string', 'ground: rgba(76, 175, 80, 0.2);             color: #4CAF50;         }                  .shop-status.inactive {             background: rgba(244, 67, 54, 0.2);             color: #F44336;         }')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.без_описания', 'Без описания', 'js_string', '</div>                         <div class="shop-description">${shop.description || 'Без описания'}</div>                         <div class="shop-stats">                             <div class="sh')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopstats', 'shop-stats', 'js_string', 'cccccc);             margin-bottom: 1rem;             line-height: 1.5;         }                  .shop-stats {             display: flex;             gap: 1rem;             margin-bottom: 1rem;     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopstat', 'shop-stat', 'js_string', 'nt-weight: 600;             color: var(--tg-theme-text-color, #ffffff);         }                  .shop-status {             padding: 0.25rem 0.75rem;             border-radius: 20px;             fon')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.shopactions', 'shop-actions', 'js_string', 'nt-weight: 600;             color: var(--tg-theme-text-color, #ffffff);         }                  .shop-actions {             display: flex;             gap: 0.5rem;             flex-wrap: wrap;     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_открытия_магазина', 'Ошибка открытия магазина', 'js_string', 'await showShops();                 } else {                     showNotification(data.message || 'Ошибка открытия магазина', 'error');                 }             } catch (error) {                 c')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.error_opening_shop', 'Error opening shop:', 'js_string', 'магазина', 'error');                 }             } catch (error) {                 console.error('Error opening shop:', error);                 showNotification('Ошибка открытия магазина', 'error');')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.укажите_цену_в', 'Укажите цену в NDN или Stars', 'js_string', 'if (priceNDN <= 0 && priceStars <= 0) {                 showNotification('Укажите цену в NDN или Stars', 'error');                 return;             }                          try {                 ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_добавления_товара', 'Ошибка добавления товара', 'js_string', 'tock').value = '-1';                 } else {                     showNotification(data.message || 'Ошибка добавления товара', 'error');                 }             } catch (error) {                ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.error_adding_item', 'Error adding item:', 'js_string', 'я товара', 'error');                 }             } catch (error) {                 console.error('Error adding item:', error);                 showNotification('Ошибка добавления товара', 'error'); ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.функция_просмотра_товаров', 'Функция просмотра товаров в разработке', 'js_string', '(shopId) {             // TODO: Реализовать просмотр товаров магазина             showNotification('Функция просмотра товаров в разработке', 'info');         }                  // Тестовые функции    ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.сбросить_все_тестовые', 'Сбросить все тестовые данные?', 'js_string', '}                  // Тестовые функции         function resetTestData() {             if (confirm('Сбросить все тестовые данные?')) {                 localStorage.removeItem('nodeon_test_user');      ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.тестовые_данные_сброшены', 'Тестовые данные сброшены', 'js_string', ')) {                 localStorage.removeItem('nodeon_test_user');                 showNotification('Тестовые данные сброшены', 'success');                 playSound('success');                 setTime')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.добавлено_1000_ndn', 'Добавлено 1000 NDN для тестирования!', 'js_string', '_ndn + 1000 // Добавляем NDN для тестирования                 });                 showNotification('Добавлено 1000 NDN для тестирования!', 'success');                 playSound('success');            ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.domcontentloaded', 'DOMContentLoaded', 'js_string', 'ateSparkles();             }         }          // Инициализация         document.addEventListener('DOMContentLoaded', function() {             console.log('🚀 DOM загружен, инициализируем приложение..')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.input', 'input', 'js_string', 'argin-bottom: 8px;             font-weight: bold;             color: #333;         }          .form-input {             width: 100%;             padding: 12px 15px;             border: 2px solid #e0e0')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.userdata', 'userData:', 'js_string', '// Обновление UI         function updateUI() {             console.log('updateUI вызвана, userData:', userData);             if (userData) {                 console.log('Обновляем UI с данными:', {')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.userdatais_pro', 'userData.is_pro:', 'js_string', ''inviteFriends() called');             console.log('userData:', userData);             console.log('userData.is_pro:', userData ? userData.is_pro : 'userData is null');                          if (!u')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.userdata_is_null', 'userData is null', 'js_string', 'g('userData:', userData);             console.log('userData.is_pro:', userData ? userData.is_pro : 'userData is null');                          if (!userData) {                 console.log('No userDa')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.no_userdata_showing', 'No userData, showing error notification', 'js_string', 's_pro : 'userData is null');                          if (!userData) {                 console.log('No userData, showing error notification');                 showNotification('Сначала загрузите данны')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.user_is_not', 'User is not PRO, showing error notification', 'js_string', 'return;             }                          if (!userData.is_pro) {                 console.log('User is not PRO, showing error notification');                 showNotification('Только PRO пользова')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.только_pro_пользователи', 'Только PRO пользователи могут приглашать друзей!', 'js_string', 'console.log('User is not PRO, showing error notification');                 showNotification('Только PRO пользователи могут приглашать друзей!', 'error');                 return;             }        ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.user_is_pro', 'User is PRO, proceeding with invite modal', 'js_string', 'ать друзей!', 'error');                 return;             }                          console.log('User is PRO, proceeding with invite modal');                          // Проверяем, существует ли мо')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.invitefriendsmodal_not_found', 'inviteFriendsModal not found', 'js_string', 'ment.getElementById('inviteFriendsModal');             if (!modal) {                 console.error('inviteFriendsModal not found');                 showNotification('Ошибка: модальное окно не найдено'')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_модальное_окно', 'Ошибка: модальное окно не найдено', 'js_string', '{                 console.error('inviteFriendsModal not found');                 showNotification('Ошибка: модальное окно не найдено', 'error');                 return;             }                  ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.invite_modal_should', 'Invite modal should be visible now', 'js_string', '// Показываем модальное окно             showModal('inviteFriendsModal');             console.log('Invite modal should be visible now');         }                  function loadReferralLink() {       ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referral_link_input', 'Referral link input not found', 'js_string', 't.getElementById('referralLinkInput');             if (!linkInput) {                 console.error('Referral link input not found');                 return;             }                          let ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.pro_stars_bot', 'pro_stars_bot', 'js_string', '// Используем ссылку из базы данных (формат: ref_ID)                 const botUsername = 'pro_stars_bot';                 referralLink = `https://t.me/${botUsername}?startapp=${userData.referral_link}')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.using_referral_link', 'Using referral link from database:', 'js_string', 'nk = `https://t.me/${botUsername}?startapp=${userData.referral_link}`;                 console.log('Using referral link from database:', userData.referral_link, '→', referralLink);             } else ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.generated_referral_link', 'Generated referral link with game ID:', 'js_string', 'erralLink = `https://t.me/${botUsername}?startapp=ref_${userData.id}`;                 console.log('Generated referral link with game ID:', referralLink);             } else if (userData && userData.t')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.using_fallback_referral', 'Using fallback referral link:', 'js_string', 'ck ссылка                 referralLink = 'https://t.me/pro_stars_bot';                 console.log('Using fallback referral link:', referralLink);             }                          linkInput.valu')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.referral_link_set', 'Referral link set to:', 'js_string', 'olor = '#000000';             linkInput.style.backgroundColor = '#ffffff';             console.log('Referral link set to:', referralLink);                          // Проверяем, что ссылка действитель')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.failed_to_set', 'Failed to set referral link value', 'js_string', 'льно установлена             if (linkInput.value !== referralLink) {                 console.error('Failed to set referral link value');                 showNotification('Ошибка загрузки реферальной с')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_загрузки_реферальной', 'Ошибка загрузки реферальной ссылки', 'js_string', 'console.error('Failed to set referral link value');                 showNotification('Ошибка загрузки реферальной ссылки', 'error');             }         }                  async function copyReferra')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.поле_ссылки_не', 'Поле ссылки не найдено', 'js_string', 'etElementById('referralLinkInput');             if (!linkInput) {                 showNotification('Поле ссылки не найдено', 'error');                 return;             }                          co')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ссылка_не_загружена', 'Ссылка не загружена. Попробуйте еще раз.', 'js_string', 't linkText = linkInput.value.trim();             if (!linkText) {                 showNotification('Ссылка не загружена. Попробуйте еще раз.', 'error');                 return;             }          ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.копируем_ссылку', 'Копируем ссылку:', 'js_string', 'те еще раз.', 'error');                 return;             }                          console.log('Копируем ссылку:', linkText);                          try {                 // Современный API для ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ссылка_скопирована_в', 'Ссылка скопирована в буфер обмена!', 'js_string', 'await navigator.clipboard.writeText(linkText);                     showNotification('Ссылка скопирована в буфер обмена!', 'success');                     console.log('Ссылка успешно скопирована через ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ссылка_успешно_скопирована', 'Ссылка успешно скопирована через Clipboard API', 'js_string', 'showNotification('Ссылка скопирована в буфер обмена!', 'success');                     console.log('Ссылка успешно скопирована через Clipboard API');                 } else {                     // Fa')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.copy', 'copy', 'js_string', 'ass="id-value" id="userId">-</div>                     <button class="button button-small" onclick="copyUserId()">📋</button>                 </div>                 <div class="id-hint" data-i18n="user')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.execcommand_failed', 'execCommand failed', 'js_string', 'пирована через execCommand');                     } else {                         throw new Error('execCommand failed');                     }                 }             } catch (err) {           ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_копирования', 'Ошибка копирования:', 'js_string', '}                 }             } catch (err) {                 console.error('Ошибка копирования:', err);                 showNotification('Не удалось скопировать ссылку. Попробуйте выделить и скоп')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.не_удалось_скопировать', 'Не удалось скопировать ссылку. Попробуйте выделить и скопировать вручную.', 'js_string', 'err) {                 console.error('Ошибка копирования:', err);                 showNotification('Не удалось скопировать ссылку. Попробуйте выделить и скопировать вручную.', 'error');             } ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.linkdisplay', 'link-display', 'js_string', 'gap: 10px;             justify-content: center;             margin-top: 10px;         }          .link-display {             margin: 20px 0;         }          .link-text {             background: #ff')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.linktext', 'link-text', 'js_string', 'argin-top: 10px;         }          .link-display {             margin: 20px 0;         }          .link-text {             background: #ffffff;             color: #000000;             padding: 15px;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.linktextdisplay', 'linkTextDisplay', 'js_string', '>                     <div class="link-display">                         <div class="link-text" id="linkTextDisplay">${linkInput.value}</div>                         <div class="link-instructions">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.linkinstructions', 'link-instructions', 'js_string', 'reak: break-all;             user-select: all;             margin-bottom: 15px;         }          .link-instructions {             background: rgba(255, 255, 255, 0.1);             padding: 15px;    ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts._blank', '_blank', 'js_string', '(linkInput.value)}&text=${encodeURIComponent(message)}`;                     window.open(shareUrl, '_blank');                 }             }         }                  // Функция для выбора контактов')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.contactinputmodal', 'contactInputModal', 'js_string', 'dal = document.createElement('div');             modal.className = 'modal';             modal.id = 'contactInputModal';             modal.innerHTML = `                 <div class="modal-content">     ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.contactinput', 'contactInput', 'js_string', 'dal = document.createElement('div');             modal.className = 'modal';             modal.id = 'contactInputModal';             modal.innerHTML = `                 <div class="modal-content">')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.введите_контакт', 'Введите контакт', 'js_string', 'closeModal('contactInputModal');                 } else {                     showNotification('Введите контакт', 'error');                 }             };         }                  // Функция для п')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.сначала_загрузите_реферальную', 'Сначала загрузите реферальную ссылку', 'js_string', 'ralLinkInput');             if (!linkInput || !linkInput.value) {                 showNotification('Сначала загрузите реферальную ссылку', 'error');                 return;             }              ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ссылка_скопирована_выберите', 'Ссылка скопирована! Выберите контакт в Telegram', 'js_string', 'window.open(shareUrl, '_blank');             }                          showNotification('Ссылка скопирована! Выберите контакт в Telegram', 'success');         }                  // Функция для провер')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.нельзя_переводить_самому', 'Нельзя переводить самому себе', 'js_string', '}                          if (recipientId == userData.id) {                 showNotification('Нельзя переводить самому себе', 'error');                 return;             }                          ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.неизвестно', 'Неизвестно', 'js_string', 'document.getElementById('recipientName').textContent = data.user.first_name || 'Неизвестно';                     document.getElementById('recipientId').textContent = `ID: ${data.user.id}`;')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.игрок_с_таким', 'Игрок с таким ID не найден', 'js_string', '{data.user.first_name}`, 'success');                 } else {                     showNotification('Игрок с таким ID не найден', 'error');                 }             } catch (error) {              ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.error_finding_recipient', 'Error finding recipient:', 'js_string', 'е найден', 'error');                 }             } catch (error) {                 console.error('Error finding recipient:', error);                 showNotification('Ошибка поиска игрока', 'error')')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_поиска_игрока', 'Ошибка поиска игрока', 'js_string', 'console.error('Error finding recipient:', error);                 showNotification('Ошибка поиска игрока', 'error');             } finally {                 hideLoading();             }         }')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.id_скопирован_в', 'ID скопирован в буфер обмена!', 'js_string', 'ator.clipboard.writeText(userData.id.toString()).then(() => {                     showNotification('ID скопирован в буфер обмена!', 'success');                 }).catch(() => {                     // ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.textarea', 'textarea', 'js_string', 'bel {             color: var(--tg-theme-text-color, #ffffff) !important;         }                  textarea.form-input {             resize: vertical;             min-height: 80px;         }')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.id_не_загружен', 'ID не загружен', 'js_string', 'ер обмена!', 'success');                 });             } else {                 showNotification('ID не загружен', 'error');             }         }                  async function confirmTransfer()')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.выберите_получателя', 'Выберите получателя', 'js_string', '💸 Перевести NDN</div>                 <div class="modal-subtitle" data-i18n="transfer.instructions">Выберите получателя и введите сумму</div>             </div>             <div class="transfer-conten')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.введите_корректную_сумму', 'Введите корректную сумму', 'js_string', 'ransferAmount').value);             if (!amount || amount <= 0) {                 showNotification('Введите корректную сумму', 'error');                 return;             }                          ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.недостаточно_средств', 'Недостаточно средств', 'js_string', 'if (amount > (userData.balance_ndn || 0)) {                 showNotification('Недостаточно средств', 'error');                 return;             }                          try {                 sh')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_перевода', 'Ошибка перевода', 'js_string', ').disabled = true;                 } else {                     showNotification(result.message || 'Ошибка перевода', 'error');                 }             } catch (error) {                 console.')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.transfer_error', 'Transfer error:', 'js_string', 'перевода', 'error');                 }             } catch (error) {                 console.error('Transfer error:', error);                 showNotification('Ошибка соединения', 'error');           ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.nodeon_crypto_зарабатывай', 'NodeOn Crypto - Зарабатывай NDN!', 'js_string', 'if (navigator.share) {                     navigator.share({                         title: 'NodeOn Crypto - Зарабатывай NDN!',                         text: message,                         url: link')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, category, context) 
                  VALUES ('texts.ошибка_при_шаринге', 'Ошибка при шаринге:', 'js_string', 'url: linkInput.value                     }).catch(err => {                         console.log('Ошибка при шаринге:', err);                         copyReferralLink();                     });         ')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  updated_at = CURRENT_TIMESTAMP;
