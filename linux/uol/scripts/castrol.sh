#!/bin/bash 

LNGCTL=/bin/linguemctl
LNGSH=/export/scripts/linguem.sh
CONT=0

HS_FORA=$($LNGCTL hs show all | grep -v threads)

if [ ! -z $HS_FORA ] ; then 
	echo ${HS_FORA%-*}
fi

for HOST in ${HS_FORA%-*}
do 

STATUS=$(sudo -u linguem ssh $HOST 'sudo /export/scripts/linguem.sh status')

if [ `echo $STATUS | grep -q 'not running'` ] ; then
	#echo "não deve ligar"
	echo $CONT++
else
	#echo "ligando $HOST"
	sudo -u linguem ssh $HOST 'sudo /export/scripts/linguem.sh realkill --force'
	sleep 2
	sudo -u linguem ssh $HOST 'sudo /export/scripts/linguem.sh start'
	if [ $? == 0 ] ; then
		echo "Host $HOST reiniciado !!!"
		echo $(date '+%D %r') - $HOST >> /export/logs/castrol.log
	fi
	
fi

done 
