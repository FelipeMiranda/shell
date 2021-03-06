#!/bin/bash


#################################################
# Bash script - Modelo					#
# Use como modelo para criar seus scripts bash. #
# v_1.0.1							#
#################################################



##########  Funcao       #######################
function help(){
    echo -en "$\n\n\t $alert Use: $green $0 NAMESPACE $normal \n\n"
}


################################################
#############        MAIN       ################
case $1 in

		"" )	
			# Quando executa sem opcao, chama funcao versao acima.
			echo -en "\n\tNAMESPACE=$green$NAMESPACE$normal\n"
		;;

		"-h"| "--help" )	
			# Quando executa sem opcao, chama funcao versao acima.
			help
		;;


		* )
			# Executa com opcao que nao tem.
			NAMESPACE=$1 
			export NAMESPACE
			echo -en "NAMESPACE=$yellow$1\n $green \t Namespace exported! $normal\n"
		;;
esac
#############        FIM      ##################
################################################

