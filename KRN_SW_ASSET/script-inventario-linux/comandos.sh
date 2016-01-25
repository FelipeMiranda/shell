#!/bin/bash

#determinar se o SO é Debian like ou RED HAT like.
ssh -l $2 $1 type dpkg > /dev/null 2>&1
if [ $? == 0 ] ;then DEB=true; fi

ssh -l $2 $1 type rpm > /dev/null 2>&1
if [ $? == 0 ] ;then RPM=true; fi

if [ "$DEB" == "true" -a "$RPM" != "true" ]
   then list_programs_cmd="dpkg -l"
		  echo Host $1 is DEB like
elif [ "$RPM" == "true" -a "$DEB" != "true" ]
    then list_programs_cmd="rpm -qa"
		   echo Host $1 is RPM like 
else echo -e "\nArquitetura de pacotes não suportada!\n"
fi



#zera a lista para começar uma nova.
echo >> lista/$1.txt

echo ##################################################################### >> lista/$1.txt
#echo $3 | ssh -l $2 $1 hostname  >> lista/$1.txt
#echo $3 | ssh -l $2 $1 date  >> lista/$1.txt
# criar uma lista dos programas instalados e enviar para um arquivo txt.
echo $3 | ssh -l $2 $1 $list_programs_cmd  >> lista/$1.txt
#echo ##################################################################### >> lista/$1.txt
#echo $3 | ssh -l $2 $1 cat /proc/cpuinfo  >> lista/$1.txt


exit 0
