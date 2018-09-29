

#!/bin/bash

#################################################
# Bash script - Modelo					#
# Use como modelo para criar seus scripts bash. #
# v_1.0.1							#
#################################################


#############     CONFIG     ####################
#Carrega variáreis de ambiente.
source ~/.export
# Suporte a cores no bash.
source ~/shell/colors.sh
################################################


##########  Funcao       #######################
function help(){

    echo -en "$\n\n\t $alert Use: $green $0 $PARAMETERS $normal \n\n"

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
			versao
		;;

		"-h"| "--help" )	
			# Quando executa sem opcao, chama funcao versao acima.
			versao
		;;


		* )
			# Executa com opcao que nao tem.
			echo -en "O comando $red $1 $normal não existe.\n"
		;;
esac
#############        FIM      ##################
################################################

