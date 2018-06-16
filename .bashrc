# .bashrc

# Caso exista, execute os exports personalizados em .export
if [ -e ~/.export ]; then
	. ~/.export
fi

# Caso exista, execute os alias personalizados em .alias
# Atençao: "como se usa variaveis dentro do .alias, nao se deve colocar ele antes do .export acima"
if [ -e ~/.alias ]; then
 	. ~/.alias
fi

# Caso exista, execute os alias personalizados em .alias
# Atençao: "como se usa variaveis dentro do .alias, nao se deve colocar ele antes do .export acima"
if [ -e $CDSHELL/hostScripts/${HOSTNAME}.alias ]; then
 	. $CDSHELL/hostScripts/${HOSTNAME}.alias
fi


#Usando <TAB><TAB> após o comando cd somente mostra diretórios
complete -d cd

#Usando git bash_completion
. /etc/bash_completion.d/git


# Instalacao das Funcoes ZZ (www.funcoeszz.net)
export ZZOFF=""  # desligue funcoes indesejadas
export ZZPATH="/opt/funcoeszz/funcoeszz"  # script
source "$ZZPATH"

#Importa Cores # ATENCAO NAO SE PODE REMOVER ISSO SENAO DA ZICA NAS CORES, Teste com comando pull para ver, kkk
SHELLCOLOR="$CDSHELL/colors.sh"  # Cores para o CDSHELL
source $SHELLCOLOR

source ~/funcoes-cdshell.sh

#Carregando os bash completions
for i in `ls $HOME/.bash_completion.d/` ; do 
	source $HOME/.bash_completion.d/$i
done

TAREFAS_TXT=$(cat $CDSHELL_VAR/tarefas_usedby_bashrc.txt)
echo -en "${WHITE} - Lista de Tarefas -\n$normal\n ${TAREFAS_TXT}$normal\n\n"
