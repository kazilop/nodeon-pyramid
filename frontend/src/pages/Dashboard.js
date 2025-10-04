import React, { useState, useEffect } from 'react';
import styled from 'styled-components';
import { Coins, Star, Users, TrendingUp, Crown, Copy } from 'lucide-react';
import axios from 'axios';
import { useAuth } from '../contexts/AuthContext';

const DashboardContainer = styled.div`
  padding: 20px 0;
`;

const WelcomeCard = styled.div`
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 16px;
  padding: 24px;
  margin-bottom: 20px;
  color: white;
  text-align: center;
`;

const WelcomeTitle = styled.h1`
  font-size: 24px;
  margin-bottom: 8px;
`;

const WelcomeSubtitle = styled.p`
  opacity: 0.9;
  font-size: 16px;
`;

const StatsGrid = styled.div`
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
  margin-bottom: 20px;
`;

const StatCard = styled.div`
  background: var(--tg-theme-secondary-bg-color, #f8f9fa);
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

const ReferralSection = styled.div`
  background: var(--tg-theme-secondary-bg-color, #f8f9fa);
  border-radius: 16px;
  padding: 20px;
  margin-bottom: 20px;
  border: 1px solid var(--tg-theme-hint-color, #e0e0e0);
`;

const ReferralTitle = styled.h3`
  font-size: 18px;
  margin-bottom: 12px;
  color: var(--tg-theme-text-color, #000000);
`;

const ReferralLink = styled.div`
  background: var(--tg-theme-bg-color, #ffffff);
  border: 1px solid var(--tg-theme-hint-color, #e0e0e0);
  border-radius: 8px;
  padding: 12px;
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 12px;
`;

const ReferralInput = styled.input`
  flex: 1;
  border: none;
  background: none;
  font-size: 14px;
  color: var(--tg-theme-text-color, #000000);
  
  &:focus {
    outline: none;
  }
`;

const CopyButton = styled.button`
  background: var(--tg-theme-button-color, #2481cc);
  color: var(--tg-theme-button-text-color, #ffffff);
  border: none;
  border-radius: 6px;
  padding: 8px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
`;

const Dashboard = () => {
  const { user, updateUser } = useAuth();
  const [stats, setStats] = useState(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (user) {
      fetchStats();
    }
  }, [user]);

  const fetchStats = async () => {
    try {
      const response = await axios.get(`/api/stats/dashboard/${user.user_id}`);
      setStats(response.data);
    } catch (error) {
      console.error('Error fetching stats:', error);
    }
  };

  const buyPro = async () => {
    if (user.balance_ndn < 1000) {
      alert('Недостаточно NDN для покупки Pro статуса. Нужно 1000 NDN.');
      return;
    }

    setLoading(true);
    try {
      const response = await axios.post('/api/users/buy-pro', {
        user_id: user.user_id
      });
      
      updateUser({
        ...user,
        is_pro: true,
        referral_link: response.data.referral_link,
        balance_ndn: response.data.new_balance
      });
      
      alert('Pro статус успешно приобретен!');
    } catch (error) {
      alert('Ошибка при покупке Pro статуса: ' + error.response?.data?.detail);
    } finally {
      setLoading(false);
    }
  };

  const buyNDN = () => {
    // Здесь будет интеграция с Telegram Stars
    alert('Функция покупки NDN будет доступна после интеграции с Telegram Stars');
  };

  const copyReferralLink = () => {
    if (user.referral_link) {
      const fullUrl = `https://t.me/${process.env.REACT_APP_TELEGRAM_BOT_USERNAME}?start=${user.referral_link}`;
      navigator.clipboard.writeText(fullUrl);
      alert('Реферальная ссылка скопирована!');
    }
  };

  if (!user) return null;

  return (
    <DashboardContainer>
      <WelcomeCard>
        <WelcomeTitle>Добро пожаловать, {user.first_name}!</WelcomeTitle>
        <WelcomeSubtitle>
          {user.is_pro ? 'У вас есть Pro статус' : 'Купите Pro статус для начала заработка'}
        </WelcomeSubtitle>
      </WelcomeCard>

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
            <Users size={24} />
          </StatIcon>
          <StatValue>{stats?.stats?.total_referrals || 0}</StatValue>
          <StatLabel>Рефералов</StatLabel>
        </StatCard>

        <StatCard>
          <StatIcon color="#27ae60">
            <TrendingUp size={24} />
          </StatIcon>
          <StatValue>{stats?.stats?.total_earnings || 0}</StatValue>
          <StatLabel>Заработано</StatLabel>
        </StatCard>

        <StatCard>
          <StatIcon color="#9b59b6">
            <Crown size={24} />
          </StatIcon>
          <StatValue>{stats?.stats?.pro_referrals || 0}</StatValue>
          <StatLabel>Pro рефералов</StatLabel>
        </StatCard>
      </StatsGrid>

      {!user.is_pro ? (
        <ActionButton onClick={buyPro} disabled={loading || user.balance_ndn < 1000}>
          {loading ? 'Покупка...' : 'Купить Pro статус (1000 NDN)'}
        </ActionButton>
      ) : (
        <ReferralSection>
          <ReferralTitle>Ваша реферальная ссылка</ReferralTitle>
          <ReferralLink>
            <ReferralInput
              value={`https://t.me/${process.env.REACT_APP_TELEGRAM_BOT_USERNAME}?start=${user.referral_link}`}
              readOnly
            />
            <CopyButton onClick={copyReferralLink}>
              <Copy size={16} />
            </CopyButton>
          </ReferralLink>
        </ReferralSection>
      )}

      <ActionButton onClick={buyNDN}>
        Купить NDN за Stars
      </ActionButton>

      <SecondaryButton>
        Вывести NDN в Stars
      </SecondaryButton>
    </DashboardContainer>
  );
};

export default Dashboard;
