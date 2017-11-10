
if [ -z $1 ]; then 
 forever.sh macs mon status -m email -a critical
else
	macs mon status -m email -a critical -i $1
fi
