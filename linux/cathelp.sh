#!/bin/bash


#Exibe os arquivos do help Miniman

OSTYPE=`uname`

VAR=$1

if [ -z $VAR ] ; then
     echo "Digite algum nome de programa para visualizar o help"
else
	if [ -e ~/help/$OSTYPE/help/$VAR.hlp ]; then
        	cat ~/help/$OSTYPE/help/$VAR.hlp
        else
                echo "Programa nao encontrado no diretório ~/help/$OSTYPE/help/"
	fi
fi

