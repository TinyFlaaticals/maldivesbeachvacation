# 🖥️ $6 DigitalOcean Droplet Setup - Complete Guide

## 🎉 **Current Application Status**

### **✅ Recently Completed (Aug 2025)**
- [x] **Email System Fixed**: Zoho SMTP fully configured and working
- [x] **Booking System**: Complete end-to-end booking flow with email confirmations
- [x] **Admin Panel**: Clean interface with star rating management
- [x] **Error Handling**: Graceful email error handling in booking process
- [x] **SMTP Configuration**: Both development and production environments configured
- [x] **Production Credentials**: All secrets properly encrypted and configured

### **🔧 Technical Improvements Made**
- [x] Added SMTP initializer for reliable email configuration
- [x] Enhanced booking controller with error handling
- [x] Configured Zoho SMTP with contact@summerdust.com
- [x] Set up DigitalOcean Spaces for file storage
- [x] Enabled SSL/HTTPS for production security
- [x] Optimized for 1GB RAM deployment

## 📋 **Pre-Deployment Checklist**

### **✅ 1. Droplet Creation**
- [ ] Created $6/month droplet (1GB RAM, 1 vCPU)
- [ ] Region: NYC1 selected
- [ ] Ubuntu 22.04 x64 selected  
- [ ] SSH key added
- [ ] Note droplet IP address: `_______________`

### **✅ 2. Domain Setup (Required)**
- [ ] Point summerdust.com to droplet IP:
  ```
  A    @    YOUR_DROPLET_IP
  A    www  YOUR_DROPLET_IP
  ```
- [ ] Update config/deploy.yml with summerdust.com domain

### **✅ 3. Configuration Updates**
- [x] Updated `config/deploy.yml` with summerdust.com domain
- [x] Optimized for 1GB RAM (WEB_CONCURRENCY=1, JOB_CONCURRENCY=1)
- [x] Production credentials configured with SMTP secrets
- [x] Email system configured with Zoho SMTP (contact@summerdust.com)
- [x] SSL/HTTPS configuration enabled
- [x] DigitalOcean Spaces configured for file storage

## 🚀 **Deployment Steps**

### **Step 1: Test Local Build**
```bash
# Test Docker build works
docker build -t resort_booking .

# Test with production key
docker run --rm -e RAILS_MASTER_KEY="$(cat config/credentials/production.key)" resort_booking rails runner "puts 'OK'"
```

### **Step 2: Initial Server Setup**
```bash
# Connect to droplet (replace IP)
ssh root@YOUR_DROPLET_IP

# Update system
apt update && apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Create deploy user
adduser --disabled-password --gecos "" deploy
usermod -aG docker deploy
```

### **Step 3: Deploy with Kamal**
```bash
# From your local machine
# Initial setup (first time only)
kamal setup

# Deploy application
kamal deploy

# Check status
kamal app logs
kamal accessory logs db
```

### **Step 4: Database Setup**
```bash
# Create and migrate database
kamal app exec "bin/rails db:create"
kamal app exec "bin/rails db:migrate"

# Create admin user (credentials already configured)
kamal app exec "bin/rails admin:create[admin@maldivesbeachvacation.com,pMeHajZX3vYk]"

# Set up admin configuration for contact email
kamal app exec "bin/rails runner 'AdminConfig.instance.update(contact_email: \"contact@summerdust.com\")'"
```

### **Step 5: Verify Deployment**
```bash
# Test website loads
curl -I https://summerdust.com

# Test admin panel
curl -I https://summerdust.com/admin

# Test booking system (should return 302 redirect)
curl -I https://summerdust.com/properties

# Check logs for any issues
kamal app logs --lines 50

# Test email system
kamal app exec "bin/rails runner 'BookingMailer.contact_email(\"test@example.com\", \"Test message\", \"Test\").deliver_now'"
```

## 🔧 **1GB RAM Optimizations**

### **Memory Management**
```yaml
# Already configured in deploy.yml
env:
  clear:
    WEB_CONCURRENCY: 1      # Single web worker
    JOB_CONCURRENCY: 1      # Single job worker
    SOLID_QUEUE_IN_PUMA: true  # Jobs in web process
```

### **Swap File (Recommended for 1GB)**
```bash
# SSH into droplet and add swap
ssh root@YOUR_DROPLET_IP

# Create 1GB swap file
fallocate -l 1G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

# Make permanent
echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab
```

## 🔍 **Monitoring & Maintenance**

### **Check Resource Usage**
```bash
# Monitor memory usage
kamal app exec "free -h"

# Monitor disk usage  
kamal app exec "df -h"

# Monitor CPU usage
kamal app exec "top -bn1 | head -20"
```

### **Log Management**
```bash
# View application logs
kamal app logs -f

# View database logs
kamal accessory logs db

# Clear old logs (if needed)
kamal app exec "find /rails/log -name '*.log' -type f -delete"
```

## 💰 **Monthly Costs**

### **Current Setup Cost**
- **Droplet:** $6/month
- **Backups (optional):** +$1.20/month (20% of droplet cost)
- **Domain (optional):** ~$1-2/month
- **Total:** ~$7-9/month

### **Upgrade Path**
When you need more performance:
- **$12/month:** 2GB RAM, 1 vCPU (recommended for higher traffic)
- **$18/month:** 2GB RAM, 2 vCPU  
- **$24/month:** 4GB RAM, 2 vCPU

## 🚨 **Troubleshooting**

### **Common Issues**

#### **"Out of Memory" Errors**
```bash
# Check memory usage
kamal app exec "free -h"

# Add swap file (see above)
# Or upgrade to 2GB droplet
```

#### **Slow Performance**
```bash
# Check if swap is being used heavily
kamal app exec "swapon --show"

# Consider upgrading to 2GB RAM
```

#### **Database Connection Issues**
```bash
# Check database status
kamal accessory logs db

# Restart database
kamal accessory restart db
```

#### **SSL Certificate Issues**
```bash
# Check certificate status
kamal traefik logs

# Force certificate renewal
kamal traefik reboot
```

## ✅ **Success Indicators**

- [ ] Website loads at https://summerdust.com
- [ ] Admin panel accessible at https://summerdust.com/admin  
- [ ] Admin login works (admin@maldivesbeachvacation.com / pMeHajZX3vYk)
- [ ] Property listings display correctly with star ratings
- [ ] Images upload and display via DigitalOcean Spaces
- [ ] Booking system creates bookings successfully
- [ ] Email notifications sent via Zoho SMTP (contact@summerdust.com)
- [ ] No memory errors in logs
- [ ] Database queries working
- [ ] SSL certificates working (HTTPS)

## 📞 **Next Steps After Deployment**

1. **Test thoroughly** - Browse site, test admin panel
2. **Monitor performance** - Watch memory/CPU usage
3. **Set up backups** - Enable DigitalOcean automated backups
4. **Configure monitoring** - Set up uptime monitoring
5. **Plan for scaling** - Monitor traffic and upgrade when needed

## 🎯 **Performance Expectations**

### **What Your $6 Droplet Can Handle:**
- ✅ **Development/Testing:** Perfect
- ✅ **Small sites:** 100-500 visitors/day
- ✅ **Low traffic:** 10-50 concurrent users
- ⚠️ **Medium traffic:** 500+ visitors/day (consider upgrade)
- ❌ **High traffic:** 1000+ visitors/day (definitely upgrade)

Your $6 droplet is perfect for getting started and testing your application in production! 