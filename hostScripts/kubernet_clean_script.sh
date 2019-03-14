#!/bin/bash

#################################################
# Bash script - Modelo					#
# Use como modelo para criar seus scripts bash. #
# v_1.0.1							#
#################################################
VERSION=1.0


#############     CONFIG     ####################
#Carrega variáreis de ambiente.
source ~/.export
# Suporte a cores no bash.
source ~/shell/colors.sh
################################################


##########  Funcao       #######################
function help(){
    echo -en "$\n\n\t $alert Use: $green $0 $PARAMETERS $normal \n\n"
}

function versao(){
    echo -en "$\n\n\t $alert Versao: $green $0 $VERSION $normal \n\n"
}

function hasParams(){
    if [ $# -lt 1 ]; then
	 echo "Faltou utilizar pelo menos um argumento!"
	 exit 1
    fi
     
    echo "Numero de argumentos: $#"
     
    COUNT=0
    for ARG in $*; do
	 COUNT=`expr $COUNT + 1`
	 echo "Argumento $COUNT: $ARG"
    done
}

function cleankubernetes(){

docker rm -f $(docker ps -qa)
docker volume rm $(docker volume ls -q)
cleanupdirs="/var/lib/etcd* /etc/kubernete* /etc/cni* /opt/cni* /var/lib/cni* /var/run/calico* /var/lib/kubelet*"
for dir in $cleanupdirs; do
      echo "Removing $dir"
	  rm -Rf $dir
	  done

}

################################################
#############        MAIN       ################
case $1 in
		"ps" | "-p" | "--ps")	
			# Faça isso... 
			ps aux ; echo "Digite os comandos aqui"
		;;


		"" )	
			# Quando executa sem opcao, chama funcao versao acima.
			cleankubernetes
		;;

		"-h"| "--help" )	
			# Quando executa sem opcao, chama funcao versao acima.
			help
		;;


		* )
			# Executa com opcao que nao tem.
			echo -en "Verificando os parametros passados $red $* $normal se existe algum.\n"
			hasParams $*
		;;
esac
#############        FIM      ##################
################################################

