
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
		"start" | "status" | "stop" | "restart" | "enable" | "disable" )	
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

		"reload" )
			if [ -z $2 ]; then
			    echo -en "necessario passar o nome do arquivo para ser atualizado la no /etc/systemd"
			    echo -en "\n\n\n Tente: --help\n"
			    exit 1;
			fi
			if [ ! -e ./$2.service ]; then
			    ls *.service
			    echo -en "$alert Arquivo $2.service não encontrado!\n Necessário ter o arquivo na pasta atual."
			    exit 1
			fi
			systemctl stop $2
			systemctl disable $2
			cp $2.service /etc/systemd/system -f
			systemctl daemon-reload $2
		      systemctl start $2
			systemctl enable $2
			systemctl status $2	
		;;

	
		# Executa com opcao que nao tem.
		* )
			while (true); do
				echo -en "\n$alert Digite $green q/Q $alert para sair.$normal\n\n"
				systemctl status $1 
				read -n 1 -t 1 input                  # so read doesn't hang
	                  if [[ $input = "q" ]] || [[ $input = "Q" ]] ; then
				      echo # to get a newline after quitting
				      break
				fi
				clear
			done

		;;
esac
#############        FIM      ##################
################################################

