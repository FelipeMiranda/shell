#/bin/bash

source ~/shell/colors.sh
CDSHELL=~/shell



echo -e "\n\n $yellow ### $blue Shell Enviroment KRN $yellow ### $normal \n\n"


echo -e "\n\n Iniciando a instalação ...\n\n"


cp $CDSHELL/.alias $HOME/
cp $CDSHELL/.export $HOME/
cp $CDSHELL/.vimrc $HOME/
cp $CDSHELL/.screenrc $HOME/
cp $CDSHELL/.bashrc $HOME/

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

echo -e "\n\n Arquivos instalados com $atention sucesso $normal \n"

#ja executa o bash para testar

#
echo -e "\n  * ${alert}Em breve será preparada uma breve página de uso após a instalação.$normal\n"

if [ ! -e ~/.cdshell_req_installed ]; then
	$CDSHELL/requisitos-INSTALL.sh
	touch ~/.cdshell_req_installed
fi

bash
