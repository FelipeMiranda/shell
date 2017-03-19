#!/bin/bash



if [ ! -z $1 ] ; then
MINIMAN_FILENAME=$1.md
MINIMAN_NAME=$1
else
	echo "Usar $$ novo_arquivo_miniman"
	exit 1
fi


cd /$USER/help/Linux/help
cp model.md $MINIMAN_FILENAME
sed -i "s/model/$MINIMAN_NAME/g" $MINIMAN_FILENAME
cd -
