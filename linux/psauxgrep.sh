#/bin/bash

source ~/colors.sh


if [ -z $1 ]; then
 echo "Digite um filtro: $0 <PROCESSO>"
 exit
fi


#Pegando o primeiro caracter
#  solucao tosca ->
#PRIMEIRA_PARTE=$(echo $1 | head -c 1)


#Solucao elegante ->
PRIMEIRA_PARTE=${1:0:1}
SEGUNDA_PARTE=${1:1}

FILTER="[$PRIMEIRA_PARTE]$SEGUNDA_PARTE"


RESULT=$(ps aux | grep $FILTER)


if [ ${#RESULT} != 0 ]; then

	echo -en "$green ps aux | grep $red $FILTER $normal\n"
	ps aux | grep $FILTER

else

	echo -en "\n\tNão existem processos com esse nome $red $1 $normal nem usuário, nada na saida do: $green ps aux | grep $FILTER\n\n" 

fi



