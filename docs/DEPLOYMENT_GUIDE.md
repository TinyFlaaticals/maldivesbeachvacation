# 🚀 Complete Deployment Guide - Maldives Beach Vacation Website

## 📊 **Cost Analysis & Server Recommendations**

### **RECOMMENDED: Kamal + DigitalOcean**

#### **Production-Ready Setup (Zero Downtime)**

| Component | DigitalOcean Droplet | Monthly Cost | Annual Cost |
|-----------|---------------------|--------------|-------------|
| **Web Server** | 2 GB RAM, 1 vCPU, 50 GB SSD | $18/month | $216/year |
| **Database Server** | 2 GB RAM, 1 vCPU, 50 GB SSD | $18/month | $216/year |
| **Load Balancer** | DigitalOcean Load Balancer | $12/month | $144/year |
| **Backups** | Automatic Backups (20% of droplet cost) | $7.20/month | $86.40/year |
| **Domain + DNS** | DigitalOcean DNS (or Cloudflare free) | $0-2/month | $0-24/year |
| **SSL Certificate** | Let's Encrypt (Free) | $0/month | $0/year |
| **Object Storage** | DigitalOcean Spaces (250GB) | $5/month | $60/year |
| **Monitoring** | DigitalOcean Monitoring | $0/month | $0/year |

**TOTAL MONTHLY:** **$60.20/month**  
**TOTAL ANNUAL:** **$722.40/year** (Save ~$74 with annual billing)

#### **Budget Setup (Acceptable for Low-Medium Traffic)**

| Component | DigitalOcean Droplet | Monthly Cost | Annual Cost |
|-----------|---------------------|--------------|-------------|
| **Single Server** | 4 GB RAM, 2 vCPU, 80 GB SSD | $24/month | $288/year |
| **Managed Database** | 1 GB RAM PostgreSQL | $15/month | $180/year |
| **Backups** | Automatic Backups | $4.80/month | $57.60/year |
| **Object Storage** | DigitalOcean Spaces | $5/month | $60/year |
| **Domain** | Your choice | $0-2/month | $0-24/year |

**TOTAL MONTHLY:** **$48.80/month**  
**TOTAL ANNUAL:** **$585.60/year**

#### **Alternative Options Comparison**

| Platform | Monthly Cost | Annual Cost | Pros | Cons |
|----------|--------------|-------------|------|------|
| **Kamal + DigitalOcean** | $48-60 | $585-722 | Full control, cheapest, scalable | Requires setup |
| **Render** | $75-120 | $900-1440 | Easy setup, managed | More expensive, less control |
| **Heroku** | $100-200 | $1200-2400 | Very easy | Most expensive, vendor lock-in |
| **Railway** | $60-100 | $720-1200 | Modern platform | Limited features |

## 🏗️ **Step-by-Step Deployment Guide**

### **Phase 1: Server Setup (30 minutes)**

#### **1. Create DigitalOcean Droplets**

```bash
# Create main application server
doctl compute droplet create maldives-web \
  --region nyc1 \
  --image ubuntu-22-04-x64 \
  --size s-2vcpu-4gb \
  --ssh-keys YOUR_SSH_KEY_ID \
  --enable-monitoring \
  --enable-backups

# Create database server (optional for budget setup)
doctl compute droplet create maldives-db \
  --region nyc1 \
  --image ubuntu-22-04-x64 \
  --size s-1vcpu-2gb \
  --ssh-keys YOUR_SSH_KEY_ID \
  --enable-monitoring \
  --enable-backups
```

#### **2. Initial Server Configuration**

```bash
# SSH into your server
ssh root@YOUR_SERVER_IP

# Update system
apt update && apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Create app user
adduser --disabled-password --gecos "" deploy
usermod -aG docker deploy
mkdir -p /home/deploy/.ssh
cp ~/.ssh/authorized_keys /home/deploy/.ssh/
chown -R deploy:deploy /home/deploy/.ssh
```

### **Phase 2: Domain & DNS Setup (15 minutes)**

#### **1. Configure DNS Records**

```bash
# Point your domain to your server
# A record: @ -> YOUR_SERVER_IP
# A record: www -> YOUR_SERVER_IP
# CNAME record: * -> yourdomain.com (for subdomains)
```

#### **2. Update Kamal Configuration**

