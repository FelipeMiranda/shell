function clone(){
VAR=$1
	if [ ! -n $1 ] ; then
		echo -en "Usar com um parametro de repositório clone $red repo $normal"
	else
		echo -en "Clonando repositório $red git@github.com:quirinobytes/$1.git $green \n"
		git clone git@github.com:quirinobytes/$1.git
		echo -en $normal
	fi
}

