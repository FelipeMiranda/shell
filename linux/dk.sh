
#!/bin/bash

#################################################
# Docker script						#
# Script para automatizar execução de comandos. #
# v_1.0.0							#
#################################################


#############     CONFIG     ####################
#Carrega variáreis de ambiente.
source ~/.export
# Suporte a cores no bash.
source ~/shell/colors.sh
################################################


##########  Funcao       #######################
function versao(){

}


################################################
#############        MAIN       ################
case $1 in
		"ps" | "-p" | "--ps")	
			# Faça isso... 
			docker ps
		;;


		"-k"|"--kill" )	
			# Matar imagens com nome X

			IDS=$( dk ps | grep vendedor | cut -f1 -d " ")
			for ID in $IDS; do 
			    echo matando $ID
			    echo $ID
			done
		;;

	
		* )
			# Executa com opcao que nao tem.
			echo -en "O comando $red $1 $normal não existe.\n"
		;;
esac
#############        FIM      ##################
################################################

