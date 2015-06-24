#!/bin/bash
#
# author: Rafael Quirino - quirinobytes (a) gmail com
# date:	2015-05-30 
# version: 1.0
############################

OSTYPE=`uname`;

if [ "$1" == "-ls" ]; then
ls ~/help/$OSTYPE/help/*.1 | sed 's/.1//g' | sed 's/[a-zA-Z]*\///g'
exit 0 # mostra os comandos possiveis e sai.
fi


if [ "$2" == "-L" ]; then
OSTYPE="Linux"
echo $OSTYPE
fi

if [ "$2" == "-A" ]; then
OSTYPE="AIX"
echo $OSTYPE
fi

if [ "$2" == "-O" ]; then
OSTYPE="OpenBSD"
echo $OSTYPE
fi




if [ -n "$1" ]; then
	
	if [ -e ~/help/$OSTYPE/help/$1.1 ]; then
	
		man ~/help/$OSTYPE/help/$1.1
	else
		echo "Manual para $1 não existe no MINIMAN"
	fi

else 
	echo -e "Uso: miniman <comando-do-miniman>\n ou $yellow miniman cdshell $normal -> maiores informações."
fi

