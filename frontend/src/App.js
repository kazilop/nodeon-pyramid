import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import styled from 'styled-components';
import { TelegramWebApp } from '@twa-dev/sdk';

import Header from './components/Header';
import Dashboard from './pages/Dashboard';
import Rules from './pages/Rules';
import Stats from './pages/Stats';
import Profile from './pages/Profile';
import { AuthProvider } from './contexts/AuthContext';
import { useAuth } from './contexts/AuthContext';

const AppContainer = styled.div`
  min-height: 100vh;
  background: var(--tg-theme-bg-color, #f8f9fa);
  color: var(--tg-theme-text-color, #000000);
`;

const MainContent = styled.main`
  padding: 0 16px 80px 16px;
  max-width: 480px;
  margin: 0 auto;
`;

function AppContent() {
  const { user, loading } = useAuth();

  useEffect(() => {
    // Инициализация Telegram WebApp
    if (window.Telegram?.WebApp) {
      window.Telegram.WebApp.ready();
      window.Telegram.WebApp.expand();
    }
  }, []);

  if (loading) {
    return (
      <AppContainer>
        <MainContent>
          <div style={{ textAlign: 'center', padding: '50px 0' }}>
            <div className="pulse">Загрузка...</div>
          </div>
        </MainContent>
      </AppContainer>
    );
  }

  if (!user) {
    return (
      <AppContainer>
        <MainContent>
          <div style={{ textAlign: 'center', padding: '50px 0' }}>
            <h2>Ошибка авторизации</h2>
            <p>Пожалуйста, откройте приложение через Telegram бота</p>
          </div>
        </MainContent>
      </AppContainer>
    );
  }

  return (
    <AppContainer>
      <Header />
      <MainContent>
        <Routes>
          <Route path="/" element={<Dashboard />} />
          <Route path="/rules" element={<Rules />} />
          <Route path="/stats" element={<Stats />} />
          <Route path="/profile" element={<Profile />} />
        </Routes>
      </MainContent>
    </AppContainer>
  );
}

function App() {
  return (
    <Router>
      <AuthProvider>
        <AppContent />
      </AuthProvider>
    </Router>
  );
}

export default App;
