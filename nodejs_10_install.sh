


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
    echo -en "$\n\n\t $alert Use: $0 $green -i $normal \t Para instalar o $alert NODEJS $normal  versao $yellow 10.X $normal\n"
}

function install(){
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
    echo -en "$red NAO ESQUECER DE MANDAR o YUM INSTALL\n"
}



################################################
#############        MAIN       ################
case $1 in

		"-i" )	
			# Quando executa sem opcao, chama funcao versao acima.
			install
			exit
		;;

		"-h"| "--help" )	
			# Quando executa sem opcao, chama funcao versao acima.
			help
			exit
		;;


		* )
			# Executa com opcao que nao tem.
			echo -en "O comando $red $1 $normal não existe\n\n\t Use $green $0 --help.$normal\n"
		;;
esac
#############        FIM      ##################
################################################

