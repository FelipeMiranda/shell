TIME=1
if [ -z $1 ]; then 
 while(true) do 
    macs mon status -m email -a critical 
	 sleep $TIME
	 clear
 done
else
	macs mon status -m email -a critical -i $1 | column
fi
