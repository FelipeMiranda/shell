#!/bin/bash


echo -e "Instalando os requisitos ... \n"

OSTYPE=`uname`


if [ $OSTYPE == "Linux" ]; then


	yum install screen vim lynx iftop ifstatus

	#CentOS 6.6
   rpm -hiv http://pkgs.repoforge.org/txt2tags/txt2tags-2.6-1.el6.rf.noarch.rpm

fi


if [ $OSTYPE == "OpenBSD" ]; then
LISTA="git screen vim lynx iftop ngrep bash"
for i in $LISTA; do
pkg_add $i 
done 
echo -e "Se desejar alterar o shell do usuário:\n usermod -s /usr/local/bin/bash $USER"
fi

