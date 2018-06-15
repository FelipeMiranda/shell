#!/bin/bash
tail -n 12 -s 0.5 -f /var/log/squid/access.log | awk '{ printf strftime("%H:%M %d/%m ") } $0' | awk '

	

	$3   ~ 'DENIED' {printf "\033[1;31m"$15"\033[1;30m\t"$10"\t\033[1;38m"$11"\t"$12"\t\033[1;32m"$13"\t\033[1;34m %s \n",$14}
	$3 !~ 'DENIED' {printf "\033[1;31m"$15"\033[1;30m\t"$10"\t"$11"\t"$12"\t\033[1;32m"$13"\t\033[1;34m %s \n",$14}
   
	
	
	
	'




	#$1!='mariana' printf "\033[1;31m"$15"\033[1;30m\t"$10"\t"$11"\t"$12"\t\033[1;32m"$13"\t\033[1;34m"$14"\n"
