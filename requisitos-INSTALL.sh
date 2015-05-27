#!/bin/bash




OSTYPE=`uname`


if [ $OSTYPE == "Linux" ]; then


	yum install screen vim lynx iftop ifstatus

fi



if [ $OSTYPE == "OpenBSD" ]; then

	pkg add screen vim lynx iftop 

fi

