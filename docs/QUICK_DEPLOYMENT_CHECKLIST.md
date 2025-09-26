# ⚡ **QUICK DEPLOYMENT CHECKLIST**
## 48-Hour Client Deployment Reference

---

## 🏃‍♂️ **HOUR-BY-HOUR TIMELINE**

### **HOURS 0-2: CLIENT BRIEFING**
- [ ] Collect client business information
- [ ] Gather branding assets (logo, colors, fonts)
- [ ] Obtain content (company name, descriptions, social media)
- [ ] Confirm domain and hosting requirements
- [ ] Set up project folder and Git repository

### **HOURS 2-8: CUSTOMIZATION**
- [ ] Replace logo files (`logo.png`, `logo-white.png`, `favicon.png`)
- [ ] Update primary color in `tailwind.config.js`
- [ ] Customize meta tags in `application.html.erb`
- [ ] Update footer content and social links
- [ ] Modify homepage SEO content
- [ ] Test UI changes locally

### **HOURS 8-16: CONFIGURATION**
- [ ] Update `config/deploy.yml` with client domain
- [ ] Configure production environment settings
- [ ] Configure Resend API for email delivery
- [ ] Configure DigitalOcean Spaces
- [ ] Update database credentials
- [ ] Prepare deployment secrets

### **HOURS 16-24: DEPLOYMENT**
- [ ] Create DigitalOcean droplet
- [ ] Set up DNS records
- [ ] Run `kamal setup`
- [ ] Execute `kamal deploy`
- [ ] Seed database with client data
- [ ] Test all functionality

### **HOURS 24-48: TESTING & HANDOVER**
- [ ] Comprehensive functionality testing
- [ ] Performance optimization
- [ ] Client training session
- [ ] Documentation handover
- [ ] Support setup

---

## 📁 **FILES TO MODIFY CHECKLIST**

### **🎨 BRANDING & ASSETS**
```
✅ app/assets/images/logo.png              # Main logo
✅ app/assets/images/logo-white.png        # White logo for dark backgrounds  
✅ app/assets/images/favicon.png           # Browser favicon
✅ tailwind.config.js                      # Primary color (#27AAE1 → CLIENT_COLOR)
```

### **📝 CONTENT & SEO**
```
✅ app/views/layouts/application.html.erb  # Page title, meta tags, author
✅ app/views/pages/home.html.erb           # Homepage title, description, JSON-LD
✅ app/views/layouts/_footer.html.erb      # Company name, social links, copyright
✅ public/robots.txt                       # Sitemap URL
✅ app/views/sitemap/index.xml.erb         # All URLs with client domain
```

### **⚙️ CONFIGURATION**
```
✅ config/deploy.yml                       # Domain, server IP, SSL hosts
✅ config/environments/production.rb       # Email settings, domain, hosts
✅ app/mailers/application_mailer.rb       # From email address
✅ .kamal/secrets                          # All environment variables
✅ db/seeds.rb                             # Admin user, default content
```

---

## 🔑 **CREDENTIALS TEMPLATE**

### **CLIENT INFORMATION**
```
CLIENT_NAME: [Company Name]
CLIENT_DOMAIN: [domain.com]
CLIENT_EMAIL: hello@[domain].com
CLIENT_PHONE: [Phone Number]
CLIENT_INSTAGRAM: @[handle]
CLIENT_FACEBOOK: @[handle]
ADMIN_PASSWORD: [Secure Password]
```

### **TECHNICAL CREDENTIALS**
```
DROPLET_IP: [139.59.22.46]
RESEND_API_KEY: [resend-api-key]
POSTGRES_PASSWORD: [secure-password]
DO_ACCESS_KEY_ID: [DigitalOcean Access Key]
DO_SECRET_ACCESS_KEY: [DigitalOcean Secret Key]
DO_REGION: [nyc3/sgp1/blr1]
DO_BUCKET: [client-name]-production-storage
```

---

## 🚀 **DEPLOYMENT COMMANDS**

### **INITIAL SETUP**
```bash
# 1. Clone template
git clone [TEMPLATE_REPO] [CLIENT_PROJECT]
cd [CLIENT_PROJECT]

# 2. Update Git remote
git remote set-url origin [CLIENT_REPO_URL]

# 3. Replace assets
cp [CLIENT_LOGO] app/assets/images/logo.png
cp [CLIENT_LOGO_WHITE] app/assets/images/logo-white.png  
cp [CLIENT_FAVICON] app/assets/images/favicon.png

# 4. Test build
docker build -t [CLIENT_NAME]_booking .
```

### **DEPLOYMENT**
```bash
# 1. Setup Kamal
kamal setup

# 2. Deploy application  
kamal deploy

# 3. Seed database
kamal app exec "rails db:seed"

# 4. Test email
kamal app exec "rails runner \"TestMailer.test_email('test@[CLIENT_DOMAIN].com').deliver_now\""
```

---

## ✅ **VERIFICATION CHECKLIST**

### **FUNCTIONALITY TESTING**
- [ ] Website loads at https://[CLIENT_DOMAIN].com
- [ ] SSL certificate active (green padlock)
- [ ] Admin panel login works
- [ ] Property search and filters work
- [ ] Booking form submits successfully
- [ ] Email confirmations sent
- [ ] Contact form works
- [ ] File uploads work in admin
- [ ] Mobile responsive design
- [ ] All social media links work

