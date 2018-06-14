#/bin/bash

####################################################
#	CDSHELL - Install.sh										#
#  Arquivo de instalação do CDSHELL						#
####################################################

CDSHELL=~/shell
BACKUP_DIR=$CDSHELL/.saved_files_before_last_install

#Get the begin time
START=$(date +%s)

#Garantindo que o cp nao está com alias cp -i
alias cp=cp

# Recebendo RUNDIR de execução, qdo é passado, via parametro $1
if [ -n "$1" ]; then
	BACKUP_FROM_RUNDIR="$1"
fi

# Suporte as cores. (cdshell -c) para ver cores do CDSHELL
source $CDSHELL/colors.sh
clear

#Cabeçalho da instalação.
echo 
echo -en "\n\t\t $blue#$yellow### $blue Shell Enviroment KRN ® $yellow###$blue#$normal\n"
echo -en "\t\t$blue-----------------------------------$normal\n"

echo -en "\n Diretório do usuário 		->	$yellow $HOME $normal\n"

#Avisando que salvou o RUNDIR para voltar no mesmo lugar que chamou o install.
if [ -n $BACKUP_FROM_RUNDIR ]; then
	 echo -en "\n Diretório corrente $blue(RUNDIR)$normal 	->	$yellow $BACKUP_FROM_RUNDIR $normal\n"
fi
echo -en "\n Diretório de instalação 	->	$yellow $CDSHELL $normal\n"

#verificando a existencia de arquivos pre-instalação, para salva-los em caso de algum erro poder voltar.
echo -en "\n Diretório de backup 		-> 	$yellow $BACKUP_DIR $normal\n"

echo -en "\n\n Iniciando backup ."

#Testando para ver se já existe o diretório de BACKUP, crie caso não exista.
if [ ! -d $BACKUP_DIR ] ; then mkdir -p $BACKUP_DIR ; echo -en "\nCriando diretório de backup: $yellow $BACKUP_DIR $normal ... " ; fi


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

if [ -e /etc/inputrc ] ; then cp -f /etc/inputrc $BACKUP_DIR/ ; fi
echo -en .
cp $CDSHELL/inputrc /etc/
echo -en .

echo -en "... $green Done $normal\n"

#garantindo o diretorio para o vim salvar historicos de edicoes dos arquivos.
if [ ! -d $HOME/.vim/undo.save/ ]; then
	mkdir $HOME/.vim/undo.save/ -p
fi

if [ -e ~/funcoes-cdshell.sh ] ; then cp -f ~/funcoes-cdshell.sh $BACKUP_DIR/ ; fi
cp $CDSHELL/funcoes-cdshell.sh ~/funcoes-cdshell.sh

