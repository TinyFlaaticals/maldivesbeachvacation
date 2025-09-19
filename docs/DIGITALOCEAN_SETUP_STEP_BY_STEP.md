# 🌊 DigitalOcean Droplet Setup - Complete Step-by-Step Guide

## 🎯 **What We're Going to Do**
1. Create a DigitalOcean droplet (virtual server)
2. Set up SSH access for secure connection
3. Configure the server for your application
4. Deploy your resort booking website

**Time Required:** 30-45 minutes  
**Cost:** $6/month for the droplet

---

## 📋 **BEFORE WE START - What You Need**

✅ **DigitalOcean Account** (create at digitalocean.com if you don't have one)  
✅ **Credit Card** (for $6/month droplet)  
✅ **Your Computer** (Mac/PC with terminal access)  
✅ **Domain Access** (to point summerdust.com to the server)

---

## 🚀 **STEP 1: CREATE SSH KEY (Security Setup)**

### **What is SSH?**
SSH is like a secure password that lets your computer talk to the server safely.

### **On Mac (Terminal):**
```bash
# Open Terminal and run this command:
ssh-keygen -t rsa -b 4096 -C "maldivesbeachvacation@deployment"

# When it asks "Enter file in which to save the key", just press ENTER
# When it asks for passphrase, just press ENTER twice (no password needed)
```

### **On Windows (PowerShell):**
```powershell
# Open PowerShell and run:
ssh-keygen -t rsa -b 4096 -C "maldivesbeachvacation@deployment"

# Press ENTER for all questions (3 times total)
```

### **Get Your SSH Key:**
```bash
# Copy your public key (this is what we'll give to DigitalOcean):
cat ~/.ssh/id_rsa.pub

# This will show something like:
# ssh-rsa AAAAB3NzaC1yc2EAAAA... maldivesbeachvacation@deployment

# SELECT ALL THE TEXT and COPY it (Cmd+C or Ctrl+C)
```

**✅ CHECKPOINT:** You should have copied a long string starting with "ssh-rsa"

---

## 🌐 **STEP 2: CREATE DIGITALOCEAN DROPLET**

### **2.1 Log into DigitalOcean**
1. Go to https://cloud.digitalocean.com/
2. Sign in to your account
3. Click the big green **"Create"** button (top right)
4. Select **"Droplets"**

### **2.2 Choose Droplet Configuration**

#### **🖼️ Choose an Image:**
- Select **"Ubuntu"** tab
- Choose **"Ubuntu 22.04 x64"** (should be selected by default)

#### **💰 Choose Size:**
- Click **"Basic"** plan
- Select **"Regular"** (with SSD)
- Choose the **$6/month** option:
  - 1 GB Memory
  - 1 vCPU
  - 25 GB SSD Disk
  - 1000 GB Transfer

#### **🌍 Choose Region:**
- Select **"New York 1"** (or closest to your location)

#### **🔐 Authentication:**
- Select **"SSH Keys"** (NOT Password)
- Click **"New SSH Key"**
- Paste your SSH key (the long string you copied earlier)
- Give it a name: "Maldives Beach Vacation Key"
- Click **"Add SSH Key"**

#### **📝 Finalize Details:**
- **Hostname:** `maldives-beach-vacation`
- **Tags:** Leave empty
- **Project:** Default project is fine
- **Backups:** You can enable this later ($1.20/month extra)

### **2.3 Create the Droplet**
1. Click **"Create Droplet"** (green button at bottom)
2. Wait 1-2 minutes for creation
3. **IMPORTANT:** Copy the IP address shown (something like 139.59.109.98)

**✅ CHECKPOINT:** You should see your droplet with an IP address

---

## 🔧 **STEP 3: INITIAL SERVER SETUP**

### **3.1 Connect to Your Server**
```bash
# Replace YOUR_DROPLET_IP with the actual IP address
ssh root@YOUR_DROPLET_IP

# Example:
# ssh root@139.59.109.98

# If it asks "Are you sure you want to continue connecting?", type: yes
```

**You should now see something like:** `root@maldives-beach-vacation:~#`

### **3.2 Update the Server**
```bash
# Update all packages (this takes 2-3 minutes)
apt update && apt upgrade -y
```

### **3.3 Install Docker**
```bash
# Install Docker (needed to run your application)
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Verify Docker is installed
docker --version
```

### **3.4 Create Deploy User**
```bash
# Create a user for deployment (more secure than using root)
adduser --disabled-password --gecos "" deploy
usermod -aG docker deploy

# Test the deploy user
su - deploy
whoami
# Should show: deploy

# Go back to root
exit
```

### **3.5 Set up Firewall (Security)**
```bash
# Allow SSH, HTTP, and HTTPS traffic
ufw allow OpenSSH
ufw allow 80
ufw allow 443
ufw --force enable

# Check firewall status
ufw status
```

**✅ CHECKPOINT:** Your server is now set up and secure!

---

## 🌍 **STEP 4: DOMAIN CONFIGURATION**

### **4.1 Update DNS Settings**
You need to point your domain to your new server.

**If using Namecheap, GoDaddy, or similar:**
1. Log into your domain provider (where you manage maldivesbeachvacation.com)
2. Go to DNS settings
3. Add/Update these records:

```
Type: A
Host: @
Value: YOUR_DROPLET_IP
TTL: Automatic

Type: A  
Host: www
Value: YOUR_DROPLET_IP
TTL: Automatic
```

**Example:**
```
A    @    139.59.109.98
A    www  139.59.109.98
```

### **4.2 Wait for DNS Propagation**
- DNS changes take 5-60 minutes to work worldwide
- You can check if it's working: `ping maldivesbeachvacation.com`

**✅ CHECKPOINT:** `ping maldivesbeachvacation.com` should show your droplet IP

---

## 📦 **STEP 5: UPDATE YOUR DEPLOYMENT CONFIG**

### **5.1 Update deploy.yml (if IP changed)**
If your droplet IP is different from 139.59.109.98:

```bash
# On your local computer, edit the deploy.yml file:
# Change line 10 to your new IP address
```

### **5.2 Update Production Credentials**
```bash
# On your local computer:
cd /Users/ayasmacbook/maldivesbeachvacation

# Edit production credentials
EDITOR="vim" rails credentials:edit --environment production

# Add this (replace with your Gmail app password):
smtp:
  username: hello@maldivesbeachvacation.com
  password: rhnr nuxt rrzy uwau

digitalocean:
  access_key_id: your_do_spaces_key_if_needed
  secret_access_key: your_do_spaces_secret_if_needed
```

**To save in vim:** Press `ESC`, type `:wq`, press `ENTER`

---

## 🚀 **STEP 6: DEPLOY YOUR APPLICATION**

### **6.1 Initial Deployment**
```bash
# On your local computer:
cd /Users/ayasmacbook/maldivesbeachvacation

# First time setup (this takes 5-10 minutes)
kamal setup

# If you get any errors, try:
kamal deploy
```

### **6.2 Set up Database**
```bash
# Create and set up the database
kamal app exec "bin/rails db:create"
kamal app exec "bin/rails db:migrate"
kamal app exec "bin/rails db:seed"
```

### **6.3 Create Admin User**
```bash
# Create your admin account
kamal app exec "bin/rails admin:create[admin@maldivesbeachvacation.com,YourSecurePassword123]"

# Remember these credentials for logging in!
```

---

## ✅ **STEP 7: VERIFY DEPLOYMENT**

### **7.1 Test Your Website**
1. Open browser and go to: `https://maldivesbeachvacation.com`
2. You should see your resort booking website!
3. Test the booking system
4. Test the contact form

### **7.2 Test Admin Panel**
1. Go to: `https://maldivesbeachvacation.com/admins/sign_in`
2. Login with: `admin@maldivesbeachvacation.com` / `YourSecurePassword123`
3. You should see the admin dashboard

### **7.3 Test Email System**
```bash
# Test email sending
kamal app exec "bin/rails runner 'TestMailer.test_email(\"your-email@example.com\").deliver_now'"
```

---

## 🎉 **SUCCESS! YOUR WEBSITE IS LIVE!**

### **🌐 Your Live Website:**
- **Main Site:** https://maldivesbeachvacation.com
- **Admin Panel:** https://maldivesbeachvacation.com/admins/sign_in
- **Admin Login:** admin@maldivesbeachvacation.com / YourSecurePassword123

### **📊 What's Working:**
✅ Resort property listings  
✅ Booking system with email confirmations  
✅ Contact form  
✅ Admin panel for management  
✅ SSL security (HTTPS)  
✅ Gmail email delivery  
✅ Social media links  

---

## 🔧 **USEFUL COMMANDS FOR LATER**

### **View Application Logs:**
```bash
kamal app logs -f
```

### **Restart Application:**
```bash
kamal app reboot
```

### **Deploy Updates:**
```bash
# After making changes to your code:
kamal deploy
```

### **SSH into Server:**
```bash
ssh root@YOUR_DROPLET_IP
```

### **Check Server Status:**
```bash
kamal app details
```

---

## 🆘 **TROUBLESHOOTING**

### **Can't Connect to Droplet:**
- Check your SSH key was added correctly
- Try: `ssh -v root@YOUR_DROPLET_IP` for detailed error info

### **Website Not Loading:**
- Check DNS propagation: `ping maldivesbeachvacation.com`
- Check server status: `kamal app logs`
- Verify SSL certificates: `kamal traefik logs`

### **Email Not Working:**
- Verify Gmail app password in credentials
- Check logs: `kamal app logs | grep -i smtp`

### **Out of Memory Errors:**
- Add swap file (see troubleshooting section in other docs)
- Consider upgrading to $12/month droplet (2GB RAM)

---

## 💰 **MONTHLY COSTS**
- **Droplet:** $6/month
- **Backups (optional):** +$1.20/month
- **Total:** $6-7.20/month

---

## 🎯 **NEXT STEPS**
1. ✅ Test all website features thoroughly
2. ✅ Add more properties via admin panel
3. ✅ Configure automated backups
4. ✅ Monitor performance and traffic
5. ✅ Set up uptime monitoring (optional)

**Congratulations! Your Maldives Beach Vacation website is now live on the internet!** 🏖️🎉
