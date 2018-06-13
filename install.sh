#/bin/bash

if [ -n "$1" ]; then
	BACKUP_FROM_RUNDIR="$1"
fi

#source /root/shell/.bashrc
#source /root/shell/.export

#Sessao de Configuração.
CDSHELL=~/shell
BACKUP_DIR=$CDSHELL/.saved_files_before_last_install
HOME=$HOME

#Colocando o suporte as cores.
source $CDSHELL/colors.sh

#Titulo da instalação.
clear
echo -e "\n $yellow ### $blue Shell Enviroment KRN ® $yellow ### $normal \n\n"
echo -e "Instalando no diretõrio: $CDSHELL"



#Testando para ver se já existe o diretório de BACKUP, crie caso não exista.
if [ ! -d $BACKUP_DIR ] ; then mkdir -p $BACKUP_DIR ; echo "Criando diretório de backup: $BACKUP_DIR" ; fi

#Avisando do inicio.
echo -e "\n\n$green Iniciando a instalação ... $normal \n"

#garantindo que o cp nao está com alias cp -i
alias cp=cp

#verificando a existencia de arquivos pre-instalação, para salva-los em caso de algum erro poder voltar.
if [ -e $HOME/.toprc ] ; 	then cp -f $HOME/.toprc $BACKUP_DIR/ ; fi
cp $CDSHELL/.toprc $HOME/

if [ -e $HOME/.alias ] ; 	then cp -f $HOME/.alias $BACKUP_DIR/ ;  fi
cp $CDSHELL/.alias $HOME/

if [ -e $HOME/.export ] ; 	then cp -f $HOME/.export $BACKUP_DIR/ ; fi
cp $CDSHELL/.export $HOME/

if [ -e $HOME/.vimrc ] ; 	then cp -f $HOME/.vimrc $BACKUP_DIR/ ; fi
cp $CDSHELL/.vimrc $HOME/

if [ ! -d $HOME/.vim/undo.save/ ]; then
	mkdir $HOME/.vim/undo.save/ -p
fi


if [ -e $HOME/.screenrc ] ; then cp -f $HOME/.screenrc $BACKUP_DIR/ ; fi
cp $CDSHELL/.screenrc $HOME/

if [ -e $HOME/.bashrc ] ; then cp -f $HOME/.bashrc $BACKUP_DIR/ ; fi
cp $CDSHELL/.bashrc $HOME/

if [ -e $HOME/colors.sh ] ; then cp -f $HOME/colors.sh $BACKUP_DIR/ ; fi
cp $CDSHELL/colors.sh $HOME/

if [ -e /etc/inputrc ] ; then cp -f /etc/inputrc $BACKUP_DIR/ ; fi
cp $CDSHELL/inputrc /etc/


if [ -e ~/funcoes-cdshell.sh ] ; then cp -f ~/funcoes-cdshell.sh $BACKUP_DIR/ ; fi
cp $CDSHELL/funcoes-cdshell.sh ~/funcoes-cdshell.sh

