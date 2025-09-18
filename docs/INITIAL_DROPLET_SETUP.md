# Initial Droplet Setup Guide

## 1. Create Droplet

1. **Basic Configuration:**
   - Choose Region: Bangalore (closest to Maldives)
   - Choose Image: Ubuntu 22.04 LTS
   - Choose Size: Basic Plan
     - Regular Intel CPU
     - 2GB RAM / 1 CPU
     - 50GB SSD
   - Add backups (recommended)
   - Enable monitoring

2. **Authentication:**
   - Choose SSH keys (recommended)
   - If you don't have an SSH key:
     ```bash
     ssh-keygen -t ed25519 -C "your_email@example.com"
     cat ~/.ssh/id_ed25519.pub
     ```
   - Add the public key to DigitalOcean

3. **Finalize:**
   - Choose hostname: summerdust-production
   - Add tags: production, rails
   - Create droplet

## 2. Initial Server Setup

1. **Connect to Server:**
   ```bash
   ssh root@139.59.109.98
   ```

2. **Create Deploy User:**
   ```bash
   adduser deploy
   usermod -aG sudo deploy
   ```

3. **Set up SSH for Deploy User:**
   ```bash
   mkdir -p /home/deploy/.ssh
   cp ~/.ssh/authorized_keys /home/deploy/.ssh/
   chown -R deploy:deploy /home/deploy/.ssh
   chmod 700 /home/deploy/.ssh
   chmod 600 /home/deploy/.ssh/authorized_keys
   ```

4. **Update System:**
   ```bash
   apt update
   apt upgrade -y
   ```

5. **Install Essential Packages:**
   ```bash
   apt install -y curl git-core nginx software-properties-common dirmngr apt-transport-https ca-certificates gnupg
   ```

## 3. Install Ruby Dependencies

1. **Install Ruby Build Dependencies:**
   ```bash
   apt install -y build-essential libssl-dev libyaml-dev libreadline-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev
   ```

2. **Install Node.js and Yarn:**
   ```bash
   curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
   apt install -y nodejs
   npm install -g yarn
   ```

## 4. Configure Nginx

1. **Create Nginx Configuration:**
   ```bash
   nano /etc/nginx/sites-available/summerdust.com
   ```

2. **Add Configuration:**
   ```nginx
   upstream puma {
     server unix:///home/deploy/apps/maldivesbeachvacation/shared/tmp/sockets/puma.sock;
   }

   server {
     listen 80;
     server_name summerdust.com www.summerdust.com;
     root /home/deploy/apps/maldivesbeachvacation/current/public;

     location ^~ /assets/ {
       gzip_static on;
       expires max;
       add_header Cache-Control public;
     }

     location ^~ /packs/ {
       gzip_static on;
       expires max;
       add_header Cache-Control public;
     }

     try_files $uri/index.html $uri @puma;
     location @puma {
       proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
       proxy_set_header Host $http_host;
       proxy_set_header X-Forwarded-Proto $scheme;
       proxy_set_header X-Forwarded-Ssl on;
       proxy_set_header X-Forwarded-Port $server_port;
       proxy_set_header X-Forwarded-Host $host;
       proxy_redirect off;
       proxy_pass http://puma;
     }

     error_page 500 502 503 504 /500.html;
     client_max_body_size 10M;
     keepalive_timeout 10;
   }
   ```

3. **Enable Site:**
   ```bash
   ln -s /etc/nginx/sites-available/summerdust.com /etc/nginx/sites-enabled/
   rm /etc/nginx/sites-enabled/default
   nginx -t
   systemctl restart nginx
   ```

## 5. Install PostgreSQL

1. **Install PostgreSQL:**
   ```bash
   apt install -y postgresql postgresql-contrib libpq-dev
   ```

2. **Create Database User:**
   ```bash
   sudo -u postgres psql
   ```
   
   In PostgreSQL prompt:
   ```sql
   CREATE USER resort_booking WITH PASSWORD 'your_password';
   ALTER USER resort_booking CREATEDB;
   \q
   ```

## 6. Configure Firewall

1. **Set Up UFW:**
   ```bash
   ufw allow OpenSSH
   ufw allow 'Nginx Full'
   ufw enable
   ```

## 7. Install Docker

1. **Install Docker:**
   ```bash
   curl -fsSL https://get.docker.com -o get-docker.sh
   sh get-docker.sh
   ```

2. **Add Deploy User to Docker Group:**
   ```bash
   usermod -aG docker deploy
   ```

## 8. Set Up SSL with Let's Encrypt

1. **Install Certbot:**
   ```bash
   snap install --classic certbot
   ln -s /snap/bin/certbot /usr/bin/certbot
   ```

2. **Get SSL Certificate:**
   ```bash
   certbot --nginx -d summerdust.com -d www.summerdust.com
   ```

## 9. Final Steps

1. **Set Hostname:**
   ```bash
   hostnamectl set-hostname summerdust-production
   ```

2. **Configure Timezone:**
   ```bash
   timedatectl set-timezone Asia/Male
   ```

3. **Set Up Swap (if needed):**
   ```bash
   fallocate -l 4G /swapfile
   chmod 600 /swapfile
   mkswap /swapfile
   swapon /swapfile
   echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab
   ```

## 10. Security Recommendations

1. **Configure Fail2Ban:**
   ```bash
   apt install -y fail2ban
   cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
   systemctl enable fail2ban
   systemctl start fail2ban
   ```

2. **Regular Updates:**
   ```bash
   apt update
   apt upgrade -y
   ```

## 11. Monitoring Setup

1. **Install Monitoring Agent:**
   - Enable DigitalOcean Monitoring
   - Set up basic system monitoring
   - Configure alert policies

## Next Steps

After completing this setup:
1. Update DNS records to point to the server IP
2. Configure deployment with Kamal
3. Set up environment variables and credentials
4. Perform first deployment
5. Set up regular backups
6. Configure monitoring alerts

Would you like to start with any specific section of this setup?


