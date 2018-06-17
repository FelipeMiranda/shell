
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
	echo qq coisa
}


################################################
#############        MAIN       ################
case $1 in
		"ps" | "-p" | "--ps")	
			# Faça isso... 
			docker ps
		;;
	
		"--top" | "top" | "-t")	
			# Faça isso... 
			docker stats
		;;

		"--run")	
			# Faça isso... 
			docker run -d $2
		;;



		"--exec")	
			# Faça isso... 
			IDS=$( docker ps | grep vendedor | cut -f1 -d " ")

			if [ $( echo $IDS| wc -l | cut -f1 -d " " ) -gt 1 ]; then
			    echo "vai ter q selecionar uma"
			    #docker exec -it 
			fi
		;;


		"-k"|"--kill" )	
			# Matar imagens com nome X

			IDS=$( docker ps | grep $2 | cut -f1 -d " ")
			for ID in $IDS; do 
			    docker kill $ID
			done
		;;

	
		* )
			# Executa com opcao que nao tem.
			docker ps
		;;
esac
#############        FIM      ##################
################################################

