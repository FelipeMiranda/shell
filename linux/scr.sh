#!/bin/bash

#################################################
# Bash script - Modelo					#
# Use como modelo para criar seus scripts bash. #
# v_1.0.1							#
#################################################
VERSION=1.0


#############     CONFIG     ####################
#Carrega variáreis de ambiente.
source ~/.export
# Suporte a cores no bash.
source ~/shell/colors.sh
################################################


##########  Funcao       #######################
function help(){
    echo -en "$\n\n\t $alert Use: $green $0 $PARAMETERS $normal \n\n"
}

function versao(){

	echo -en "Usado para criar uma sessao de screen, e voltar $green sempre $normal na mesma.\n"
	echo -en "$\n\n\t $alert Versao: $green $0 $VERSION $normal \n\n"
}


################################################
#############        MAIN       ################
case $1 in
		"" )	
			# Quando executa sem opcao, chama funcao versao acima.
			LISTA=$(screen -ls | grep -v "There" | grep -v "Socket" | cut -d'.' -f1 )
                  ITEMS=$(echo $LISTA | wc -w)
                  PASSOU=0

			# Se tiver somente uma sessao, entra nela com screen -x, ou se já rodou o while 3 vezes vai fora
			if [[ $ITEMS = 1 ]] || [[ $PASSOU = 3 ]]; then
				screen -x
			fi
                  
                  if [[ "$ITEMS" = 0 ]]; then ABRA='sim'; fi

			# Se tiver mais de uma sessao
			if [ $ITEMS -gt 1 ]; then
			    while (true); do
                          if [[ $ITEMS = 0  ]]; then
                            exit 0
                          fi
				  for each in $(echo $LISTA); do
					  screen -x $each
					  echo -en "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\t\t\t$WHITE Tem mais uma $red PORRA => $alert ($magenta $each ) $normal $WHITE de sessão aberta. \n\n\n\t ... entrando ......$normal \n\n\n\n\n\t\t $normal \n\n\n\n\n\n\n\t\t -> pressione $red $alert (q/d) $normal -> $red Sair $normal \n\t\t\t\t\t\t\t\t\t\t\t $yellow ... pause $normal \n\n"
					  ULTIMO=$each
					  read -n 1 QUIT
					  if [[ $QUIT = 'q' ]] || [[ $QUIT = 'd' ]]; then
					    exit 0	
					  fi
				  done
                              
                      # Atualiza a lista, pois pode terem encerrado alguma sessao
      		    LISTA=$(screen -ls | grep -v "There" | grep -v "Socket" | cut -d'.' -f1 )
                      ITEMS=$(echo $LISTA | wc -w)
                      PASSOU=$(($PASSOU + 1))
			    done
		 	fi
                  
                  if [[ "$ABRA" = 'sim' ]]; then
                    screen 
                  else
			  echo -en "\n\n\t$red Não $normal havia mais nenhuma $yellow *SESSION ABERTA* $normal \n\n\n"
                  fi
		;;

		"-h"| "--help" )	
			# Quando executa sem opcao, chama funcao versao acima.
			help
		;;


		* )
			# Executa com opcao que nao tem.
			echo -en "Verificando os parametros passados $red $* $normal se existe algum.\n"
			hasParams $*
		;;
esac
#############        FIM      ##################
################################################

