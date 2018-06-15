#!/bin/bash

echo "Cole a saída do Slack Devops-api + ENTER + Crtl-D"

cat > /tmp/1

cat /tmp/1 | grep -v uol | sed '/^$/d' | awk '/@/{print $NF}' > /tmp/afil.list

cat /tmp/1 | grep -v dominiotemporario | grep -v bol.com.br | grep -v devops | sed '/^$/d' > /tmp/uol.list


for EMAIL in $(cat /tmp/afil.list); do
 sse geleia13 "echo -en 'yes\r' | reconstruct $EMAIL"
done

sse geleia13 "status $(cat /tmp/afil.list | tr '\n' ' ' )"
