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


cd /root/shell
git pull

/root/shell/install.sh

node /root/shell/push/cdshelld.js $(/root/shell/linux/cdshell -g)



