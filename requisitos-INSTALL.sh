#!/bin/bash
source ~/colors.sh

OSTYPE=`uname`
PACOTES_LINUX="colordiff gcc ruby-devel rubygems screen vim lynx iftop ifstatus ronn htop jq"

# Mensagem de inicio
echo -en "\n $alert Primeira instalação sendo executada $normal"


############ Linux Install ##############################
if [ $OSTYPE == "Linux" ]; then
	PACOTES=$PACOTES_LINUX
	echo -en "\n\n\n Vamos instalar os requisitos: $green $PACOTES $normal"
	echo -en "\n\n\t Pressione qualquer tecla para continuar ou $yellow 'q'$normal para $WHITE cancelar$normal ... \n\n\tcontinuando em ...\n"

	for TEMPO in {3..0} ; do
		echo -en "\r\t$TEMPO segundos"
		read -n 1 -t 1 CANCELAR
		if [ "$CANCELAR" == 'q' ]; then
			exit 1
		fi
	done

	yum install $PACOTES -y
	#CentOS 6.6
	#   rpm -hiv http://pkgs.repoforge.org/txt2tags/txt2tags-2.6-1.el6.rf.noarch.rpm
fi

############ OpenBSD Install ############################
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

############ FreeBSD Install ############################
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

############ Windows Install ############################


# Chegou aqui, significa que executou tudo, entao cria o arquivo de sinalizacao da primeira instalacao executada.
touch $CDSHELL_VAR/.cdshell_req_installed
