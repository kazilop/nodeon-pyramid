import React, { useState, useEffect } from 'react';
import styled from 'styled-components';
import { BarChart3, Users, TrendingUp, Crown, DollarSign } from 'lucide-react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';
import axios from 'axios';
import { useAuth } from '../contexts/AuthContext';

const StatsContainer = styled.div`
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

const LevelStats = styled.div`
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(100px, 1fr));
  gap: 12px;
  margin-top: 16px;
`;

const LevelCard = styled.div`
  background: var(--tg-theme-bg-color, #ffffff);
  border-radius: 12px;
  padding: 16px;
  text-align: center;
  border: 1px solid var(--tg-theme-hint-color, #e0e0e0);
`;

const LevelNumber = styled.div`
  font-size: 16px;
  font-weight: bold;
  color: var(--tg-theme-button-color, #2481cc);
  margin-bottom: 4px;
`;

const LevelValue = styled.div`
  font-size: 14px;
  color: var(--tg-theme-text-color, #000000);
`;

const ChartContainer = styled.div`
  height: 300px;
  margin-top: 16px;
`;

const Leaderboard = styled.div`
  margin-top: 16px;
`;

const LeaderboardItem = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 16px;
  background: var(--tg-theme-bg-color, #ffffff);
  border-radius: 8px;
  margin-bottom: 8px;
  border: 1px solid var(--tg-theme-hint-color, #e0e0e0);
`;

const LeaderboardRank = styled.div`
  font-weight: bold;
  color: var(--tg-theme-button-color, #2481cc);
  margin-right: 12px;
`;

const LeaderboardName = styled.div`
  flex: 1;
  color: var(--tg-theme-text-color, #000000);
`;

const LeaderboardValue = styled.div`
  font-weight: bold;
  color: var(--tg-theme-text-color, #000000);
`;

const Stats = () => {
  const { user } = useAuth();
  const [referralStats, setReferralStats] = useState(null);
  const [leaderboard, setLeaderboard] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (user?.is_pro) {
      fetchStats();
    }
  }, [user]);

  const fetchStats = async () => {
    try {
      const [referralResponse, leaderboardResponse] = await Promise.all([
        axios.get(`/api/referrals/referral-stats/${user.user_id}`),
        axios.get('/api/stats/leaderboard')
      ]);
      
      setReferralStats(referralResponse.data);
      setLeaderboard(leaderboardResponse.data);
    } catch (error) {
      console.error('Error fetching stats:', error);
    } finally {
      setLoading(false);
    }
  };

  if (!user?.is_pro) {
    return (
      <StatsContainer>
        <Section>
          <SectionTitle>
            <BarChart3 size={20} />
            Статистика
          </SectionTitle>
          <div style={{ textAlign: 'center', padding: '40px 0' }}>
            <Crown size={48} style={{ margin: '0 auto 16px', color: '#f39c12' }} />
            <h3>Pro статус требуется</h3>
            <p>Купите Pro статус для просмотра статистики рефералов</p>
          </div>
        </Section>
      </StatsContainer>
    );
  }

  if (loading) {
    return (
      <StatsContainer>
        <div style={{ textAlign: 'center', padding: '50px 0' }}>
          Загрузка статистики...
        </div>
      </StatsContainer>
    );
  }

  const chartData = referralStats?.level_stats?.map(level => ({
    level: `Уровень ${level.level}`,
    referrals: level.referrals_count,
    earnings: level.earnings
  })) || [];

  return (
    <StatsContainer>
      <Section>
        <SectionTitle>
          <BarChart3 size={20} />
          Общая статистика
        </SectionTitle>
        <StatsGrid>
          <StatCard>
            <StatIcon color="#27ae60">
              <Users size={24} />
            </StatIcon>
            <StatValue>{referralStats?.total_referrals || 0}</StatValue>
            <StatLabel>Всего рефералов</StatLabel>
          </StatCard>
          <StatCard>
            <StatIcon color="#f39c12">
              <DollarSign size={24} />
            </StatIcon>
            <StatValue>{referralStats?.total_earnings || 0}</StatValue>
            <StatLabel>Заработано NDN</StatLabel>
          </StatCard>
        </StatsGrid>
      </Section>

      <Section>
        <SectionTitle>
          <TrendingUp size={20} />
          Статистика по уровням
        </SectionTitle>
        <LevelStats>
          {referralStats?.level_stats?.map((level, index) => (
            <LevelCard key={level.level}>
              <LevelNumber>{level.level}</LevelNumber>
              <LevelValue>{level.referrals_count}</LevelValue>
              <div style={{ fontSize: '12px', color: '#666' }}>рефералов</div>
              <div style={{ fontSize: '12px', color: '#27ae60', marginTop: '4px' }}>
                {level.earnings} NDN
              </div>
            </LevelCard>
          ))}
        </LevelStats>
      </Section>

      <Section>
        <SectionTitle>
          <BarChart3 size={20} />
          График рефералов
        </SectionTitle>
        <ChartContainer>
          <ResponsiveContainer width="100%" height="100%">
            <BarChart data={chartData}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="level" />
              <YAxis />
              <Tooltip />
              <Bar dataKey="referrals" fill="#2481cc" />
            </BarChart>
          </ResponsiveContainer>
        </ChartContainer>
      </Section>

      {leaderboard && (
        <>
          <Section>
            <SectionTitle>
              <Crown size={20} />
              Топ по заработку
            </SectionTitle>
            <Leaderboard>
              {leaderboard.top_earners?.map((user, index) => (
                <LeaderboardItem key={index}>
                  <LeaderboardRank>#{index + 1}</LeaderboardRank>
                  <LeaderboardName>
                    {user.username || user.first_name || 'Пользователь'}
                  </LeaderboardName>
                  <LeaderboardValue>{user.total_earnings} NDN</LeaderboardValue>
                </LeaderboardItem>
              ))}
            </Leaderboard>
          </Section>

          <Section>
            <SectionTitle>
              <Users size={20} />
              Топ по рефералам
            </SectionTitle>
            <Leaderboard>
              {leaderboard.top_referrers?.map((user, index) => (
                <LeaderboardItem key={index}>
                  <LeaderboardRank>#{index + 1}</LeaderboardRank>
                  <LeaderboardName>
                    {user.username || user.first_name || 'Пользователь'}
                  </LeaderboardName>
                  <LeaderboardValue>{user.referrals_count}</LeaderboardValue>
                </LeaderboardItem>
              ))}
            </Leaderboard>
          </Section>
        </>
      )}
    </StatsContainer>
  );
};

export default Stats;
