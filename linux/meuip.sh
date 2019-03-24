
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
function with_curl_ipinfo(){
      curl https://ipinfo.io/ip
      return $?
}

function with_curl_dyndns(){
      curl -s https://checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'
      return $?
}


function with_dig(){
      dig +short myip.opendns.com @resolver1.opendns.com
      return $?
}



################################################
#############        MAIN       ################
case $1 in
		"-h" | "--help" )	
			# Faça isso... 
			echo -en "Help $0 \n\n Usado para Obter seu Ip na internet os exemplos aqui:"
		;;

	
		# Para qualquer nome de serviço
		* )
                  with_curl_ipinfo || with_curl_dyndns
		;;
esac
#############        FIM      ##################
################################################

