#!/bin/bash
PORT=2013
SERVER=10.129.144.72
UNICORN=$(/bin/egrep -c "$(date +%Y/%m/%d" "%R -d "1 min ago").*Resource temporarily unavailable.*/var/run/wor/unicorn.webmail.sock" /export/logs/nginx17/error.log-$(date +%Y%m%d).log)
echo "WEBMAILAFIL.$(hostname).unicornunavailable $UNICORN $(date +%s)" | nc -w1 ${SERVER} ${PORT}
date ; echo $UNICORN
