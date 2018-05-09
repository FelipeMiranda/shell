#!/bin/bash

if   [ ! -z "$1" -a -z "$2" ]; then
	egrep -i $1 --color
	exit
elif [ ! -z "$2" -a -z "$3" ]; then
	egrep -i "$1|$2" --color
	exit
elif [ ! -z "$3" -a -z "$4" ]; then
	egrep -i "$1|$2|$3" --oclor
	exit
elif [ ! -z $4 ]; then
	egrep -i "$1|$2|$3|$4" --color
fi