### **SEO & PERFORMANCE**
- [ ] Meta tags show client information
- [ ] Sitemap accessible at /sitemap.xml
- [ ] Google Search Console setup
- [ ] Page load time <2 seconds
- [ ] Images optimized and loading
- [ ] Favicon displays correctly
- [ ] All pages return 200 status

### **BRANDING VERIFICATION**
- [ ] Logo displays on all pages
- [ ] Colors match brand guidelines
- [ ] Company name appears correctly
- [ ] Footer information accurate
- [ ] Social media icons link correctly
- [ ] Copyright year current

---

## 🎯 **COMMON CUSTOMIZATION PATTERNS**

### **FIND & REPLACE PATTERNS**
```bash
# Company Name
find . -name "*.erb" -exec sed -i '' 's/Maldives Beach Vacation Pvt Ltd/[CLIENT_COMPANY]/g' {} \;

# Domain
find . -name "*.rb" -o -name "*.yml" -o -name "*.erb" -exec sed -i '' 's/maldivesbeachvacation\.com/[CLIENT_DOMAIN].com/g' {} \;

# Email  
find . -name "*.rb" -o -name "*.erb" -exec sed -i '' 's/hello@maldivesbeachvacation\.com/hello@[CLIENT_DOMAIN].com/g' {} \;

# Social Media
find . -name "*.erb" -exec sed -i '' 's/maldivesbeachvacation/[CLIENT_HANDLE]/g' {} \;
```

### **COLOR CUSTOMIZATION**
```javascript
// tailwind.config.js
primary: "#[CLIENT_PRIMARY_COLOR]",

// Additional colors if needed
secondary: "#[CLIENT_SECONDARY_COLOR]",
accent: "#[CLIENT_ACCENT_COLOR]",
```

---

## 🆘 **TROUBLESHOOTING QUICK FIXES**

### **DEPLOYMENT ISSUES**
```bash
# Site not loading
kamal app logs
kamal app restart

# SSL issues
kamal deploy --force

# Database connection
kamal app exec "rails db:migrate"
kamal app exec "rails db:seed"
```

### **EMAIL ISSUES**
```bash
# Test email sending (uses Resend API)
kamal app exec "rails runner \"
TestMailer.test_email('test@example.com').deliver_now
\""

# Check Resend configuration
kamal app exec "rails runner \"
puts 'Resend API Key: ' + (Resend.api_key ? 'Set' : 'Not set')
puts 'Delivery method: ' + ActionMailer::Base.delivery_method.to_s
\""

# Check background job processing
kamal app exec "rails runner \"
puts 'SolidQueue running: ' + (defined?(SolidQueue) ? 'Yes' : 'No')
\""
```

### **PERFORMANCE ISSUES**
```bash
# Check server resources
kamal app exec "free -h"
kamal app exec "df -h"

# Application logs
kamal app logs --tail 100

# Check background job queue
kamal app exec "rails runner \"
puts 'Pending jobs: ' + SolidQueue::Job.pending.count.to_s
puts 'Failed jobs: ' + SolidQueue::Job.failed.count.to_s
\""

# Restart if needed
kamal app restart
```

### **502 ERRORS (FIXED)**
```bash
# If you encounter 502 errors during form submissions:
# This was caused by synchronous email delivery blocking requests
# SOLUTION: All emails now use deliver_later (background processing)

# Check if background jobs are processing
kamal app logs | grep "SolidQueue"

# Verify async email delivery is working
kamal app exec "rails runner \"
BookingMailer.contact_confirmation('test@example.com', 'test', 'test').deliver_later
puts 'Email queued successfully'
\""
```

---

## 📋 **CLIENT HANDOVER PACKAGE**

### **ACCESS CREDENTIALS TEMPLATE**
```
🌐 WEBSITE ACCESS
URL: https://[CLIENT_DOMAIN].com
Status: ✅ Live and SSL Secured

🔐 ADMIN PANEL ACCESS  
URL: https://[CLIENT_DOMAIN].com/admins/sign_in
Email: admin@[CLIENT_DOMAIN].com
Password: [SECURE_PASSWORD]

📧 EMAIL SERVICE
Service: Resend API
From Address: hello@[CLIENT_DOMAIN].com
API Key: [RESEND_API_KEY]
No SMTP ports required

🖥️ SERVER DETAILS
Provider: DigitalOcean
IP Address: [DROPLET_IP]
Size: $6/month (1GB RAM)
Region: [REGION]

☁️ STORAGE
Provider: DigitalOcean Spaces
Bucket: [BUCKET_NAME]
Region: [REGION]
CDN: Enabled
```

### **TRAINING CHECKLIST**
- [ ] Admin panel navigation
- [ ] Property management
- [ ] Image uploads
- [ ] Booking management
- [ ] Content updates
- [ ] Site configuration
- [ ] SEO settings
- [ ] Contact form monitoring

---

## 💰 **COST BREAKDOWN**

### **MONTHLY RECURRING COSTS**
- **Server (DigitalOcean)**: $6/month
- **Storage (Spaces)**: $5/month  
- **Domain SSL**: Free (Let's Encrypt)
- **Email**: Free (Resend API - 3,000 emails/month free tier)
- **Total Infrastructure**: $11/month

### **SETUP COSTS (ONE-TIME)**
- **Platform Customization**: $2,000-3,000
- **DigitalOcean Setup**: $50
- **Domain Setup**: Client responsibility
- **Training Session**: Included
- **Documentation**: Included

---

**⚡ READY FOR RAPID DEPLOYMENT! ⚡**

*Keep this checklist handy for every client deployment to ensure consistency and speed.*
