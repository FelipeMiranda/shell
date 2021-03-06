#!/bin/bash

#######################################################
# dklogs - Docker Logs CDShell				#
# Usado para facilitar a leitura de logs no sistema.  #
# v_1.0.1							      # 
#######################################################
VERSION=1.0.1


#############     CONFIG     ####################
#Carrega variáreis de ambiente.
source ~/.export
# Suporte a cores no bash.
source ~/shell/colors.sh
################################################


DOCKER=$(whereis docker | cut -f2 -d" ")


##########  Funcao       #######################
function help(){
    echo -en "$\n\n\t $alert Use: $green $0 $PARAMETERS $normal \n\n"
}

function versao(){
    echo -en "$\n\n\t $alert Versao: $green $0 $VERSION $normal \n\n"
}



################################################
#############        MAIN       ################
case $1 in

		"-v" )	
			# Quando executa sem opcao, chama funcao versao acima.
			versao
		;;

		"-h"| "--help" )	
			# Quando executa sem opcao, chama funcao versao acima.
			help
		;;

		"" )	
			# Quando executa sem opcao, chama funcao versao acima.
			echo -en "$yellow    __________ $normal \n"
			echo -en "    $alert| Images |$normal\n$iyellow    ---------- \n$normal$green\n" 
			$DOCKER ps | grep -v "CONTAINER ID" | awk '{ print "\033[31m " NR "\033[32m -> " $NF }' 
			echo -en $normal
		;;

		* )
			check=`echo "$1" | grep -E ^\-?[0-9]*\.?[0-9]+$`

			if [ "$check" != '' ]; then    
			      # it IS numeric
				echo "Yeap!"
			else
				# it is NOT numeric.
				# Executa com opcao que nao tem.
				CONTAINER_ID=$($DOCKER ps | grep $1 | awk '{ print $1 }' )
				$DOCKER logs $CONTAINER_ID -f
			fi
		;;
esac
#############        FIM      ##################
################################################

