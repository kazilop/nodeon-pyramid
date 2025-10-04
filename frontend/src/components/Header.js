import React from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import styled from 'styled-components';
import { Home, BookOpen, BarChart3, User } from 'lucide-react';

const HeaderContainer = styled.header`
  background: var(--tg-theme-bg-color, #ffffff);
  border-bottom: 1px solid var(--tg-theme-hint-color, #e0e0e0);
  position: sticky;
  top: 0;
  z-index: 100;
`;

const HeaderContent = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  max-width: 480px;
  margin: 0 auto;
`;

const Logo = styled.div`
  font-size: 20px;
  font-weight: bold;
  color: var(--tg-theme-button-color, #2481cc);
`;

const Nav = styled.nav`
  display: flex;
  gap: 8px;
`;

const NavButton = styled.button`
  display: flex;
  align-items: center;
  justify-content: center;
  width: 44px;
  height: 44px;
  border: none;
  border-radius: 12px;
  background: ${props => props.active 
    ? 'var(--tg-theme-button-color, #2481cc)' 
    : 'var(--tg-theme-secondary-bg-color, #f0f0f0)'
  };
  color: ${props => props.active 
    ? 'var(--tg-theme-button-text-color, #ffffff)' 
    : 'var(--tg-theme-text-color, #000000)'
  };
  cursor: pointer;
  transition: all 0.2s ease;
  
  &:hover {
    opacity: 0.8;
  }
`;

const Header = () => {
  const navigate = useNavigate();
  const location = useLocation();

  const navItems = [
    { path: '/', icon: Home, label: 'Главная' },
    { path: '/rules', icon: BookOpen, label: 'Правила' },
    { path: '/stats', icon: BarChart3, label: 'Статистика' },
    { path: '/profile', icon: User, label: 'Профиль' }
  ];

  return (
    <HeaderContainer>
      <HeaderContent>
        <Logo>NodeOn</Logo>
        <Nav>
          {navItems.map(({ path, icon: Icon, label }) => (
            <NavButton
              key={path}
              active={location.pathname === path}
              onClick={() => navigate(path)}
              title={label}
            >
              <Icon size={20} />
            </NavButton>
          ))}
        </Nav>
      </HeaderContent>
    </HeaderContainer>
  );
};

export default Header;
