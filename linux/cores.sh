
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
function show(){

COR=$( cat $CDSHELL/colors.sh | grep export | cut -d' ' -f2- )

eval echo -en "$( echo -en ${COR} | sed 's/red/$red red $normal / ; s/black/$black black $normal/ ; s/blue/$blue blue $normal/ ; s/cyan/$cyan cyan $normal/ ; s/white/$white white $normal/ ; s/magenta/$magenta magenta $normal/ ; s/green/$green green $normal/ ; s/yellow/$yellow yellow $normal/ ; s/WHITE/$WHITE WHITE $normal/ ; s/atention/$atention atention $normal/ ; s/alert/$alert alert $normal/ ; s/normal/$normal normal/ ; s/HIDE/$white HIDE $normal/' )"

}



show

echo
