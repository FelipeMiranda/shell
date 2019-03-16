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
			echo -en "---\n$green LISTA=$LISTA $normal\n---"
			for each in $(echo $LISTA); do
				screen -d -r $each
				echo -en "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\t\t\t$WHITE Tinha outro$alert ($magenta $each ) $normal $WHITE aberto, entrando nele:$normal \n\n\n\n\n\t\t $yellow $> screen -d -r [$each].pts-0.hp $normal \n\n\n\n\n\n\n\t\t -> pressione $green qq tecla para continuar <- $normal \n\n\n\n\n\t\t\t\t\t\t\t\t $yellow ... pause $normal \n"
				ULTIMO=$each
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

