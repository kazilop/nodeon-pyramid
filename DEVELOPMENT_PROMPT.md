# NodeOn Pyramid - Промт для разработки

## Контекст проекта

Ты работаешь над **NodeOn Pyramid** - Telegram Mini App для реферальной игры с монетами NDN. Это полнофункциональное приложение с современным дизайном и продуманной архитектурой.

## Что уже реализовано

### Backend (FastAPI)
- ✅ Модели базы данных (User, Transaction, ReferralStats, PaymentRequest)
- ✅ API роутеры (auth, users, payments, referrals, stats)
- ✅ Система авторизации через Telegram WebApp
- ✅ Реферальная система с 7 уровнями
- ✅ Логика распределения наград
- ✅ Telegram бот с Mini App интеграцией

### Frontend (React)
- ✅ Современный UI с Telegram WebApp SDK
- ✅ Страницы: Dashboard, Rules, Stats, Profile
- ✅ Контекст авторизации
- ✅ Styled-components для стилизации
- ✅ Адаптивный дизайн

### Инфраструктура
- ✅ Docker Compose для развертывания
- ✅ PostgreSQL + Redis
- ✅ Конфигурация через переменные окружения
- ✅ Документация и README

## Архитектура системы

```
Telegram Bot <-> Mini App (React) <-> FastAPI <-> PostgreSQL
                    ↓
              Telegram Stars API
```

## Основные сущности

### User
- `telegram_id` - уникальный ID в Telegram
- `balance_ndn` - баланс игровой валюты
- `is_pro` - Pro статус (доступ к рефералам)
- `referral_link` - уникальная реферальная ссылка
- `inviter_id` - кто пригласил пользователя

### Transaction
- `type` - тип операции (buy_ndn, withdraw_ndn, referral_reward, etc.)
- `amount_ndn` - сумма в NDN
- `amount_stars` - сумма в Telegram Stars
- `referral_level` - уровень реферала (1-7)

## Бизнес-логика

### Реферальная система
1. Пользователь покупает Pro статус за 1000 NDN
2. Получает реферальную ссылку
3. Приглашает друзей по ссылке
4. Зарабатывает с каждого Pro реферала:
   - Уровень 1: 200 NDN
   - Уровень 2-7: по 150 NDN

### Распределение при покупке Pro (1000 NDN)
- 200 NDN → разработчику
- 200 NDN → 1-й уровень реферала
- 150 NDN → 2-й уровень реферала
- 150 NDN → 3-й уровень реферала
- 150 NDN → 4-й уровень реферала
- 150 NDN → 5-й уровень реферала
- 150 NDN → 6-й уровень реферала
- 150 NDN → 7-й уровень реферала

## Технические особенности

### Telegram WebApp
- Авторизация через `initData`
- Проверка подписи данных
- Использование Telegram переменных для тем
- Поддержка мобильных устройств

### Безопасность
- Валидация всех входящих данных
- Проверка подписи Telegram
- Защита от SQL-инъекций
- Rate limiting

### Производительность
- Кэширование через Redis
- Индексы в БД
- Асинхронные операции
- Оптимизация запросов

## Стиль кода

### Python (Backend)
```python
# Используй type hints
async def buy_pro(request: ProPurchaseRequest, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == request.user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="Пользователь не найден")
```

### JavaScript (Frontend)
```javascript
// React hooks и styled-components
const Dashboard = () => {
  const { user, updateUser } = useAuth();
  const [stats, setStats] = useState(null);
  
  return (
    <DashboardContainer>
      <WelcomeCard>
        <WelcomeTitle>Добро пожаловать, {user.first_name}!</WelcomeTitle>
      </WelcomeCard>
    </DashboardContainer>
  );
};
```

### CSS
```css
/* Используй переменные Telegram */
background: var(--tg-theme-bg-color, #ffffff);
color: var(--tg-theme-text-color, #000000);
```

## Частые задачи

### Добавление нового API endpoint
1. Создай Pydantic модель для запроса/ответа
2. Добавь функцию в соответствующий роутер
3. Обработай ошибки и валидацию
4. Добавь в документацию

### Изменение UI компонента
1. Обнови компонент в `frontend/src/`
2. Используй styled-components
3. Добавь анимации и переходы
4. Тестируй на мобильных устройствах

### Изменение бизнес-логики
1. Обнови модели в `database.py` если нужно
2. Измени логику в роутерах
3. Обнови фронтенд для отображения
4. Добавь миграции БД

## Полезные команды

### Docker
```bash
# Запуск всех сервисов
docker-compose up -d

# Просмотр логов
docker-compose logs -f backend

# Перезапуск сервиса
docker-compose restart backend
```

### Backend
```bash
# Запуск в режиме разработки
cd backend
uvicorn main:app --reload

# Запуск бота
python telegram_bot.py
```

### Frontend
```bash
# Запуск в режиме разработки
cd frontend
npm start

# Сборка для продакшена
npm run build
```

## Приоритеты разработки

### Высокий приоритет
1. Интеграция с Telegram Stars API
2. Тестирование всех функций
3. Исправление багов
4. Оптимизация производительности

### Средний приоритет
1. Добавление новых функций
2. Улучшение UI/UX
3. Расширение статистики
4. Добавление уведомлений

### Низкий приоритет
1. Дополнительные аналитики
2. A/B тестирование
3. Многоязычность
4. Дополнительные платежные методы

## Контакты и поддержка

- **Telegram**: @your_support_bot
- **GitHub**: your-repo
- **Email**: support@yourdomain.com

## Важные замечания

1. **Всегда тестируй изменения** перед коммитом
2. **Следуй принципам безопасности** при работе с платежами
3. **Оптимизируй для мобильных** устройств
4. **Документируй изменения** в коде
5. **Используй осмысленные названия** переменных и функций

---

**Помни**: Ты создаешь продукт, который будет использоваться реальными людьми для заработка денег. Каждая строка кода должна быть продумана и протестирована!
