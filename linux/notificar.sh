#/bin/bash

OUTPUT=/dev/pts/1

while(true); do
    sleep 1;
    pgrep install.sh > /dev/null
    if [ $? -ne 0 ]; then
		echo -en "\033\0143" > $OUTPUT
		echo -en "\n\n$alert Instalaçao CDSHELL $normal  ->  $green DONE $normal \n\n" > $OUTPUT
		screen -t instalado -X split -v
		screen -p instalado -X focus
		screen -X screen -t teste -p 2 /root/shell/linux/-t
		exit 0
    fi
done