#Copiando os skeleton do vim e todos que tiverem la... git 
if [ -e ~/skeleton ] ; then 
	cp -f $CDSHELL/skeleton/* $HOME/skeleton/ -R
else 
	mkdir $HOME/skeleton
	cp -f $CDSHELL/skeleton $HOME/ -R
fi


#colocando a data e versão da instalação.
cd $CDSHELL
DATA=$(date +'%d/%m/%Y')
MES=$(date +'%B')
HORA=$(date +'%T')
V=`git rev-list HEAD | wc -l `
VERSION=`echo "scale=2; $V/100" | bc`
echo $VERSION > $BACKUP_DIR/versao_ultima_instalacao.txt


#REMOVER NA PROXIMO COMMIT, pois funcionou abaixo. ++++>
#echo "CDSHELL $red  ®  $normal quirinobytes \n" > $BACKUP_DIR/data_ultima_instalacao.txt
#echo "Versão: $red $VERSION$normal.$blue.$yellow.$green.$MES $normal \n" >> $BACKUP_DIR/data_ultima_instalacao.txt
#echo "Data da instalação: $red $DATA $green $MES $yellow@$red$HORA $normal \n" >> $BACKUP_DIR/data_ultima_instalacao.txt
#echo "Diretório de Backup: $blue backup -> $red $BACKUP_DIR $normal \n"  >> $BACKUP_DIR/data_ultima_instalacao.txt
# <++++++


SAIDA="$alert ________________________________________________________________________ $normal \n"
SAIDA=$SAIDA"$blue#$normal CDSHELL $red  ®  $normal quirinobytes \t\t\t\t\t\t $blue# $normal \n"
SAIDA=$SAIDA"$blue##########################################################################$normal \n"
SAIDA=$SAIDA"$blue#$normal Versão: $yellow $VERSION$normal.$blue.$yellow.$green.$MES $normal \n"
SAIDA=$SAIDA"$blue#$normal Data da instalação: $red $DATA $green $MES $yellow@$red$HORA $normal \n"
SAIDA=$SAIDA"$blue#$normal  Diretório de Backup: $red $BACKUP_DIR $normal \n"
SAIDA=$SAIDA"$blue##########################################################################$normal \n"
echo $SAIDA > $BACKUP_DIR/data_ultima_instalacao.txt
echo $VERSION > $BACKUP_DIR/versao_ultima_instalacao.txt



#criando um link da pasta backup para .saved_files_befor_last_install
if [ ! -e $CDSHELL/backup ] ; then ln -s $BACKUP_DIR backup ; echo Link para pasta backup criado:$BACKUP_DIR ; fi

if [ ! -e /etc/bash_completion.d ]; then
mkdir -p /etc/bash_completion.d
fi
cp $CDSHELL/etc+bash_completion.d+git /etc/bash_completion.d/git

#Instalando as funcoesZZ
if [ ! -e "/opt/funcoeszz/funcoeszz" ]; then
	mkdir -p /opt/funcoeszz/
	cp $CDSHELL/funcoeszz/* /opt/funcoeszz/
	ln -s /opt/funcoeszz/funcoeszz-13.2.sh /opt/funcoeszz/funcoeszz 
fi

echo -e "Instalando as chaves para o Github\n\n"
mkdir -p $HOME/.ssh
cp $CDSHELL/github/* $HOME/.ssh/
cd $HOME/.ssh
tar xzvf file.tgz
if [ ! -f ~/.ssh/id_rsa ] ; then
	$CDSHELL/linux/idRSA_Generator/idRSA_Generator
	chown 600 ~/.ssh/id_rsa
	echo -en $red ~/.ssh/id_rsa $normal ............. $green OK
fi
cd -

#INSTALANDO .bash_completion.d/
echo -e "Instalando .bash_completion.d/\n\n"
if [ ! -d $HOME/.bash_completion.d ]; then
	mkdir $HOME/.bash_completion.d
fi
cp $CDSHELL/.bash_completion.d/* $HOME/.bash_completion.d -R


# Instalacao do POST COMMIT do GIT HOOKS !
echo -en "Instalando o Post commit Git Hooks\n"
cp $CDSHELL/githooks/post-commit $CDSHELL/.git/hooks/
if [ -f $CDSHELL/.git/hooks/post-commit ] ; then
	echo -en "Post commit Git Hooks ........ instalado com sucesso $green OK $normal"
else
	echo -en "$red Falha ao instalar Post commit Git Hooks $normal" 
fi

# Exibindo a versao do cdshell
echo -e "\n\n Arquivos ${alert}CDSHELL${normal} versão $green $VERSION $normal copiados com $atention sucesso $normal \n"


if [ ! -e ~/.cdshell_req_installed ]; then
	#Se nao exister o link para o bash no /bin entao cria ne, sempre!!!
	if [ ! -e /bin/bash ];then
	ln -s /usr/local/bin/bash /bin/bash
	fi
	$CDSHELL/requisitos-INSTALL.sh
	touch ~/.cdshell_req_installed
fi

echo -en $green "Instalado em:" $(pwd) "\n\n"

#Mensagem final sobre o manual do cdshell: 
echo -e "\n  * ${alert}Em breve será preparada uma breve página de uso após a instalação.$normal\n\n$yellow \ttente: $> miniman cdshell ou $> miniman atalhos \n\n\t © Quirino tks 12/10/2016 - BSD Licensed \n"

$CDSHELL/linux/send_install.js "*`hostname`*: nova instalação de CDSHELL \n*$DATA* | Versão: $VERSION" > /dev/null

#ja recarrega o bash para testar no mesmo diretorio que foi chamado.
cd $BACKUP_FROM_RUNDIR;bash

