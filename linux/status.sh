
#!/bin/bash

#################################################
# Bash script - start.sh				#
# Facilitador acesso a systemctl start e ja     #
# exibe status de execucao do servico.		#
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

		      status $1
		;;
esac
#############        FIM      ##################
################################################

