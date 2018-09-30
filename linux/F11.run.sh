#!/bin/bash																				
######################################################################
# F11 Deploy - Script para executar o conteúdo do arquivo ~/.F11.cmd #
######################################################################




#Config
source ~/colors.sh


#Ler o comando
COMANDO=$(cat ~/.F11.cmd)


#Executando
echo -en "\n  $alert - F11 Launcher -${normal}\n\n\n\n${yellow}  # COMANDO #\n\n$WHITE[ $COMANDO ]$normal\n\n\n\n$cyan  # RESULTADO #\n$WHITE"
$COMANDO


#Tratamento de erros.
if [ $? != 0 ]; then

			# Errors ocurred
			echo -en "$red \n\n\n\n\n\t Teve algum erro no: $WHITE [ $COMANDO ]\n\n\n\t$normal"
			echo -en "$alert pressione qualquer tecla para contiuar ... $normal\n"
			read -n 1
else

			# COMMAND OK
			echo -en "$alert\n\n\n\n\n\t Seu comando foi executado com $normal $green SUCESSO, $normal tchau... $normal\n"
			read -n 1
fi
