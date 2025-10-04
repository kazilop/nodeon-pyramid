import React, { createContext, useContext, useState, useEffect } from 'react';
import axios from 'axios';

const AuthContext = createContext();

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const initAuth = async () => {
      try {
        // Получаем данные от Telegram WebApp
        if (window.Telegram?.WebApp?.initData) {
          const initData = window.Telegram.WebApp.initData;
          const userData = window.Telegram.WebApp.initDataUnsafe?.user;
          
          if (userData) {
            // Авторизуемся через API
            const response = await axios.post('/api/auth/login', {
              id: userData.id,
              first_name: userData.first_name,
              last_name: userData.last_name,
              username: userData.username,
              photo_url: userData.photo_url,
              auth_date: Math.floor(Date.now() / 1000),
              hash: initData.split('hash=')[1]
            });
            
            setUser(response.data);
          }
        }
      } catch (error) {
        console.error('Auth error:', error);
      } finally {
        setLoading(false);
      }
    };

    initAuth();
  }, []);

  const updateUser = (userData) => {
    setUser(userData);
  };

  const value = {
    user,
    updateUser,
    loading
  };

  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  );
};
