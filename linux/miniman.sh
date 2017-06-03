#!/bin/bash
#
# author: Rafael Quirino - quirinobytes (a) gmail com
# date:	2015-05-30 
# version: 1.0
############################
source ~/shell/colors.sh

OSTYPE=`uname`;
SCRIPT_NAME=`basename $0`

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
if [ "$1" == "--ls" ] || [ "$1" == "-l" ] ; then
echo -e "Sistema Operacional:$red $OSTYPE $normal"
ls ~/help/$OSTYPE/help/*.1 | sed 's/.1//g' | sed 's/[a-zA-Z]*\///g'
exit 0 # mostra os comandos possiveis e sai.
fi


if [ "$1" == "-c" ]; then

	if [ ! -z $2 ] ; then
		MINIMAN_FILENAME=$2.md
		MINIMAN_NAME=$2
		else
		   echo -en "Use: ${SCRIPT_NAME} -c $green arquivo_miniman $normal\n"
	   exit 1
	fi
	#	se ja entrou no -c entao sai fora...
	exit 0
fi



# funcao default *) quando nao passado nenhum paramento -c/-l/-L/-h/etc...
## COMO NAO ENTROU EM NENHUMA OPCAO ACIMA E SAIU VIA FORCEPS COM EXIT, so sobrou executar o padrao.
# Se passar um parametro, entao vamos la mostrar o miniman daquele comando, caso tenha!
if [ -n "$1" ]; then

	if [ -e ~/help/$OSTYPE/help/$1.1 ]; then
		man ~/help/$OSTYPE/help/$1.1
	else
		echo -en "\n${red}ERRO: Manual para esse $yellow $1 $red não existe no diretório de MINIMAN's $normal\n\n\n"
		echo -en "\n\n\n${green}Criando o miniman...\n" 
		
			#se ja existe o .md criado, e ainda nao foi gerado o .1 entao alerte-o sobre o perigo de apagar algo ja criado!
			if [ -e ~/help/$OSTYPE/help/$1.md ] && [ ! -e ~/help/$OSTYPE/help/$1.1 ]; then
				echo -en "\n\t\t$alert#DANGER#$normal Já existe um md, mas ainda nao foi gerado o miniman $MINIMAN_NAME $alert#DANGER#$normal\n\n"
			fi
		echo -en "- Deseja já copiar o modelo para -> ~/help/$OSTYPE/help/$1.md ?\n"
		read -p "(S/N)" RESP
		if [ "$RESP" == "S" ] || [ "$RESP" == "s" ]; then
			
			#criando as variaveis necessarias para criar o nome do arquivo.
			MINIMAN_FILENAME=$1.md
			MINIMAN_NAME=$1	
			cd /$USER/help/Linux/help
			cp model.md $MINIMAN_FILENAME
			sed -i "s/model/$MINIMAN_NAME/g" $MINIMAN_FILENAME
			cd -
			echo -en "\nDone!\n\n ... $yellow $MINIMAN_FILENAME $normal criado com $green sucesso! \t $alert \o/ $normal\n\n" 
			exit 0
		fi 
	   echo -e "\n\n Use: miniman [COMANDO] <SIST.OPERACIONAL>\n"
      echo -e "\n miniman --ls    -> Mostra os minimans disponiveis\n\n"
      echo -e "\n <SIST. OPERACIONAL> = -A  -> AIX "
      echo -e "\n <SIST. OPERACIONAL> = -L  -> Linux "
      echo -e "\n <SIST. OPERACIONAL> = -O  -> OpenBSD "
      echo -e "\n <SIST. OPERACIONAL> = -W  -> Windows "
	fi

else 
	echo -e "Uso: miniman <comando-do-miniman>\n ou $yellow miniman cdshell $normal -> maiores informações."
fi

