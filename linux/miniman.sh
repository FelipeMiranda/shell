#!/bin/bash
#
# author: Rafael Quirino - quirinobytes (a) gmail com
# date:	2015-05-30 
# version: 1.0
############################

OSTYPE=`uname`;

if [ "$1" == "-ls" ]; then
ls ~/help/$OSTYPE/help/*.1 | sed 's/.1//g'
exit 0 # mostra os comandos possiveis e sai.
fi


if [ "$2" == "-l" ]; then
OSTYPE="Linux"
echo $OSTYPE
if [ -n "$1" ]; then
	
	if [ -e ~/help/$OSTYPE/help/$1.1 ]; then
	
		man ~/help/$OSTYPE/help/$1.1
	else
		echo "Manual para $1 não existe no MINIMAN"
	fi

else 
	echo -e "Uso: miniman <comando-do-miniman>\n ou $yellow miniman cdshell $normal -> maiores informações."
fi

