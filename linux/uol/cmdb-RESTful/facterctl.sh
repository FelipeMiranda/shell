#!/bin/bash

# Documentation api:
# https://confluence.intranet.uol.com.br/confluence/display/QPD/API+macs-inventory

#bin
CURL=$(which curl)
JQ=$(which jq)
SED=$(which sed)
EGREP=$(which egrep)
AWK=$(which awk)
TR=$(which tr)

#jq install
    if [ -z $JQ ]; then 
      echo
      printf "  Ops, install jq to parser json: \n"
      printf "  https://stedolan.github.io/jq/download/ \n"
      echo
      exit 1
    fi

#api
API_URL="https://api.macs.intranet/inventory/customers/uolcs"

#usage
usage (){
    script_name=`basename $0`
    echo
    printf "HowTo: $script_name\n"
    printf "[mandatory] \n"
    printf "  -t <type - sys|cpu|mem|disk|eth|pkg|mnt|net|phy|hw> \n"
    printf "  -n <hostname> \n"
    printf "[optional] \n"
    printf "  -s <size> \n"
    printf "  -h help \n"
    printf "[type] \n"
    printf "  <sys>  view operating_system \n"
    printf "  <cpu>  view cpu <logical;physical> \n"
    printf "  <mem>  view ram <mb> \n"
    printf "  <disk> view disk <gb> \n"
    printf "  <eth>  view interfaces <alias;ip> \n"
    printf "  <pkg>  view package <name-version-releasea-arch> \n"
    printf "  <mnt>  view mounts <filesystem;device;mountpoint> \n"
    printf "  <net>  view net listen port <service;address;port> \n"
    printf "  <phy>  view type <vmware/physical> \n"
    printf "  <hw>   view vendor hardware \n"
    echo
    exit 1;
}

#args
  if [ -z $1 ]; then
    usage
  else
    while getopts "ht:n:s:" opt; do
      case ${opt} in
        t) TYPE="${OPTARG}" ;;
        n) if [[ $OPTARG = -* ]]; then ((OPTIND--)) ; continue ; fi ; HOST=${OPTARG} ;;
        s) if [[ $OPTARG = -* ]]; then ((OPTIND--)) ; continue ; fi ; SIZE=${OPTARG} ;;
        *) usage ;;
      esac
    done
  fi

system () {
    SO=$($CURL -s -k -X GET $API_URL/facts/facterfacts?"host=$1.host.intranet&name=operatingsystem" | \
    $JQ -r '.payload[0] .value.value')
      VERSION=$($CURL -s -k -X GET $API_URL/facts/facterfacts?"host=$1.host.intranet&name=operatingsystemrelease" | \
      $JQ -r '.payload[0] .value.value')
        ARCH=$($CURL -s -k -X GET $API_URL/facts/facterfacts?"host=$1.host.intranet&name=architecture" | \
        $JQ -r '.payload[0] .value.value')
    echo "so-$SO-$VERSION-$ARCH" |$TR '[:upper:]' '[:lower:]'
}

microprocessor (){
    PROCESSOR_COUNT=$($CURL -s -k -X GET $API_URL/facts/facterfacts?"host=$1.host.intranet&name=processorcount" | \
    $JQ -r '.payload[0] .value.value')
      PHYSICAL_COUNT=$($CURL -s -k -X GET $API_URL/facts/facterfacts?"host=$1.host.intranet&name=physicalprocessorcount" | \
      $JQ -r '.payload[0] .value.value')
    echo "$PROCESSOR_COUNT;$PHYSICAL_COUNT"
}

memory (){
    $CURL -s -k -X GET $API_URL/facts/facterfacts?"host=$1.host.intranet&name=memorysize_mb" | \
    $JQ -r '.payload[0] .value.value'
}

disk (){
    COLLECT_DISK=$($CURL -s -k -X GET $API_URL/facts/facterfacts?"host=$1.host.intranet&name=blockdevices" | \
    $JQ -r '.payload[0] .value.value' |$EGREP sd)
      for BLOCK in $COLLECT_DISK; do
        DISK=$($CURL -s -k -X GET $API_URL/facts/facterfacts?"host=$1.host.intranet&name=blockdevice_$BLOCK\_size" | \
        $JQ -r '.payload[0] .value.value' |$AWK {'print $1'/1024/1024/1024})
        echo "$BLOCK;$DISK" |$EGREP 'sd'
      done
}    

net (){
    COLLECT_ALIAS=$($CURL -s -k -X GET $API_URL/facts/facterfacts?"host=$1.host.intranet&name=interfaces" | \
    $JQ '.payload[0] .value.value' |$SED 's/,/ /g;s/"//g')
      for ALIAS in $COLLECT_ALIAS; do
        IP=$($CURL -s -k -X GET $API_URL/facts/facterfacts?"host=$1.host.intranet&name=ipaddress_$ALIAS" | \
        $JQ '.payload[0] .value.value' |$SED 's/,/ /g;s/"//g')
        echo "$ALIAS;$IP"
      done
}

package (){
    $CURL -s -k -X GET $API_URL/hosts/$1.host.intranet/packages?size=$2 | \
    $JQ -r '.payload[].value | [.name, .version, .release, .arch | tostring] | join("-")'
}

mounts (){
    $CURL -s -k -X GET $API_URL/hosts/$1.host.intranet/mounts?size=$2 | \
    $JQ -r '.payload[].value | [.fileSystem, .device, .mountPoint | tostring] | join(";")'
}

netlisten (){
    $CURL -s -k -X GET $API_URL/hosts/$1.host.intranet/netlistenings?size=$2 | \
    $JQ -r '.payload[].value | [.processName, .address, .port | tostring] | join(";")'
}

physical (){
    $CURL -s -k -X GET $API_URL/facts/facterfacts?"host=$1.host.intranet&name=virtual" | \
    $JQ -r '.payload[0] .value.value'
}

model (){
    $CURL -s -k -X GET $API_URL/facts/facterfacts?"host=$1.host.intranet&name=productname" | \
    $JQ -r '.payload[0] .value.value'
}

#type
    if [ "$TYPE" == "sys" ]; then
      system "$HOST"
    elif [ "$TYPE" == "cpu" ]; then 
  	  microprocessor "$HOST"
    elif [ "$TYPE" == "mem" ]; then 
      memory "$HOST"
    elif [ "$TYPE" == "disk" ]; then 
      disk "$HOST"
    elif [ "$TYPE" == "eth" ]; then 
      net "$HOST"
    elif [ "$TYPE" == "pkg" ]; then 
      package "$HOST" "$SIZE"
    elif [ "$TYPE" == "mnt" ]; then
      mounts "$HOST" "$SIZE"
    elif [ "$TYPE" == "net" ]; then
      netlisten "$HOST" "$SIZE"
    elif [ "$TYPE" == "phy" ]; then
      physical "$HOST"
    elif [ "$TYPE" == "hw" ]; then
      model "$HOST"
    fi
