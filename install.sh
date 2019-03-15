#!/bin/bash

####################################################
#  CDSHELL - Install.sh                            #
#  Arquivo de instalação do CDSHELL                #	
####################################################

# Coleta o início da execução.
START=$(date +%s)

# Suporte as cores. (cdshell -c) para ver cores do CDSHELL
source $CDSHELL/colors.sh || source colors.sh

# Git Config
###################git config --global user.email quirinobytes@gmail.com
git config --global user.name "Rafael Castro"
git config credential.helper store
git config --global push.default simple


# Configurando Variável do CDSHELL
if [ ! -e $CDSHELL ]; then
	echo -en "\n Caminho para instalar seu $alert CDSHELL$normal: $cyan"
	read CAMINHO
	echo -en "$normal"
	CDSHELL=$CAMINHO
fi

# Carregando configs específicas por host
if [ -e $CDSHELL/hostScripts/${HOSTNAME}.export ]; then
	source $CDSHELL/hostScripts/${HOSTNAME}.export
fi

CDSHELL=$HOME/shell
BACKUP_DIR=$CDSHELL/.saved_files_before_last_install
CDSHELL_VAR=$HOME/.cdshell

# Garantindo que o cp nao está com alias cp -i
alias cp=cp

# Recebendo RUNDIR de execução, quando é passado, via parametro $1
if [ -n "$1" ]; then
	BACKUP_FROM_RUNDIR="$1"
fi

# Cabeçalho da instalação.
echo -en "\033c\n\t\t $blue#$yellow### $blue Shell Enviroment KRN ® $yellow###$blue#$normal\n"
echo -en "\t\t$blue-----------------------------------$normal\n"
echo -en "\n Diretório do usuário ${yellow}\$HOME${normal}	->	$yellow $HOME $normal\n"

# Avisando que salvou o RUNDIR para voltar no mesmo lugar que chamou o install.
if [ -n $BACKUP_FROM_RUNDIR ]; then
	 echo -en "\n Diretório corrente $yellow(RUNDIR)$normal 	->	$yellow $BACKUP_FROM_RUNDIR $normal\n"
fi
echo -en "\n Diretório de instalação 	->	$yellow $CDSHELL $normal\n"

# Verificando a existencia de arquivos pre-instalação, para salva-los em caso de algum erro poder voltar.
echo -en "\n Diretório de backup 		-> 	$yellow \$CDSHELL/backup $normal\n"

echo -en "\n\n${blue}....................................................$normal \n"

# Criando um link $CDSHELL/backup -> $CDSHELL/.saved_files_befor_last_install
if [ ! -e $CDSHELL/backup ] ; then 
	cd $CDSHELL
	mkdir -p $BACKUP_DIR
	ln -s $BACKUP_DIR backup 
	echo -en "\n Criando link para backup ..................... $green Done${normal}\n" 
fi

# Criando um CDSHELL_VAR
if [ ! -e $CDSHELL_VAR ]; then
	echo -en "\n Criando$WHITE CDSHELL_VAR$normal .............."  
	mkdir -p $CDSHELL_VAR
	echo -en "............ $green Done${normal}\n" 
fi


# Testando para ver se já existe o diretório de BACKUP, então crie caso não exista.
#if [ ! -d $BACKUP_DIR ] ; then mkdir -p $BACKUP_DIR ; echo -en "\nCriando diretório de backup: $yellow $BACKUP_DIR $normal ... " ; fi

# Copiando a Suite de configurações CDSHELL e fazendo o BACKUP 
echo -en "\n Iniciando backup ."
if [ -e $HOME/.toprc ] ; 	then cp -f $HOME/.toprc $BACKUP_DIR/ ; fi
echo -en .
cp $CDSHELL/.toprc $HOME/
echo -en .

if [ -e $HOME/.alias ] ; 	then cp -f $HOME/.alias $BACKUP_DIR/ ;  fi
echo -en .
cp $CDSHELL/.alias $HOME/
echo -en ..

if [ -e $HOME/.export ] ; 	then cp -f $HOME/.export $BACKUP_DIR/ ; fi
echo -en .
cp $CDSHELL/.export $HOME/
echo -en ..

if [ -e $HOME/.vimrc ] ; 	then cp -f $HOME/.vimrc $BACKUP_DIR/ ; fi
echo -en .
cp $CDSHELL/.vimrc $HOME/
echo -en .

if [ -e $HOME/git-prompt.sh ] ; 	then cp -f $HOME/git-prompt.sh $BACKUP_DIR/ ; fi
echo -en .
cp $CDSHELL/git-prompt.sh $HOME/
echo -en .

