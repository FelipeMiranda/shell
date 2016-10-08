#/bin/bash

source /root/shell/colors.sh
CDSHELL=~/shell



echo -e "\n\n $yellow ### $blue Shell Enviroment KRN ® $yellow ### $normal \n\n"


echo -e "\n\n Iniciando a instalação ...\n\n"

mkdir -p ~/.saved

cp $HOME/.alias : ~/.saved/
cp $CDSHELL/.alias $HOME/
cp $HOME/.export : ~/.saved/
cp $CDSHELL/.export $HOME/
cp $HOME/.vimrc: ~/.saved/
cp $CDSHELL/.vimrc $HOME/
cp $HOME/.screenrc: ~/.saved/
cp $CDSHELL/.screenrc $HOME/
cp $HOME/.bashrc : ~/.saved/
cp $CDSHELL/.bashrc $HOME/
cp $HOME/inputrc : ~/.saved/
cp $CDSHELL/inputrc /etc/

if [ ! -e /etc/bash_completion.d ]; then
mkdir -p /etc/bash_completion.d
fi
cp $CDSHELL/etc+bash_completion.d+git /etc/bash_completion.d/git

#Instalando as funcoesZZ
if [ ! -e "/opt/funcoeszz/funcoeszz" ]; then
mkdir -p /opt/funcoeszz/
cp $CDSHELL/funcoeszz/* /opt/funcoeszz/
ln -s /opt/funcoeszz/* /opt/funcoeszz/funcoeszz
fi


echo -e "\n\n Instalando as chaves para o Github\n\n"
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


#ja executa o bash para testar
bash
