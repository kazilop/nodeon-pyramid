const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const compression = require('compression');
const path = require('path');
require('dotenv').config();

// Выводим переменные для отладки
console.log('🔑 Загруженные переменные окружения:');
console.log('SUPABASE_URL:', process.env.SUPABASE_URL ? '✓ Установлен' : '✗ Не установлен');
console.log('TELEGRAM_BOT_TOKEN:', process.env.TELEGRAM_BOT_TOKEN ? '✓ Установлен' : '✗ Не установлен');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      scriptSrc: ["'self'", "'unsafe-inline'", "https://telegram.org"],
      styleSrc: ["'self'", "'unsafe-inline'"],
      imgSrc: ["'self'", "data:", "https:"],
      connectSrc: ["'self'", "https://*.supabase.co", "https://telegram.org"],
      frameSrc: ["'self'", "https://telegram.org"]
    }
  }
}));

app.use(compression());
app.use(cors());
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// Serve static files
app.use(express.static(path.join(__dirname, 'public')));

// Import API routes
const authRoutes = require('./routes/auth');
const minerRoutes = require('./routes/miner');
const usersRoutes = require('./routes/users');
const referralsRoutes = require('./routes/referrals');
const statsRoutes = require('./routes/stats');
const gameRoutes = require('./routes/game');
const transfersRoutes = require('./routes/transfers');
const translationsRoutes = require('./routes/translations');
const adminRoutes = require('./routes/admin');
const paymentsRoutes = require('./routes/payments');
const proRoutes = require('./routes/pro');
const webhookRoutes = require('./webhook');

// API Routes
app.use('/api/auth', authRoutes);
app.use('/api/miner', minerRoutes);
app.use('/api/users', usersRoutes);
app.use('/api/user', usersRoutes); // Alias for /api/user/create and /api/user/profile
app.use('/api/referrals', referralsRoutes);
app.use('/api/stats', statsRoutes);
app.use('/api/game', gameRoutes);
app.use('/api/transfers', transfersRoutes);
app.use('/api/translations', translationsRoutes);
app.use('/api/admin', adminRoutes);
app.use('/api/payments', paymentsRoutes);
app.use('/api/pro', proRoutes);
app.use('/', webhookRoutes);

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({ 
    status: 'ok', 
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    version: process.env.npm_package_version || '1.0.0'
  });
});

// Catch all handler for SPA
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error('Server error:', err);
  res.status(500).json({ 
    error: 'Internal Server Error',
    message: process.env.NODE_ENV === 'development' ? err.message : 'Something went wrong'
  });
});

// Start server
app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 NodeOn Pyramid server running on port ${PORT}`);
  console.log(`🌐 Environment: ${process.env.NODE_ENV || 'production'}`);
  console.log(`📊 Health check: http://localhost:${PORT}/health`);
});

// Graceful shutdown
process.on('SIGTERM', () => {
  console.log('SIGTERM received, shutting down gracefully');
  process.exit(0);
});

process.on('SIGINT', () => {
  console.log('SIGINT received, shutting down gracefully');
  process.exit(0);
});

