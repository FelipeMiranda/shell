
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

function help(){

			echo -en "Help do $green ctl $normal ainda não elaborado.\n\n"
			echo -en "Use $0 <start/stop/status/restart> serviço\n"
			echo -en "Exemplo: $WHITE $> ctl cdshelld $normal ou $green start cdshelld $normal \n"
			echo -en "Ou chame direto $WHITE $> ctl <SERVIÇO> $normal para ver o status\n"
}


################################################
#############        MAIN       ################
case $1 in

		# Opcoes do comando original
		"start" | "status" | "stop" | "restart" )	
			# Faça isso... 
			if [ ! -z $2 ]; then
				systemctl $1 $2
			else
			    	echo -en "$red Sem nome de serviço para ação.$normal \n"
				help
			fi
		;;

		# Help fajuto
		"-h" | "--help" )
			help
		;;

	
		# Executa com opcao que nao tem.
		* )
			systemctl status $1
		;;
esac
#############        FIM      ##################
################################################

