#/bin/bash



if [ -z $1 ] ; then

netstat -atun

else

netstat -atun | grep --color $1

fi