#Copiando os skeleton do vim e todos que tiverem la... git 
if [ -e ~/skeleton ] ; then
	echo -en "\n Copiando os skeletons .........."
	cp -f $CDSHELL/skeleton/* $HOME/skeleton/ -Ra
	echo -en ".............. $green Done $normal\n"
else 
	echo -en "\n Copiando os skeletons $yellow pela primeira vez $normal"
	mkdir $HOME/skeleton
	cp -f $CDSHELL/skeleton $HOME/ -R
fi

echo -en "\n Atualizando$yellow F11.cmd $normal.............."
if [ -e ~/.F11.cmd ]; then
	 #verifica se arquivo do CDSHELL e mais novo que do HOME, se for faz um backup e sobrescreva-o.
	 if [[ ~/.F11.cmd -ot $CDSHELL/skeleton/F11.cmd ]]; then
		  	 cp ~/.F11.cmd $BACKUP_DIR/
		  	 rm ~/.F11.cmd
			 cp -f $CDSHELL/skeleton/F11.cmd ~/.F11.cmd
			 chmod +x ~/.F11.cmd
	 fi
	 else
		   #Se nao existe, crie-o
		  	cp -f $CDSHELL/skeleton/F11.cmd ~/.F11.cmd
			chmod +x ~/.F11.cmd
fi
echo -en "............ $green Done $normal\n"


echo -en "\n Carimbo de instalacão ........."
#colocando a data e versão da instalação.
cd $CDSHELL
echo -en . 
DATA=$(date +'%d/%m/%Y')
echo -en . 
MES=$(date +'%B')
echo -en . 
HORA=$(date +'%T')
echo -en . 
V=`git rev-list HEAD | wc -l `
echo -en . 

VERSION=`echo "scale=2; $V/100" | bc 2>&1 > /dev/null `
echo $VERSION > $BACKUP_DIR/versao_ultima_instalacao.txt
echo -en ".......... $green Done $normal\n"

if [ -z $VERSION ]; then
	 VERSION=$(echo $V  | sed  's/./\0\./g')
	 if [ -z $VERSION ]; then
	 	echo -en "\n $redERROR: Não criou a versão, verifique se o bc está instalado$normal\n"
	 fi
fi

SAIDA="$alert ________________________________________________________________________ $normal \n"
SAIDA=$SAIDA"$blue#$normal CDSHELL $red  ®  $normal quirinobytes \t\t\t\t\t\t $blue# $normal \n"
SAIDA=$SAIDA"$blue##########################################################################$normal \n"
SAIDA=$SAIDA"$blue#$normal Versão: $yellow $VERSION$normal.$blue.$yellow.$green.$MES $normal \n"
SAIDA=$SAIDA"$blue#$normal Data da instalação: $red $DATA $green $MES $yellow@$red$HORA $normal \n"
SAIDA=$SAIDA"$blue#$normal  Diretório de Backup: $red $BACKUP_DIR $normal \n"
SAIDA=$SAIDA"$blue##########################################################################$normal \n"
echo $SAIDA > $BACKUP_DIR/data_ultima_instalacao.txt
echo $VERSION > $BACKUP_DIR/versao_ultima_instalacao.txt


echo -en "\n Criando link para backup ........"

#criando um link da pasta backup para .saved_files_befor_last_install
if [ ! -e $CDSHELL/backup ] ; then ln -s $BACKUP_DIR backup ; echo Link para pasta backup criado:$BACKUP_DIR ; fi

echo -en . 
if [ ! -e /etc/bash_completion.d ]; then
	echo -en . 
	mkdir -p /etc/bash_completion.d
	echo -en . 
fi
echo -en . 
echo -en "........... $green Done $normal\n"


echo -en "\n Configurando $yellow .bash_completion.d $normal ....."
#bash_completion
cp $CDSHELL/etc+bash_completion.d+git /etc/bash_completion.d/git
echo -en "....... $green Done $normal\n"

echo -en "\n Instalando $yellow funcoesZZ $normal ...."
#Instalando as funcoesZZ
if [ ! -e "/opt/funcoeszz/funcoeszz" ]; then
	mkdir -p /opt/funcoeszz/
	cp $CDSHELL/funcoeszz/* /opt/funcoeszz/ 2>&1 > /dev/null
	ln -s /opt/funcoeszz/funcoeszz-13.2.sh /opt/funcoeszz/funcoeszz 
fi
echo -en "................... $green Done $normal\n"

echo -en "\n Instalando as chaves SSH ........"
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

#INSTALANDO .bash_completion.d/
echo -en "\n Copiando arquivos do $yellow .bash_completion.d $normal .."
if [ ! -d $HOME/.bash_completion.d ]; then
	mkdir $HOME/.bash_completion.d
fi
cp $CDSHELL/.bash_completion.d/* $HOME/.bash_completion.d -R
echo -en ".. $green Done $normal\n"


# Instalacao do POST COMMIT do GIT HOOKS !
echo -en "\n Instalando o Git Hooks ........"
cp $CDSHELL/githooks/post-commit $CDSHELL/.git/hooks/
if [ -f $CDSHELL/.git/hooks/post-commit ] ; then
	echo -en "............... $green Done $normal\n"
else
	echo -en "\n$red ERROR: Erro ao instalar Post commit do Git Hooks$normal\n" 
fi


if [ ! -e ~/.cdshell_req_installed ]; then
	#Se nao exister o link para o bash no /bin entao cria ne, sempre!!!
	if [ ! -e /bin/bash ];then
	ln -s /usr/local/bin/bash /bin/bash
	fi
	$CDSHELL/requisitos-INSTALL.sh
	touch ~/.cdshell_req_installed
fi

echo -en "\n Enviando mensagem para $yellow slack$normal ................ $green Done$normal\n"
#Envia mensagem para canal install do SLACK
$CDSHELL/linux/send_install.js "*$DATA* Nova instalação de CDSHELL em $HOSTNAME* | Versão: $VERSION" 2>&1 > /dev/null

END=$(date +%s)
RUNTIME=$(expr $END - $START)

# Exibindo a versao do cdshell
echo -e "\n ${alert} CDSHELL ${normal} v.$atention$VERSION$normal instalado$normal em $yellow $RUNTIME $normal segundos . $green Done\n"

#Mensagem final sobre o manual do cdshell: 
echo -en "\n ${alert} Existe uma página help feita com miniman $normal\n    $yellow $> miniman cdshell ou cdshell -h\n\n"

#Carregar o bash e testar
cd $BACKUP_FROM_RUNDIR;bash


