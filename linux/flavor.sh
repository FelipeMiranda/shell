
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
    echo -en "$\n\n\t $alert Use: $green $0 $PARAMETERS $normal \n"
    echo -en "Tenta descobrir o flavor do linux instalado, Fedora, Debian, Ubuntu, Centos, RedHat, etc...\n"
}

function flavor(){

	cat /etc/*rele* | grep ubuntu > /dev/null
	if [ $? == 0 ]; then
	    echo -en "Ubuntu"
	    exit
	fi

	cat /etc/*rele* | grep centos > /dev/null
	if [ $? == 0 ]; then
	    echo -en "Ubuntu"
	    exit
	fi

}



################################################
#############        MAIN       ################
case $1 in

		"" )	
			# Quando executa sem opcao, chama funcao versao acima.
			flavor
		;;

		"-h"| "--help" )	
			# Quando executa sem opcao, chama funcao versao acima.
			help
		;;

esac
#############        FIM      ##################
################################################

