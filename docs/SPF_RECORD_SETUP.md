# SPF Record Setup Guide

## What is an SPF Record?
An SPF (Sender Policy Framework) record is a DNS TXT record that identifies which mail servers are permitted to send email on behalf of your domain.

## Current Required Components
For your setup, the SPF record needs to include:
1. Google Workspace's mail servers (for your Google Workspace email)
2. Your application server IP (139.59.109.98)

## SPF Record Format
Your SPF record should be:
```
v=spf1 include:_spf.google.com ip4:139.59.109.98 ~all
```

Breaking down the components:
- `v=spf1`: Version of SPF being used
- `include:_spf.google.com`: Includes Google Workspace mail servers
- `ip4:139.59.109.98`: Your application server IP
- `~all`: Soft fail for all other sources (recommended)

## How to Update SPF Record

### Option 1: Through Google Workspace Admin Console
1. Log in to [Google Workspace Admin Console](https://admin.google.com)
2. Go to `Domains`
3. Select your domain (summerdust.com)
4. Go to `DNS records`
5. Find the existing TXT record with `v=spf1`
6. Edit the record or add a new one if none exists
7. Add the complete SPF record:
   ```
   v=spf1 include:_spf.google.com ip4:139.59.109.98 ~all
   ```

### Option 2: Through Your Domain Registrar
1. Log in to your domain registrar's control panel
2. Go to DNS management or DNS records section
3. Look for TXT records
4. Find any existing record that starts with `v=spf1`
5. Either:
   - Edit the existing SPF record to include your server IP
   - Or create a new TXT record:
     - Type: TXT
     - Host/Name: @ (or leave blank, depending on registrar)
     - Value/Data: `v=spf1 include:_spf.google.com ip4:139.59.109.98 ~all`
     - TTL: 3600 (or 1 hour)

## Verifying SPF Record

### Method 1: Using dig
```bash
dig TXT summerdust.com
```

### Method 2: Using online SPF checker
1. Visit [MXToolbox SPF Check](https://mxtoolbox.com/SPFRecordLookup.aspx)
2. Enter your domain (summerdust.com)
3. Click "SPF Record Lookup"

### Method 3: Using Google Admin Toolbox
1. Visit [Google Admin Toolbox](https://toolbox.googleapps.com/apps/checkmx/)
2. Enter your domain
3. Check the SPF record status

## Important Notes

1. **Wait Time**:
   - DNS changes can take 24-48 hours to propagate globally
   - Most changes are visible within a few hours

2. **Multiple SPF Records**:
   - A domain should have only ONE SPF record
   - If you find multiple records, consolidate them

3. **SPF Record Limits**:
   - Maximum 10 DNS lookups per record
   - Include necessary IPs and mechanisms only

4. **Common Issues**:
   - Too many lookups (exceeding 10 DNS lookups)
   - Multiple SPF records
   - Incorrect syntax
   - Missing required components

## Testing Email Delivery

After updating SPF record:

1. Wait at least 1 hour for initial DNS propagation
2. Send a test email from your application
3. Check the email headers of received mail
4. Verify SPF pass in the authentication-results header

## Monitoring

1. Regularly check your SPF record status
2. Monitor email delivery reports in Google Workspace
3. Watch for any increase in spam complaints
4. Check email headers for authentication results

## Troubleshooting

If emails are being marked as spam or failing SPF checks:

1. Verify SPF record syntax
2. Ensure all legitimate sending IPs are included
3. Check for DNS propagation
4. Verify Google Workspace inclusion
5. Monitor authentication results headers

## Best Practices

1. Use `~all` instead of `-all` initially to soft-fail
2. Include only necessary IP addresses
3. Keep record simple and under lookup limits
4. Document all changes to SPF records
5. Regular monitoring and maintenance

