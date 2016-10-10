#/bin/bash

#source /root/shell/.bashrc
#source /root/shell/.export

#Sessao de Configuração.
CDSHELL=~/shell
BACKUP_DIR=$CDSHELL/.saved_files_before_last_install
HOME='/root'

#Colocando o suporte as cores.
source $CDSHELL/colors.sh

#Titulo da instalação.
clear
echo -e "\n $yellow ### $blue Shell Enviroment KRN ® $yellow ### $normal \n\n"

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

if [ -e $HOME/.screenrc ] ; then cp -f $HOME/.screenrc $BACKUP_DIR/ ; fi
cp $CDSHELL/.screenrc $HOME/

if [ -e $HOME/.bashrc ] ; then cp -f $HOME/.bashrc $BACKUP_DIR/ ; fi
cp $CDSHELL/.bashrc $HOME/

if [ -e /etc/inputrc ] ; then cp -f /etc/inputrc $BACKUP_DIR/ ; fi
cp $CDSHELL/inputrc /etc/

if [ -e /opt/funcoeszz/funcoeszz ] ; then cp -f /opt/funcoeszz/funcoeszz $BACKUP_DIR/ ; else mkdir -p /opt/funcoeszz/ ; fi
cp $CDSHELL/opt/funcoeszz/funcoeszz /opt/funcoeszz/



#colocando a data e versão da instalação.
cd $CDSHELL
DATA=$(date +'%d/%m/%Y')
MES=$(date +'%B')
HORA=$(date +'%T')
VERSION=`git rev-list HEAD | wc -l `

echo "CDSHELL $red  ®  $normal quirinobytes \n" > $BACKUP_DIR/data_ultima_instalacao.txt
echo "Versão: $red $VERSION$normal.$blue.$yellow.$green.$MES $normal \n" >> $BACKUP_DIR/data_ultima_instalacao.txt
echo "Data da instalação: $red $DATA $green $MES $yellow@$red$HORA $normal \n" >> $BACKUP_DIR/data_ultima_instalacao.txt
echo "Diretório de Backup: $blue backup -> $red $BACKUP_DIR $normal \n"  >> $BACKUP_DIR/data_ultima_instalacao.txt


#criando um link da pasta backup para .saved_files_befor_last_install
if [ ! -s $CDSHELL/backup ] ; then ln -s $BACKUP_DIR backup ; echo Link para pasta backup criado:$BACKUP_DIR ; fi

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
cd -

echo -e "\n\n Arquivos ${alert}CDSHELL${normal} versão $green `git rev-list HEAD | wc -l`  $normal instalados com $atention sucesso $normal \n"


if [ ! -e ~/.cdshell_req_installed ]; then
	#Se nao exister o link para o bash no /bin entao cria ne, sempre!!!
	if [ ! -e /bin/bash ];then
	ln -s /usr/local/bin/bash /bin/bash
	fi
	$CDSHELL/requisitos-INSTALL.sh
	touch ~/.cdshell_req_installed
fi

#Mensagem final sobre o manual do cdshell: 
echo -e "\n  * ${alert}Em breve será preparada uma breve página de uso após a instalação.$normal\n$yellow  $> miniman cdshell\n\n ® tks ®\n"

pwd

#ja executa o bash para testar
bash
