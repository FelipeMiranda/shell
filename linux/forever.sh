#!/bin/bash

source $HOME/.alias
source $CDSHELL/colors.sh

function show_quit_message(){
	echo -en "\n\t$alert Pressione $atention$green 'q' $alert para encerrar. $normal \n\n"
}


if [ -z $1 ] ; then
	echo -en "Digite algum comando para $red eternizar !!! $normal uhuu \n"
   exit 1
else
    show_quit_message
fi

PRINTED_LINES=0
while(true) do

    LINES=$(tput lines)
	

	$1 $2 $3 $4 $5 $6 $7 $8 $9

   # -n 1 to get one character at a time, -t 0.1 to set a timeout 
   read -n 1 -t 0.1 input                  # so read doesn't hang
   if [[ $input = "q" ]] || [[ $input = "Q" ]] 
   then
      echo # to get a newline after quitting
      break
   fi

   sleep 1

   PRINTED_LINES=$(( $PRINTED_LINES + 1))
	
	if [ $PRINTED_LINES -gt $LINES ]; then
	    show_quit_message
	    PRINTED_LINES=0
	fi
done

exit 0
