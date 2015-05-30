#!/bin/bash




OSTYPE=`uname`


if [ $OSTYPE == "Linux" ]; then


	yum install screen vim lynx iftop ifstatus

	#CentOS 6.6
   rpm -hiv http://pkgs.repoforge.org/txt2tags/txt2tags-2.6-1.el6.rf.noarch.rpm


fi



if [ $OSTYPE == "OpenBSD" ]; then

	pkg add screen vim lynx iftop 

fi