```yaml
# config/deploy.yml
service: resort_booking
image: your-docker-username/resort_booking

servers:
  web:
    - YOUR_SERVER_IP

proxy:
  ssl: true
  host: yourdomain.com

registry:
  username: your-docker-username
  password:
    - KAMAL_REGISTRY_PASSWORD

env:
  secret:
    - RAILS_MASTER_KEY
    - POSTGRES_PASSWORD
  clear:
    DB_HOST: resort_booking-db
    POSTGRES_USER: resort_booking
    POSTGRES_DB: resort_booking_production
    DB_PORT: 5432
    SOLID_QUEUE_IN_PUMA: true

accessories:
  db:
    image: postgres:15
    host: YOUR_SERVER_IP
    port: "127.0.0.1:5432:5432"
    env:
      clear:
        POSTGRES_USER: "resort_booking"
        POSTGRES_DB: "resort_booking_production"
      secret:
        - POSTGRES_PASSWORD
    directories:
      - data:/var/lib/postgresql/data
    files:
      - db/production_setup.sql:/docker-entrypoint-initdb.d/setup.sql
```

### **Phase 3: Application Deployment (20 minutes)**

#### **1. Prepare Local Environment**

```bash
# Install Kamal (if not already installed)
gem install kamal

# Set up secrets
cp .kamal/secrets.example .kamal/secrets

# Edit .kamal/secrets with your actual values
# KAMAL_REGISTRY_PASSWORD=your_docker_hub_token
# RAILS_MASTER_KEY=your_master_key
# POSTGRES_PASSWORD=secure_password_here
```

#### **2. Build and Deploy**

```bash
# Initial setup (first time only)
kamal setup

# For subsequent deployments
kamal deploy

# Check deployment status
kamal app logs
kamal accessory logs db
```

#### **3. Database Setup**

```bash
# Run migrations
kamal app exec "bin/rails db:create db:migrate"

# Seed initial data (if needed)
kamal app exec "bin/rails db:seed"

# Create admin user
kamal app exec --interactive "bin/rails console"
# In console:
# Admin.create!(email: 'admin@yourdomain.com', password: 'secure_password')
```

### **Phase 4: Production Optimizations (30 minutes)**

#### **1. SSL Certificate Setup**

```bash
# Kamal handles this automatically with Let's Encrypt
# Verify SSL is working
curl -I https://yourdomain.com
```

#### **2. Environment Variables Configuration**

```bash
# Add production environment variables
kamal env push

# Verify environment
kamal app exec "printenv | grep RAILS"
```

#### **3. Background Jobs Configuration**

```yaml
# config/queue.yml
production:
  dispatchers:
    - polling_interval: 1
      batch_size: 500
  workers:
    - queues: "*"
      threads: 3
      processes: 2
      polling_interval: 0.1
```

#### **4. File Storage Setup**

```ruby
# config/storage.yml
digitalocean:
  service: S3
  access_key_id: <%= ENV['DO_SPACES_ACCESS_KEY'] %>
  secret_access_key: <%= ENV['DO_SPACES_SECRET_KEY'] %>
  region: nyc3
  bucket: your-bucket-name
  endpoint: https://nyc3.digitaloceanspaces.com

# config/environments/production.rb
config.active_storage.service = :digitalocean
```

### **Phase 5: Monitoring & Backups (20 minutes)**

#### **1. Application Monitoring**

```bash
# Create monitoring script
# /home/deploy/monitor.sh
#!/bin/bash
curl -f https://yourdomain.com/up || echo "App is down!" | mail -s "App Down" admin@yourdomain.com

# Add to crontab
echo "*/5 * * * * /home/deploy/monitor.sh" | crontab -
```

#### **2. Database Backups**

```bash
# Create backup script
# /home/deploy/backup.sh
#!/bin/bash
BACKUP_DIR="/home/deploy/backups"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p $BACKUP_DIR

# Backup database
docker exec resort_booking-db pg_dump -U resort_booking resort_booking_production > $BACKUP_DIR/db_backup_$DATE.sql

# Upload to DigitalOcean Spaces (optional)
# s3cmd put $BACKUP_DIR/db_backup_$DATE.sql s3://your-backup-bucket/

# Keep only last 7 days of backups
find $BACKUP_DIR -name "db_backup_*.sql" -mtime +7 -delete

# Daily backup
echo "0 2 * * * /home/deploy/backup.sh" | crontab -
```

#### **3. Log Management**

