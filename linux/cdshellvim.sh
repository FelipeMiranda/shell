
#!/bin/bash

#################################################
# Bash script - Modelo					#
# Use como modelo para criar seus scripts bash. #
# v_1.0.1							#
#################################################


#############     CONFIG     ####################
#Carrega variáreis de ambiente.
source ~/.export
# Suporte a cores no bash.
#source ~/colors.sh
VIM=$(type vim)
VI=$(type vi)
if [ -n "$VIM" ]; then VIM=$VI ; fi
################################################


##########  Funcao       #######################
function commit(){
    
	echo -en "\n\n Publicando $1 "
    
   	if [ $( md5sum ~/$1 | cut -f1 -d ' ') != $(md5sum $CDSHELL/$1 | cut -f1 -d' ') ]; then
	    echo -en "\n Deseja commitar o $1 ? (${WHITE}s${normal})im/(${WHITE}n${normal})ão\n"
	    read -n 1 COMMITAR
	    if [ "$COMMITAR" == "s" ] || [ $COMMITAR == "S" ] ; then
		  	echo "estou iniciando"
			cp ~/$1 $CDSHELL/$1 -i
			cds
			git add .
			git commit 
			cd -
			echo "Faça o ®®®"
	    fi
	    if [ "$COMMITAR" == "n" ]; then
		  echo -en "\n $red Cancelado! $yellow saindo sem commitar... cuidado os arquivos $WHITE estão alterados. $normal \n"
	    fi
	else
	    echo -en "\n Sem modificações para commit, arquivo: $1 $green IGUALADO\n\n"
	fi
}


################################################
#############        MAIN       ################
case $1 in
		"--alias")	
			ALIAS_FILE_DATE=$(stat -c %y ~/.alias)
			# Faça isso... 
			vim ~/.alias
			ALIAS_FILE_DATE_POS_VI=$(stat -c %y ~/.alias)
			if [ $(echo "$ALIAS_FILE_DATE" | md5sum | cut -f1 -d' ') != $(echo "$ALIAS_FILE_DATE_POS_VI" |md5sum | cut -f1 -d' ' ) ]; then
				echo -en "$HOME/.alias alterado com sucesso, $red não esqueça de $green ** COMMITar ** $WHITE-> $> ec $normal\n\n"
			else
			    	echo "\n\n\t Arquivo $HOME/.alias não alterado\n"
			fi
		;;

		"--export")	
			EXPORT_FILE_DATE=$(stat -c %y ~/.export)
			# Faça isso... 
			vim ~/.export
			EXPORT_FILE_DATE_POS_VI=$(stat -c %y ~/.export)
			if [ $(echo "$EXPORT_FILE_DATE" | md5sum | cut -f1 -d' ') != $(echo "$EXPORT_FILE_DATE_POS_VI" |md5sum | cut -f1 -d' ' ) ]; then
				echo -en "$HOME/.export alterado com sucesso, $red não esqueça de $green ** COMMITar ** $WHITE-> $> ec $normal\n\n"
			else
			    	echo "\n\n\t Arquivo $HOME/.export não alterado\n"
			fi
		;;

		"--commit" )
			    echo -en "\n Deseja commitar o .alias ou .export ? (${WHITE}a${normal})lias/(${WHITE}e${normal})xport\n"
			    read -n 1 RESPOSTA
			    if [ "$RESPOSTA" == "a" ] ; then
				    commit .alias
			    fi
			    if [ "$RESPOSTA" == "e" ]; then
				    commit .export
			    fi
		;;

	
		* )
			# Executa com opcao que nao tem.
			echo -en "O comando $red $1 $normal não existe.\n"
		;;
esac
#############        FIM      ##################
################################################

