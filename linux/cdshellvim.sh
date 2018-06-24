
#!/bin/bash

#################################################
# Bash script - Modelo					#
# Use como modelo para criar seus scripts bash. #
# v_1.0.1							#
#################################################


#############     CONFIG     ####################
#Carrega variáreis de ambiente.
#source ~/.export
# Suporte a cores no bash.
source ~/shell/colors.sh
VIM=$(type vim)
VI=$(type vi)
if [ -n "$VIM" ]; then VIM=$VI ; fi
################################################


##########  Funcao       #######################
function commit(){
    		if [ ! -n $1 ]; then
		    echo publicando $1
		    exit
		fi
		#alias cp=cp
		#cp -f ~/.alias 
		#cdshell
		#git checkout -f
		#cdshell install
}


################################################
#############        MAIN       ################
case $1 in
		"--alias")	
			# Faça isso... 
			vim ~/.alias
		;;


		"--commit" )	
			# Quando executa sem opcao, chama funcao versao acima.
			commit $2
		;;

	
		* )
			# Executa com opcao que nao tem.
			echo -en "O comando $red $1 $normal não existe.\n"
		;;
esac
#############        FIM      ##################
################################################

