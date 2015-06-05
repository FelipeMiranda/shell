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



# Instalacao das Funcoes ZZ (www.funcoeszz.net)
export ZZOFF=""  # desligue funcoes indesejadas
export ZZPATH="/opt/funcoeszz/funcoeszz"  # script
source "$ZZPATH"

#Importa Cores
export SHELLCOLOR="/root/shell/colors.sh"  # Cores para o CDSHELL
source "$SHELLCOLOR"
