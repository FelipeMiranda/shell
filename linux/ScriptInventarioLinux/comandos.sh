#!/bin/bash

#zera a lista para começar uma nova.
echo >> lista/$1.txt

echo ##################################################################### >> lista/$1.txt
#echo $3 | ssh -l $2 $1 hostname  >> lista/$1.txt
#echo $3 | ssh -l $2 $1 date  >> lista/$1.txt
# criar uma lista dos programas instalados e enviar para um arquivo txt.
echo "$3 | ssh -l $2 $1 rpm -qa  >> lista/$1.txt"
#echo ##################################################################### >> lista/$1.txt
#echo $3 | ssh -l $2 $1 cat /proc/cpuinfo  >> lista/$1.txt


exit 0
