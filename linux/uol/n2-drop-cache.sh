

# UOL - Devops Mail 
# Script: Drop Cache
# Descript: Zerar o cache dos servidores.
# Data: 01/01/2018


REMOTE_CMD='echo 3 > /proc/sys/vm/drop_caches'

if [ ! -z $1 ]; then
	HOST=$1
else
	echo -en Digite um host para executar o comando: $green $REMOTE_CMD $normal
	exit 1
fi

	sse $1 $REMOTE_CMD



