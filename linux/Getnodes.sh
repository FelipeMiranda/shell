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
    echo -en "Mostra os $magenta nodes $normal que existem registrados no $alert servidorPush $normal \n"
    echo -en "$\n\n\t $alert Use: $green $0 $PARAMETERS $normal \n\n"

}

function versao(){
    echo -en "$\n\n\t $alert Versao: $green $0 $VERSION $normal \n\n"
}

function exibeNodes(){
    	echo -en "$magente \tMy_host: $red[$yellow$(hostname)$red]$normal \n\t-----------------\n\n"
 	#curl -s http://servidorpush.superati.com.br:3000/rest/nodes | jq '.[] | (.hostname) + " => [" + (.version) + "] | " + (.hostconfig{}) '
 	curl -s http://servidorpush.superati.com.br:3000/rest/nodes | jq '.[] | (.hostname) + " => [" + (.version) + "] | Farm: (" + (.hostconfig.mainfunction)+ ")" '
}

function watchExibeNodes(){
    while (true); do
	  exibeNodes
	  read -n 1 -t 0.2 KEY
	  if [[ $KEY = 'q' ]]; then
		exit
	  else
	 	echo -en "\n\n $alert Digite (q) para sair $normal \n\n"
		sleep .8
		clear
	  fi
    done
}


################################################
#############        MAIN       ################
case $1 in
		"ps" | "-p" | "--ps")	
			# Faça isso... 
			ps aux ; echo "Digite os comandos aqui"
		;;


		"" )	
			# Quando executa sem opcao, chama funcao versao acima.
			exibeNodes
		;;

		"-h"| "--help" )	
			# Quando executa sem opcao, chama funcao versao acima.
			help
		;;


		"-w"| "--watch" )	
			# Quando executa sem opcao, chama funcao versao acima.
			watchExibeNodes
		;;



		* )
			# Executa com opcao que nao tem.
			echo -en "Verificando os parametros passados $red $* $normal se existe algum.\n"
			hasParams $*
		;;
esac
#############        FIM      ##################
################################################

