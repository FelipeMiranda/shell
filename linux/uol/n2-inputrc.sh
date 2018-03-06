

# UOL - Devops Mail 
# Script: Modelo
# Descript: template para uso comum
# Data: 01/01/2018


REMOTE_CMD="sed 's/beginning-of-history/history-search-backward/g' -i /etc/inputrc;sed 's/end-of-history/history-search-forward/g' -i /etc/inputrc;"


if [ ! -z $1 ]; then
	HOST=$1
else
	echo -en Digite um host para executar o comando: $green $REMOTE_CMD $normal
	exit 1
fi


	sse $1 "$REMOTE_CMD"



