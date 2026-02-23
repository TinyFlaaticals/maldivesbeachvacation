#!/bin/bash

# 🏥 Maldives Beach Vacation - Health Check Script
# Run this script every 6 hours to monitor your website

cd "$(dirname "$0")"

echo "🏥 Health Check - $(date)"
echo "=================================="

# Test website response
echo "🌐 Testing website..."
if curl -f -s --max-time 10 https://www.maldivesbeachvacation.com > /dev/null; then
    echo "✅ Website is responding normally"
    WEBSITE_STATUS="UP"
else
    echo "❌ Website is DOWN - Attempting automatic restart..."
    WEBSITE_STATUS="DOWN"
    
    # Attempt to restart the application
    echo "🔄 Restarting application container..."
    kamal app boot
    
    # Wait a moment and test again
    sleep 30
    if curl -f -s --max-time 10 https://www.maldivesbeachvacation.com > /dev/null; then
        echo "✅ Website restored after restart"
        WEBSITE_STATUS="RESTORED"
    else
        echo "❌ Website still down after restart - Manual intervention needed"
        WEBSITE_STATUS="CRITICAL"
    fi
fi

# Check container status
echo ""
echo "🐳 Checking container status..."
CONTAINER_COUNT=$(kamal app details 2>/dev/null | grep -c "Up.*seconds")
if [ "$CONTAINER_COUNT" -gt 0 ]; then
    echo "✅ Application container is running"
    CONTAINER_STATUS="RUNNING"
else
    echo "❌ No running containers found"
    CONTAINER_STATUS="STOPPED"
fi

# Check memory usage
echo ""
echo "💾 Checking memory usage..."
MEMORY_USAGE=$(kamal app exec "free | grep Mem | awk '{printf \"%.0f\", \$3/\$2 * 100}'" 2>/dev/null || echo "N/A")
if [ "$MEMORY_USAGE" != "N/A" ]; then
    echo "📊 Memory usage: ${MEMORY_USAGE}%"
    if [ "$MEMORY_USAGE" -gt 85 ]; then
        echo "⚠️  HIGH MEMORY USAGE WARNING"
        MEMORY_STATUS="HIGH"
    else
        MEMORY_STATUS="OK"
    fi
else
    echo "❓ Could not check memory usage"
    MEMORY_STATUS="UNKNOWN"
fi

# Check disk usage
echo ""
echo "💿 Checking disk usage..."
DISK_USAGE=$(kamal app exec "df -h / | tail -1 | awk '{print \$5}'" 2>/dev/null | sed 's/%//' || echo "N/A")
if [ "$DISK_USAGE" != "N/A" ]; then
    echo "📊 Disk usage: ${DISK_USAGE}%"
    if [ "$DISK_USAGE" -gt 85 ]; then
        echo "⚠️  HIGH DISK USAGE WARNING"
        DISK_STATUS="HIGH"
    else
        DISK_STATUS="OK"
    fi
else
    echo "❓ Could not check disk usage"
    DISK_STATUS="UNKNOWN"
fi

# Check background jobs
echo ""
echo "⚙️ Checking background jobs..."
FAILED_JOBS=$(kamal app exec "rails runner 'puts SolidQueue::Job.failed.count'" 2>/dev/null || echo "N/A")
if [ "$FAILED_JOBS" != "N/A" ]; then
    echo "📊 Failed jobs: ${FAILED_JOBS}"
    if [ "$FAILED_JOBS" -gt 5 ]; then
        echo "⚠️  HIGH FAILED JOBS WARNING"
        JOBS_STATUS="HIGH"
    else
        JOBS_STATUS="OK"
    fi
else
    echo "❓ Could not check background jobs"
    JOBS_STATUS="UNKNOWN"
fi

# Summary
echo ""
echo "📋 HEALTH CHECK SUMMARY"
echo "======================="
echo "🌐 Website: $WEBSITE_STATUS"
echo "🐳 Container: $CONTAINER_STATUS"
echo "💾 Memory: $MEMORY_STATUS ($MEMORY_USAGE%)"
echo "💿 Disk: $DISK_STATUS ($DISK_USAGE%)"
echo "⚙️ Jobs: $JOBS_STATUS ($FAILED_JOBS failed)"
echo "🕐 Checked at: $(date)"

# Log to file
echo "$(date): Website=$WEBSITE_STATUS Container=$CONTAINER_STATUS Memory=$MEMORY_USAGE% Disk=$DISK_USAGE% FailedJobs=$FAILED_JOBS" >> health_check.log

# Send alert if critical issues
if [ "$WEBSITE_STATUS" = "CRITICAL" ] || [ "$CONTAINER_STATUS" = "STOPPED" ]; then
    echo ""
    echo "🚨 CRITICAL ALERT: Manual intervention required!"
    echo "   - Check server status"
    echo "   - Review application logs: kamal app logs"
    echo "   - Check proxy logs: kamal proxy logs"
    
    # Uncomment and configure for email alerts:
    # echo "Critical issue detected on $(date)" | mail -s "🚨 URGENT: Website Down" your-email@gmail.com
fi

echo ""
echo "✅ Health check completed"
echo "=================================="