#/bin/bash

source colors.sh
CDSHELL=~/shell



echo -e "\n\n $yellow ### $blue Shell Enviroment KRN ® $yellow ### $normal \n\n"


echo -e "\n\n Iniciando a instalação ...\n\n"


cp $CDSHELL/.alias $HOME/
cp $CDSHELL/.export $HOME/
cp $CDSHELL/.vimrc $HOME/
cp $CDSHELL/.screenrc $HOME/
cp $CDSHELL/.bashrc $HOME/
cp $CDSHELL/inputrc /etc/

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

echo -e "\n\n Arquivos ${alert}CDSHELL${normal} instalados com $atention sucesso $normal \n"


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
