


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
    echo -en "$\n\n\t $alert Use: $0 $green -i $normal \t Para instalar o docker versao 17.03.02\n"
}

function install(){
    echo -en "$green Iniciando a instalacao do ${alert}ronn$normal .....\n"
    apt install ruby ruby-dev -y
    gem install nokogiri
    gem install rdiscount
    gem install hpricot
    gem install ronn
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


