#!/bin/bash
# Name:	gitc.sh
# Desc: easy to use git clone (as if it wasn't easy enough already)

# BEGIN 
# ==============================================
echo -e "\033[1;37;42m                                              \033[1;37;40m"
echo -e "\033[1;37;42m     \033[1;31;42mgitc.sh\033[1;37;42m - clone a git repo with ease     \033[1;37;40m"
echo -e "\033[1;37;42m                                              \033[1;37;40m"

# FUNCTIONS 
# ==============================================
clone_repo () {
	git clone https://github.com/$1/$2/ $3
}
author_proj () {
	echo -ne  "repo author? (ex: https://github.com/\033[35melzii\033[37m/fblp/) > "
	read author
	echo -ne  "project name? (ex: https://github.com/elzii/\033[35mfblp\033[37m/) > "
	read proj

	local authorandproj=$author'/'$proj

	echo "  "
	echo -ne "Author/Project:\033[35m $authorandproj \033[37m"

	clone_repo $author $proj $CLONEDIR
}


# DEFAULTS 
# ==============================================
GITDIRNAME="git-repos"
CLONEDIR="/Users/`whoami`/Dropbox/Development/$GITDIRNAME"
DEFAULTDIR=y


# DIRECORY 
# ==============================================
echo -ne  "clone to default directory? \033[35m($CLONEDIR)\033[37m  [\033[32my\033[37m/\033[31mn\033[37m]  > "; read DEFAULTDIR


if [[ "$DEFAULTDIR" = yes || "$DEFAULTDIR" = y || "$DEFAULTDIR" = Y ]] ; then
	echo ""
    echo -e "you answered \033[32mYes\033[37m, the default directory is \033[36m $CLONEDIR \033[37m"
    echo -n "-----------------------------------------------------------------" 
	echo ""
    author_proj

elif [[ "$DEFAULTDIR" = no  || "$DEFAULTDIR" = n || "$DEFAULTDIR" = n ]] ; then
    echo ""
    echo -ne "alternative directory? \033[35m(full path or relative to current)\033[37m > "; read altdir
    mkdir $altdir
    CLONEDIR=$altdir
    author_proj
else
   echo -e "You must answer \033[32mYES (yes, y, Y)\033[37m or \033[31mNO (no, n, N)\033[37m "
fi


# function DEFAULTDIR()
# {

#     echo -ne  "clone to default directory? \033[30m~/gitrepos033[37m \033[33m[\033[32my\033[33m/\033[31mn\033[33m]\033[37m > "
	
# 	if 
# }
