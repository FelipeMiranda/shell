# F11 - deploy cmd
##################
source $HOME/colors.sh


# Define variables
##################
DISPLAY=192.168.15.2:0
COMANDO='echo -en "$red\n\t\t Teve algum erro acima $normal\n\n"'
export DISPLAY
##################






SAIDA=$($COMANDO)
false

if [ $? ]; then
	echo -en "$red\n\t\t Teve algum erro acima $normal\n\n"

	#congelar tela somente se ERROS na execuçao COMANDO
	read -n 1
fi





