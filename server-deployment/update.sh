#!/bin/bash

# NodeOn Pyramid - Update Script
# Usage: ./update.sh

set -e

echo "🔄 Updating NodeOn Pyramid..."

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

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}❌ Please run as root (use sudo)${NC}"
    exit 1
fi

echo -e "${BLUE}📋 Update Configuration:${NC}"
echo "  App Directory: $APP_DIR"
echo "  Service Name: $SERVICE_NAME"
echo ""

# Stop the application
echo -e "${YELLOW}⏹️ Stopping application...${NC}"
pm2 stop $SERVICE_NAME || true

# Backup current version
echo -e "${YELLOW}💾 Creating backup...${NC}"
BACKUP_DIR="/var/backups/$APP_NAME-$(date +%Y%m%d-%H%M%S)"
mkdir -p $BACKUP_DIR
cp -r $APP_DIR/* $BACKUP_DIR/ 2>/dev/null || true

# Update application files
echo -e "${YELLOW}📁 Updating application files...${NC}"
cp -r ./* $APP_DIR/
cd $APP_DIR

# Install/update dependencies
echo -e "${YELLOW}📦 Installing dependencies...${NC}"
npm install --production

# Set proper permissions
echo -e "${YELLOW}🔐 Setting permissions...${NC}"
chown -R www-data:www-data $APP_DIR
chmod -R 755 $APP_DIR

# Restart the application
echo -e "${YELLOW}🚀 Restarting application...${NC}"
pm2 restart $SERVICE_NAME

# Test Nginx configuration
echo -e "${YELLOW}🧪 Testing Nginx configuration...${NC}"
nginx -t

# Reload Nginx
echo -e "${YELLOW}🔄 Reloading Nginx...${NC}"
systemctl reload nginx

echo -e "${GREEN}✅ Update completed successfully!${NC}"
echo ""
echo -e "${BLUE}📊 Application Status:${NC}"
pm2 status $SERVICE_NAME
echo ""
echo -e "${BLUE}📋 Useful commands:${NC}"
echo "  View logs: pm2 logs $SERVICE_NAME"
echo "  Restart app: pm2 restart $SERVICE_NAME"
echo "  Check status: pm2 status"
