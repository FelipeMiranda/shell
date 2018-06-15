#!/bin/bash

if [ ! -z $1 ]; then
HOST=$1
else
	echo "Use $0 HOST"
fi

sse $HOST "/export/scripts/linguem.sh realkill --force"
sse $HOST "/export/scripts/linguem.sh start"

