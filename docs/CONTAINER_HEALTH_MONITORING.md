# 🏥 Container Health Monitoring & Prevention Guide

## 🚨 **Why Container Failures Happen**

Container failures like the 502 error you experienced can occur due to:

### **Common Causes:**
1. **Memory Exhaustion** - Rails app runs out of RAM
2. **CPU Overload** - High traffic or inefficient code
3. **Database Issues** - Connection timeouts or deadlocks
4. **Background Job Problems** - SolidQueue worker crashes
5. **Server Maintenance** - DigitalOcean updates/restarts
6. **Application Bugs** - Unhandled exceptions causing crashes

---

## 🛡️ **Prevention Strategies**

### **1. Resource Monitoring**

Add these monitoring commands to check regularly:

```bash
# Check memory usage
kamal app exec "free -h"

# Check disk usage
kamal app exec "df -h"

# Check application logs for errors
kamal app logs --lines 100 | grep -i error

# Check background job status
kamal app exec "rails runner 'puts SolidQueue::Job.failed.count'"
```

### **2. Automated Health Checks**

Create a health check script:

```bash
#!/bin/bash
# File: health_check.sh

echo "🏥 Health Check - $(date)"

# Test website response
if curl -f -s https://www.maldivesbeachvacation.com > /dev/null; then
    echo "✅ Website responding"
else
    echo "❌ Website DOWN - Restarting application"
    cd /path/to/maldivesbeachvacation
    kamal app boot
    # Send alert email/notification here
fi

# Check memory usage
MEMORY_USAGE=$(kamal app exec "free | grep Mem | awk '{printf \"%.0f\", \$3/\$2 * 100}'")
if [ "$MEMORY_USAGE" -gt 85 ]; then
    echo "⚠️ High memory usage: ${MEMORY_USAGE}%"
    # Consider restarting if consistently high
fi

echo "📊 Memory usage: ${MEMORY_USAGE}%"
```

### **3. Application-Level Improvements**

#### **Memory Management:**
```ruby
# config/environments/production.rb

# Limit memory usage
config.force_ssl = true
config.log_level = :info  # Reduce log verbosity

# Optimize garbage collection
ENV['RUBY_GC_HEAP_GROWTH_FACTOR'] = '1.1'
ENV['RUBY_GC_HEAP_GROWTH_MAX_SLOTS'] = '10000'
```

#### **Database Connection Pool:**
```ruby
# config/database.yml
production:
  pool: <%= ENV.fetch("RAILS_MAX_THREADS", 3) %>
  timeout: 5000
  checkout_timeout: 5
```

### **4. Proactive Monitoring Setup**

#### **Daily Health Check Cron Job:**
```bash
# Add to your local machine or monitoring server
# crontab -e
0 */6 * * * /path/to/health_check.sh >> /var/log/health_check.log 2>&1
```

#### **Log Rotation:**
```bash
# Prevent log files from filling disk
kamal app exec "logrotate -f /etc/logrotate.conf"
```

---

## 🚑 **Quick Recovery Procedures**

### **If Website Goes Down:**

1. **Immediate Fix:**
   ```bash
   cd /Users/ayasmacbook/maldivesbeachvacation
   kamal app boot
   ```

2. **Check What Happened:**
   ```bash
   # Check recent logs
   kamal app logs --lines 50
   
   # Check proxy logs
   kamal proxy logs | tail -20
   
   # Check system resources
   kamal app exec "free -h && df -h"
   ```

3. **Verify Recovery:**
   ```bash
   curl -I https://www.maldivesbeachvacation.com
   ```

### **If Database Issues:**
```bash
# Check database status
kamal accessory logs db

# Restart database if needed
kamal accessory restart db

# Test database connection
kamal app exec "rails runner 'puts ActiveRecord::Base.connection.execute(\"SELECT 1\")'"
```

---

## 📊 **Monitoring Dashboard**

Create a simple monitoring script:

```bash
#!/bin/bash
# File: status_dashboard.sh

echo "🏨 Maldives Beach Vacation - Status Dashboard"
echo "=============================================="
echo "📅 $(date)"
echo ""

# Website Status
if curl -f -s https://www.maldivesbeachvacation.com > /dev/null; then
    echo "🌐 Website: ✅ ONLINE"
else
    echo "🌐 Website: ❌ OFFLINE"
fi

# Container Status
CONTAINER_STATUS=$(kamal app details | grep "Up" | wc -l)
if [ "$CONTAINER_STATUS" -gt 0 ]; then
    echo "🐳 Container: ✅ RUNNING"
else
    echo "🐳 Container: ❌ STOPPED"
fi

# Memory Usage
MEMORY_USAGE=$(kamal app exec "free | grep Mem | awk '{printf \"%.0f\", \$3/\$2 * 100}'")
echo "💾 Memory Usage: ${MEMORY_USAGE}%"

# Disk Usage
DISK_USAGE=$(kamal app exec "df -h / | tail -1 | awk '{print \$5}'" | sed 's/%//')
echo "💿 Disk Usage: ${DISK_USAGE}%"

# Background Jobs
FAILED_JOBS=$(kamal app exec "rails runner 'puts SolidQueue::Job.failed.count'" 2>/dev/null || echo "N/A")
echo "⚙️ Failed Jobs: ${FAILED_JOBS}"

echo ""
echo "🔄 Last updated: $(date)"
```

---

## 🔔 **Alert Setup Options**

### **1. Email Alerts (Simple):**
```bash
# Add to health check script
if [ website_down ]; then
    echo "Website is down!" | mail -s "ALERT: Website Down" your-email@gmail.com
fi
```

### **2. Slack/Discord Webhook:**
```bash
# Send alert to Slack
curl -X POST -H 'Content-type: application/json' \
    --data '{"text":"🚨 Website Down - Auto-restarting"}' \
    YOUR_SLACK_WEBHOOK_URL
```

### **3. SMS Alerts (Advanced):**
Use services like Twilio for critical alerts.

---

## 📈 **Long-term Stability Improvements**

### **1. Resource Scaling:**
- Monitor traffic patterns
- Upgrade server if consistently high resource usage
- Consider load balancing for high traffic

### **2. Application Optimization:**
- Regular code reviews for memory leaks
- Database query optimization
- Image optimization and CDN usage

### **3. Backup Strategy:**
- Regular database backups
- Application state snapshots
- Quick rollback procedures

---

## 🎯 **Recommended Monitoring Schedule**

| Frequency | Action | Purpose |
|-----------|--------|---------|
| **Every 6 hours** | Automated health check | Early problem detection |
| **Daily** | Review logs for errors | Identify recurring issues |
| **Weekly** | Resource usage analysis | Plan capacity needs |
| **Monthly** | Full system review | Optimize and improve |

---

## 🚀 **Next Steps for You**

1. **Set up the health check script** (run every 6 hours)
2. **Monitor resource usage** for a week to establish baselines
3. **Set up basic email alerts** for downtime
4. **Review logs weekly** for any recurring issues
5. **Consider upgrading server** if resource usage is consistently high

This proactive approach will significantly reduce the likelihood of unexpected downtime and ensure quick recovery when issues do occur.