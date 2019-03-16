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

	echo -en "Usado para criar uma sessao de screen, e voltar $green sempre $normal na mesma.\n"
	echo -en "$\n\n\t $alert Versao: $green $0 $VERSION $normal \n\n"
}


################################################
#############        MAIN       ################
case $1 in
		"" )	
			# Quando executa sem opcao, chama funcao versao acima.
			LISTA=$(screen -ls | grep -vE "There|Socket" | cut -d'.' -f1 )
			echo $LISTA
			foreach $pid $(cat $LISTA); do
				screen -d -r $pid
				echo -en "Tinha outro aberto, entrando...."
				read -n 1
			done
		;;

		"-h"| "--help" )	
			# Quando executa sem opcao, chama funcao versao acima.
			help
		;;


		* )
			# Executa com opcao que nao tem.
			echo -en "Verificando os parametros passados $red $* $normal se existe algum.\n"
			hasParams $*
		;;
esac
#############        FIM      ##################
################################################

