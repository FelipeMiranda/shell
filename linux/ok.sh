
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

    echo -en "$\n\n\t $alert Use: $green $0 $PARAMETERS $normal \n\n

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
			cd $CDSHELl
			git add .
			git commit -m "OK" * || ERROR_CODE=1
			git push || ERROR_CODE=1
			if [ $? -eq 0 ]; then
				echo -en "$green Tudo $alert CDSHELL$normal enviado com sucesso!\n\n"
				return 0;
			else
				echo -en "\n\n $red (X) Aconteceu um erro na execução do $0! \n\n"
				return 1;
			fi
		echo "\t Finalizado com status erro=$EERRO_CODE\n\n"
		;;

	
		* )
			# Executa com opcao que nao tem.
			echo -en "O comando $red $1 $normal não existe.\n"
		;;
esac
#############        FIM      ##################
################################################

