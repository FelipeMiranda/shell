#!/bin/bash
source ~/colors.sh
source ~/.export
source $CDSHELL/funcoes-cdshell.sh

OSTYPE=`uname`
PACOTES_LINUX="net-tools colordiff gcc gcc-dev ruby-devel rubygems screen vim lynx iftop ifstatus ronn htop jq net-tools htop dialog python34 nodejs docker netcat tcpdump nmap tcl puppet ansible dig mc lsof bc bind-utils tmux bc ntpdate nmon wget screen mlocate cifs-utils zip  unzip  psmisc  kubelet  kubeadm  kubectl "
PACOTES_OPENBSD="git vim-7.4.475-no_x11-ruby lynx iftop ngrep bash colorls wget autoconf-2.69p1 automake-1.9.6p11"
PACOTES_FREEBSD="git vim lynx iftop ngrep bash colorls wget autoconf automake binutils"
PACK_MANAGER=yum

# Mensagem de inicio
echo -en "\n $alert Primeira instalação sendo executada $normal"

############ Linux Install ##############################
if [ $OSTYPE == "Linux" ]; then

	if [ -e /etc/os-release ]; then
		cat /etc/os-release | grep CentOS -q
		if [ $? == 0 ]; then
		      echo -en "$green ** $atention RED HAT -$yellow like found $green ** $normal\n\n"
		    	FLAVOR=redhat
		    	PACK_MANAGER="yum -y"
		fi
		
		cat /etc/os-release | grep Zorin -q
		if [ $? == 0 ]; then
		      echo -en "$green ** $atention DEBIAN -$yellow like found $green ** $normal\n\n"
		      FLAVOR=debian
			PACK_MANAGER="apt -y" 
		fi
		
		cat /etc/*rele* | grep Ubuntu -q
		if [ $? == 0 ]; then
		      echo -en "$green ** $atention UBUNTU -$yellow like found $green ** $normal\n\n"
		      FLAVOR=debian
			PACK_MANAGER="apt -y" 
		 
		 apt install curl -y
		 curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
		 curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -
		 apt install nodejs -y

		fi

	else
	    echo -en "\n\n $red Nao foi possível determinar o S.O.$normal \n\n"
	    echo -en "$alert(X) $red Saindo por nao determinar o PACK_MANAGER $normal \n\n"
	    exit 1
	fi


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


	# INSTALANDO OS PACOTES
	echo -en "\n\n$alert Iniciando PACK_INSTALL: $normal $yellow ($PACK_MANAGER install $PACOTES ) $normal \n\n"

	case $FLAVOR in
	
	    "redhat" ) 
		    $PACK_MANAGER install -y epel-release > /dev/null
		    
		    echo -en "$alert Como estou num RedHat like, vou remover o chrony... $normal\n\n"
		    $PACK_MANAGER remove chrony -y > /dev/null
		    
		    if [ $? == 0 ]; then
			    echo -en "... Done -> Chrony removido com $green sucesso! $normal \n\n"
		    fi
		    
		    $PACK_MANAGER install $PACOTES > /dev/null
		    if [ $? == 0 ]; then
			    echo -en " $atention YUM INSTALL ...... finalizado com $green sucesso! $normal \n\n"
		    else
			    echo -en " $alert (X) $atention YUM INSTALL ...... finalizado com $red ERRO! $normal \n\n"
		    fi

	    ;;

	    "debian" )
		    #echo -en "$alert Como estou num Debian like, vou remover o chrony... $normal"
		    #PACK_MANAGER remove chrony -y >> /dev/null
		    #if [ $? == 0 ]; then
		    #	echo -en "... Done -> Chrony removido com $green sucesso! $normal \n\n"
		    #fi

		    	apt-get install nodejs -y

			for PACOTE in $PACOTES ; do
				echo -en "Instalando $PACOTE ..."
			      $PACK_MANAGER install $PACOTE > /dev/null
				echo -en "........ $atention $PACOTE $green instalado $normal \n\n"
			done

		    
		    $PACK_MANAGER install $PACOTES
		    if [ $? == 0 ]; then
			    echo -en " $atention APT-GET INSTALL ...... finalizado com $green sucesso! $normal \n\n"
		    else
			    echo -en " $alert (X) $atention APT-GET INSTALL ...... finalizado com $red ERRO! $normal \n\n"
		    fi
	    ;;

	    * )
		    echo -en "Passando no case de Opcao de FLAVOR GERAL: * \n\n"
	    ;;

	esac

fi

	## NODE.JS INSTALL ##
	#/usr/bin/npm install nodemon ronn colors -g


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


