import React, { useState, useEffect } from 'react';
import styled from 'styled-components';
import { User, Coins, Star, Download, Upload, History, Settings } from 'lucide-react';
import axios from 'axios';
import { useAuth } from '../contexts/AuthContext';

const ProfileContainer = styled.div`
  padding: 20px 0;
`;

const Section = styled.div`
  background: var(--tg-theme-secondary-bg-color, #f8f9fa);
  border-radius: 16px;
  padding: 20px;
  margin-bottom: 20px;
  border: 1px solid var(--tg-theme-hint-color, #e0e0e0);
`;

const SectionTitle = styled.h2`
  font-size: 20px;
  margin-bottom: 16px;
  color: var(--tg-theme-text-color, #000000);
  display: flex;
  align-items: center;
  gap: 8px;
`;

const UserCard = styled.div`
  background: var(--tg-theme-bg-color, #ffffff);
  border-radius: 16px;
  padding: 24px;
  text-align: center;
  border: 1px solid var(--tg-theme-hint-color, #e0e0e0);
  margin-bottom: 20px;
`;

const Avatar = styled.div`
  width: 80px;
  height: 80px;
  border-radius: 50%;
  background: var(--tg-theme-button-color, #2481cc);
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 16px;
  color: white;
  font-size: 32px;
  font-weight: bold;
`;

const UserName = styled.h2`
  font-size: 24px;
  margin-bottom: 8px;
  color: var(--tg-theme-text-color, #000000);
`;

const UserInfo = styled.p`
  color: var(--tg-theme-hint-color, #666666);
  margin-bottom: 16px;
`;

const ProBadge = styled.div`
  background: linear-gradient(135deg, #f39c12, #e67e22);
  color: white;
  padding: 8px 16px;
  border-radius: 20px;
  font-size: 14px;
  font-weight: bold;
  display: inline-block;
`;

const StatsGrid = styled.div`
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
  margin-bottom: 20px;
`;

const StatCard = styled.div`
  background: var(--tg-theme-bg-color, #ffffff);
  border-radius: 12px;
  padding: 20px;
  text-align: center;
  border: 1px solid var(--tg-theme-hint-color, #e0e0e0);
`;

const StatIcon = styled.div`
  width: 48px;
  height: 48px;
  border-radius: 12px;
  background: ${props => props.color || '#2481cc'};
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 12px;
  color: white;
`;

const StatValue = styled.div`
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 4px;
  color: var(--tg-theme-text-color, #000000);
`;

const StatLabel = styled.div`
  font-size: 14px;
  color: var(--tg-theme-hint-color, #666666);
`;

const ActionButton = styled.button`
  width: 100%;
  background: var(--tg-theme-button-color, #2481cc);
  color: var(--tg-theme-button-text-color, #ffffff);
  border: none;
  border-radius: 12px;
  padding: 16px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  margin-bottom: 12px;
  transition: all 0.2s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  
  &:hover {
    opacity: 0.9;
  }
  
  &:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }
`;

const SecondaryButton = styled(ActionButton)`
  background: var(--tg-theme-secondary-bg-color, #f0f0f0);
  color: var(--tg-theme-text-color, #000000);
`;

