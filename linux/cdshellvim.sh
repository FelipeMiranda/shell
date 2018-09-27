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
source ~/colors.sh
VIM=$(type vim)
VI=$(type vi)
if [ -n "$VIM" ]; then VIM=$VI ; fi
################################################


##########  git commit #######################
function commit(){
    
  	if [ $( md5sum ~/$1 | cut -f1 -d ' ') != $(md5sum $CDSHELL/$1 | cut -f1 -d' ') ]; then
		echo -en "\n\n $yellow $1 $green está diferente! $normal \n\n"
	    echo -en "\n Deseja commitar o $1 ? (${WHITE}s${normal})im/(${WHITE}n${normal})ão\n"
	    read -n 1 COMMITAR
	    if [ "$COMMITAR" == "s" ] || [ $COMMITAR == "S" ] ; then
			cp ~/$1 $CDSHELL/$1 > /dev/null
			cd $CDSHELL
			#git add .
			git commit -m "Novas melhorias no $1"
			echo -en "\n git commit ..... $green Done $normal \n"
			cd -
			echo -en "\n\t\t Enviar p/ GITHUB \t -> \t $WHITE rr(®®)$normal\n\n"
	    fi
	    if [ "$COMMITAR" == "n" ]; then
		  echo -en "\n $red Cancelado! $yellow saindo sem commitar... cuidado os arquivos $WHITE estão alterados. $normal \n"
	    fi
	else
	    echo -en "\n Sem modificações para commit, arquivo: $1 $green IGUALADO\n\n"
	fi
}

#Testa se o arquivo foi alterado, comparando com o original do CDSHELL, se diferentes retorna 0.
function is_file_changed(){
  	#if [ $( md5sum ~/$1 | cut -f1 -d ' ') != $(md5sum $CDSHELL/$1 | cut -f1 -d' ') ]; then
  	if [ $( sed '/TAREFAS_SHOWED_AT_TIME/d' ~/$1 | md5sum | cut -f1 -d ' ') != $(sed '/TAREFAS_SHOWED_AT_TIME/d' $CDSHELL/$1 | md5sum | cut -f1 -d' ') ]; then
	    	#sim
		return 0;
	else
	    	# nao modificado
		return 1;
	fi
}