if [ -e $HOME/.config/mc/ini ] ;	then cp -f $HOME/.config/mc/ini $BACKUP_DIR/.midnightcom.ini ; fi
echo -en .
mkdir -p $HOME/.config/mc
cp $CDSHELL/.midnightcom.ini $HOME/.config/mc/ini
echo -en ...

if [ -e $HOME/.screenrc ] ; then cp -f $HOME/.screenrc $BACKUP_DIR/ ; fi
echo -en .
cp $CDSHELL/.screenrc $HOME/
echo -en ...

if [ -e $HOME/.bashrc ] ; then cp -f $HOME/.bashrc $BACKUP_DIR/ ; fi
echo -en .
cp $CDSHELL/.bashrc $HOME/
echo -en ...

if [ -e $HOME/colors.sh ] ; then cp -f $HOME/colors.sh $BACKUP_DIR/ ; fi
echo -en .
cp $CDSHELL/colors.sh $HOME/
echo -en ..

cat /etc/selinux/config | grep "SELINUX=enforcing" -q
if [ $? -eq 0 ] ; then cp -f $CDSHELL/install/config /etc/selinux/config ; fi
echo -en .

if [ ! -f /usr/bin/bc ] ; then cp $CDSHELL/install/bc /usr/bin/bc ; fi
if [ ! -f $HOME/.ssh/config ] ; then cp -f $CDSHELL/install/config_ssh $HOME/.ssh/config ; fi

if [ -e $HOME/.ssh/config ] ; then cp -f $HOME/.ssh/config $BACKUP_DIR/ ; fi
echo -en .
mkdir -p $HOME/.ssh
cp $CDSHELL/ssh.config $HOME/.ssh/config
echo -en ..

if [ -e /etc/inputrc ] ; then 
    cp -f /etc/inputrc $BACKUP_DIR/ ; 
else
    if [ ! -e /etc/inputrc.cdshell ]; then
	# Faz um backup do original e nunca sobrescreva.
    	cp -f /etc/inputrc /etc/inputrc.cdshell
	# ja que fez o backup do original, pode sobrescreve-lo.
	cp -f $CDSHELL/inputrc /etc/inputrc
    fi
fi

echo -en .
cp $CDSHELL/inputrc /etc/
echo -en .
echo -en "... $green Done $normal\n"

# Garantindo o diretorio para o vim salvar históricos de edições dos arquivos.
if [ ! -d $HOME/.vim/undo.save/ ]; then
	mkdir $HOME/.vim/undo.save/ -p
fi

# Criando os link para funcoesZZ
if [ -e ~/funcoes-cdshell.sh ] ; then cp -f ~/funcoes-cdshell.sh $BACKUP_DIR/ ; fi
cp $CDSHELL/funcoes-cdshell.sh $CDSHELL_VAR/funcoes-cdshell.sh

# Copiando arquivos para fazer deploy com F11 no screen
echo -en "\n Atualizando$yellow F11.cmd $normal.............."
if [ -e ~/.F11.cmd ]; then
	 # Verifica se arquivo do CDSHELL é mais recente que do HOME, se for faz um backup e sobrescreva-o.
	 if [[ ~/.F11.cmd -ot $CDSHELL/skeleton/F11.cmd ]]; then
		  	 cp ~/.F11.cmd $BACKUP_DIR/
		  	 rm ~/.F11.cmd
			 cp -f $CDSHELL/skeleton/F11.cmd ~/.F11.cmd
			 chmod +x ~/.F11.cmd
	 fi
	 else
		   #Se não existe, crie-o
		  	cp -f $CDSHELL/skeleton/F11.cmd ~/.F11.cmd
			chmod +x ~/.F11.cmd
fi
echo -en "............ $green Done $normal\n"

