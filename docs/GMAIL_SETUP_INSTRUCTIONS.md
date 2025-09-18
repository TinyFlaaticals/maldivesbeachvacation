# 📧 Gmail SMTP Setup - UPDATED Configuration

## ✅ **What Has Been Updated**

### **1. Replaced Zoho with Gmail**
- **OLD:** contact@summerdust.com (Zoho SMTP)
- **NEW:** hello@maldivesbeachvacation.com (Gmail SMTP)

### **2. Updated Configuration Files**
- ✅ `config/initializers/smtp_config.rb` - Updated for Gmail SMTP
- ✅ `config/environments/production.rb` - Updated for Gmail credentials
- ✅ `app/mailers/application_mailer.rb` - Updated sender email

## 🔧 **Gmail Setup Required**

### **Step 1: Create Gmail Account**
1. Create a Gmail account: `hello@maldivesbeachvacation.com`
2. Enable 2-Step Verification on the account

### **Step 2: Generate App Password**
1. Go to [Google Account Settings](https://myaccount.google.com/)
2. Navigate to Security → 2-Step Verification → App passwords
3. Select "Mail" as the app and "Other" as the device
4. Enter name: "Maldives Beach Vacation Website"
5. Copy the 16-character app password

### **Step 3: Set Development Environment Variables**
```bash
# Add to your .env file or export in terminal
export GMAIL_USERNAME="hello@maldivesbeachvacation.com"
export GMAIL_APP_PASSWORD="your-16-character-app-password"
```

### **Step 4: Update Production Credentials**
```bash
# Edit production credentials
EDITOR="vim" rails credentials:edit --environment production
```

Add this to your production credentials:
```yaml
smtp:
  username: hello@maldivesbeachvacation.com
  password: your-16-character-app-password
```

## 📧 **Gmail SMTP Settings**
- **Server:** smtp.gmail.com
- **Port:** 587 (TLS)
- **Authentication:** PLAIN
- **Security:** STARTTLS
- **Username:** hello@maldivesbeachvacation.com
- **Password:** Your Gmail App Password

## 🧪 **Testing Configuration**

### **Development Testing**
```bash
# Set environment variables first
export GMAIL_USERNAME="hello@maldivesbeachvacation.com"
export GMAIL_APP_PASSWORD="your-app-password"

# Test in Rails console
rails console
TestMailer.test_email("your-test-email@example.com").deliver_now
```

### **Production Testing**
```bash
# After deployment with updated credentials
kamal app exec "bin/rails runner 'TestMailer.test_email(\"your-test-email@example.com\").deliver_now'"
```

## 🔄 **Email Flow Updated**

### **User Booking Confirmation**
- **FROM:** "Maldives Beach Vacation <maldivesbeachvacation@gmail.com>"
- **TO:** Customer's email address
- **SUBJECT:** "Booking Confirmation - Maldives Beach Vacation"

### **Admin Notifications**
- **FROM:** "Maldives Beach Vacation <maldivesbeachvacation@gmail.com>"
- **TO:** Admin contact email (set in AdminConfig)
- **SUBJECT:** Various admin notifications

## ⚠️ **Important Notes**

1. **Domain Considerations**: Using @gmail.com instead of @summerdust.com
2. **Deliverability**: Gmail SMTP is reliable for transactional emails
3. **Rate Limits**: Gmail has sending limits (500 emails/day for free accounts)
4. **Professional Email**: Consider upgrading to Google Workspace for professional domain email

## 🚀 **Next Steps for Deployment**

1. Create Gmail account: `hello@maldivesbeachvacation.com`
2. Generate App Password
3. Update production credentials with Gmail details
4. Test email functionality after deployment
5. Monitor email delivery and Gmail account limits

Your email system is now configured to use Gmail SMTP! 🎉
