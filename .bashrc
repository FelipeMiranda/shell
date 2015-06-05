# .bashrc


# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions

if [ -e ~/.alias ]; then
 	. ~/.alias
fi

if [ -e ~/.export ]; then
	. ~/.export
fi


#Usando <TAB><TAB> após o comando cd somente mostra diretórios
complete -d cd


# Instalacao das Funcoes ZZ (www.funcoeszz.net)
export ZZOFF=""  # desligue funcoes indesejadas
export ZZPATH="/opt/funcoeszz/funcoeszz"  # script
source "$ZZPATH"

#Importa Cores
export SHELLCOLOR="/root/shell/colors.sh"  # Cores para o CDSHELL
source "$SHELLCOLOR"
