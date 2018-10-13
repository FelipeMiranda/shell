#!/bin/bash

####################################################
#  CDSHELL - Install.sh                            #
#  Arquivo de instalação do CDSHELL                #	
####################################################


# Coleta o início da execução.
START=$(date +%s)

# Git Config
#git config --global user.email quirinobytes@gmail.com
#git config --global user.name Rafael Castro
#git config credential.helper store

cd /root/sistemas/bEOS
#cd /root/sistemas/projects/webserver
git pull
docker build -t webserver .
systemctl restart docker
docker run -p 80:3841 -d webserver

