#!/bin/bash

#################################################
# Bash script - Modelo					#
# Use como modelo para criar seus scripts bash. #
# v_1.0.1							#
#################################################
VERSION=1.0


#############     CONFIG     ####################
#Carrega variáreis de ambiente.
source ~/.export
# Suporte a cores no bash.
source ~/shell/colors.sh
################################################


##########  Funcao       #######################
function help(){
    echo -en "$\n\n\t $alert Use: $green $0 $PARAMETERS $normal \n\n"
}

function versao(){
    echo -en "$\n\n\t $alert Versao: $green $0 $VERSION $normal \n\n"
}

#funcao que retorna o numero de parametros, caso tenha, 
function hasParams(){
    if [ $# -lt 1 ]; then
	 echo "Faltou utilizar pelo menos um argumento!"
    	 echo "Numero de argumentos: $#"
	 return 0
    else
	 echo "Tem $#"
	 return $#
    fi
}

################################################
#############        MAIN       ################
case $1 in
		"ps" | "-p" | "--ps")	
			# Faça isso... 
			ps aux ; echo "Digite os comandos aqui"
		;;


		"" )	
			# Quando executa sem opcao, chama funcao versao acima.
			versao
			hasParams $*
		;;

		"-h"| "--help" )	
			# Quando executa sem opcao, chama funcao versao acima.
			help
		;;


		* )
			# Executa com opcao que nao tem.
			echo -en "Parametros passados $red $* $normal, checando.\n"
			myparams=( "$@" ) 
			hasParams $*
			NUMBER_PARAMS=$?
			if [ $NUMBER_PARAMS -ge 2 ]; then
			    for ARG in $(seq 1 $NUMBER_PARAMS) ; do
				  echo ARG=$ARG
				  COMANDAO="$COMANDAO ${myparams[$ARG]}"
			    done
			    	echo -en "$magenta COMANDAO= $COMANDAO \n"
				sed "s/ALIAS_CRIADOR/ALIAS_CRIADOR\nalias $1\=$COMANDAO/g" -i $CDSHELL/.alias
			else
			    echo -en "Necessrio somente 2 parametros: tem $? $red $0 <NOME ALIAS> COMANDO DESEJADO $normal\n"
			fi
		;;
esac
#############        FIM      ##################
################################################

