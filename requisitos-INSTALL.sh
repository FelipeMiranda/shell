#!/bin/bash


echo -en "\n Instalando os requisitos .............."

OSTYPE=`uname`

############ Linux ##############################
if [ $OSTYPE == "Linux" ]; then
	 PROGRAMAS_YUM="colordiff gcc ruby-devel rubygems screen vim lynx iftop ifstatus ronn htop"
	 echo -en "\n Vamos instalar esses pacotes: $green $PROGRAMAS_YUM $normal\n"
	 echo -en "\n\n\t Pressione qualquer tecla para continuar..."
	 read -n 1

	 for programa in $PROGRAMAS_YUM ; do
		 echo -en "\n Instalando o$yellow $programa \n"
		 yum install $programa -y
	 done

	#CentOS 6.6
   rpm -hiv http://pkgs.repoforge.org/txt2tags/txt2tags-2.6-1.el6.rf.noarch.rpm
fi

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
