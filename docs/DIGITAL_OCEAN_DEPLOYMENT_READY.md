# 🚀 Digital Ocean Deployment - READY TO LAUNCH

## ✅ **Status: READY FOR TONIGHT'S DEPLOYMENT**

All systems are configured and ready for DigitalOcean deployment! Here's your complete launch plan.

## 📋 **Pre-Deployment Checklist**

### **✅ Completed:**
- [x] Gmail SMTP configuration updated
- [x] Admin authentication system verified
- [x] Application mailer updated to use Gmail
- [x] Admin contact email updated to Gmail
- [x] Deployment configuration reviewed

### **⏳ Required Before Launch:**
- [ ] Create Gmail account: `maldivesbeachvacation@gmail.com`
- [ ] Generate Gmail App Password
- [ ] Create $6 DigitalOcean Droplet
- [ ] Update production credentials with Gmail details
- [ ] Point domain to droplet IP

## 🎯 **Gmail Setup (Required First)**

### **Step 1: Create Gmail Account**
1. Go to [Gmail](https://gmail.com)
2. Create account: `hello@maldivesbeachvacation.com`
3. Use a strong password and save it securely

### **Step 2: Enable 2-Step Verification**
1. Go to [Google Account Security](https://myaccount.google.com/security)
2. Enable "2-Step Verification"
3. Follow the setup process

### **Step 3: Generate App Password**
1. In Google Account Security, go to "2-Step Verification"
2. Scroll down to "App passwords"
3. Click "Select app" → "Mail"
4. Click "Select device" → "Other"
5. Enter: "Maldives Beach Vacation Website"
6. Click "Generate"
7. **SAVE THE 16-CHARACTER PASSWORD** - you'll need it for deployment

## 🖥️ **DigitalOcean Droplet Setup**

### **Step 1: Create Droplet**
**IP Already Configured:** Your deploy.yml shows server IP `139.59.109.98` is already configured.

If this droplet doesn't exist or you need a new one:
1. Log into [DigitalOcean](https://cloud.digitalocean.com/)
2. Click "Create" → "Droplets"
3. **Image:** Ubuntu 22.04 x64
4. **Plan:** Basic ($6/month - 1GB RAM, 1 vCPU)
5. **Region:** New York 1 (NYC1) - recommended
6. **SSH Keys:** Add your SSH key
7. **Hostname:** `maldives-beach-vacation`
8. Click "Create Droplet"
9. **Update deploy.yml** with the new IP address if different

### **Step 2: Domain Configuration**
Update your domain DNS settings to point to the droplet:
```
A    @    139.59.109.98
A    www  139.59.109.98
```
(This IP is already configured in your deploy.yml)

## 🔐 **Production Credentials Setup**

### **Step 1: Update Production Credentials**
```bash
# Edit production credentials
EDITOR="vim" rails credentials:edit --environment production
```

### **Step 2: Add Gmail Configuration**
Add this to your production credentials file:
```yaml
smtp:
  username: hello@maldivesbeachvacation.com
  password: YOUR_16_CHARACTER_APP_PASSWORD

digitalocean:
  access_key_id: YOUR_DO_SPACES_KEY
  secret_access_key: YOUR_DO_SPACES_SECRET
```

### **Step 3: Save and Close**
- Save the file (`:wq` in vim)
- The credentials will be automatically encrypted

## 🚀 **Deployment Commands**

### **Step 1: Initial Server Setup**
```bash
# SSH into your droplet
ssh root@139.59.109.98

# Update system
apt update && apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Create deploy user
adduser --disabled-password --gecos "" deploy
usermod -aG docker deploy

# Exit SSH
exit
```

### **Step 2: Deploy Application**
```bash
# From your local machine in the project directory
cd /Users/ayasmacbook/maldivesbeachvacation

# Initial setup (first time only)
kamal setup

# Deploy the application
kamal deploy

# Check deployment status
kamal app logs
```

### **Step 3: Database Setup**
```bash
# Create and migrate database
kamal app exec "bin/rails db:create"
kamal app exec "bin/rails db:migrate"

# Load seed data (properties, facilities, etc.)
kamal app exec "bin/rails db:seed"
```

### **Step 4: Create Admin User**
```bash
# Create admin user for the panel
kamal app exec "bin/rails admin:create[admin@maldivesbeachvacation.com,YourSecurePassword123]"
```

### **Step 5: Verify Deployment**
```bash
# Test website loads
curl -I https://summerdust.com

# Test admin panel
curl -I https://summerdust.com/admin

# Check application logs
kamal app logs --lines 50

# Test email system
kamal app exec "bin/rails runner 'TestMailer.test_email(\"hello@maldivesbeachvacation.com\").deliver_now'"
```

## 🔧 **Memory Optimization (Already Configured)**

Your application is already optimized for the $6 droplet (1GB RAM):
```yaml
# In deploy.yml
env:
  clear:
    WEB_CONCURRENCY: 1      # Single web worker
    JOB_CONCURRENCY: 1      # Single job worker
    SOLID_QUEUE_IN_PUMA: true  # Jobs in web process
```

### **Optional: Add Swap File**
```bash
# SSH into droplet and add swap for extra safety
ssh root@139.59.109.98

# Create 1GB swap file
fallocate -l 1G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

# Make permanent
echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab

# Exit SSH
exit
```

## ✅ **Launch Verification Checklist**

After deployment, verify these work:
- [ ] Website loads: `https://summerdust.com`
- [ ] Admin login: `https://summerdust.com/admins/sign_in`
- [ ] Admin panel: `https://summerdust.com/admin`
- [ ] Properties display correctly
- [ ] Images load from DigitalOcean Spaces
- [ ] Booking system works
- [ ] Email notifications work (Gmail SMTP)
- [ ] SSL certificates active (HTTPS)

## 🎯 **Expected Timeline**

**Total deployment time: ~30-45 minutes**
- Gmail setup: 5-10 minutes
- Droplet creation: 5 minutes
- Domain DNS update: 5-15 minutes (propagation)
- Credentials update: 5 minutes
- Deployment: 10-15 minutes

## 🚨 **Troubleshooting**

### **Common Issues & Solutions:**

#### **"Out of Memory" Errors**
```bash
# Check memory usage
kamal app exec "free -h"

# Add swap file (see above) or upgrade to 2GB droplet
```

#### **Email Delivery Issues**
```bash
# Check Gmail app password is correct
kamal app exec "bin/rails runner 'puts Rails.application.credentials.smtp'"

# Test email sending
kamal app exec "bin/rails runner 'TestMailer.test_email(\"test@example.com\").deliver_now'"
```

#### **SSL Certificate Issues**
```bash
# Check Traefik logs
kamal traefik logs

# Force certificate renewal
kamal traefik reboot
```

#### **Database Connection Issues**
```bash
# Check database status
kamal accessory logs db

# Restart database
kamal accessory restart db
```

## 💰 **Monthly Costs**
- **Droplet:** $6/month (1GB RAM, 1 vCPU)
- **Backups (optional):** +$1.20/month
- **Domain:** ~$1-2/month (if not already owned)
- **Total:** ~$7-9/month

## 🎉 **You're Ready to Launch!**

Everything is configured and ready. Just follow the steps above and you'll have your resort booking website live on DigitalOcean tonight!

### **Quick Launch Summary:**
1. Create Gmail account + App Password (10 mins)
2. Create DigitalOcean droplet (5 mins)
3. Update credentials with Gmail details (5 mins)
4. Run deployment commands (15-20 mins)
5. Verify everything works (5-10 mins)

**Total time: ~45 minutes to go live!** 🚀
