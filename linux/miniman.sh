#!/bin/bash
#
# author: Rafael Quirino - quirinobytes (a) gmail com
# date:	2015-05-30 
# version: 1.0
############################

if [ -z $OSTYPE ]; then


	if [ -e ~/help/$OSTYPE/help/$1.man ]; then

		man ~/help/$OSTYPE/help/$1.man

	else
		echo "Manual para $1 não existe no MINIMAN"
	fi

else 
	echo -e "Uso: $0 <comando-do-miniman>"
fi
