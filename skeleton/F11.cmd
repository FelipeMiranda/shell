# .F11.cmd - Config
###################

source $HOME/colors.sh
DISPLAY=192.168.15.2:0
export DISPLAY
COMANDO="echo -en '\n\n$green\n\t\t <COLOQUE SEU COMANDO AQUI> $normal\n\n'"
COMANDO="/root/codigo-fonte/python/artificialInteligence/stockprediction/stockprediction.py"



# execute
$COMANDO


#testar comando e so para se houver erro.
if [ $? != 0 ]; then
			# print ERROR and wait press key to see output
			echo -en "$red\n\t\t Teve algum erro no COMANDO acima $normal\n\n"
			echo -en "$blue\n\t pause...$normal"
			read -n 1
else
			# OK printing result
			echo -en $SAIDA
			read -n 1
fi
