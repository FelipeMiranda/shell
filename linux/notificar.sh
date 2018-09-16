#/bin/bash

OUTPUT=/dev/pts/1

while(true); do
    sleep 1;
    pgrep install.sh
    if [ $? == 1 ]; then
		echo -en "\033\0143" > $OUTPUT
		echo -en "\n\n$alert Instalaçao CDSHELL $normal  ->  $green DONE $normal \n\n" > $OUTPUT
		exit 0
    fi
done


