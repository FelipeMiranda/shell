
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
source ~/shell/colors.sh
################################################


##########  Funcao       #######################
function addPACOTES_LINUX(){
	if [ ! -z $1 ]; then
		sed -i -r 's/^PACOTES_LINUX.*[^"]/\0 $pacote/g' $CDSHELL/requisitos-INSTALL.sh
		echo -en "$green Pacote $alert ${pacote} $green adicionado com sucesso!$normal\n\n"
	else
		echo -en "$alert (Erro) $normal $red Necessário passar um pacote como parâmetro para ser adicionado.$normal\n"
		echo -en "Tente $green $0 <NOME-DO-PACOTE> $normal\n\n"
	fi
   
}


################################################
#############        MAIN       ################
case $OSTYPE in
		"linux" | "LINUX" | "Linux")	
		echo "Chamdando add($1)"	
		addPACOTES_LINUX $1

		;;


		"" )	
			# Quando executa sem opcao, chama funcao versao acima.
			versao
		;;

	
		* )
			# Executa com opcao que nao tem.
			echo -en "O comando $red $1 $normal não existe.\n"
		;;
esac
#############        FIM      ##################
################################################

