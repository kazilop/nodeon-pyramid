#!/bin/bash

# NodeOn Pyramid - Server Deployment Script
# Usage: ./deploy.sh

set -e

echo "🚀 Starting NodeOn Pyramid deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
APP_NAME="nodeon-pyramid"
APP_DIR="/var/www/$APP_NAME"
SERVICE_NAME="nodeon-pyramid"
NGINX_SITES="/etc/nginx/sites-available"
NGINX_ENABLED="/etc/nginx/sites-enabled"
SITE_CONFIG="nodeon-pyramid"

echo -e "${BLUE}📋 Deployment Configuration:${NC}"
echo "  App Name: $APP_NAME"
echo "  App Directory: $APP_DIR"
echo "  Service Name: $SERVICE_NAME"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}❌ Please run as root (use sudo)${NC}"
    exit 1
fi

# Update system packages
echo -e "${YELLOW}📦 Updating system packages...${NC}"
apt update && apt upgrade -y

# Install Node.js 18.x
echo -e "${YELLOW}📦 Installing Node.js 18.x...${NC}"
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs

# Install PM2 globally
echo -e "${YELLOW}📦 Installing PM2...${NC}"
npm install -g pm2

# Install Nginx
echo -e "${YELLOW}📦 Installing Nginx...${NC}"
apt install -y nginx

# Install Certbot for SSL
echo -e "${YELLOW}📦 Installing Certbot...${NC}"
apt install -y certbot python3-certbot-nginx

# Create application directory
echo -e "${YELLOW}📁 Creating application directory...${NC}"
mkdir -p $APP_DIR
mkdir -p $APP_DIR/logs

# Copy application files
echo -e "${YELLOW}📁 Copying application files...${NC}"
cp -r ./* $APP_DIR/
cd $APP_DIR

# Install dependencies
echo -e "${YELLOW}📦 Installing Node.js dependencies...${NC}"
npm install --production

# Set up environment variables
echo -e "${YELLOW}⚙️ Setting up environment variables...${NC}"
if [ ! -f .env ]; then
    cp env.example .env
    echo -e "${YELLOW}⚠️  Please edit .env file with your configuration${NC}"
fi

# Set proper permissions
echo -e "${YELLOW}🔐 Setting permissions...${NC}"
chown -R www-data:www-data $APP_DIR
chmod -R 755 $APP_DIR

# Configure Nginx
echo -e "${YELLOW}🌐 Configuring Nginx...${NC}"
cp nginx-site.conf $NGINX_SITES/$SITE_CONFIG
ln -sf $NGINX_SITES/$SITE_CONFIG $NGINX_ENABLED/
# Не удаляем default, чтобы не сломать другие сайты

# Test Nginx configuration
echo -e "${YELLOW}🧪 Testing Nginx configuration...${NC}"
nginx -t

# Start services
echo -e "${YELLOW}🚀 Starting services...${NC}"

# Start application with PM2
pm2 start ecosystem.config.js
pm2 save
pm2 startup

# Start and enable Nginx
systemctl start nginx
systemctl enable nginx

# Configure firewall
echo -e "${YELLOW}🔥 Configuring firewall...${NC}"
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable

echo -e "${GREEN}✅ Deployment completed successfully!${NC}"
echo ""
echo -e "${BLUE}📋 Next steps:${NC}"
echo "1. Edit environment variables: nano $APP_DIR/.env"
echo "2. Get SSL certificate: certbot --nginx -d sistemypro.ru -d www.sistemypro.ru"
echo "3. Restart services: systemctl restart nginx && pm2 restart $SERVICE_NAME"
echo ""
echo -e "${BLUE}🔗 Your application will be available at:${NC}"
echo "  HTTP: http://sistemypro.ru"
echo "  HTTPS: https://sistemypro.ru (after SSL setup)"
echo ""
echo -e "${BLUE}📊 Useful commands:${NC}"
echo "  Check status: pm2 status"
echo "  View logs: pm2 logs $SERVICE_NAME"
echo "  Restart app: pm2 restart $SERVICE_NAME"
echo "  Nginx status: systemctl status nginx"
echo "  Nginx logs: tail -f /var/log/nginx/error.log"
