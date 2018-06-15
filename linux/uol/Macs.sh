TIME=25
if [ -z $1 ]; then 
 while(true) do 
    macs mon status -m email -a critical  | awk '{ printf("\033[32m %s\033[0;0m\t%s\t%s\t%s ->\t\033[36;1m %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s\033[0;0m\n",$3,$5,$7,$8,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24,$25) }' | cut -c-$((`tput cols`-15)) | tee /M.log
    #macs mon status -m email -a critical  | awk '{ printf("\033[32m %s\033[0;0m\t%s\t\033[33;1m %s\033[0;0m\t%s ->\t\033[36;1m %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s\033[0;0m\n",$3,$5,$7,$8,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24,$25) }' | column -t | cut -c-$((`tput cols`-15)) 
    #macs mon status -m email -a critical  |  cut -d ' ' -f3,5,7,8,10 | cut -c-`tput cols`
    #macs mon status -m email -a critical  #| awk '{ printf("%s\t%s \t %s \t %s -> %s \n",$3,$4,$8,$9,$10) }' | cut -c-`tput cols`
	 #for ((c=0;$c<`tput cols`;c=$c+1)) ; do echo -en "\e[44;33;1m \e[0;0m" ; done
	 for ((c=0;$c<`tput cols`;c=$c+1)) ; do echo -en _ ; done
	 sleep $TIME
	 clear
 done
else
	macs mon status -m email -a critical -i $1 | column
	 for ((c=0;$c<`tput cols`;c=$c+1)) ; do echo -en "\e[44;33;1m \e[0;0m" ; done
fi
