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
    echo -en "$\n\n\t $alert Use: $green $0 <POD_NAME> $normal \n\n"
}

function exec(){
   KUBE=$(whereis kubectl | cut -f2 -d' ')
   $KUBE exec -it $1 $2 $3 $4 $5 $6 $7 $8 $9 $10
}



################################################
#############        MAIN       ################
case $1 in
		"-h"| "--help" )	
			# Quando executa sem opcao, chama funcao versao acima.
			help
		;;


		"" )	

			kubectl get pods -n $NAMESPACE
			
		;;


		* )

			if [ -n $1 ]; then
			exec $1 $2 $3 $4 $5 $6 $7 $8 $9 $10
			fi
		;;
esac
#############        FIM      ##################
################################################

