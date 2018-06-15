#!/bin/bash

ARQUIVO=$1
POSICAO=$2
TEXTO=`cat $3`

sed -i -e  $POSICAO'i '"$TEXTO" ../../lista/$ARQUIVO
