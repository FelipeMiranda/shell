#!/bin/bash


if [ ! -z $1 ] ; then
MINIMAN_FILENAME=$1.md
else
	echo "Usar $$ novo_arquivo_miniman"
	exit 0
fi


cd /$USER/help/Linux/help
cp model.md $MINIMAN_FILENAME
sed -i "s/model/$MINIMAN_FILENAME/g" $MINIMAN_FILENAME
cd -