# Instalando as funcoesZZ @ aurelio.verde
echo -en "\n Instalando$yellow funcoesZZ$normal ......"
if [ ! -e "/opt/funcoeszz/funcoeszz" ]; then
	mkdir -p /opt/funcoeszz/
	cp $CDSHELL/funcoeszz/* /opt/funcoeszz/ 2>&1 > /dev/null
	ln -s /opt/funcoeszz/funcoeszz-13.2.sh /opt/funcoeszz/funcoeszz
fi
echo -en "................... $green Done $normal\n"

# Copiando os SKELETON do vim, tarefas e todos que estiverem lá ... git, vim, F11, etc.
if [ -e ~/skeleton ] ; then
	echo -en "\n Copiando os ${WHITE}skeletons${normal} .........."
	cp -f $CDSHELL/skeleton/* $HOME/skeleton/ -Ra
	echo -en ".............. $green Done $normal\n"
else 
	echo -en "\n Copiando os skeletons $WHITE pela primeira vez $normal"
	mkdir -p $HOME/skeleton
	cp -f $CDSHELL/skeleton $HOME/ -R
	cp -f $CDSHELL/skeleton/cdshell_tarefas.json $CDSHELL_VAR/
   echo 0 > $CDSHELL_VAR/cdshell_tarefas.next_id
	touch $CDSHELL_VAR/tarefas_usedby_bashrc.txt
	echo -en "..... $green Done $normal\n"
fi

#Coletando data e versão da instalação, para carimbar dia da instalação.
echo -en "\n Carimbo de instalação ........."
cd $CDSHELL
echo -en . 
DATA=$(date +'%d/%m/%Y')
echo -en . 
MES=$(date +'%B')
echo -en . 
HORA=$(date +'%T')
echo -en . 
V=$(git rev-list HEAD | wc -l | tr -d '\n')
echo -en . 
VERSION=$(echo -en $V | sed  's/./\0\./g; s/.$//')
HOST=$(hostname)
# Montando a SAIDA para carimbar o arquivo.
SAIDA="$alert ________________________________________________________________________ $normal \n"
SAIDA=$SAIDA"$blue#$normal CDSHELL $red  ®  $normal quirinobytes \t\t\t\t\t\t $blue# $normal \n"
SAIDA=$SAIDA"$blue##########################################################################$normal \n"
SAIDA=$SAIDA"$blue#$normal Versão: $yellow $VERSION$normal.$blue.$yellow.$green.$MES $normal \n"
SAIDA=$SAIDA"$blue#$normal Data da instalação: $red $DATA $green $MES $yellow@$red$atention$HORA$normal \n"
SAIDA=$SAIDA"$blue#$normal  Diretório de Backup: $red \$CDSHELL/backup $normal \n"
SAIDA=$SAIDA"$blue#$normal  Server Hostname: $WHITE $HOST $normal \n"
SAIDA=$SAIDA"$blue#$normal  Instalador: $REDALERT $0 $normal \n"
SAIDA=$SAIDA"$blue##########################################################################$normal \n"
echo $SAIDA > $BACKUP_DIR/data_ultima_instalacao.txt
echo $VERSION | head 1 > $BACKUP_DIR/versao_ultima_instalacao.txt
echo -en ".......... $green Done $normal\n"

# Instalacao do POST COMMIT do GIT HOOKS !
echo -en "\n Instalando o ${yellow}Git Hooks${normal} ........"
cp $CDSHELL/githooks/post-commit $CDSHELL/.git/hooks/
if [ -f $CDSHELL/.git/hooks/post-commit ] ; then
   echo -en "............... $green Done $normal\n"
else
   echo -en "\n$red ERROR: Erro ao instalar Post commit do Git Hooks$normal\n"
fi

# Chaves SSH
echo -en "\n Instalando as ${cyan}chaves SSH${normal} ........"
if [ ! -d $HOME/.ssh ]; then
	 mkdir -p $HOME/.ssh 
fi
cp $CDSHELL/github/* $HOME/.ssh/ > /dev/null
cd $HOME/.ssh
tar xzvf file.tgz 2>&1 > /dev/null
echo -en "............. $green Done $normal\n"

if [ ! -f $HOME/.ssh/id_rsa ] ; then	
	echo -en "\n Arquivo $yellow id_rsa $normal não existia, criando pela primeira vez ...."
	$CDSHELL/linux/idRSA_Generator/idRSA_Generator
	chown 600 ~/.ssh/id_rsa
	echo -en "........... $green Done$normal"
fi
cd - > /dev/null

# Configurando bash_completion
if [ ! -e /etc/bash_completion.d ]; then
	mkdir -p /etc/bash_completion.d
fi

echo -en "\n Configurando$yellow bash_completion.d$normal ........"
mkdir -p /etc/bash_completion.d

cp $CDSHELL/etc+bash_completion.d+git /etc/bash_completion.d/git
echo -en "....... $green Done $normal\n"

# Instalando PERSONAL .bash_completion.d/
echo -en "\n Copiando arquivos$yellow bash_completion.d$normal ........"
if [ ! -d $HOME/.bash_completion.d ]; then
	mkdir $HOME/.bash_completion.d
fi
cp $CDSHELL/.bash_completion.d/* $HOME/.bash_completion.d -R
echo -en ".. $green Done $normal\n"

# Somente a primeira vez instala os REQUISITOS, e cria um arquivo para lembrar.
if [ ! -e $CDSHELL_VAR/.cdshell_req_installed ]; then

	#Se nao exister o link para o bash no /bin entao cria ne, sempre!!!
	if [ ! -e /bin/bash ]; then
		ln -s /usr/local/bin/bash /bin/bash
	fi
	
	chmod +x $CDSHELL/requisitos-INSTALL.sh
	$CDSHELL/requisitos-INSTALL.sh

	if [ $? == 0 ]; then
	    echo -en "$green Requisitos-INSTALL.sh....... executada com sucesso! $normal \n\n"
	else
	    echo -en "$alert (X) $red Requisitos-INSTALL.sh....... executada com ERRO! $normal \n\n"
	    echo -en "$green ... continuando install.sh... $normal \n\n"
	fi
fi

#Envia mensagem para canal install @ slack
if [ "$SLACK_CDSHELL_SEND_MESSAGES" == "true" ]; then
	echo -en "\n Enviando mensagem para ${magenta}install${blue}@${magenta}slack$normal ......... $green Done$normal\n"
	$CDSHELL/linux/send_install.js "*$DATA* Nova instalação de CDSHELL em *$HOSTNAME* | Versão: $VERSION" 2>&1 > /dev/null
fi

# Exibindo dados da instalacao e tempo gasto.
END=$(date +%s)
RUNTIME=$(expr $END - $START)
echo -e "\n ${alert} CDSHELL ${normal} ${atention}v_${VERSION}${normal} instalado$normal em ${yellow}${RUNTIME}${normal} segundo`if [ $RUNTIME -gt 1 ]; then echo -en "s" ; else echo -en " "; fi;` .... $green Done\n"

#Mensagem final sobre o manual de ajuda. 
echo -en "\n     ${alert} Existe uma página help feita com miniman $normal\n       $yellow $> miniman cdshell ou cdshell -h\n\n"

#Instalar o ANSIBLE para controlar algumas coisas.
ANSIBLE_PLAYBOOK=$(which ansible-playbook)
which ansible-playbook > /dev/null
if [ $? -ne 0 ]; then
	yum install ansible -y
fi

which ansible-playbook > /dev/null
if [ $? -eq 0 ]; then
	cd $CDSHELL/ansible
	$ANSIBLE_PLAYBOOK -i $CDSHELL/ansible/hosts $CDSHELL/ansible/tasks/main.yml
else
	echo -en "$alert (X) Erro ao tentar instalar o ansible. $normal \n Tente instalar manualmente com gerenciador de pacotes da sua Distro \n"
fi



# FINALIZANDO AS COISAS, se tiver executado via screen, feche as janelas e informe a instalacao, na nova janela.
screen -ls | grep Socket
if [ $? == 1 ]; then
	echo -en "\nTeste a instalação, $green bash $normal já carregado.\n"
	cd $BACKUP_FROM_RUNDIR;bash
else
    	SCREEN_SESSION=yes
    	#echo -en "Usando novo formato de instalação em nova janela em backgroud com: screen -c install.screenrc\n"
	#screen -p instalado -t instalado
	screen -p 1 -X remove
	screen -t instalado -X next
	screen -p instalado -X focus
	screen -p instalado -X vbell off
	screen -p instalado -X exec "$CDSHELL/linux/notificar.sh"
	screen -p instalado -X source "$CDSHELL/.screenrc"
fi

systemctl stop cdshelld
systemctl disable cdshelld
rm /etc/systemd/system/cdshelld.service -rf
cp $CDSHELL/push/cdshelld.service /etc/systemd/system/
systemctl start cdshelld
systemctl enable cdshelld
systemctl daemon-reload


# Criar pasta NODE LIB caso nao exista
if [ ! -d $NODE_MODULES ] || [ ! -e $NODE_MODULES ]; then
    	NODE_MODULES=/lib/node_modules
	mkdir -p $NODE_MODULES 
	echo -en "\nCriando diretório padrão /lib/node_modules para comportar variável $alert NODE_MODULES $normal\n"
else
	mkdir -p /lib/node_modules 
	echo -en "\nCriando diretório padrão /lib/node_modules para comportar variável $alert NODE_MODULES $normal\n"
fi

echo -en "\n\n $green Try executing: $> node deploy.js \$(cdshell -V) \n\n"
# Avisando do DEPLOY VIA PUSH
cd /root/shell/push/
echo -en "$green CHAMANDO => $red /root/shell/push/version.sh $( /root/shell/linux/cdshell -V ) $normal \n"
/root/shell/push/version.js $( /root/shell/linux/cdshell -V )

if [ $? -ne 0 ]; then
    echo -en "\n\n\t (X) erro ao executar o DEPLOY PUSH NOTIFICATION $normal \n\n"
else
    echo -en "\n\n\t (OK) DEPLOY PUSH NOTIFICATION \t -> \t$green DONE $normal \n\n"
fi

#sleep 1 && kill -SIGTERM nodemon && exit 0

# Fechando com a chamada do teste em um screen separado, caso a instalacao esteja rolando em uma sessao de screen
# será invocado ao final da linux/notificar.sh

whereis miniman > /dev/null
if [ $? -eq 0 ]; then

   $CDSHELL/linux/cdshell -h
else
    echo -en "Existe miniman, para help tente: $yellow $> miniman cdshell$normal \n\n" 
fi
