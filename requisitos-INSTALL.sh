#!/bin/bash
source ~/colors.sh
source ~/.export
source $CDSHELL/funcoes-cdshell.sh

OSTYPE=`uname`
PACOTES_LINUX="net-tools colordiff gcc gcc-dev ruby-devel rubygems screen vim lynx iftop ifstatus ronn htop jq net-tools htop dialog python34 nodejs docker netcat tcpdump nmap tcl puppet ansible dig mc lsof bc bind-utils tmux  vim  bc  ntpdate "
PACOTES_OPENBSD="git vim-7.4.475-no_x11-ruby lynx iftop ngrep bash colorls wget autoconf-2.69p1 automake-1.9.6p11"
PACOTES_FREEBSD="git vim lynx iftop ngrep bash colorls wget autoconf automake binutils"

# Mensagem de inicio
echo -en "\n $alert Primeira instalação sendo executada $normal"


############ Linux Install ##############################
if [ $OSTYPE == "Linux" ]; then
	PACOTES=$PACOTES_LINUX
	echo -en "\n\n\n Vamos instalar os requisitos: $green $PACOTES $normal"
	echo -en "\n\n\t Pressione qualquer tecla para continuar ou $yellow 'q'$normal para $WHITE cancelar$normal ... \n\n\tcontinuando em ...\n"

	yum install -y epel-release

	for TEMPO in {3..0} ; do
		echo -en "\r\t$TEMPO segundos"
		read -n 1 -t 1 CANCELAR
		if [ "$CANCELAR" == 'q' ]; then
			exit 1
		fi
	done

	
	if [ -e /etc/os-release ]; then
		
		cat /etc/os-release | grep CentOS -q
		if [ $? == 0 ]; then
		    	PACK_INSTALL="yum -y install"
		fi
		
		cat /etc/os-release | grep Zorin -q
		if [ $? == 0 ]; then
			PACK_INSTALL="apt install" 
		fi
	else
	    echo -en "\n\n $red Nao foi possível determinar o S.O.$normal \n\n"
	    exit 1
	fi


#	for PACOTE in $PACOTES ; do
#		echo "Instalando $PACOTE ..."
#		$PACK_INSTALL $PACOTE 
#		echo " $PACOTE instalado\n\n"
#	done
	yum install $PACOTES -y

	yum remove chrony NetworkManager -y


	 ## NODE.JS INSTALL ##
	#/usr/bin/npm install nodemon ronn colors -g

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
if [ $OSTYPE == "Windows" ]; then

runas /savecred /user:Administrator "/c/WINDOWS/system32/cmd.exe" -k @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

choco install wget

fi


if [[ ! -d $HOME/workspace ]] || [[ ! -d $HOME/help ]] || [[ ! -d $HOME/sistemas ]] || [[ ! -d $HOME/codigo-fonte ]]; then
	echo -en "\n\n\t $REDALERT Primeira instalação... clonando tudo \n\t $> cloneall $normal\n\n\t"
	cd $HOME ; cloneall ; cd - > /dev/null 
fi

# Chegou aqui, significa que executou tudo, entao cria o arquivo de sinalizacao da primeira instalacao executada.
touch $CDSHELL_VAR/.cdshell_req_installed


