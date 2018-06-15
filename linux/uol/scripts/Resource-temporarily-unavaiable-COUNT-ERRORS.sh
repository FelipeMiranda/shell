#!/bin/bash

while (true) do lsof -U | grep unicorn -c | awk '{if ($1>100 && $1<120) print "\033[33m",d,$0 ; else if ($1>120) print "\033[31m",d,$0 ; else print "\033[0m",d,$0}' "d=$(date -R)" ; sleep 50 ; done | tee /tmp/unicorn.unix.socket.log
