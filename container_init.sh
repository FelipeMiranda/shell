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

/usr/local/bin/node /root/shell/push/version.js booting

rm /root/shell -rf
cd /root/
clone shell

/root/shell/push-install.sh &

/usr/local/bin/node /root/shell/push/cdshelld.js $(/root/shell/linux/cdshell -g)
