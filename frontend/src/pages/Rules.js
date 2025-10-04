import React, { useState, useEffect } from 'react';
import styled from 'styled-components';
import { BookOpen, Star, Users, TrendingUp, Calculator } from 'lucide-react';
import axios from 'axios';

const RulesContainer = styled.div`
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

const RuleItem = styled.div`
  margin-bottom: 16px;
  padding: 16px;
  background: var(--tg-theme-bg-color, #ffffff);
  border-radius: 12px;
  border: 1px solid var(--tg-theme-hint-color, #e0e0e0);
`;

const RuleTitle = styled.h3`
  font-size: 16px;
  margin-bottom: 8px;
  color: var(--tg-theme-text-color, #000000);
`;

const RuleContent = styled.p`
  font-size: 14px;
  line-height: 1.5;
  color: var(--tg-theme-hint-color, #666666);
  white-space: pre-line;
`;

const LevelGrid = styled.div`
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
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
  font-size: 18px;
  font-weight: bold;
  color: var(--tg-theme-button-color, #2481cc);
  margin-bottom: 4px;
`;

const LevelReward = styled.div`
  font-size: 14px;
  color: var(--tg-theme-text-color, #000000);
`;

const CalculatorSection = styled.div`
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 16px;
  padding: 24px;
  color: white;
  text-align: center;
  margin-bottom: 20px;
`;

const CalculatorTitle = styled.h2`
  font-size: 20px;
  margin-bottom: 16px;
`;

const CalculatorGrid = styled.div`
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
  margin-top: 16px;
`;

const CalculatorCard = styled.div`
  background: rgba(255, 255, 255, 0.2);
  border-radius: 12px;
  padding: 16px;
`;

const CalculatorValue = styled.div`
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 4px;
`;

const CalculatorLabel = styled.div`
  font-size: 14px;
  opacity: 0.9;
`;

const Rules = () => {
  const [rules, setRules] = useState(null);

  useEffect(() => {
    fetchRules();
  }, []);

  const fetchRules = async () => {
    try {
      const response = await axios.get('/api/stats/game-rules');
      setRules(response.data);
    } catch (error) {
      console.error('Error fetching rules:', error);
    }
  };

  if (!rules) {
    return (
      <RulesContainer>
        <div style={{ textAlign: 'center', padding: '50px 0' }}>
          Загрузка правил...
        </div>
      </RulesContainer>
    );
  }

  return (
    <RulesContainer>
      <CalculatorSection>
        <CalculatorTitle>
          <Calculator size={24} style={{ marginRight: '8px' }} />
          Калькулятор заработка
        </CalculatorTitle>
        <p>При 10 рефералах на каждом уровне</p>
        <CalculatorGrid>
          <CalculatorCard>
            <CalculatorValue>180,000+</CalculatorValue>
            <CalculatorLabel>NDN заработано</CalculatorLabel>
          </CalculatorCard>
          <CalculatorCard>
            <CalculatorValue>7</CalculatorValue>
            <CalculatorLabel>Уровней рефералов</CalculatorLabel>
          </CalculatorCard>
        </CalculatorGrid>
      </CalculatorSection>

      <Section>
        <SectionTitle>
          <BookOpen size={20} />
          Как начать играть
        </SectionTitle>
        <RuleItem>
          <RuleTitle>1. Регистрация</RuleTitle>
          <RuleContent>
            Зарегистрируйтесь в боте через Telegram Mini App
          </RuleContent>
        </RuleItem>
        <RuleItem>
          <RuleTitle>2. Покупка NDN</RuleTitle>
          <RuleContent>
            Купите 1000 NDN за Telegram Stars по курсу 1:1
          </RuleContent>
        </RuleItem>
        <RuleItem>
          <RuleTitle>3. Pro статус</RuleTitle>
          <RuleContent>
            Приобретите Pro статус за 1000 NDN и получите реферальную ссылку
          </RuleContent>
        </RuleItem>
        <RuleItem>
          <RuleTitle>4. Приглашение друзей</RuleTitle>
          <RuleContent>
            Делитесь своей реферальной ссылкой и зарабатывайте с каждого Pro реферала
          </RuleContent>
        </RuleItem>
      </Section>

      <Section>
        <SectionTitle>
          <Users size={20} />
          Реферальная система
        </SectionTitle>
        <RuleContent>
          За каждого друга, который купит Pro статус, вы получаете награды до 7 уровней в глубину:
        </RuleContent>
        <LevelGrid>
          <LevelCard>
            <LevelNumber>1</LevelNumber>
            <LevelReward>200 NDN</LevelReward>
          </LevelCard>
          <LevelCard>
            <LevelNumber>2</LevelNumber>
            <LevelReward>150 NDN</LevelReward>
          </LevelCard>
          <LevelCard>
            <LevelNumber>3</LevelNumber>
            <LevelReward>150 NDN</LevelReward>
          </LevelCard>
          <LevelCard>
            <LevelNumber>4</LevelNumber>
            <LevelReward>150 NDN</LevelReward>
          </LevelCard>
          <LevelCard>
            <LevelNumber>5</LevelNumber>
            <LevelReward>150 NDN</LevelReward>
          </LevelCard>
          <LevelCard>
            <LevelNumber>6</LevelNumber>
            <LevelReward>150 NDN</LevelReward>
          </LevelCard>
          <LevelCard>
            <LevelNumber>7</LevelNumber>
            <LevelReward>150 NDN</LevelReward>
          </LevelCard>
        </LevelGrid>
      </Section>

      <Section>
        <SectionTitle>
          <Star size={20} />
          Вывод средств
        </SectionTitle>
        <RuleItem>
          <RuleTitle>Конвертация NDN в Stars</RuleTitle>
          <RuleContent>
            NDN можно вывести обратно в Telegram Stars по курсу 1:1
          </RuleContent>
        </RuleItem>
        <RuleItem>
          <RuleTitle>Минимальная сумма</RuleTitle>
          <RuleContent>
            Минимальная сумма для вывода: 1 NDN
          </RuleContent>
        </RuleItem>
        <RuleItem>
          <RuleTitle>Время обработки</RuleTitle>
          <RuleContent>
            Заявки на вывод обрабатываются в течение 24 часов
          </RuleContent>
        </RuleItem>
      </Section>

      <Section>
        <SectionTitle>
          <TrendingUp size={20} />
          Пример расчета
        </SectionTitle>
        <RuleContent>
          При 10 рефералах на каждом уровне:
          {'\n\n'}
          • Уровень 1: 10 × 200 = 2,000 NDN
          {'\n'}
          • Уровень 2: 100 × 150 = 15,000 NDN
          {'\n'}
          • Уровень 3: 1,000 × 150 = 150,000 NDN
          {'\n'}
          • Уровень 4: 10,000 × 150 = 1,500,000 NDN
          {'\n'}
          • И так далее...
          {'\n\n'}
          Общий потенциал заработка: 180,000+ NDN
        </RuleContent>
      </Section>
    </RulesContainer>
  );
};

export default Rules;
