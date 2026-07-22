#!/bin/bash
# Kill existing processes
pkill -f "http.server 18080" 2>/dev/null
pkill -f "node.*localtunnel" 2>/dev/null
sleep 1

# Start HTTP server
cd /home/work/.openclaw/workspace/ktv-salary
nohup python3 -m http.server 18080 > /dev/null 2>&1 &

# Start localtunnel
nohup node -e "
const lt = require('/tmp/node_modules/localtunnel');
const fs = require('fs');
(async () => {
  const tunnel = await lt({ port: 18080 });
  fs.writeFileSync('/tmp/lt-url.txt', tunnel.url);
  console.log('Tunnel started: ' + tunnel.url);
  await new Promise(() => {});
})();
" > /tmp/lt.log 2>&1 &

echo "Server started"
