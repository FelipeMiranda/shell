#!/bin/bash -x

# Script para atualizacao em massa, via ssh, das regras de horario de verão
# nos servidores listados no arquivo
#
# - servidores.txt
#
# Autor: Daniel K Lima
# Data: 17/10/2009
########################

# VARIAVEIS para funcionamento do script
SERVIDORES="./servidores.txt"
COMANDOS="./comandos.sh"

# Testa se o arquivo servidores.txt existe
if [ ! -e ${SERVIDORES} ]
 then
 echo "Arquivo 'servidores.txt' não encontrado."
 exit 1
fi

# Ler o arquivo ${SERVIDORES} e processar cada linha que contém informações
# acerca da conexão
#cat ${SERVIDORES} | while read LINHA
for LINHA in `cat ${SERVIDORES}`
do
 # Joga os campos em variáveis
 HOST=$(echo ${LINHA} | cut -d',' -f1)
 USERNORMAL=$(echo ${LINHA} | cut -d',' -f2)
 USERPASSWD=$(echo ${LINHA} | cut -d',' -f3)
 ROOTPASSWD=$(echo ${LINHA} | cut -d',' -f4)

 # Teste sobre repasse das variáveis
 #echo ${HOST}
 #echo ${USERNORMAL}
 #echo ${USERPASSWD}
 #echo ${ROOTPASSWD}

 # Chama o arquivo comandos.sh com os parâmetros coletados
 # Testa se o arquivo comandos.sh existe
 if [ ! -e ${COMANDOS} ]
  then
  echo "Arquivo com script expect ${COMANDOS} não encontrado"
  exit 1
 else
  # Garantir que o arquivo tenha permissão de execução
  chmod 755 ${COMANDOS}

  # imprimir na tela o comando que esta sendo executado
  #echo "${COMANDOS} ${HOST} ${USERNORMAL} ${USERPASSWD} ${ROOTPASSWD}"

  # executar o script COMANDOS com os parametros
  ${COMANDOS} ${HOST} ${USERNORMAL} ${USERPASSWD} ${ROOTPASSWD}
 fi

done
