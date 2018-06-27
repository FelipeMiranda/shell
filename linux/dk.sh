
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
			if [ ! -n "$2" ]; then
			    	CONT=0
				IMAGES=$(docker images | grep -vE "REPOSITORY|<none>" | cut -f1 -d' ' | uniq)
				echo -en " Escolha uma imagem para INICIAR ...\n\n "
				for IMAGE in $IMAGES ; do 
				    ARRAY[$CONT]=$IMAGE
				    CONT=$(( $CONT +1 ))
				    echo -en "\t $green $CONT $normal - $IMAGE\n"
				done
				read RESPOSTA
				OPTION=$(( RESPOSTA -1 ))
				echo ${ARRAY[ $OPTION ]}
				docker run -d ${ARRAY[$OPTION]} 
			else
				docker run -d $2
			fi
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
			# se nao passar uma, mata tudo.
			if [ -n $2 ]; then
				IDS=$( docker ps | grep -v CONTAINER | cut -f1 -d " ")
				for ID in $IDS; do
					$(docker kill $ID)
					echo -en " $ID - matado"
				done
			else
				IDS=$( docker ps | grep $2 | cut -f1 -d " ")
				for ID in $IDS; do 
				    docker kill $ID
				done
			fi
		;;

	
		* )
			# Executa com opcao que nao tem.
			docker ps
		;;
esac
#############        FIM      ##################
################################################

