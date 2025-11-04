-- SQL запросы для вставки локализации из JSON файлов
-- Сгенерировано автоматически

INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('app.name', 'NodeOn Crypto', 'NodeOn Crypto', 'NodeOn Crypto', 'NodeOn Crypto', 'NodeOn Crypto', 'NodeOn Crypto', 'NodeOn Crypto', 'NodeOn Crypto', 'NodeOn Crypto', 'NodeOn Crypto', 'NodeOn Crypto', 'NodeOn Crypto')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('app.description', 'Крипто игра с монетами NDN', 'Crypto game with NDN coins', 'Juego cripto con monedas NDN', 'Krypto-Spiel mit NDN-Münzen', 'Jeu crypto avec des pièces NDN', 'Gioco crypto con monete NDN', 'Jogo de cripto com moedas NDN', 'لعبة التشفير بعملات NDN', 'NDN सिक्कों के साथ क्रिप्टो गेम', 'NDNコインの暗号ゲーム', 'NDN 코인 암호화 게임', 'NDN币加密游戏')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('app.tagline', 'Зарабатывай, играй, приглашай друзей!', 'Earn, play, invite friends!', '¡Gana, invita amigos, conviértete en líder!', 'Verdiene, spiele, lade Freunde ein!', 'Gagnez, jouez, invitez des amis !', 'Guadagna, gioca, invita amici!', 'Ganhe, jogue, convide amigos!', 'اكسب، العب، ادع الأصدقاء!', 'कमाएं, खेलें, दोस्तों को आमंत्रित करें!', '稼ぐ、遊ぶ、友達を招待！', '벌고, 놀고, 친구 초대하세요!', '赚钱、游戏、邀请朋友！')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('welcome.title', 'Добро пожаловать в NodeOn Crypto!', 'Welcome to NodeOn Crypto!', '¡Bienvenido a NodeOn Crypto!', 'Willkommen bei NodeOn Crypto!', 'Bienvenue sur NodeOn Crypto !', 'Benvenuto in NodeOn Crypto!', 'Bem-vindo ao NodeOn Crypto!', 'مرحباً بك في NodeOn Crypto!', 'NodeOn Crypto में आपका स्वागत है!', 'NodeOn Cryptoへようこそ！', 'NodeOn Crypto에 오신 것을 환영합니다!', '欢迎来到NodeOn Crypto！')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('welcome.subtitle', 'Криптовалютная игра с реальными наградами', 'Cryptocurrency game with real rewards', 'Juego cripto con monedas NDN', 'Kryptowährungs-Spiel mit echten Belohnungen', 'Jeu de cryptomonnaie avec de vraies récompenses', 'Gioco di criptovalute con ricompense reali', 'Jogo de criptomoeda com recompensas reais', 'لعبة العملات المشفرة بمكافآت حقيقية', 'वास्तविक पुरस्कारों के साथ क्रिप्टोकरेंसी गेम', 'リアルな報酬のある暗号通貨ゲーム', '실제 보상이 있는 암호화폐 게임', '具有真实奖励的加密货币游戏')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('welcome.description', 'Покупай NDN за Telegram Stars, приглашай друзей и зарабатывай до 7 уровней в глубину!', 'Buy NDN with Telegram Stars, invite friends and earn up to 7 levels deep!', '¡Gana monedas NDN, compra estado Pro, invita amigos y obtén recompensas!', 'Kaufe NDN mit Telegram Stars, lade Freunde ein und verdiene bis zu 7 Ebenen tief!', 'Achetez des NDN avec Telegram Stars, invitez des amis et gagnez jusqu''à 7 niveaux de profondeur !', 'Compra NDN con Telegram Stars, invita amici e guadagna fino a 7 livelli di profondità!', 'Compre NDN com Telegram Stars, convide amigos e ganhe até 7 níveis de profundidade!', 'اشتر NDN بـ Telegram Stars، ادع الأصدقاء واكسب حتى 7 مستويات عمق!', 'Telegram Stars के साथ NDN खरीदें, दोस्तों को आमंत्रित करें और 7 स्तर तक कमाएं!', 'Telegram StarsでNDNを購入し、友達を招待して最大7レベルまで稼ごう！', 'Telegram Stars로 NDN을 구매하고, 친구를 초대하여 최대 7단계까지 벌어보세요!', '用Telegram Stars购买NDN，邀请朋友，赚取最多7层深度！')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('user.balance_ndn', 'Баланс NDN', 'NDN Balance', 'Saldo NDN', 'NDN Guthaben', 'Solde NDN', 'Saldo NDN', 'Saldo NDN', 'رصيد NDN', 'NDN बैलेंस', 'NDN残高', 'NDN 잔액', 'NDN余额')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('user.balance_stars', 'Баланс Stars', 'Stars Balance', 'Saldo Stars', 'Stars Guthaben', 'Solde Stars', 'Saldo Stars', 'Saldo Stars', 'رصيد Stars', 'Stars बैलेंस', 'Stars残高', 'Stars 잔액', 'Stars余额')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('user.pro_status', 'Pro статус', 'Pro Status', 'Estado Pro', 'Pro Status', 'Statut Pro', 'Stato Pro', 'Status Pro', 'حالة Pro', 'Pro स्थिति', 'Proステータス', 'Pro 상태', 'Pro状态')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('user.user_id', 'Ваш игровой ID', 'Your Game ID', 'Deine Spiel-ID', 'Votre ID de Jeu', 'Il Tuo ID di Gioco', 'Seu ID do Jogo', 'معرف اللعبة الخاص بك', 'आपका गेम ID', 'あなたのゲームID', '당신의 게임 ID', '您的游戏ID')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('user.user_id_hint', 'Используйте этот ID для переводов вам другими игроками', 'Use this ID for transfers from other players', 'Verwende diese ID für Überweisungen von anderen Spielern', 'Utilisez cet ID pour les transferts d''autres joueurs', 'Usa questo ID per i trasferimenti da altri giocatori', 'Use este ID para transferências de outros jogadores', 'استخدم هذا المعرف للتحويلات من اللاعبين الآخرين', 'अन्य खिलाड़ियों से ट्रांसफर के लिए इस ID का उपयोग करें', '他のプレイヤーからの送金にこのIDを使用', '다른 플레이어의 송금에 이 ID를 사용하세요', '使用此ID接收其他玩家的转账')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('tabs.core', '🏠 Основное')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('tabs.game', '🎮 Игра')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('tabs.miner', '⛏️ NDN Miner')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('game.daily_rewards', 'Ежедневные награды')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('game.daily_rewards_desc', 'Заходите каждый день и получайте бонусы!')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('game.achievements', 'Достижения')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('game.achievements_desc', 'Выполняйте задачи и получайте награды!')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('game.player_level', 'Уровень игрока')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('game.statistics', 'Статистика')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('game.days_played', 'Дней в игре')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('game.achievements_count', 'Достижений')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('game.total_earned', 'Заработано NDN')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('game.total_referrals', 'Приглашено')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('game.level', 'Уровень')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('game.xp', 'XP')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('game.claim_reward', 'Получить награду')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('game.reward_claimed', 'Награда получена!')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('game.level_up', 'Поздравляем! Вы достигли нового уровня!')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('game.achievement_completed', 'Достижение выполнено!')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('achievements.title', 'Достижения', 'Achievements', 'Erfolge', 'Succès', 'Obiettivi', 'Conquistas', 'الإنجازات', 'उपलब्धियां', '実績', '업적', '成就')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('achievements.description', 'Выполняйте задачи и получайте награды!', 'Complete tasks and earn rewards!')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('achievements.unlocked', 'Разблокировано', 'Unlocked', 'Freigeschaltet', 'Débloqué', 'Sbloccato', 'Desbloqueado', 'مفتوح', 'अनलॉक', 'アンロック済み', '잠금 해제됨', '已解锁')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('achievements.locked', 'Заблокировано', 'Locked', 'Gesperrt', 'Verrouillé', 'Bloccato', 'Bloqueado', 'مقفل', 'लॉक', 'ロック済み', '잠김', '已锁定')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('achievements.claim_reward', 'Получить награду', 'Claim Reward', 'Belohnung einfordern', 'Réclamer Récompense', 'Rivendica Ricompensa', 'Reivindicar Recompensa', 'المطالبة بالمكافأة', 'पुरस्कार का दावा करें', '報酬を受け取る', '보상 받기', '领取奖励')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('achievements.claimed', 'Получено', 'Claimed', 'Eingefordert', 'Réclamé', 'Rivendicato', 'Reivindicado', 'تم المطالبة', 'दावा किया गया', '受け取り済み', '받음', '已领取')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.buy_pro', 'Купить Pro статус', 'Buy Pro Status', 'Comprar Estado Pro', 'Pro Status kaufen', 'Acheter Statut Pro', 'Compra Stato Pro', 'Comprar Status Pro', 'شراء حالة Pro', 'Pro स्थिति खरीदें', 'Proステータスを購入', 'Pro 상태 구매', '购买Pro状态')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.buy_ndn', 'Купить NDN', 'Buy NDN', 'Comprar NDN', 'NDN kaufen', 'Acheter NDN', 'Compra NDN', 'Comprar NDN', 'شراء NDN', 'NDN खरीदें', 'NDNを購入', 'NDN 구매', '购买NDN')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.withdraw_ndn', 'Вывести NDN', 'Withdraw NDN', 'Retirar NDN', 'NDN abheben', 'Retirer NDN', 'Preleva NDN', 'Sacar NDN', 'سحب NDN', 'NDN निकालें', 'NDNを引き出し', 'NDN 출금', '提取NDN')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.transfer_ndn', 'Перевести NDN', 'Transfer NDN', 'NDN übertragen', 'Transférer NDN', 'Trasferisci NDN', 'Transferir NDN', 'تحويل NDN', 'NDN ट्रांसफर करें', 'NDNを送金', 'NDN 송금', '转账NDN')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.referrals', 'Мои рефералы', 'My Referrals', 'Mis Referidos', 'Meine Empfehlungen', 'Mes Parrainages', 'I Miei Referral', 'Meus Indicados', 'إحالاتي', 'मेरे रेफरल', '私の紹介', '내 추천', '我的推荐')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.leaderboard', 'Таблица лидеров', 'Leaderboard', 'Tabla de Líderes', 'Bestenliste', 'Classement', 'Classifica', 'Ranking', 'لوحة المتصدرين', 'लीडरबोर्ड', 'リーダーボード', '리더보드', '排行榜')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.rules', 'Правила игры', 'Game Rules', 'Reglas del Juego', 'Spielregeln', 'Règles du Jeu', 'Regole del Gioco', 'Regras do Jogo', 'قواعد اللعبة', 'गेम नियम', 'ゲームルール', '게임 규칙', '游戏规则')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('buttons.language', 'Язык', 'Language')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.achievements', 'Достижения', 'Achievements', 'Erfolge', 'Succès', 'Obiettivi', 'Conquistas', 'الإنجازات', 'उपलब्धियां', '実績', '업적', '成就')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.shops', 'Магазины', 'Shops', 'Shops', 'Boutiques', 'Negozi', 'Lojas', 'المتاجر', 'दुकानें', 'ショップ', '상점', '商店')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.invite_friends', 'Пригласить друзей', 'Invite Friends', 'Freunde einladen', 'Inviter des Amis', 'Invita Amici', 'Convidar Amigos', 'دعوة الأصدقاء', 'दोस्तों को आमंत्रित करें', '友達を招待', '친구 초대', '邀请朋友')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.close', 'Закрыть', 'Close', 'Cerrar', 'Schließen', 'Fermer', 'Chiudi', 'Fechar', 'إغلاق', 'बंद करें', '閉じる', '닫기', '关闭')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.confirm', 'Подтвердить', 'Confirm', 'Confirmar', 'Bestätigen', 'Confirmer', 'Conferma', 'Confirmar', 'تأكيد', 'पुष्टि करें', '確認', '확인', '确认')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.cancel', 'Отмена', 'Cancel', 'Cancelar', 'Abbrechen', 'Annuler', 'Annulla', 'Cancelar', 'إلغاء', 'रद्द करें', 'キャンセル', '취소', '取消')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.copy', 'Копировать', 'Copy', 'Kopieren', 'Copier', 'Copia', 'Copiar', 'نسخ', 'कॉपी करें', 'コピー', '복사', '复制')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.share', 'Поделиться', 'Share', 'Teilen', 'Partager', 'Condividi', 'Compartilhar', 'مشاركة', 'साझा करें', '共有', '공유', '分享')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.back', 'Назад', 'Back', 'Zurück', 'Retour', 'Indietro', 'Voltar', 'رجوع', 'वापस', '戻る', '뒤로', '返回')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.search', 'Поиск', 'Search', 'Suchen', 'Rechercher', 'Cerca', 'Pesquisar', 'بحث', 'खोजें', '検索', '검색', '搜索')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.find_player', 'Найти игрока', 'Find Player', 'Spieler finden', 'Trouver un Joueur', 'Trova Giocatore', 'Encontrar Jogador', 'البحث عن لاعب', 'खिलाड़ी खोजें', 'プレイヤーを検索', '플레이어 찾기', '查找玩家')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.send', 'Отправить', 'Send', 'Senden', 'Envoyer', 'Invia', 'Enviar', 'إرسال', 'भेजें', '送信', '보내기', '发送')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.buy', 'Купить', 'Buy', 'Kaufen', 'Acheter', 'Compra', 'Comprar', 'شراء', 'खरीदें', '購入', '구매', '购买')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.sell', 'Продать', 'Sell', 'Verkaufen', 'Vendre', 'Vendi', 'Vender', 'بيع', 'बेचें', '売却', '판매', '出售')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('buttons.exchange', 'Обменять', 'Exchange', 'Tauschen', 'Échanger', 'Scambia', 'Trocar', 'تبديل', 'एक्सचेंज करें', '交換', '교환', '兑换')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('buttons.change', 'Изменить', 'Change')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('buttons.withdraw', 'Вывести')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('pro.buy_success', 'Pro статус успешно активирован!', 'Pro status successfully activated!', '¡Estado Pro activado exitosamente!', 'Pro Status erfolgreich aktiviert!', 'Statut Pro activé avec succès !', 'Stato Pro attivato con successo!', 'Status Pro ativado com sucesso!', 'تم تفعيل حالة Pro بنجاح!', 'Pro स्थिति सफलतापूर्वक सक्रिय!', 'Proステータスが正常にアクティベートされました！', 'Pro 상태가 성공적으로 활성화되었습니다!', 'Pro状态成功激活！')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('pro.buy_error', 'Недостаточно NDN для покупки Pro статуса', 'Insufficient NDN to buy Pro status', 'NDN insuficiente para comprar estado Pro', 'Unzureichende NDN zum Kauf des Pro Status', 'NDN insuffisant pour acheter le statut Pro', 'NDN insufficienti per comprare lo stato Pro', 'NDN insuficiente para comprar status Pro', 'رصيد NDN غير كافي لشراء حالة Pro', 'Pro स्थिति खरीदने के लिए अपर्याप्त NDN', 'Proステータス購入にNDNが不足しています', 'Pro 상태 구매에 NDN이 부족합니다', 'NDN不足，无法购买Pro状态')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('pro.status', 'Pro статус', 'Pro Status', 'Pro Status', 'Statut Pro', 'Stato Pro', 'Status Pro', 'حالة Pro', 'Pro स्थिति', 'Proステータス', 'Pro 상태', 'Pro状态')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('pro.benefits', 'Преимущества Pro', 'Pro Benefits', 'Pro Vorteile', 'Avantages Pro', 'Vantaggi Pro', 'Benefícios Pro', 'مزايا Pro', 'Pro लाभ', 'Pro特典', 'Pro 혜택', 'Pro优势')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('pro.referral_link', 'Реферальная ссылка', 'Referral Link', 'Empfehlungslink', 'Lien de Parrainage', 'Link di Referral', 'Link de Indicação', 'رابط الإحالة', 'रेफरल लिंक', '紹介リンク', '추천 링크', '推荐链接')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('pro.total_referrals', 'Всего рефералов', 'Total Referrals', 'Gesamte Empfehlungen', 'Total Parrainages', 'Totale Referral', 'Total de Indicados', 'إجمالي الإحالات', 'कुल रेफरल', '総紹介数', '총 추천 수', '总推荐数')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('pro.total_earned', 'Заработано NDN', 'Total Earned NDN', 'Gesamt verdiente NDN', 'NDN Total Gagné', 'NDN Totali Guadagnati', 'NDN Total Ganho', 'إجمالي NDN المكتسب', 'कुल कमाया गया NDN', '総獲得NDN', '총 획득 NDN', '总赚取NDN')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('pro.regular_referrals', 'Обычных рефералов', 'Regular Referrals', 'Reguläre Empfehlungen', 'Parrainages Réguliers', 'Referral Regolari', 'Indicados Regulares', 'إحالات عادية', 'नियमित रेफरल', '通常紹介', '일반 추천', '普通推荐')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('pro.pro_referrals', 'Pro рефералов', 'Pro Referrals', 'Pro Empfehlungen', 'Parrainages Pro', 'Referral Pro', 'Indicados Pro', 'إحالات Pro', 'Pro रेफरल', 'Pro紹介', 'Pro 추천', 'Pro推荐')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('pro.cost', 'Стоимость: 1000 NDN')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('referrals.title', 'Мои рефералы', 'My Referrals', 'Sistema de Referidos', 'Meine Empfehlungen', 'Mes Parrainages', 'I Miei Referral', 'Meus Indicados', 'إحالاتي', 'मेरे रेफरल', '私の紹介', '내 추천', '我的推荐')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('referrals.total', 'Всего рефералов', 'Total Referrals', 'Gesamte Empfehlungen', 'Total Parrainages', 'Totale Referral', 'Total de Indicados', 'إجمالي الإحالات', 'कुल रेफरल', '総紹介数', '총 추천 수', '总推荐数')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('referrals.regular', 'Обычных', 'Regular', 'Regulär', 'Réguliers', 'Regolari', 'Regulares', 'عادية', 'नियमित', '通常', '일반', '普通')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('referrals.pro', 'Pro', 'Pro', 'Pro', 'Pro', 'Pro', 'Pro', 'Pro', 'Pro', 'Pro', 'Pro', 'Pro')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('referrals.earnings', '+{earnings} NDN', '+{earnings} NDN', 'Verdiente NDN', 'NDN Gagné', 'NDN Guadagnati', 'NDN Ganho', 'NDN المكتسب', 'कमाया गया NDN', '獲得NDN', '획득 NDN', '赚取NDN')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('referrals.level', '{level} уровень', 'Level {level}', 'Ebene', 'Niveau', 'Livello', 'Nível', 'المستوى', 'स्तर', 'レベル', '레벨', '级别')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('referrals.rewards', 'Награды', 'Rewards', 'Belohnungen', 'Récompenses', 'Ricompense', 'Recompensas', 'المكافآت', 'पुरस्कार', '報酬', '보상', '奖励')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('referrals.description', 'Награды начисляются только когда рефералы покупают PRO статус', 'Earnings only from Pro referrals', 'Invita amigos y gana recompensas hasta 7 niveles de profundidad', 'Einnahmen nur von Pro Empfehlungen', 'Gains uniquement des parrainages Pro', 'Guadagni solo dai referral Pro', 'Ganhos apenas de indicados Pro', 'الأرباح من إحالات Pro فقط', 'केवल Pro रेफरल से कमाई', 'Pro紹介からの収益のみ', 'Pro 추천에서만 수익', '仅从Pro推荐中赚取')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('referrals.invite_description', 'Поделитесь ссылкой и зарабатывайте с каждого реферала!')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('referrals.your_link', 'Ваша реферальная ссылка:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('referrals.show_link', 'Показать ссылку')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('referrals.invite_methods', 'Способы приглашения:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('referrals.select_contact', 'Выбрать контакт из Telegram')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('referrals.share_telegram', 'Поделиться в Telegram')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, es) 
                  VALUES ('referrals.copy_link', 'Скопировать ссылку', 'Copiar Enlace')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('referrals.how_to_earn', 'Как зарабатывать:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('referrals.step1', 'Друг переходит по вашей ссылке')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('referrals.step2', 'Регистрируется в игре')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('referrals.step3', 'Покупает PRO статус')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('referrals.step4', 'Вы получаете 200 NDN')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('referrals.step5', 'Зарабатываете до 7 уровней в глубину')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('referrals.level_stats', '📊 Статистика по уровням:', '📊 Statistics by levels:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('referrals.referrals_count', '{count} рефералов', '{count} referrals')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('referrals.no_level_stats', 'Статистика по уровням пока недоступна', 'Level statistics not available yet')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('referrals.referrals_list', '👥 Список рефералов по уровням:', '👥 Referrals list by levels:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('referrals.level_with_count', '📊 {level} уровень ({count} рефералов):', '📊 Level {level} ({count} referrals):')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('transfer.title', 'Перевести NDN', 'Transfer NDN', 'NDN übertragen', 'Transférer NDN', 'Trasferisci NDN', 'Transferir NDN', 'تحويل NDN', 'NDN ट्रांसफर करें', 'NDN送金', 'NDN 송금', '转账NDN')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('transfer.instructions', 'Выберите получателя и введите сумму', 'Select recipient and enter amount')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('transfer.recipient', 'Получатель', 'Recipient', 'Empfänger', 'Destinataire', 'Destinatario', 'Destinatário', 'المستلم', 'प्राप्तकर्ता', '受取人', '수신자', '收款人')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('transfer.amount', 'Сумма', 'Amount', 'Betrag', 'Montant', 'Importo', 'Valor', 'المبلغ', 'राशि', '金額', '금액', '金额')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('transfer.balance', 'Ваш баланс', 'Your Balance', 'Dein Guthaben', 'Votre Solde', 'Il Tuo Saldo', 'Seu Saldo', 'رصيدك', 'आपका बैलेंस', 'あなたの残高', '당신의 잔액', '您的余额')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('transfer.confirm', 'Подтвердить перевод', 'Confirm Transfer', 'Übertragung bestätigen', 'Confirmer le Transfert', 'Conferma Trasferimento', 'Confirmar Transferência', 'تأكيد التحويل', 'ट्रांसफर की पुष्टि करें', '送金を確認', '송금 확인', '确认转账')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('transfer.success', 'Перевод выполнен успешно!', 'Transfer completed successfully!', 'Übertragung erfolgreich abgeschlossen!', 'Transfert effectué avec succès !', 'Trasferimento completato con successo!', 'Transferência concluída com sucesso!', 'تم التحويل بنجاح!', 'ट्रांसफर सफलतापूर्वक पूरा!', '送金が正常に完了しました！', '송금이 성공적으로 완료되었습니다!', '转账成功完成！')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('transfer.error', 'Ошибка перевода', 'Transfer error', 'Übertragungsfehler', 'Erreur de transfert', 'Errore nel trasferimento', 'Erro na transferência', 'خطأ في التحويل', 'ट्रांसफर त्रुटि', '送金エラー', '송금 오류', '转账错误')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('transfer.insufficient_balance', 'Недостаточно NDN', 'Insufficient NDN', 'Unzureichende NDN', 'NDN insuffisant', 'NDN insufficienti', 'NDN insuficiente', 'رصيد NDN غير كافي', 'अपर्याप्त NDN', 'NDN不足', 'NDN 부족', 'NDN不足')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('transfer.user_not_found', 'Пользователь не найден', 'User not found', 'Benutzer nicht gefunden', 'Utilisateur non trouvé', 'Utente non trovato', 'Usuário não encontrado', 'لم يتم العثور على المستخدم', 'उपयोगकर्ता नहीं मिला', 'ユーザーが見つかりません', '사용자를 찾을 수 없습니다', '未找到用户')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('payment.rate', 'Курс: 1 NDN = 1 Telegram Star', 'Rate: 1 NDN = 1 Telegram Star')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('payment.stars_info', '💡 Stars поступают на баланс бота и могут быть выведены в TON', '💡 Stars go to bot balance and can be withdrawn to TON')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('payment.stars_cost', 'Стоимость в Stars:', 'Cost in Stars:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('exchange.stars_info', '💡 NDN списываются с вашего счета, Stars поступают в Telegram', '💡 NDN debited from your account, Stars go to Telegram')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('exchange.username', 'Ваш Telegram username:', 'Your Telegram username:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('exchange.receive_stars', 'Получите Stars:', 'Receive Stars:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('shops.title', 'Магазины', 'Shops', 'Shops', 'Boutiques', 'Negozi', 'Lojas', 'المتاجر', 'दुकानें', 'ショップ', '상점', '商店')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('shops.description', 'Откройте свой магазин за 10,000 NDN!', 'Open your own shop for 10,000 NDN!')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('shops.open_shop', 'Открыть магазин', 'Open Shop', 'Shop eröffnen', 'Ouvrir Boutique', 'Apri Negozio', 'Abrir Loja', 'فتح متجر', 'दुकान खोलें', 'ショップを開く', '상점 열기', '开设商店')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('shops.cost', 'Стоимость: 10,000 NDN', 'Cost: 10,000 NDN', 'Kosten: 10.000 NDN', 'Coût : 10 000 NDN', 'Costo: 10.000 NDN', 'Custo: 10.000 NDN', 'التكلفة: 10,000 NDN', 'लागत: 10,000 NDN', '費用：10,000 NDN', '비용: 10,000 NDN', '费用：10,000 NDN')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('shops.my_shop', 'Мой магазин', 'My Shop', 'Mein Shop', 'Ma Boutique', 'Il Mio Negozio', 'Minha Loja', 'متجري', 'मेरी दुकान', '私のショップ', '내 상점', '我的商店')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('shops.add_item', 'Добавить товар', 'Add Item', 'Artikel hinzufügen', 'Ajouter Article', 'Aggiungi Articolo', 'Adicionar Item', 'إضافة عنصر', 'आइटम जोड़ें', 'アイテムを追加', '아이템 추가', '添加商品')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('shops.add_item_description', 'Добавьте товар в ваш магазин')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('shops.shop_name', 'Название магазина', 'Shop Name', 'Shop Name', 'Nom de la Boutique', 'Nome Negozio', 'Nome da Loja', 'اسم المتجر', 'दुकान का नाम', 'ショップ名', '상점 이름', '商店名称')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('shops.shop_description', 'Описание магазина', 'Shop Description', 'Shop Beschreibung', 'Description de la Boutique', 'Descrizione Negozio', 'Descrição da Loja', 'وصف المتجر', 'दुकान का विवरण', 'ショップの説明', '상점 설명', '商店描述')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('shops.category', 'Категория')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('shops.item_name', 'Название товара')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('shops.item_description', 'Описание товара')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('shops.price_ndn', 'Цена в NDN')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('shops.price_stars', 'Цена в Stars')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('shops.item_type', 'Тип товара')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('shops.image_url', 'Ссылка на изображение')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('shops.stock', 'Количество на складе (-1 = безлимит)')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('shops.categories.general', 'Общие товары')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('shops.categories.digital', 'Цифровые товары')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('shops.categories.physical', 'Физические товары')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('shops.categories.services', 'Услуги')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('shops.categories.congratulations', 'Поздравления')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('shops.categories.merchandise', 'Мерч')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('shops.types.digital', 'Цифровой')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('shops.types.physical', 'Физический')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('shops.types.service', 'Услуга')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('withdraw.minimum', 'Минимальная сумма: 100 NDN')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('withdraw.recipient_id', 'Telegram ID получателя')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru) 
                  VALUES ('withdraw.recipient_placeholder', '@username или ID')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('leaderboard.title', 'Таблица лидеров', 'Leaderboard', 'Tabla de Líderes', 'Bestenliste', 'Classement', 'Classifica', 'Ranking', 'لوحة المتصدرين', 'लीडरबोर्ड', 'リーダーボード', '리더보드', '排行榜')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('leaderboard.rank', 'Место', 'Rank', 'Posición', 'Rang', 'Rang', 'Posizione', 'Posição', 'الترتيب', 'रैंक', '順位', '순위', '排名')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('leaderboard.player', 'Игрок', 'Player', 'Spieler', 'Joueur', 'Giocatore', 'Jogador', 'اللاعب', 'खिलाड़ी', 'プレイヤー', '플레이어', '玩家')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('leaderboard.balance', 'Баланс NDN', 'NDN Balance', 'Saldo NDN', 'NDN Guthaben', 'Solde NDN', 'Saldo NDN', 'Saldo NDN', 'رصيد NDN', 'NDN बैलेंस', 'NDN残高', 'NDN 잔액', 'NDN余额')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('leaderboard.referrals', 'Рефералы', 'Referrals', 'Empfehlungen', 'Parrainages', 'Referral', 'Indicados', 'الإحالات', 'रेफरल', '紹介', '추천', '推荐')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('leaderboard.pro_status', 'Pro статус', 'Pro Status', 'Pro Status', 'Statut Pro', 'Stato Pro', 'Status Pro', 'حالة Pro', 'Pro स्थिति', 'Proステータス', 'Pro 상태', 'Pro状态')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('admin.panel', 'Админ панель', 'Admin Panel', 'Admin Panel', 'Panneau Admin', 'Pannello Admin', 'Painel Admin', 'لوحة الإدارة', 'एडमिन पैनल', '管理パネル', '관리 패널', '管理面板')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('admin.status', 'Статус', 'Status', 'Status', 'Statut', 'Stato', 'Status', 'الحالة', 'स्थिति', 'ステータス', '상태', '状态')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('admin.wallet_stats', 'Статистика кошелька', 'Wallet Statistics', 'Wallet Statistiken', 'Statistiques Portefeuille', 'Statistiche Portafoglio', 'Estatísticas da Carteira', 'إحصائيات المحفظة', 'वॉलेट आंकड़े', 'ウォレット統計', '지갑 통계', '钱包统计')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('admin.system_stats', 'Статистика системы', 'System Statistics', 'System Statistiken', 'Statistiques Système', 'Statistiche Sistema', 'Estatísticas do Sistema', 'إحصائيات النظام', 'सिस्टम आंकड़े', 'システム統計', '시스템 통계', '系统统计')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('admin.exchange_requests', 'Заявки на обмен', 'Exchange Requests', 'Tausch Anfragen', 'Demandes d''Échange', 'Richieste di Scambio', 'Solicitações de Troca', 'طلبات التبديل', 'एक्सचेंज अनुरोध', '交換リクエスト', '교환 요청', '兑换请求')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('admin.user_management', 'Управление пользователями', 'User Management', 'Benutzerverwaltung', 'Gestion Utilisateurs', 'Gestione Utenti', 'Gerenciamento de Usuários', 'إدارة المستخدمين', 'उपयोगकर्ता प्रबंधन', 'ユーザー管理', '사용자 관리', '用户管理')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('admin.analytics', 'Аналитика', 'Analytics', 'Analytik', 'Analytiques', 'Analytics', 'Analytics', 'التحليلات', 'विश्लेषण', '分析', '분석', '分析')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('errors.auth_required', 'Требуется авторизация через Telegram. Откройте приложение в Telegram Mini App.', 'Telegram authorization required. Open the app in Telegram Mini App.', 'Se requiere autorización de Telegram. Abre la aplicación en Telegram Mini App.', 'Telegram-Autorisierung erforderlich. Öffne die App in Telegram Mini App.', 'Autorisation Telegram requise. Ouvrez l''app dans Telegram Mini App.', 'Autorizzazione Telegram richiesta. Apri l''app in Telegram Mini App.', 'Autorização do Telegram necessária. Abra o app no Telegram Mini App.', 'مطلوب تفويض Telegram. افتح التطبيق في Telegram Mini App.', 'Telegram प्राधिकरण आवश्यक। Telegram Mini App में ऐप खोलें।', 'Telegram認証が必要です。Telegram Mini Appでアプリを開いてください。', 'Telegram 인증이 필요합니다. Telegram Mini App에서 앱을 열어주세요.', '需要Telegram授权。请在Telegram Mini App中打开应用。')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('errors.user_not_found', 'Пользователь не найден', 'User not found', 'Usuario no encontrado', 'Benutzer nicht gefunden', 'Utilisateur non trouvé', 'Utente non trovato', 'Usuário não encontrado', 'لم يتم العثور على المستخدم', 'उपयोगकर्ता नहीं मिला', 'ユーザーが見つかりません', '사용자를 찾을 수 없습니다', '未找到用户')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('errors.insufficient_balance', 'Недостаточно средств', 'Insufficient funds', 'Fondos insuficientes', 'Unzureichende Mittel', 'Fonds insuffisants', 'Fondi insufficienti', 'Saldo insuficiente', 'رصيد غير كافي', 'अपर्याप्त फंड', '資金不足', '잔액 부족', '资金不足')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('errors.invalid_amount', 'Неверная сумма', 'Invalid amount', 'Ungültiger Betrag', 'Montant invalide', 'Importo non valido', 'Valor inválido', 'مبلغ غير صحيح', 'अमान्य राशि', '無効な金額', '유효하지 않은 금액', '金额无效')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('errors.server_error', 'Ошибка сервера', 'Server error', 'Serverfehler', 'Erreur serveur', 'Errore del server', 'Erro do servidor', 'خطأ في الخادم', 'सर्वर त्रुटि', 'サーバーエラー', '서버 오류', '服务器错误')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('errors.network_error', 'Ошибка сети', 'Network error', 'Error de red', 'Netzwerkfehler', 'Erreur réseau', 'Errore di rete', 'Erro de rede', 'خطأ في الشبكة', 'नेटवर्क त्रुटि', 'ネットワークエラー', '네트워크 오류', '网络错误')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('notifications.success', 'Успешно!', 'Success!', 'Erfolgreich!', 'Succès !', 'Successo!', 'Sucesso!', 'نجح!', 'सफलता!', '成功！', '성공!', '成功！')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('notifications.error', 'Ошибка!', 'Error!', 'Fehler!', 'Erreur !', 'Errore!', 'Erro!', 'خطأ!', 'त्रुटि!', 'エラー！', '오류!', '错误！')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('notifications.info', 'Информация', 'Info', 'Info', 'Info', 'Info', 'Info', 'معلومات', 'जानकारी', '情報', '정보', '信息')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('notifications.warning', 'Внимание!', 'Warning!', 'Warnung!', 'Attention !', 'Attenzione!', 'Aviso!', 'تحذير!', 'चेतावनी!', '警告！', '경고!', '警告！')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('notifications.copied', 'Скопировано!', 'Copied!', 'Kopiert!', 'Copié !', 'Copiato!', 'Copiado!', 'تم النسخ!', 'कॉपी किया गया!', 'コピーしました！', '복사됨!', '已复制！')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('notifications.saved', 'Сохранено!', 'Saved!', 'Gespeichert!', 'Sauvegardé !', 'Salvato!', 'Salvo!', 'تم الحفظ!', 'सहेजा गया!', '保存しました！', '저장됨!', '已保存！')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('notifications.sent', 'Отправлено!', 'Sent!', 'Gesendet!', 'Envoyé !', 'Inviato!', 'Enviado!', 'تم الإرسال!', 'भेजा गया!', '送信しました！', '전송됨!', '已发送！')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('game_rules.title', 'Правила игры', 'Game Rules', 'Spielregeln', 'Règles du Jeu', 'Regole del Gioco', 'Regras do Jogo', 'قواعد اللعبة', 'गेम नियम', 'ゲームルール', '게임 규칙', '游戏规则')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('game_rules.how_to_play', 'Как играть', 'How to Play', 'Wie man spielt', 'Comment Jouer', 'Come Giocare', 'Como Jogar', 'كيفية اللعب', 'कैसे खेलें', '遊び方', '게임 방법', '如何游戏')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('game_rules.step1', '1. Покупайте NDN за Telegram Stars', '1. Buy NDN with Telegram Stars', '1. Kaufe NDN mit Telegram Stars', '1. Achetez des NDN avec Telegram Stars', '1. Compra NDN con Telegram Stars', '1. Compre NDN com Telegram Stars', '1. اشتر NDN بـ Telegram Stars', '1. Telegram Stars के साथ NDN खरीदें', '1. Telegram StarsでNDNを購入', '1. Telegram Stars로 NDN 구매', '1. 用Telegram Stars购买NDN')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('game_rules.step2', '2. Приглашайте друзей по реферальной ссылке', '2. Invite friends via referral link', '2. Lade Freunde über Empfehlungslink ein', '2. Invitez des amis via lien de parrainage', '2. Invita amici tramite link di referral', '2. Convide amigos via link de indicação', '2. ادع الأصدقاء عبر رابط الإحالة', '2. रेफरल लिंक के माध्यम से दोस्तों को आमंत्रित करें', '2. 紹介リンクで友達を招待', '2. 추천 링크로 친구 초대', '2. 通过推荐链接邀请朋友')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('game_rules.step3', '3. Получайте награды за Pro рефералов', '3. Get rewards for Pro referrals', '3. Erhalte Belohnungen für Pro Empfehlungen', '3. Obtenez des récompenses pour parrainages Pro', '3. Ottieni ricompense per referral Pro', '3. Ganhe recompensas por indicados Pro', '3. احصل على مكافآت للإحالات Pro', '3. Pro रेफरल के लिए पुरस्कार प्राप्त करें', '3. Pro紹介で報酬を獲得', '3. Pro 추천으로 보상 획득', '3. 从Pro推荐中获得奖励')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('game_rules.step4', '4. Открывайте достижения и магазины', '4. Unlock achievements and shops', '4. Schalte Erfolge und Shops frei', '4. Débloquez succès et boutiques', '4. Sblocca obiettivi e negozi', '4. Desbloqueie conquistas e lojas', '4. افتح الإنجازات والمتاجر', '4. उपलब्धियां और दुकानें अनलॉक करें', '4. 実績とショップをアンロック', '4. 업적과 상점 잠금 해제', '4. 解锁成就和商店')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('game_rules.rewards', 'Награды', 'Rewards', 'Belohnungen', 'Récompenses', 'Ricompense', 'Recompensas', 'المكافآت', 'पुरस्कार', '報酬', '보상', '奖励')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('game_rules.level1', '1-й уровень: 200 NDN', 'Level 1: 200 NDN', 'Ebene 1: 200 NDN', 'Niveau 1 : 200 NDN', 'Livello 1: 200 NDN', 'Nível 1: 200 NDN', 'المستوى 1: 200 NDN', 'स्तर 1: 200 NDN', 'レベル1：200 NDN', '레벨 1: 200 NDN', '第1级：200 NDN')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('game_rules.level2_7', '2-7 уровни: по 150 NDN', 'Levels 2-7: 150 NDN each', 'Ebenen 2-7: je 150 NDN', 'Niveaux 2-7 : 150 NDN chacun', 'Livelli 2-7: 150 NDN ciascuno', 'Níveis 2-7: 150 NDN cada', 'المستويات 2-7: 150 NDN لكل منها', 'स्तर 2-7: प्रत्येक 150 NDN', 'レベル2-7：各150 NDN', '레벨 2-7: 각 150 NDN', '第2-7级：各150 NDN')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('game_rules.developer_fee', 'Комиссия разработчика: 200 NDN', 'Developer fee: 200 NDN', 'Entwicklergebühr: 200 NDN', 'Commission développeur : 200 NDN', 'Commissione sviluppatore: 200 NDN', 'Taxa do desenvolvedor: 200 NDN', 'رسوم المطور: 200 NDN', 'डेवलपर शुल्क: 200 NDN', '開発者手数料：200 NDN', '개발자 수수료: 200 NDN', '开发者费用：200 NDN')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('language.select', 'Выберите язык', 'Select Language', 'Sprache wählen', 'Sélectionner Langue', 'Seleziona Lingua', 'Selecionar Idioma', 'اختر اللغة', 'भाषा चुनें', '言語を選択', '언어 선택', '选择语言')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('language.russian', 'Русский', 'Русский', 'Русский', 'Русский', 'Русский', 'Русский', 'Русский', 'Русский', 'Русский', 'Русский', 'Русский')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('language.english', 'English', 'English', 'English', 'English', 'English', 'English', 'English', 'English', 'English', 'English', 'English')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('language.spanish', 'Español', 'Español', 'Español', 'Español', 'Español', 'Español', 'Español', 'Español', 'Español', 'Español', 'Español')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('language.german', 'Deutsch', 'Deutsch', 'Deutsch', 'Deutsch', 'Deutsch', 'Deutsch', 'Deutsch', 'Deutsch', 'Deutsch', 'Deutsch', 'Deutsch')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('language.french', 'Français', 'Français', 'Français', 'Français', 'Français', 'Français', 'Français', 'Français', 'Français', 'Français', 'Français')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('language.chinese', '中文', '中文', '中文', '中文', '中文', '中文', '中文', '中文', '中文', '中文', '中文')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('language.japanese', '日本語', '日本語', '日本語', '日本語', '日本語', '日本語', '日本語', '日本語', '日本語', '日本語', '日本語')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('language.korean', '한국어', '한국어', '한국어', '한국어', '한국어', '한국어', '한국어', '한국어', '한국어', '한국어', '한국어')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('language.arabic', 'العربية', 'العربية', 'العربية', 'العربية', 'العربية', 'العربية', 'العربية', 'العربية', 'العربية', 'العربية', 'العربية')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('language.portuguese', 'Português', 'Português', 'Português', 'Português', 'Português', 'Português', 'Português', 'Português', 'Português', 'Português', 'Português')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('language.italian', 'Italiano', 'Italiano', 'Italiano', 'Italiano', 'Italiano', 'Italiano', 'Italiano', 'Italiano', 'Italiano', 'Italiano', 'Italiano')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, de, fr, it, pt, ar, hi, ja, ko, zh) 
                  VALUES ('language.hindi', 'हिन्दी', 'हिन्दी', 'हिन्दी', 'हिन्दी', 'हिन्दी', 'हिन्दी', 'हिन्दी', 'हिन्दी', 'हिन्दी', 'हिन्दी', 'हिन्दी')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.title', 'NDN Miner', 'NDN Miner', 'NDN Miner', 'NDN Miner', 'NDN Miner', 'NDN矿工')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.stats.ndn_gas', 'NDN Gas', 'NDN Gas', 'NDN Gas', 'NDN Gas', 'NDN Gas', 'NDN Gas')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.stats.energy', 'Энергия', 'Energy', 'Energía', 'Energie', 'Énergie', '能量')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.stats.gas_per_second', 'Gas/сек', 'Gas/sec', 'Gas/seg', 'Gas/sek', 'Gas/sec', 'Gas/秒')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.stats.gas_per_minute', 'Gas/мин', 'Gas/min')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.farms.title', 'Фермы майнинга', 'Mining Farms', 'Granjas de minería', 'Mining-Farmen', 'Fermes de minage', '挖矿农场')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.farms.cpu_miner', 'CPU Miner', 'CPU Miner', 'CPU Miner', 'CPU Miner', 'CPU Miner', 'CPU矿工')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.farms.cpu_miner_desc', 'Базовая ферма на процессоре', 'Basic processor farm', 'Granja básica de procesador', 'Grundlegende Prozessor-Farm', 'Ferme de base sur processeur', '基础处理器农场')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.farms.gpu_farm', 'GPU Farm', 'GPU Farm', 'GPU Farm', 'GPU Farm', 'GPU Farm', 'GPU农场')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.farms.gpu_farm_desc', 'Мощная ферма на видеокартах', 'Powerful graphics card farm', 'Granja potente de tarjetas gráficas', 'Leistungsstarke Grafikkarten-Farm', 'Ferme puissante sur cartes graphiques', '强大的显卡农场')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.farms.asic_rig', 'ASIC Rig', 'ASIC Rig', 'ASIC Rig', 'ASIC Rig', 'ASIC Rig', 'ASIC设备')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.farms.asic_rig_desc', 'Профессиональная ферма ASIC', 'Professional ASIC farm', 'Granja profesional ASIC', 'Professionelle ASIC-Farm', 'Ferme professionnelle ASIC', '专业ASIC农场')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.farms.data_center', 'Data Center', 'Data Center', 'Data Center', 'Data Center', 'Data Center', '数据中心')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.farms.data_center_desc', 'Мега-ферма в дата-центре', 'Mega-farm in data center', 'Mega-granja en centro de datos', 'Mega-Farm im Rechenzentrum', 'Méga-ferme en centre de données', '数据中心巨型农场')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.farms.gas_per_sec', 'Gas/сек', 'Gas/sec', 'Gas/seg', 'Gas/sek', 'Gas/sec', 'Gas/秒')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.farms.gas_per_min', 'Gas/мин', 'Gas/min')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.farms.energy_cost', 'Энергия', 'Energy', 'Energía', 'Energie', 'Énergie', '能量')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.farms.quantity', 'Количество', 'Quantity', 'Cantidad', 'Anzahl', 'Quantité', '数量')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.farms.cost', 'Стоимость', 'Cost', 'Costo', 'Kosten', 'Coût', '成本')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.farms.buy', 'Купить', 'Buy', 'Comprar', 'Kaufen', 'Acheter', '购买')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.farms.locked', 'Заблокировано', 'Locked', 'Bloqueado', 'Gesperrt', 'Verrouillé', '已锁定')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.farms.not_enough_gas', 'Недостаточно Gas', 'Not enough Gas', 'Gas insuficiente', 'Nicht genug Gas', 'Pas assez de Gas', 'Gas不足')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.title', 'Улучшения', 'Upgrades', 'Mejoras', 'Upgrades', 'Améliorations', '升级')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.speed', 'Скорость', 'Speed', 'Velocidad', 'Geschwindigkeit', 'Vitesse', '速度')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.efficiency', 'Эффективность', 'Efficiency', 'Eficiencia', 'Effizienz', 'Efficacité', '效率')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.automation', 'Автоматизация', 'Automation', 'Automatización', 'Automatisierung', 'Automatisation', '自动化')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.premium', 'Премиум', 'Premium', 'Premium', 'Premium', 'Premium', '高级')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.speed_upgrades.fast_processor', 'Быстрый процессор', 'Fast Processor', 'Procesador rápido', 'Schneller Prozessor', 'Processeur rapide', '快速处理器')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.speed_upgrades.fast_processor_desc', '+10% скорости', '+10% speed', '+10% velocidad', '+10% Geschwindigkeit', '+10% vitesse', '+10%速度')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.speed_upgrades.code_optimization', 'Оптимизация кода', 'Code Optimization', 'Optimización de código', 'Code-Optimierung', 'Optimisation du code', '代码优化')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.speed_upgrades.code_optimization_desc', '+25% скорости', '+25% speed', '+25% velocidad', '+25% Geschwindigkeit', '+25% vitesse', '+25%速度')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.speed_upgrades.parallel_computing', 'Параллельные вычисления', 'Parallel Computing', 'Computación paralela', 'Parallele Berechnung', 'Calcul parallèle', '并行计算')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.speed_upgrades.parallel_computing_desc', '+50% скорости', '+50% speed', '+50% velocidad', '+50% Geschwindigkeit', '+50% vitesse', '+50%速度')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.efficiency_upgrades.energy_saving', 'Энергосбережение', 'Energy Saving', 'Ahorro de energía', 'Energiesparen', 'Économie d''énergie', '节能')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.efficiency_upgrades.energy_saving_desc', '-20% энергии', '-20% energy', '-20% energía', '-20% Energie', '-20% énergie', '-20%能量')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.efficiency_upgrades.smart_cooling', 'Умное охлаждение', 'Smart Cooling', 'Enfriamiento inteligente', 'Intelligente Kühlung', 'Refroidissement intelligent', '智能冷却')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.efficiency_upgrades.smart_cooling_desc', '-40% энергии', '-40% energy', '-40% energía', '-40% Energie', '-40% énergie', '-40%能量')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.efficiency_upgrades.quantum_optimization', 'Квантовая оптимизация', 'Quantum Optimization', 'Optimización cuántica', 'Quantenoptimierung', 'Optimisation quantique', '量子优化')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.efficiency_upgrades.quantum_optimization_desc', '-60% энергии', '-60% energy', '-60% energía', '-60% Energie', '-60% énergie', '-60%能量')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.automation_upgrades.auto_collect', 'Авто-сбор', 'Auto-Collect', 'Auto-recogida', 'Auto-Sammlung', 'Auto-collecte', '自动收集')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.automation_upgrades.auto_collect_desc', 'Автоматический сбор Gas', 'Automatic Gas collection', 'Recolección automática de Gas', 'Automatische Gas-Sammlung', 'Collecte automatique de Gas', '自动收集Gas')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.automation_upgrades.smart_algorithms', 'Умные алгоритмы', 'Smart Algorithms', 'Algoritmos inteligentes', 'Intelligente Algorithmen', 'Algorithmes intelligents', '智能算法')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.automation_upgrades.smart_algorithms_desc', 'Оптимизация майнинга', 'Mining optimization', 'Optimización de minería', 'Mining-Optimierung', 'Optimisation du minage', '挖矿优化')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.automation_upgrades.ai_management', 'ИИ управление', 'AI Management', 'Gestión IA', 'KI-Management', 'Gestion IA', 'AI管理')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.automation_upgrades.ai_management_desc', 'Полная автоматизация', 'Full automation', 'Automatización completa', 'Vollständige Automatisierung', 'Automatisation complète', '完全自动化')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.cost', 'Стоимость', 'Cost', 'Costo', 'Kosten', 'Coût', '成本')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.bought', 'Куплено', 'Bought', 'Comprado', 'Gekauft', 'Acheté', '已购买')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.max_level', 'Макс. уровень', 'Max Level', 'Nivel máx.', 'Max. Level', 'Niveau max', '最高等级')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.upgrades.not_enough_gas', 'Недостаточно Gas', 'Not enough Gas', 'Gas insuficiente', 'Nicht genug Gas', 'Pas assez de Gas', 'Gas不足')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.shop.title', 'Магазин', 'Shop', 'Tienda', 'Shop', 'Boutique', '商店')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.shop.energy_drink', 'Энергетический напиток', 'Energy Drink', 'Bebida energética', 'Energiedrink', 'Boisson énergétique', '能量饮料')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.shop.energy_drink_desc', 'Восстанавливает 50 энергии', 'Restores 50 energy', 'Restaura 50 energía', 'Stellt 50 Energie wieder her', 'Restaure 50 énergie', '恢复50能量')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.shop.premium_booster', 'Премиум ускоритель', 'Premium Booster', 'Booster premium', 'Premium-Booster', 'Booster premium', '高级加速器')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.shop.premium_booster_desc', '2x скорость на 1 час', '2x speed for 1 hour', '2x velocidad por 1 hora', '2x Geschwindigkeit für 1 Stunde', '2x vitesse pendant 1 heure', '1小时2倍速度')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.shop.golden_farm', 'Золотая ферма', 'Golden Farm', 'Granja dorada', 'Goldene Farm', 'Ferme dorée', '黄金农场')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.shop.golden_farm_desc', 'Эксклюзивная ферма', 'Exclusive farm', 'Granja exclusiva', 'Exklusive Farm', 'Ferme exclusive', '专属农场')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.shop.buy', 'Купить', 'Buy', 'Comprar', 'Kaufen', 'Acheter', '购买')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.leaderboard.title', 'Рейтинг майнеров', 'Miner Leaderboard', 'Ranking de mineros', 'Miner-Rangliste', 'Classement des mineurs', '矿工排行榜')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.leaderboard.rank', 'Место', 'Rank', 'Posición', 'Rang', 'Rang', '排名')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.leaderboard.player', 'Игрок', 'Player', 'Jugador', 'Spieler', 'Joueur', '玩家')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.leaderboard.gas_earned', 'Gas заработано', 'Gas Earned', 'Gas ganado', 'Gas verdient', 'Gas gagné', 'Gas赚取')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.leaderboard.farms_count', 'Ферм', 'Farms', 'Granjas', 'Farmen', 'Fermes', '农场')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.leaderboard.level', 'Уровень', 'Level', 'Nivel', 'Level', 'Niveau', '等级')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en, es, de, fr, zh) 
                  VALUES ('miner.leaderboard.you', 'Вы', 'You', 'Tú', 'Du', 'Vous', '你')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.energy.refill_button', 'Пополнить энергию', 'Refill Energy')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.energy.waiting', 'Ожидание...', 'Waiting...')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.energy.next_refill', 'Следующее пополнение через:', 'Next refill in:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.energy.refilled', 'Энергия полностью восстановлена!', 'Energy fully restored!')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.energy.next_event', 'След. событие', 'Next event')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.sync.button', 'Синхронизировать', 'Synchronize')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.sync.waiting', 'Синхронизация...', 'Synchronizing...')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.sync.success', 'Данные синхронизированы с сервером', 'Data synchronized with server')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.sync.error', 'Ошибка синхронизации данных', 'Synchronization error')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.sync.cooldown', 'Следующее пополнение через:', 'Next refill in:')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.tabs.farms', 'Фермы', 'Farms')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.tabs.upgrades', 'Улучшения', 'Upgrades')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.tabs.boosts', 'Бусты', 'Boosts')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.tabs.special', 'Особые', 'Special')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.tabs.quests', 'Квесты', 'Quests')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.tabs.shop', 'Магазин', 'Shop')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.tabs.leaderboard', 'Рейтинг', 'Leaderboard')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.boosts.title', 'Бусты', 'Boosts')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.boosts.activate', 'Активировать', 'Activate')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.boosts.active', 'Активен', 'Active')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.boosts.not_enough_gas', 'Недостаточно Gas', 'Not enough Gas')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.special.title', 'Особые майнеры', 'Special Miners')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.special.watch_ad', 'Смотреть рекламу', 'Watch Ad')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.special.active', 'Активен', 'Active')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.special.not_enough_gas', 'Недостаточно Gas', 'Not enough Gas')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.quests.title', 'Квесты', 'Quests')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.quests.reward', 'Награда', 'Reward')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.quests.complete', 'Получить награду', 'Get Reward')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.quests.completed', 'Выполнено', 'Completed')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
INSERT INTO nodeon_localization (text_id, ru, en) 
                  VALUES ('miner.quests.in_progress', 'В процессе', 'In Progress')
                  ON CONFLICT (text_id) DO UPDATE SET 
                  ru = EXCLUDED.ru,
                  en = EXCLUDED.en,
                  es = EXCLUDED.es,
                  de = EXCLUDED.de,
                  fr = EXCLUDED.fr,
                  it = EXCLUDED.it,
                  pt = EXCLUDED.pt,
                  ar = EXCLUDED.ar,
                  hi = EXCLUDED.hi,
                  ja = EXCLUDED.ja,
                  ko = EXCLUDED.ko,
                  zh = EXCLUDED.zh,
                  updated_at = CURRENT_TIMESTAMP;
