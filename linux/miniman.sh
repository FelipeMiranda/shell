#!/bin/bash
#
# author: Rafael Quirino - quirinobytes (a) gmail com
# date:	2015-05-30 
# version: 1.0
############################
source ~/shell/colors.sh

OSTYPE=`uname`;

if [ "$2" == "-L" ]; then
OSTYPE="Linux"
fi

if [ "$2" == "-A" ]; then
OSTYPE="AIX"
fi

if [ "$2" == "-O" ]; then
OSTYPE="OpenBSD"
fi

if [ "$2" == "-W" ]; then
OSTYPE="Windows"
fi


#Isso tem que ficar embaixo dos opcoes -L -A -O pois depende do valor da variavel OSTYPE que pode ser mudada ali.
if [ "$1" == "-ls" ]; then
echo -e "Sistema Operacional:$red $OSTYPE $normal"
ls ~/help/$OSTYPE/help/*.1 | sed 's/.1//g' | sed 's/[a-zA-Z]*\///g'
exit 0 # mostra os comandos possiveis e sai.
fi



if [ -n "$1" ]; then
	
	if [ -e ~/help/$OSTYPE/help/$1.1 ]; then
	
		man ~/help/$OSTYPE/help/$1.1
	else
		echo -e "Manual para $1 não existe no MINIMAN\n"
	   echo -e "\n\n tente: miniman [COMANDO] <SIST.OPERACIONAL>\n"
      echo -e "\n miniman -ls    -> Mostra os minimans disponiveis\n\n"
      echo -e "\n <SIST. OPERACIONAL> = -A  -> AIX "
      echo -e "\n <SIST. OPERACIONAL> = -L  -> Linux "
      echo -e "\n <SIST. OPERACIONAL> = -O  -> OpenBSD "
      echo -e "\n <SIST. OPERACIONAL> = -W  -> Windows "
	fi

else 
	echo -e "Uso: miniman <comando-do-miniman>\n ou $yellow miniman cdshell $normal -> maiores informações."
fi

