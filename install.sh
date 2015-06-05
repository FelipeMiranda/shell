#/bin/bash

source ~/shell/colors.sh
SHELL=~/shell



echo -e "\n\n $yellow ### $blue Shell Enviroment KRN $yellow ### $normal \n\n"


echo -e "\n\n Iniciando a instalacao ...\n\n"


cp $SHELL/.alias $HOME/
cp $SHELL/.export $HOME/
cp $SHELL/.vimrc $HOME/
cp $SHELL/.screenrc $HOME/
cp $SHELL/.bashrc $HOME/

mkdir -p /opt/funcoeszz/
cp $SHELL/funcoeszz/* /opt/funcoeszz/
ln -s /opt/funcoeszz/* /opt/funcoeszz/funcoeszz

echo -e "\n\n Instalando as chaves para o Git hub\n\n"
mkdir -p $HOME/.ssh
cp $SHELL/github/* $HOME/.ssh/
cd $HOME/.ssh
tar xzvf file.tgz
cd -

echo -e "\n\n Arquivos instalados com $atention sucesso $normal \n"

#ja executa o bash para testar

#
echo -e "$alert \n em breve será preparada uma breve pagina de uso apos a instalacao\n $normal"

bash
