# .bashrc



if [ -e ~/source.sh ] ; then
	source ~/colors.sh
fi

# Caso exista, execute os exports personalizados em .export
if [ -e ~/.export ]; then
	. ~/.export
fi

# Caso exista, execute os alias personalizados em .alias
# Atençao: "como se usa variaveis dentro do .alias, nao se deve colocar ele antes do .export acima"
if [ -e ~/.alias ]; then
 	. ~/.alias
fi

if [ -e ~/git-prompt.sh ] ; then
	source ~/git-prompt.sh
fi


# Caso exista, execute os alias personalizados em .alias
# Atençao: "como se usa variaveis dentro do .alias, nao se deve colocar ele antes do .export acima"
if [ -e $CDSHELL/hostScripts/${HOSTNAME}.alias ]; then
 	. $CDSHELL/hostScripts/${HOSTNAME}.alias
fi

if [ -e $CDSHELL/hostScripts/${HOSTNAME}.export ]; then
 	. $CDSHELL/hostScripts/${HOSTNAME}.export
fi



#Usando <TAB><TAB> após o comando cd somente mostra diretórios
complete -d cd

#Usando git bash_completion
. /etc/bash_completion.d/git

#KUBERNETES AUTOCOMPLETE
which kubectl
if [ $? == 0 ]; then
	source <(kubectl completion bash)
fi

# Instalacao das Funcoes ZZ (www.funcoeszz.net)
export ZZOFF=""  # desligue funcoes indesejadas
export ZZPATH="/opt/funcoeszz/funcoeszz"  # script
source "$ZZPATH"

#Importa Cores # ATENCAO NAO SE PODE REMOVER ISSO SENAO DA ZICA NAS CORES, Teste com comando pull para ver, kkk
SHELLCOLOR="$CDSHELL/colors.sh"  # Cores para o CDSHELL
source $SHELLCOLOR

source $CDSHELL_VAR/funcoes-cdshell.sh

#Carregando os bash completions
for i in `ls $HOME/.bash_completion.d/` ; do 
	source $HOME/.bash_completion.d/$i
done

# Mostrar as tarefas se SLACK_CDSHELL_SEN_MESSAGES == true
#if [ "$SLACK_CDSHELL_SEND_MESSAGES" == "true" ]; then
	if [ $(( $(date +%s) - $TAREFAS_SHOWED_AT_TIME )) -gt $TAREFAS_TIME_TO_WAIT ]; then
		TAREFAS_TXT=$(cat $CDSHELL_VAR/tarefas_usedby_bashrc.txt)
		echo -en "${WHITE} - Lista de Tarefas -\n$normal\n"
		echo -en "${TAREFAS_TXT}$normal\n\n"
		sed "s/^TAREFAS_SHOWED_AT_TIME.*/TAREFAS_SHOWED_AT_TIME=$(date +%s)/g" ~/.export -i
	fi
#fi
