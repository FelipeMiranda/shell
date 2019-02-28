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
			help
		;;

		"-h"| "--help" )	
			# Quando executa sem opcao, chama funcao versao acima.
			help
		;;


		* )
			# Executa com opcao que nao tem.
			#echo -en "NAMESPACE=$red$1\n\n $green \t Namespace exported! $normal\n\n"
			echo declare -x NAMESPACE=$1 
			NAMESPACE=$1 
			export NAMESPACE
		;;
esac
#############        FIM      ##################
################################################