################################################
#############        MAIN       ################
case $1 in
		"--alias")	
			ALIAS_FILE_DATE=$(stat -c %y ~/.alias)
			# Faça isso... 
			vim $HOME/.alias
			ALIAS_FILE_DATE_POS_VI=$(stat -c %y $HOME/.alias)
			if [ $(echo "$ALIAS_FILE_DATE" | md5sum | cut -f1 -d' ') != $(echo "$ALIAS_FILE_DATE_POS_VI" |md5sum | cut -f1 -d' ' ) ]; then
				echo -en "$HOME/.alias alterado $red *LOCALMENTE*$normal,   $alert NÃO ESQUEÇA $green de  $green ** COMMITar ** $WHITE-> $> ec $normal\n\n"
				bash -c "
					echo -en \" $HOME/.alias  -> $green Recarregado !!!$normal\n\"
					echo -en \"Testar o alias e sair($green ec $normal)\n\"
				"
				$CDSHELL/linux/cdshellvim.sh --commit
			else
			    	echo -en "\n\n\t Arquivo $HOME/.alias não alterado: $green RELAXA$normal\n\n"
			fi
		;;

		"--export")	
			EXPORT_FILE_DATE=$(stat -c %y ~/.export)
			# Faça isso... 
			vim $HOME/.export
			EXPORT_FILE_DATE_POS_VI=$(stat -c %y $HOME/.export)
			if [ $(echo "$EXPORT_FILE_DATE" | md5sum | cut -f1 -d' ') != $(echo "$EXPORT_FILE_DATE_POS_VI" |md5sum | cut -f1 -d' ' ) ]; then
				echo -en "$HOME/.export alterado com sucesso, $alert NÃO ESQUEÇA $green de ** COMMITar ** $WHITE-> $> ec $normal\n\n"
			else
			    	echo -en "\n\n\t Arquivo $HOME/.export não alterado: $green RELAXA$normal\n\n"
			fi
		;;

		"--edit-install")	
			cd / ; cd $CDSHELL
			EXPORT_FILE_DATE=$(stat -c %y $CDSHELL/install.sh)
			# Faça isso... 
			vim $CDSHELL/install.sh
			EXPORT_FILE_DATE_POS_VI=$(stat -c %y $CDSHELL/install.sh)
			if [ $(echo "$EXPORT_FILE_DATE" | md5sum | cut -f1 -d' ') != $(echo "$EXPORT_FILE_DATE_POS_VI" |md5sum | cut -f1 -d' ' ) ]; then
				echo -en "$CDSHELL/install.sh alterado com sucesso, $alert NÃO ESQUEÇA $green de ** COMMITar ** $WHITE-> $> ec $normal\n\n"
			else
			    	echo -en "\n\n\t Arquivo $CDSHELL/install.sh não alterado: $green RELAXA$normal\n\n"
			fi
		;;

		"--edit-cdshellvim")	
			cd / ; cd $CDSHELL
			EXPORT_FILE_DATE=$(stat -c %y $CDSHELL/linux/cdshellvim.sh)
			# Faça isso... 
			vim $CDSHELL/linux/cdshellvim.sh
			EXPORT_FILE_DATE_POS_VI=$(stat -c %y $CDSHELL/linux/cdshellvim.sh)
			if [ $(echo "$EXPORT_FILE_DATE" | md5sum | cut -f1 -d' ') != $(echo "$EXPORT_FILE_DATE_POS_VI" |md5sum | cut -f1 -d' ' ) ]; then
				echo -en "$CDSHELL/linux/cdshellvim.sh alterado com sucesso, $alert NÃO ESQUEÇA $green de ** COMMITar ** $WHITE-> $> ec $normal\n\n"
			else
			    	echo -en "\n\n\t Arquivo $CDSHELL/linux/cdshellvim.sh não alterado: $green RELAXA$normal\n\n"
			fi
		;;


		"--commit" )
				$CDSHELL/linux/cdshellvim.sh --check-all
			    #echo -en "\n Deseja commitar o .alias ou .export ? (${WHITE}a${normal})lias/(${WHITE}e${normal})xport\n"
			    #read -n 1 RESPOSTA
			    #if [ "$RESPOSTA" == "a" ] ; then
			#	    commit .alias
			#    fi
			#    if [ "$RESPOSTA" == "e" ]; then
		#		    commit .export
	#		    fi
		;;

		# Amarrado aos alias etodos cdshell --check-all ou cdshell --etodos
		"--check-all"|"--etodos" )
				CODE=1
				is_file_changed .export 
				if [ $? == 0 ]; then
				    	commit .export
					CODE=0
				fi

				is_file_changed .alias
				if [ $? == 0 ]; then
				    	commit .alias
					if [ $CODE -ne 1 ]; then
					    CODE=0
					fi
				fi

				git status $CDSHELL/install.sh | grep "nothing to commit"
				if [ $? -ne 0 ]; then
				    echo -en "Tem commit para fazer no install.sh"
				    cd $CDSHELL
				    git commit install.sh -m "Melhorias cotidianas no install.sh"
				    echo -en "$alert NAO ESQUECER $normal de fazer $red (rr) $normal\n"
				    push
				    if [ $CODE -ne 1 ]; then
					    CODE=0
				    fi
				    cd -
				fi

				git status $CDSHELL/linux/cdshellvim.sh | grep "nothing to commit"
				if [ $? -ne 0 ]; then
				    echo -en "Tem commit para fazer no linux/cdshellvim.sh"
				    cd $CDSHELL
				    git commit linux/cdshellvim.sh -m "Melhorias cotidianas no linux/cdshellvim.sh"
				    echo -en "$alert NAO ESQUECER $normal de fazer $red (rr) $normal\n"
				    git push 
				    if [ $CODE -ne 1 ]; then
					    CODE=0
				    fi
				    cd -
				fi

				exit $CODE
		;;

			"--help" )
				echo -en "* A cdshellvim.sh é um script que é acionado por um monte de alias.\n"
				echo -en "\n\n$green ea\t $normal -> \t SMART edit of alias"
				echo -en "\n$green ee\t $normal -> \t SMART edit of export"
				echo -en "\n$green ec\t $normal -> \t Ordena o commit das mudanças já!"
				echo -en "\n$green ei\t $normal -> \t SMART edit of install.sh"
				echo -en "\n$green eh\t $normal -> \t Exibe esse $red help $normal"
				echo -en "\n$green etodos\t $normal -> \t Verifica mudanças nos principais arquivos \$HOME/.alias \$HOME/.export $alert MENOS $normal \$CDSHELL/install.sh"


				echo -en "$normal\n\n"

		;;


		* )
			# Executa com opcao que nao tem.
			echo -en "O comando $red $1 $normal não existe.\n"
		;;
esac
#############        FIM      ##################
################################################

