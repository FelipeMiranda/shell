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
function commit(){

if [ $# -gt 1 ]; then
    git add .
    git commit -m "$*" . || ERROR_CODE=1
    git push || ERROR_CODE=1
fi

if [ $# -eq 0 ]; then
    git add .
    git commit -m "Commiting my job!" . || ERROR_CODE=1
    git push || ERROR_CODE=1
fi

return $ERROR_CODE
}

################################################
#############        MAIN       ################
case $1 in
		"ps" | "-p" | "--ps")	
			# Faça isso... 
			ps aux ; echo "Digite os comandos aqui"
		;;


		"" )	
		ERROR_CODE=0
		if [ -n $1 ]; then
		    echo -en "entrando na OK para fazer seu $green commit $normal \n"
			
			#cd $CDSHELL
			
			commit $*
			echo -en "\n\n\t $alert Feito o rr$normal \n\n"

			if [ $? -eq 0 ]; then
				echo -en "$green Todo $atention $(git config remote.origin.url | cut -d '/' -f2- | cut -d'.' -f1) $normal enviado com sucesso!\n\n"
				ERROR_CODE=0
				exit $ERROR_CODE
			else
				echo -en "\n\n $red (X) Aconteceu um erro na execução do $0! \n\n"
				ERROR_CODE=$?
				exit $ERROR_CODE
			fi
		echo -en "\t Finalizado com status erro=$EERRO_CODE\n\n"
		fi
		cd - > /dev/null
		echo -en "$green \n\n\tVersao enviada: " $(cdshell -g) "\n$normal\n"
		;;

	
		* )
			commit $*
		;;
esac
#############        FIM      ##################
################################################

