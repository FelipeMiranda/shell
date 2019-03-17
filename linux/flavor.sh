
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
	    return 0
	fi

	cat /etc/*rele* | grep centos > /dev/null
	if [ $? == 0 ]; then
	    echo -en "Centos"
	    return 0
	fi
}

function testeflavor(){
	if [ -n $1 ]; then
		if [ $(flavor) == "$1" ]; then
		    	echo 0
		else
			echo 1
		fi
	fi
}

function getDistroPackageManagerInstallCmdline(){
	if [ flavor = "Ubuntu" ]; then
	    echo -en "apt install -y"
	    return 0;
	fi
	if [ flavor = "Centos" ]; then
	    echo -en "yum install -y"
	    return 0;
	fi
echo -en "\n\n\t Infelizmente, não encontrei o tipo da Distro na minha lista\n $red (: \n"
	
return 1;
}

################################################
#############        MAIN       ################
case $1 in

		"" )	
			# Quando executa sem opcao, chama funcao versao acima.
			flavor
		;;


		* )	
			# Quando executa sem opcao, chama funcao versao acima.
			testeflavor $1
		;;

		"--get-distro-package-manager" )

			getDistroPackageManagerInstallCmdline
		;;

		"-h"| "--help" )	
			# Quando executa sem opcao, chama funcao versao acima.
			help
		;;

esac
#############        FIM      ##################
################################################

