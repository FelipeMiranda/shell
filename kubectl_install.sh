


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
    echo -en "$\n\n\t $alert Use: $0 $green -i $normal \t Para instalar o docker versao 17.03.02\n"
}

function install(){
    FLAVOR=$(flavor.sh)

if [ $FLAVOR == "Ubuntu" ]; then
    sudo apt-get update && sudo apt-get install -y apt-transport-https
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update
    sudo apt-get install -y kubectl
fi

if [ $FLAVOR == "Centos" ]; then
    cat <<EOF > /etc/yum.repos.d/kubernetes.repo
    [kubernetes]
    name=Kubernetes
    baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
    enabled=1
    gpgcheck=1
    repo_gpgcheck=1
    gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
    EOF
    yum install -y kubectl
fi



}



################################################
#############        MAIN       ################
case $1 in

		"-i" )	
			# Quando executa sem opcao, chama funcao versao acima.
			install
			exit
		;;

		"-h"| "--help" )	
			# Quando executa sem opcao, chama funcao versao acima.
			help
			exit
		;;


		* )
			# Executa com opcao que nao tem.
			echo -en "O comando $red $1 $normal não existe\n\n\t Use $green $0 --help.$normal\n"
		;;
esac
#############        FIM      ##################
################################################

