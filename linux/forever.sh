#!/bin/bash

echo -en "Pressione" $green q $normal "para sair"

if [ ! -n  ] ; then
	echo Digite alguma comando para eternizar !!! uhuu
fi

while(true) do

	$1 $2 $3 $4 $5 $6 $7 $8 $9

   # -n 1 to get one character at a time, -t 0.1 to set a timeout 
   read -n 1 -t 0.1 input                  # so read doesn't hang
   if [[ $input = "q" ]] || [[ $input = "Q" ]] 
   then
      echo # to get a newline after quitting
      break
   fi

done
