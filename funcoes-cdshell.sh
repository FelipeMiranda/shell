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


function cloneall(){
CURRENT_DIR=$PWD
cd

for repoName in `cat $CDSHELL/all-gitRepoNames.txt` ; do 
    if [ ! -d $repoName ]; then
	git clone git@github.com:quirinobytes/$repoName.git
    else
	echo -en "Repositório: $green $repoName $red já existe! $normal\n" 
    fi
done
cd $CURRENT_DIR
}
