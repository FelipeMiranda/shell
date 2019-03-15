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

### FUNCAO COMMIT ( um texto como se fosse, varios parametros )
function commitAmendMessage(){

if [ -n $1 ]; then
    git commit --amend -m "$*" || ERROR_CODE=1
else
	echo -en "$red Erro: $yellow variavel nula, sem mensagem\n"
fi
}

################################################
#############        MAIN       ################
case $1 in
		"-h" | "--help")	
			help
		;;


		"" )	
			commitAmendMessage $*
		;;

		* )
			commitAmendMessage $*
		;;
esac
#############        FIM      ##################
################################################

