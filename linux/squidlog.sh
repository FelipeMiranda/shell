tail -s 0.5 -f /var/log/squid/access.log | awk '{ printf strftime("%H:%M %d/%m ") } $0'
