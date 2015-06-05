#/bin/bash

source ~/shell/colors.sh
SHELL=~/shell



echo -e "\n\n $yellow ### $blue Shell Enviroment KRN $yellow ### $normal \n\n"


echo -e "\n\n Iniciando a instalação ...\n\n"


cp $SHELL/.alias $HOME/
cp $SHELL/.export $HOME/
cp $SHELL/.vimrc $HOME/
cp $SHELL/.screenrc $HOME/
cp $SHELL/.bashrc $HOME/

#Instalando as funcoesZZ
if [ ! -e "/opt/funcoeszz/funcoeszz" ]; then
mkdir -p /opt/funcoeszz/
cp $SHELL/funcoeszz/* /opt/funcoeszz/
ln -s /opt/funcoeszz/* /opt/funcoeszz/funcoeszz
fi


echo -e "\n\n Instalando as chaves para o Github\n\n"
mkdir -p $HOME/.ssh
cp $SHELL/github/* $HOME/.ssh/
cd $HOME/.ssh
tar xzvf file.tgz
cd -

echo -e "\n\n Arquivos instalados com $atention sucesso $normal \n"

#ja executa o bash para testar

#
echo -e "\n  * ${alert}Em breve será preparada uma breve página de uso após a instalação.$normal\n"

bash
