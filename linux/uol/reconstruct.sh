#!/bin/bash

FIRST_NAME=`echo $1 | cut -f1 -d@`


if [ ! -z $1 ]; then
	if [ `echo $1 | grep @uol.com.br` ]; then
		sse gemada12 "reconstruct ${1%@uol.com.br}" | grep $FIRST_NAME | grep -v gemada
	else
		sse geleia13 "reconstruct ${1%@bol.com.br}" | grep $FIRST_NAME | grep -v geleia

	fi
fi