const TransactionItem = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 16px;
  background: var(--tg-theme-bg-color, #ffffff);
  border-radius: 8px;
  margin-bottom: 8px;
  border: 1px solid var(--tg-theme-hint-color, #e0e0e0);
`;

const TransactionInfo = styled.div`
  flex: 1;
`;

const TransactionType = styled.div`
  font-weight: 600;
  color: var(--tg-theme-text-color, #000000);
  margin-bottom: 4px;
`;

const TransactionDate = styled.div`
  font-size: 12px;
  color: var(--tg-theme-hint-color, #666666);
`;

const TransactionAmount = styled.div`
  font-weight: bold;
  color: ${props => props.positive ? '#27ae60' : '#e74c3c'};
`;

const Profile = () => {
  const { user, updateUser } = useAuth();
  const [transactions, setTransactions] = useState([]);
  const [loading, setLoading] = useState(false);
  const [withdrawAmount, setWithdrawAmount] = useState('');

  useEffect(() => {
    if (user) {
      fetchTransactions();
    }
  }, [user]);

  const fetchTransactions = async () => {
    try {
      const response = await axios.get(`/api/stats/transactions/${user.user_id}?limit=10`);
      setTransactions(response.data.transactions);
    } catch (error) {
      console.error('Error fetching transactions:', error);
    }
  };

  const handleWithdraw = async () => {
    const amount = parseFloat(withdrawAmount);
    
    if (!amount || amount <= 0) {
      alert('Введите корректную сумму');
      return;
    }

    if (amount > user.balance_ndn) {
      alert('Недостаточно NDN на балансе');
      return;
    }

    setLoading(true);
    try {
      const response = await axios.post('/api/users/withdraw', {
        user_id: user.user_id,
        amount_ndn: amount
      });
      
      updateUser({
        ...user,
        balance_ndn: response.data.new_balance
      });
      
      setWithdrawAmount('');
      alert('Заявка на вывод создана');
      fetchTransactions();
    } catch (error) {
      alert('Ошибка при создании заявки: ' + error.response?.data?.detail);
    } finally {
      setLoading(false);
    }
  };

  const getTransactionTypeText = (type) => {
    const types = {
      'buy_ndn': 'Покупка NDN',
      'withdraw_ndn': 'Вывод NDN',
      'referral_reward': 'Реферальная награда',
      'developer_fee': 'Комиссия разработчика',
      'pro_purchase': 'Покупка Pro статуса'
    };
    return types[type] || type;
  };

  const formatDate = (dateString) => {
    return new Date(dateString).toLocaleDateString('ru-RU', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  if (!user) return null;

  return (
    <ProfileContainer>
      <UserCard>
        <Avatar>
          {user.first_name?.charAt(0) || user.username?.charAt(0) || 'U'}
        </Avatar>
        <UserName>
          {user.first_name} {user.last_name}
        </UserName>
        <UserInfo>@{user.username || 'без_username'}</UserInfo>
        {user.is_pro && <ProBadge>PRO</ProBadge>}
      </UserCard>

      <StatsGrid>
        <StatCard>
          <StatIcon color="#f39c12">
            <Coins size={24} />
          </StatIcon>
          <StatValue>{user.balance_ndn}</StatValue>
          <StatLabel>NDN</StatLabel>
        </StatCard>
        <StatCard>
          <StatIcon color="#e74c3c">
            <Star size={24} />
          </StatIcon>
          <StatValue>{user.balance_ndn}</StatValue>
          <StatLabel>Stars</StatLabel>
        </StatCard>
      </StatsGrid>

      <Section>
        <SectionTitle>
          <Download size={20} />
          Вывод средств
        </SectionTitle>
        <div style={{ marginBottom: '16px' }}>
          <input
            type="number"
            placeholder="Сумма NDN для вывода"
            value={withdrawAmount}
            onChange={(e) => setWithdrawAmount(e.target.value)}
            style={{
              width: '100%',
              padding: '12px',
              border: '1px solid var(--tg-theme-hint-color, #e0e0e0)',
              borderRadius: '8px',
              fontSize: '16px',
              marginBottom: '12px'
            }}
          />
          <ActionButton 
            onClick={handleWithdraw} 
            disabled={loading || !withdrawAmount}
          >
            <Download size={16} />
            {loading ? 'Обработка...' : 'Вывести NDN'}
          </ActionButton>
        </div>
      </Section>

      <Section>
        <SectionTitle>
          <Upload size={20} />
          Покупка NDN
        </SectionTitle>
        <ActionButton>
          <Upload size={16} />
          Купить NDN за Stars
        </ActionButton>
      </Section>

      <Section>
        <SectionTitle>
          <History size={20} />
          История транзакций
        </SectionTitle>
        {transactions.length > 0 ? (
          transactions.map((transaction) => (
            <TransactionItem key={transaction.id}>
              <TransactionInfo>
                <TransactionType>
                  {getTransactionTypeText(transaction.type)}
                </TransactionType>
                <TransactionDate>
                  {formatDate(transaction.created_at)}
                </TransactionDate>
                {transaction.description && (
                  <div style={{ fontSize: '12px', color: '#666', marginTop: '4px' }}>
                    {transaction.description}
                  </div>
                )}
              </TransactionInfo>
              <TransactionAmount positive={transaction.amount_ndn > 0}>
                {transaction.amount_ndn > 0 ? '+' : ''}{transaction.amount_ndn} NDN
              </TransactionAmount>
            </TransactionItem>
          ))
        ) : (
          <div style={{ textAlign: 'center', padding: '20px', color: '#666' }}>
            Нет транзакций
          </div>
        )}
      </Section>

      <Section>
        <SectionTitle>
          <Settings size={20} />
          Настройки
        </SectionTitle>
        <SecondaryButton>
          <Settings size={16} />
          Настройки уведомлений
        </SecondaryButton>
        <SecondaryButton>
          <User size={16} />
          О приложении
        </SecondaryButton>
      </Section>
    </ProfileContainer>
  );
};

export default Profile;
