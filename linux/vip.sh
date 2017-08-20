#!/bin/bash

## SCRIPT VARIABLES ##
PRODUCT_SCRIPT="systemctl wor status"
PRODUCT_NAME="Webmail"
AMBIENTE_UOL="AFIL"
ENVIRONMENT="production"
SCRIPT_NAME=vip.sh

## APP VARIABLES ##
GET_CMD=$(which GET)

## PRODUCT VARIABLES ##
# URL que o VIP usa para testar o servidor e colocar ou tira-lo do VIP Publico.
URL_VIPCHECK="http://localhost/cnx.htm"
#DESCRIPTION
DESCRITION="Esse script expoe o produto do $PRODUCT_NAME"

# Help
help () { 
  printf " Vip Control - Administration script\n"
  printf " Usage: $SCRIPT_NAME <action>\n"
  echo
  printf "  help|--help      Print this help.\n"
  printf "  start            Put Product behind VIP.\n"
  printf "  stop             Take out Product behind VIP.\n"
  printf "  status           Get VIP status.\n"
  echo
  exit 0
}


# O produto principal está Rodando?
isProductRunning() {
  productStatus="$(systemctl status wor | grep 'Started Webmail' -q)"

# Se houve erro é porque nao está rodando
  if [ $? -eq 0 ]; then  			# Running  
    return 0;
  else     			                # Stopped
    return 1;
  fi
}


enableVip() {
  if [ ! isProductRunning ]; then
    echo -en  "\n\t Product $PRODUCT_NAME \033[31m; is not running \033[37m;,  Start the Product, later start VIP.\n\n"
    return 0
  fi

  if [ isAlreadyOnVip ]; then
    printf "\n\tAlready enabled on VIP\n\n"
  else
    printf "\n\tEnabling $PRODUCT_NAME on VIP\n\n"
  fi
}

disableVip() {
  if [ ! isOnVIP ]; then
	echo Ja está fora do VIP
  else
	echo Esta no VIP, desabilitando....
	echo pronto VIP DESABILITADO {FAKE MESSAGE}
  fi
}

isAlreadyOnVip(){
RESULT=$($GET_CMD $URL_VIPCHECK -s)
echo RESULT=$RESULT
echo $RESULT | grep -q 200
  if [ $? ]; then
        exit 1
  else
        exit 0

  fi
}

status() {
  if [ isAlreadyOnVip ]; then
        echo " Esta no VIP"
  else
        echo " Nao esta no VIP"

  fi
}

#---------------------[ Options ]---------------------------

case "$1" in
  help|--help)
    help
  ;;

  restart)
    stopWOR
    startWOR
  ;;

  start)
     enableVip
  ;;

  stop)
     disableVip
  ;;

  startWOR)
    startWOR
  ;;

  stopWOR)
    stopWOR
  ;;

  status)
    status
  ;;

  enable)
    enableVip
  ;;

  disable)
    disableVip
  ;;

  *)
    help
  ;;
esac;
