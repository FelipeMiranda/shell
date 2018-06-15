#!/bin/bash


echo -e "Instalando os requisitos ... \n"

OSTYPE=`uname`


############ Linux ##############################
if [ $OSTYPE == "Linux" ]; then

	#instalar o colordiff
	yum install colordiff -y

	#instalar o rubydevel para funcionar o ronn
	yum -y install gcc ruby-devel rubygems
	
	#instalar o screen e outras dependencias COMUNS, tudo que deveria ser de praxe
	yum install screen vim lynx iftop ifstatus -y

	#instalar o ronn para fazer os miniman
	gem install ronn

	#CentOS 6.6
   rpm -hiv http://pkgs.repoforge.org/txt2tags/txt2tags-2.6-1.el6.rf.noarch.rpm

	#Htop
	yum install htop

fi


PROGRAMAS_YUM="jq"

for programa in $PROGRAMAS_YUM; do

	echo -en "\n Instalando o$yellow $PRORGAMA_YUM"
	read -n 1
	exit
done


############ OpenBSD ##############################
if [ $OSTYPE == "OpenBSD" ]; then
#LISTA de requisitos para ser instalados no OpenBSD
LISTA="git vim-7.4.475-no_x11-ruby lynx iftop ngrep bash colorls wget autoconf-2.69p1 automake-1.9.6p11"

for i in $LISTA; do
pkg_add $i 
done 

. $CDSHELL/openbsd/install-screen.sh

#mudar o shell do usuário para bash
echo -e "Se desejar alterar o shell do usuário:\n usermod -s /usr/local/bin/bash $USER"

fi


############ FreeBSD ##############################
if [ $OSTYPE == "FreeBSD" ]; then
#LISTA de requisitos para ser instalados no FreeBSD
LISTA="git vim lynx iftop ngrep bash colorls wget autoconf automake binutils"

for i in $LISTA; do
pkg install $i
done
echo tentando instalar o screen no FreeBSD
. $CDSHELL/openbsd/install-screen.sh

#mudar o shell do usuário para bash
echo -e "Se desejar alterar o shell do usuário:\n usermod -s /usr/local/bin/bash $USER"

fi

