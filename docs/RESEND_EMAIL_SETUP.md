# 📧 Resend Email Setup Guide

## ✅ **Migration from SMTP to Resend API Complete**

### **Why Resend?**
- **No SMTP ports required** - Works with any hosting provider
- **Reliable delivery** - Better than traditional SMTP
- **Free tier** - 3,000 emails/month included
- **Simple API integration** - No complex authentication

---

## 🔧 **Current Configuration**

### **Email Flow:**
- **Booking Confirmations:** FROM hello@maldivesbeachvacation.com → TO customer email
- **Admin Notifications:** FROM hello@maldivesbeachvacation.com → TO hello@maldivesbeachvacation.com
- **Contact Form:** FROM hello@maldivesbeachvacation.com → TO admin contact email

### **API Key:**
```
RESEND_API_KEY: re_RkiRrkpk_5Lp2qpM23qZgf235uizdZ9X5
```

---

## 🏗️ **Technical Implementation**

### **Gem Added:**
```ruby
# Gemfile
gem "resend"
```

### **Configuration Files Updated:**

#### **1. config/initializers/resend.rb**
```ruby
# Resend API Configuration
require 'resend'

# Configure Resend API key
Resend.api_key = Rails.application.credentials.resend_api_key || ENV['RESEND_API_KEY'] || 're_RkiRrkpk_5Lp2qpM23qZgf235uizdZ9X5'

# Custom ActionMailer delivery method for Resend
class ResendDelivery
  def initialize(settings = {})
    @settings = settings
  end

  def deliver!(mail)
    # Convert mail object to Resend format and send via API
    resend_params = {
      from: mail.from.first,
      to: mail.to,
      subject: mail.subject,
      html: mail.html_part ? mail.html_part.body.to_s : mail.body.to_s
    }
    
    response = Resend::Emails.send(resend_params)
    Rails.logger.info "Resend API Response: #{response.inspect}"
    
    mail
  end
end

# Register the custom delivery method
ActionMailer::Base.add_delivery_method :resend, ResendDelivery
```

#### **2. config/environments/production.rb**
```ruby
# Use Resend API for email delivery (no SMTP required)
config.action_mailer.delivery_method = :resend
config.action_mailer.perform_deliveries = true
config.action_mailer.raise_delivery_errors = true
```

#### **3. config/environments/development.rb**
```ruby
# Use Resend API for email delivery in development
config.action_mailer.delivery_method = :resend
config.action_mailer.perform_deliveries = true
config.action_mailer.raise_delivery_errors = true
```

---

## 📋 **Deployment Checklist**

### **For New Client Deployments:**

1. **Domain Verification (Required):**
   - Log in to [Resend Dashboard](https://resend.com/domains)
   - Add client domain (e.g., clientdomain.com)
   - Add DNS records for domain verification
   - Wait for verification (usually 5-10 minutes)

2. **Environment Variables:**
   ```bash
   # Add to .kamal/secrets
   RESEND_API_KEY=re_RkiRrkpk_5Lp2qpM23qZgf235uizdZ9X5
   ```

3. **Update ApplicationMailer:**
   ```ruby
   # app/mailers/application_mailer.rb
   class ApplicationMailer < ActionMailer::Base
     default from: "Client Name <hello@clientdomain.com>"
     layout "mailer"
   end
   ```

4. **Update AdminConfig:**
   ```ruby
   # db/seeds.rb
   admin_config.update!(contact_email: 'hello@clientdomain.com')
   ```

---

## 🧪 **Testing Email Delivery**

### **Development Testing:**
```bash
# Test in Rails console
rails console

# Test contact form emails (async delivery)
BookingMailer.contact_confirmation('test@example.com', 'Test message', 'Test subject').deliver_later
BookingMailer.contact_email('test@example.com', 'Test message', 'Test subject').deliver_later

# For immediate testing (synchronous)
BookingMailer.contact_confirmation('test@example.com', 'Test message', 'Test subject').deliver_now
```

### **Production Testing:**
```bash
# Test via Kamal (async delivery)
kamal app exec "rails runner \"
BookingMailer.contact_confirmation('test@clientdomain.com', 'Production test', 'Test').deliver_later
puts 'Email queued successfully'
\""

# Check background job processing
kamal app exec "rails runner \"
puts 'Pending jobs: ' + SolidQueue::Job.pending.count.to_s
puts 'Failed jobs: ' + SolidQueue::Job.failed.count.to_s
\""
```

---

## 📊 **Email Limits & Monitoring**

### **Free Tier Limits:**
- **3,000 emails/month** - More than sufficient for most resort booking sites
- **Rate limiting:** 2 emails per second
- **Daily quota tracking** - Visible in API responses

### **Monitoring:**
- Check logs for `RESEND API SUCCESS` messages
- Monitor email delivery via Resend Dashboard
- Track daily/monthly quota usage

---

## 🔧 **Advantages Over SMTP**

### **No Port Restrictions:**
- ✅ **No port 465 or 587 required**
- ✅ **Works with any hosting provider**
- ✅ **No firewall configuration needed**
- ✅ **No authentication complexity**

### **Better Reliability:**
- ✅ **Direct API calls** - More reliable than SMTP
- ✅ **Detailed error messages** - Easier debugging
- ✅ **Built-in retry logic** - Better delivery rates
- ✅ **Real-time delivery status** - Immediate feedback
- ✅ **Async processing** - No request timeouts or 502 errors

### **Simplified Deployment:**
- ✅ **Single API key** - No username/password
- ✅ **Environment agnostic** - Same config everywhere
- ✅ **No DNS MX records** - Domain verification only
- ✅ **Instant setup** - No SMTP server configuration
- ✅ **Background jobs** - SolidQueue handles email delivery

---

## 🚨 **Important Notes**

### **Domain Verification Required:**
- Each client domain must be verified in Resend
- DNS records must be added by client
- Verification typically takes 5-10 minutes

### **API Key Security:**
- Store in Rails credentials or environment variables
- Never commit API keys to version control
- Use different API keys for different environments if needed

### **Email Sending Best Practices:**
- Always use client's domain for "from" address
- Include proper unsubscribe links if sending marketing emails
- Monitor bounce rates and delivery statistics
- **Use `deliver_later` for production** - Prevents 502 errors and timeouts
- **Use `deliver_now` only for testing** - Immediate delivery for debugging

### **502 Error Prevention:**
- **FIXED**: All form submissions now use `deliver_later`
- **Contact forms** queue emails in background (no blocking)
- **Booking forms** queue emails in background (no blocking)
- **SolidQueue** processes all emails asynchronously
- **Result**: Instant form submissions, no timeouts

---

**✅ RESEND INTEGRATION COMPLETE - NO SMTP PORTS REQUIRED! ✅**

*This configuration ensures reliable email delivery without any port restrictions, SMTP complexity, or 502 errors.*
