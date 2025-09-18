# Gmail SMTP Setup Guide

This guide explains how to set up Gmail SMTP for sending emails from the application.

## Prerequisites

1. A Gmail account
2. 2-Step Verification enabled on your Google Account

## Setting up Gmail App Password

1. Go to your Google Account settings: https://myaccount.google.com/
2. Navigate to Security
3. Under "Signing in to Google," find "2-Step Verification" and click on "App passwords"
4. Select "Mail" as the app and "Other" as the device
5. Enter a name for the app password (e.g., "Maldives Beach Vacation")
6. Click "Generate"
7. Copy the 16-character password that appears

## Configuration

### Development Environment

Set the following environment variables:

```bash
export GMAIL_USERNAME="your.email@gmail.com"
export GMAIL_APP_PASSWORD="your-16-character-app-password"
```

### Production Environment

Update your Rails credentials:

```bash
EDITOR="vim" bin/rails credentials:edit
```

Add the following to your credentials file:

```yaml
smtp:
  username: your.email@gmail.com
  password: your-16-character-app-password
```

## SMTP Settings

The application is configured to use the following Gmail SMTP settings:

- SMTP Server: smtp.gmail.com
- Port: 587 (TLS)
- Authentication: Required (PLAIN)
- Security: STARTTLS
- Username: Your Gmail address
- Password: Your App Password

## Testing

To test if the email configuration is working:

1. Start the Rails console:
```bash
bin/rails console
```

2. Send a test email:
```ruby
TestMailer.test_email("recipient@example.com").deliver_now
```

## Troubleshooting

1. If you get authentication errors:
   - Verify your App Password is correct
   - Ensure 2-Step Verification is enabled
   - Check if you're using the correct Gmail address

2. If emails aren't being sent:
   - Check if your Gmail account has any sending limits
   - Verify the SMTP settings in config/initializers/smtp_config.rb
   - Check the Rails logs for detailed error messages
