#!/bin/bash


#VARIAVEIS
green='\033[32m'
red='\033[31m'
normal='\033[37m'



function alert(){
 for ((c=0;$c<3;c=$c+1))
 do
	echo -en '\a'
	tput bel
	sleep .2
 	tput bel
	sleep .2
	tput bel
	sleep .5

 done
}


while(true) do 
	LIST=$(linguemctl hs list | grep Down)
	if [ $? -eq 0 ] ; then 
		echo -en $green Tem cara $red Down  $normal
		echo -en "\007\a\a -> $LIST\n"
		alert
	else 
		echo -en $green.$normal
	fi 
	sleep 20
done






