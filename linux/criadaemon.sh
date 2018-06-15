#!/bin/bash

OSTYPE=`uname`

if [ $OSTYPE == "Linux" ]; then

	if [ -e /etc/init.d/$1 ]; then
		ln -s /etc/init.d/$1 /sbin/rc$1
	else
		echo "O arquivo $1 não existe!"
	fi
fi

