#!/bin/bash
# Check if tunnel is running
if ! ps aux | grep -q "node.*localtunnel" | grep -v grep; then
    echo "$(date): Tunnel not running, restarting..." >> /tmp/lt-watchdog.log
    /home/work/.openclaw/workspace/ktv-salary/start-server.sh
fi

# Check if HTTP server is running
if ! ps aux | grep -q "http.server 18080" | grep -v grep; then
    echo "$(date): HTTP server not running, restarting..." >> /tmp/lt-watchdog.log
    cd /home/work/.openclaw/workspace/ktv-salary
    nohup python3 -m http.server 18080 > /dev/null 2>&1 &
fi
