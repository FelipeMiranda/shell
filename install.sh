#/bin/bash


echo #Instador para o Shell Enviroment KRN"


echo -e "\n\n Iniciando a instalacao ...\n\n"


cp .alias $HOME/
cp .export $HOME/
cp .vimrc $HOME/
cp .screenrc $HOME/

echo -e "\n\n Instalando as chaves para o Git hub\n\n"
mkdir -p $HOME/.ssh
cp github/* $HOME/.ssh/
cd $HOME/.ssh
tar xzvf file.tgz
cd -

echo -e "\n\n Arquivos instalados com \033[31m sucesso\033[39m \n"
