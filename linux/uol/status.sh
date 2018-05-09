#!/bin/bash

# Esse script pega o parametro de entrada (email) e envia o comando status <EMAIL> para o AS e devolve o retorno, manda para o lugar certo, dependendo do ambiente UOL/AFIL.



FIRST_NAME=`echo $1 | cut -f1 -d@`


if [ ! -z $1 ]; then
	if [ `echo $1 | grep @uol.com.br` ]; then
		sse gemada12 "status ${1%@uol.com.br}" | grep $FIRST_NAME | grep -v gemada
	else
		sse geleia13 "status ${1%@bol.com.br}" | grep $FIRST_NAME | grep -v geleia

	fi
fi
