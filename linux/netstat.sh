#/bin/bash



if [ -z $1 ] ; then

netstat -atunop

else

netstat -atunop | grep --color $1

fi
