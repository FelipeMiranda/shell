
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
function status(){
	systemctl status $1
}


################################################
#############        MAIN       ################
case $1 in
		"-h" | "--help" )	
			# Faça isso... 
			echo -en "Help $0 \n\n Digite os exemplos aqui:"
		;;

	
		# Para qualquer nome de serviço
		* )
			systemctl stop $1
			status $1
		;;
esac
#############        FIM      ##################
################################################

