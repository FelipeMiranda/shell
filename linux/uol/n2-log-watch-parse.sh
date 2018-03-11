

# UOL - Devops Mail 
# Script: RESTART do /export/scripts/Log_Watch.sh
# Descript: template para uso comum
# Data: 01/01/2018


REMOTE_CMD='/export/scripts/Log_Watch.sh stop parse; /export/scripts/Log_Watch.sh start parse'

if [ ! -z $1 ]; then
	HOST=$1
else
	echo -en Digite um host para executar o comando: $green $REMOTE_CMD $normal
	exit 1
fi


	sse $1 "$REMOTE_CMD"



