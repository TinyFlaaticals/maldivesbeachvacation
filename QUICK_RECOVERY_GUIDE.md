# 🚑 Quick Recovery Guide - 502 Errors

## ⚡ **IMMEDIATE ACTION (30 seconds)**

If your website shows 502 errors:

```bash
cd /Users/ayasmacbook/maldivesbeachvacation
kamal app boot
```

**Wait 1-2 minutes, then test:**
```bash
curl -I https://www.maldivesbeachvacation.com
```

✅ **If you see `HTTP/2 200 OK` - Problem solved!**

---

## 🔍 **If Still Not Working**

### **Step 1: Check Container Status**
```bash
kamal app details
```
Look for: `STATUS: Up X seconds`

### **Step 2: Check Proxy Logs**
```bash
kamal proxy logs | tail -20
```
Look for: `"Error while proxying"` messages

### **Step 3: Check Application Logs**
```bash
kamal app logs --lines 50
```
Look for: Error messages or crashes

### **Step 4: Check Server Resources**
```bash
kamal app exec "free -h && df -h"
```
Look for: High memory/disk usage

---

## 🛠️ **Advanced Recovery Steps**

### **If Container Won't Start:**
```bash
# Force restart everything
kamal proxy restart
kamal app boot

# If still failing, check database
kamal accessory logs db
kamal accessory restart db
```

### **If Memory Issues:**
```bash
# Check memory usage
kamal app exec "free -h"

# If memory is full, restart to clear
kamal app boot
```

### **If Disk Full:**
```bash
# Check disk usage
kamal app exec "df -h"

# Clean up logs if needed
kamal app exec "find /rails/log -name '*.log' -mtime +7 -delete"
```

---

## 📞 **Emergency Contacts**

- **Server IP:** 139.59.22.46
- **Domain:** maldivesbeachvacation.com
- **Registry:** ibazhad/resort_booking

## 🔄 **Prevention**

Run the health check script every 6 hours:
```bash
./health_check.sh
```

Add to crontab for automation:
```bash
crontab -e
# Add: 0 */6 * * * /path/to/maldivesbeachvacation/health_check.sh >> /var/log/health_check.log 2>&1
```