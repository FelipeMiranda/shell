
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




################################################
#############        MAIN       ################
case $1 in

		"" )	
			# Quando executa sem opcao, chama funcao versao acima.
			kubectl config get-context 
		;;

		* )
			# Executa com opcao que nao tem.
			kubectl config use-context $1
		;;
esac
#############        FIM      ##################
################################################

