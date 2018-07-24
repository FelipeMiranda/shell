#!/bin/bash
source ~/colors.sh

OSTYPE=`uname`
PACOTES_LINUX="colordiff gcc ruby-devel rubygems screen vim lynx iftop ifstatus ronn htop jq"
PACOTES_OPENBSD="git vim-7.4.475-no_x11-ruby lynx iftop ngrep bash colorls wget autoconf-2.69p1 automake-1.9.6p11"
PACOTES_FREEBSD="git vim lynx iftop ngrep bash colorls wget autoconf automake binutils"

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

	UNAME=$( uname -pa | grep "Ubuntu")
	if [ "$?" != 0 ]; then
		PACK_INSTALL="apt install" 
	else
		PACK_INSTALL="yum -y install"
	fi

	for PACOTE in $PACOTES ; do
	    echo "Instalando $PACOTE ..."
	    $PACK_INSTALL $PACOTE 
	    echo " $PACOTE instalado\n\n"
	done

	#CentOS 6.6
	#   rpm -hiv http://pkgs.repoforge.org/txt2tags/txt2tags-2.6-1.el6.rf.noarch.rpm
fi

############ OpenBSD Install ############################
if [ $OSTYPE == "OpenBSD" ]; then
	
	PACK_INSTALL=pkd_add
	for i in $PACOTES_OPENBSD; do
		 PACK_INSTALL $i 
	done 

	. $CDSHELL/openbsd/install-screen.sh

	#mudar o shell do usuário para bash
	echo -e "Se desejar alterar o shell do usuário:\n usermod -s /usr/local/bin/bash $USER"
fi

############ FreeBSD Install ############################
if [ $OSTYPE == "FreeBSD" ]; then
	PACK_INSTALL="pkg add"

	for i in $PACOTES_FREEBSD; do
	$PACK_INSTALL $i
	done
	echo tentando instalar o screen no FreeBSD
	. $CDSHELL/openbsd/install-screen.sh

	#mudar o shell do usuário para bash
	echo -e "Se desejar alterar o shell do usuário mande um:\n\t $WHITE usermod -s /usr/local/bin/bash $USER $normal"

fi

############ Windows Install ############################


# Chegou aqui, significa que executou tudo, entao cria o arquivo de sinalizacao da primeira instalacao executada.
touch $CDSHELL_VAR/.cdshell_req_installed
