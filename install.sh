#/bin/bash

SHELL=~/shell


echo #Instador para o Shell Enviroment KRN"


echo -e "\n\n Iniciando a instalacao ...\n\n"


cp $SHELL/.alias $HOME/
cp $SHELL/.export $HOME/
cp $SHELL/.vimrc $HOME/
cp $SHELL/.screenrc $HOME/
cp $SHELL/.bashrc $HOME/

echo -e "\n\n Instalando as chaves para o Git hub\n\n"
mkdir -p $HOME/.ssh
cp $SHELL/github/* $HOME/.ssh/
cd $HOME/.ssh
tar xzvf file.tgz
cd -

echo -e "\n\n Arquivos instalados com \033[31m sucesso\033[39m \n"
