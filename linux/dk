#!/bin/bash

#################################################
# Bash script - Modelo							#
# Use como modelo para criar seus scripts bash. #
# v_1.0.1										#
#################################################



#Reutiliza suas variáreis de ambiente.
source ~/.export
# Suporte a cores no bash.
source ~/shell/colors.sh

function resetar_e_instalar_ultima_versao(){
	cdshell
	git checkout -f
	cdshell install
}


case $1 in

	# Faça isso... 
    "ps" | "-p" | "--ps")   ps aux ; echo "Digite os comandos aqui"
	;;

	# Quando executa sem opcao
    "" ) exibe_versao_cdshell
    ;;
   
   	# Executa com opcao que nao tem.
    * )	echo -en "O comando $red $1 $normal não existe.\n"
    ;;

esac



