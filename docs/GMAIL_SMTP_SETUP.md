# Gmail SMTP Setup Guide

## Email Configuration
**Email Address:** `hello@maldivesbeachvacation.com`

## Setup Steps

### 1. Create Gmail Account
Create Gmail account: `hello@maldivesbeachvacation.com`

### 2. Enable 2-Step Verification
1. Go to [Google Account Security](https://myaccount.google.com/security)
2. Enable "2-Step Verification"

### 3. Generate App Password
1. In Security settings, go to "2-Step Verification" → "App passwords"
2. Select "Mail" → "Other" 
3. Enter: "Maldives Beach Vacation Website"
4. Copy the 16-character password

### 4. Update Production Credentials
```bash
EDITOR="vim" rails credentials:edit --environment production
```

Add to credentials:
```yaml
smtp:
  username: hello@maldivesbeachvacation.com
  password: your-16-character-app-password
```

### 5. Development Environment
```bash
export GMAIL_USERNAME="hello@maldivesbeachvacation.com"
export GMAIL_APP_PASSWORD="your-16-character-app-password"
```
