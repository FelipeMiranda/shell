
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
echo funcao
}


################################################
#############        MAIN       ################
case $1 in
		"--rec" | "-r" | "--restore")	
			echo -en "\n\t $atention### CDSHELL ###$green \n\n\t### BACKUP RECOVER ###$normal\n"
			echo -en "\n\n Escolha uma opção de arquivo para recuperar...\n"
			FILES=$(ls $CDSHELL/backup/.*)
			CONT=0
			for FILENAME in $FILES ; do
			    ARRAY[$CONT]=$FILENAME
			    ((CONT++))
			    echo $CONT - $FILENAME
			done
			read RESPOSTA
			if [ $RESPOSTA -gt 0 ]; then
			    	if [ $RESPOSTA -lt $CONT ]; then
				    	POSITION=$(( $RESPOSTA - 1 ))
			 		echo "\n $red Vou recuperar o ${ARRAY[$POSITION]} ok? s/y para continuar\n"
					cp $CDSHELL/${ARRAY[$POSITION]} $HOME/ -i
				else
					echo RESPOSTA=$RESPOSTA
					echo CONT=$CONT
				fi
			else
			    echo segundo if
			echo RESPOSTA=$RESPOSTA
			echo CONT=$CONT
			fi

		;;


		""|"-h"|"--help"|"help" )	
			# Quando executa sem opcao, chama funcao versao acima.
			help
		;;

	
		* )
			# Executa com opcao que nao tem.
			echo -en "O comando $red $1 $normal não existe.\n"
		;;
esac
#############        FIM      ##################
################################################