```bash
# Set up log rotation
sudo tee /etc/logrotate.d/docker > /dev/null <<EOF
/var/lib/docker/containers/*/*.log {
    rotate 7
    daily
    compress
    size=1M
    missingok
    delaycompress
    copytruncate
}
EOF
```

### **Phase 6: Performance Optimization (15 minutes)**

#### **1. Database Optimization**

```sql
-- Connect to database
kamal accessory exec db psql -U resort_booking resort_booking_production

-- Add indexes for performance
CREATE INDEX CONCURRENTLY idx_properties_star_rating ON properties(star_rating);
CREATE INDEX CONCURRENTLY idx_bookings_created_at ON bookings(created_at);
CREATE INDEX CONCURRENTLY idx_active_storage_attachments_record ON active_storage_attachments(record_type, record_id);
```

#### **2. Application Performance**

```ruby
# config/environments/production.rb

# Enable caching
config.action_controller.perform_caching = true
config.cache_store = :solid_cache_store

# Asset compression
config.assets.css_compressor = :sass
config.assets.js_compressor = :terser

# Image optimization
config.image_processing.variant_processor = :mini_magick
```

#### **3. CDN Setup (Optional)**

```ruby
# Use DigitalOcean Spaces CDN
# config/environments/production.rb
config.asset_host = "https://your-cdn-endpoint.nyc3.cdn.digitaloceanspaces.com"
```

## 🚨 **Troubleshooting Common Issues**

### **1. Deployment Fails**

```bash
# Check Kamal logs
kamal app logs --lines 100

# Check system resources
kamal app exec "free -h"
kamal app exec "df -h"

# Restart services
kamal app restart
```

### **2. Database Connection Issues**

```bash
# Check database status
kamal accessory logs db

# Test database connection
kamal app exec "bin/rails db:migrate:status"

# Reset database (CAUTION: Data loss!)
kamal app exec "bin/rails db:drop db:create db:migrate"
```

### **3. SSL Certificate Issues**

```bash
# Check SSL certificate
openssl s_client -connect yourdomain.com:443 -servername yourdomain.com

# Force SSL renewal
kamal traefik reboot
```

### **4. Memory Issues**

```bash
# Check memory usage
kamal app exec "free -h"

# Restart app to free memory
kamal app restart

# Adjust container resources in deploy.yml
```

## 📈 **Scaling Strategies**

### **Traffic Growth Handling**

| Traffic Level | Server Setup | Monthly Cost |
|---------------|--------------|--------------|
| **0-1K visitors/day** | Single 4GB droplet | $48 |
| **1K-10K visitors/day** | 2x 4GB droplets + load balancer | $84 |
| **10K-50K visitors/day** | 3x 8GB droplets + load balancer | $156 |
| **50K+ visitors/day** | Kubernetes cluster | $300+ |

### **Database Scaling**

```bash
# For high traffic, upgrade to managed database
# DigitalOcean Managed PostgreSQL
# 2GB RAM: $30/month
# 4GB RAM: $60/month
# 8GB RAM: $120/month
```

## ✅ **Final Deployment Checklist**

### **Pre-Deployment**
- [ ] Domain purchased and DNS configured
- [ ] DigitalOcean account set up with payment method
- [ ] SSH keys configured
- [ ] Docker Hub account created
- [ ] Environment variables prepared

### **Deployment**
- [ ] Server created and configured
- [ ] Kamal deployment successful
- [ ] Database migrations completed
- [ ] SSL certificate installed
- [ ] Admin user created
- [ ] Email delivery configured

### **Post-Deployment**
- [ ] Website accessible via HTTPS
- [ ] Admin panel login working
- [ ] Email sending tested
- [ ] File uploads working
- [ ] Monitoring set up
- [ ] Backups configured
- [ ] Performance optimized

## 🎯 **Summary**

**For your first production deployment, I recommend:**

1. **Start with Budget Setup:** $48/month
2. **Use managed database:** Easier maintenance
3. **Enable automatic backups:** Peace of mind
4. **Set up monitoring:** Early issue detection
5. **Plan for scaling:** As your traffic grows

**Total Time Investment:** ~2-3 hours for initial setup
**Monthly Cost:** $48-60 (much cheaper than alternatives)
**Learning Value:** High (full DevOps experience)

This setup will handle **10,000+ visitors per month** comfortably and can scale as needed. The Kamal deployment gives you professional-grade infrastructure at a fraction of the cost of managed platforms. 