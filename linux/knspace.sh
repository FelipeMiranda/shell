####!/bin/bash

#################################################
# Bash script - Modelo					#
# Use como modelo para criar seus scripts bash. #
# v_1.0.1							#
#################################################



##########  Funcao       #######################
function help(){
    echo -en "$\n\n\t $alert Use: $green $0 $PARAMETERS $normal \n\n"
}


################################################
#############        MAIN       ################
case $1 in

		"" )	
			# Quando executa sem opcao, chama funcao versao acima.
			help
		;;

		"-h"| "--help" )	
			# Quando executa sem opcao, chama funcao versao acima.
			help
		;;


		* )
			# Executa com opcao que nao tem.
			export NAMESPACE=$1
			echo -en "NAMESPACE=$red$1$green exported $normal\n\n"
		;;
esac
#############        FIM      ##################
################################################

