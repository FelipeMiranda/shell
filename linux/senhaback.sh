#!/bin/bash


#sleep 10 && kill $$ &

if [ ! -z $1 ] ; then

	HOST=$1
	echo Trocando a senha no servidor: $HOST
	/root/uol/senhas/troca_senha_expirada.exp $HOST > /dev/null
	/root/uol/senhas/destroca_para_Bi.exp $HOST > /dev/null

else

	echo Para trocar sua senha para a padrao no servidor_X.
	echo Use $0 servidor_X

fi
