# Google Workspace SMTP Relay Setup Guide

This guide explains how to set up Google Workspace SMTP Relay for sending emails from the application.

## Prerequisites

1. Google Workspace (formerly G Suite) administrator access
2. Domain verified with Google Workspace
3. Server IP address(es) where the application will be deployed

## 1. Configure Google Workspace SMTP Relay

### Access SMTP Relay Settings
1. Log in to the [Google Workspace Admin Console](https://admin.google.com)
2. Go to `Apps` → `Google Workspace` → `Gmail` → `Routing`
3. Scroll to the "SMTP relay service" section
4. Click "Configure" or "Add another rule"

### Configure SMTP Relay Settings
1. **Basic Settings:**
   - Provide a descriptive name (e.g., "Maldives Beach Vacation App")
   - Description: "SMTP relay for resort booking application"

2. **Allowed Senders:**
   - Select "Only addresses in my domains"

3. **Authentication:**
   - Enable "Only accept mail from the specified IP addresses"
   - Click "ADD"
   - Add your server IP address: `139.59.109.98` (from deploy.yml)
   - If using multiple servers in future, add all server IPs

4. **Encryption:**
   - Enable "Require TLS encryption"
   - This ensures secure email transmission

5. Click "SAVE" to apply the settings

## 2. Update Application Configuration

### Update SMTP Settings

Update `config/initializers/smtp_config.rb`:

```ruby
# SMTP Configuration for Google Workspace Relay
if Rails.env.development?
  ActionMailer::Base.smtp_settings = {
    address: "smtp-relay.gmail.com",
    port: 587,
    domain: "summerdust.com", # Your verified domain
    enable_starttls_auto: true,
    open_timeout: 5,
    read_timeout: 5
  }

  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.raise_delivery_errors = true
end
```

Update `config/environments/production.rb`:

```ruby
  # Specify Google Workspace SMTP Relay settings
  config.action_mailer.smtp_settings = {
    address: "smtp-relay.gmail.com",
    port: 587,
    domain: "summerdust.com", # Your verified domain
    enable_starttls_auto: true,
    open_timeout: 5,
    read_timeout: 5
  }
```

## 3. Update DNS Records

### Add/Update SPF Record
Add your application server IP to your domain's SPF record:

```
v=spf1 include:_spf.google.com ip4:139.59.109.98 ~all
```

If you already have an SPF record, merge this with your existing record.

### Verify MX Records
Ensure your domain has the correct Google Workspace MX records:

```
Priority    Host                
1          ASPMX.L.GOOGLE.COM
5          ALT1.ASPMX.L.GOOGLE.COM
5          ALT2.ASPMX.L.GOOGLE.COM
10         ALT3.ASPMX.L.GOOGLE.COM
10         ALT4.ASPMX.L.GOOGLE.COM
```

## 4. Testing

### Test Email Configuration
1. Start Rails console in production environment:
```bash
RAILS_ENV=production bin/rails console
```

2. Send a test email:
```ruby
TestMailer.test_email("recipient@example.com").deliver_now
```

### Monitor Email Delivery
1. Check Rails logs for email delivery status
2. Monitor Google Workspace Admin Console:
   - Go to `Apps` → `Google Workspace` → `Gmail` → `Advanced Settings`
   - Check "Email Log Search" for delivery status

## 5. Troubleshooting

### Common Issues and Solutions

1. **Connection Refused:**
   - Verify server IP is correctly added in Google Workspace SMTP relay settings
   - Check if port 587 is open in your server's firewall

2. **TLS Errors:**
   - Ensure your server's OpenSSL is up to date
   - Verify TLS is properly configured in SMTP settings

3. **Authentication Failures:**
   - Confirm server IP is correctly allowlisted
   - Verify you're sending from your verified domain

4. **Emails Marked as Spam:**
   - Check SPF record is properly configured
   - Verify sending domain matches verified domain
   - Ensure email content follows best practices

### Logging and Debugging

Enable detailed SMTP logging in Rails:

```ruby
# config/environments/production.rb
config.action_mailer.logger = Logger.new(STDOUT)
config.action_mailer.logger.level = Logger::DEBUG
```

## 6. Security Best Practices

1. **IP Management:**
   - Keep IP allowlist up to date
   - Remove IPs of decommissioned servers
   - Use specific IPs rather than broad ranges

2. **Monitoring:**
   - Regularly check email logs
   - Monitor for unauthorized usage
   - Set up alerts for unusual sending patterns

3. **Access Control:**
   - Limit access to SMTP configuration
   - Regularly audit admin access
   - Document all configuration changes

## 7. Maintenance

Regular maintenance tasks:

1. Monitor email delivery rates and patterns
2. Review and update IP allowlist as needed
3. Keep SPF records current
4. Check for Google Workspace SMTP relay service updates
5. Review and update security settings

