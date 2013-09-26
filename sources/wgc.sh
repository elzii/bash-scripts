#!/bin/bash

# DEFAULTS
#=========================================
WGETDIRNAME="wget"
# WGETDEFAULTDIR="/Users/`whoami`/Dropbox/Development/$WGETDIRNAME"
WGETDEFAULTDIR="/Users/`whoami`/$WGETDIRNAME"
# REV=""
# L=""
# NP=""
# CL=""
# PR=""
# WURL=""

# COLORS
# ==============================================
C_DEFAULT="\033[0m"
C_PINK="\033[35m"
C_GREEN="\033[32m"
C_ORANGE="\033[33m"
C_AQUA="\033[36m"
C_RED="\033[31m"

# DIRECTORY SELECT
# ==============================================
echo ""
echo -ne  "CHOOSE WGET DOWNLOAD DIRECTORY $C_PINK(default directory is $WGETDEFAULTDIR)$C_DEFAULT [$C_GREEN (1) auto  $C_ORANGE(2) list $C_AQUA(3) new $C_DEFAULT] > "; read DEFAULTDIR
echo -e "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"

# (1) DEFAULT DIR
if [[ "$DEFAULTDIR" = auto || "$DEFAULTDIR" = a || "$DEFAULTDIR" = 1 || "$DEFAULTDIR" = "" ]] ; then
	# check if directory does not exit
	if [ ! -d "$WGETDEFAULTDIR" ]; then
		cd "$WGETDEFAULTDIR"
		mkdir "$WGETDEFAULTDIR"
	else
		cd "$WGETDEFAULTDIR"
	fi

  echo -e "$C_GREEN(1)auto$C_DEFAULT - the auto (default) select directory is $C_PINK $WGETDEFAULTDIR $C_DEFAULT"
	echo ""
	cd "$WGETDEFULTDIR"

# (2) LIST DIR
elif [[ "$DEFAULTDIR" = list  || "$DEFAULTDIR" = l || "$DEFAULTDIR" = 2 ]] ; then

	echo ""
    echo -e "select an existing directory in \033[35m($WGETDEFAULTDIR)$C_DEFAULT"
    select d in */; do test -n "$d" && break; echo ">>> Invalid Selection"; done
	cd "$d" && pwd

# (3) NEW DIR
elif [[ "$DEFAULTDIR" = new  || "$DEFAULTDIR" = n || "$DEFAULTDIR" = 3 ]] ; then

	echo -ne "ENTER A NEW DIRECTORY NAME $C_PINK(will be created in from ~/)$C_DEFAULT > "; read NEWDIR
	mkdir "/Users/`whoami`/$NEWDIR"
	cd "/Users/`whoami`/$NEWDIR"

else
   echo -e "You must answer \033[32mYES (yes, y, Y)$C_DEFAULT or \033[31mNO (no, n, N)$C_DEFAULT "
fi


# FUNCTIONS
#=========================================
wgc_recursive () {
	echo -ne "recursive? (-r)                                              \033[33m[\033[32mY\033[33m/\033[31mN\033[33m]$C_DEFAULT > "; read RECURSIVE
	if [[ "$RECURSIVE" = yes || "$RECURSIVE" = y || "$RECURSIVE" = Y || "$RECURSIVE" = "" ]] ; then
		R="-r"	
   		wgc_levels

	elif [[ "$RECURSIVE" = no  || "$RECURSIVE" = n || "$RECURSIVE" = N ]] ; then
		R=""
	    wgc_levels
	else
	   	echo -e "$C_REDERROR >> $C_DEFAULT - You must answer \033[32mYES (yes, y, Y)$C_DEFAULT or \033[31mNO (no, n, N)$C_DEFAULT "
	   	wgc_recursive
	fi
}
wgc_levels () {
	echo -ne "levels? (-l #) - max recursive depth, 0=infinite, 1=current) \033[33m[0-5]$C_DEFAULT > "; read LEVELNUM
	if [[ "$LEVELNUM" = 0 || "$LEVELNUM" = 1 || "$LEVELNUM" = 2 || "$LEVELNUM" = 3 || "$LEVELNUM" = 4 || "$LEVELNUM" = 5 ]] ; then
		LEV="-l $LEVELNUM"
		wgc_noparent
	elif [[ ! "$LEVELNUM" ]]; then
		echo -e "$C_GREEN ___________________________________________"
		echo -e " MESSAGE >> no depth chosen, defaulting to 1"
		echo -e " ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾ $C_DEFAULT"

		LEV="-l 1"
		wgc_noparent
	else
		echo -e "$C_RED ___________________________________"
		echo -e " ERROR >> enter a number betwen 0 to 5"
		echo -e " ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾ $C_DEFAULT"
		wgc_levels
	fi
}
wgc_noparent() {
	echo -ne "no parent? (--no-parent) - don't ascend to parent dir        \033[33m[\033[32mY\033[33m/\033[31mN\033[33m]$C_DEFAULT > "; read NOPARENT
	if [[ "$NOPARENT" = yes || "$NOPARENT" = y || "$NOPARENT" = Y || "$NOPARENT" = "" ]] ; then
    NP="--no-parent"
    wgc_convertlinks

	elif [[ "$NOPARENT" = no  || "$NOPARENT" = n || "$NOPARENT" = N ]] ; then
		NP=""
	    wgc_convertlinks
	else
	   	echo -e "$C_RED ___________________________________"
	   	echo -e " ERROR >> invalid. YES or NO?"
	   	echo -e " ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾ $C_DEFAULT"
	   	wgc_noparent
	fi
}
wgc_convertlinks() {
	echo -ne "convert links? (-k) - point to local files after dl          \033[33m[\033[32mY\033[33m/\033[31mN\033[33m]$C_DEFAULT > "; read CONVERTLINKS
	if [[ "$CONVERTLINKS" = yes || "$CONVERTLINKS" = y || "$CONVERTLINKS" = Y || "$CONVERTLINKS" = "" ]] ; then
	CL="-k"	
    wgc_pagereqs

	elif [[ "$CONVERTLINKS" = no  || "$CONVERTLINKS" = n || "$CONVERTLINKS" = N ]] ; then
		$CL=""
	    wgc_pagereqs
	else
	  echo -e "$C_RED ___________________________________"
	  echo -e " ERROR >> invalid. YES or NO?"
	  echo -e " ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾ $C_DEFAULT"

	  wgc_convertlinks
	fi
}
wgc_pagereqs () {
	echo -ne "page requirements? (-p) - get images, etc needed to display  \033[33m[\033[32mY\033[33m/\033[31mN\033[33m]$C_DEFAULT > "; read PAGEREQS
	if [[ "$PAGEREQS" = yes || "$PAGEREQS" = y || "$PAGEREQS" = Y  || "$PAGEREQS" = "" ]] ; then
    PR="-p"
    wgc_url

	elif [[ "$PAGEREQS" = no  || "$PAGEREQS" = n || "$PAGEREQS" = N ]] ; then
	    PR=""
	    wgc_url
	else
		echo -e "$C_RED ___________________________________"
		echo -e " ERROR >> invalid. YES or NO?"
		echo -e " ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾ $C_DEFAULT"
	   	wgc_pagereqs
	fi
}
wgc_url () {
	echo -ne "URL? - enter the url that you wish to download contents of         > "; read WGETURL
    if [[ "$WGETURL" = "" ]] ; then
    	echo -e "$C_RED ______________________________"
    	echo -e " ERROR >> you must supply a URL"
    	echo -e " ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾ $C_DEFAULT"
    	wgc_url
	else
		WURL="$WGETURL"
	   	wgc_confirm
	fi
}
wgc_confirm () {
	echo -ne "run\033[36m wget $R $LEV $NP $CL $PR $WURL$C_DEFAULT ? \033[33m[\033[32mY\033[33m/\033[31mN\033[33m]$C_DEFAULT > "; read CONFIRM
	if [[ "$CONFIRM" = yes || "$CONFIRM" = y || "$CONFIRM" = Y || "$CONFIRM" = "" ]] ; then
    do_wget

	elif [[ "$CONFIRM" = no  || "$CONFIRM" = n || "$CONFIRM" = N ]] ; then
	    exit
	else
	   echo -e "\033[31m*----------------------------------------------------------*$C_DEFAULT"
	   echo -e "\033[33mERROR >> $C_DEFAULT - You must answer \033[32mYES (yes, y, Y)$C_DEFAULT or \033[31mNO (no, n, N)$C_DEFAULT " 
	   echo -e "\033[33m*----------------------------------------------------------*$C_DEFAULT"
	   wgc_confirm
	fi
}
do_wget () {
	wget $R $LEV $NP $CL $PR $WURL
	open_dir
}
open_dir() {
	open .
}


# EXECUTE FIRST FUNCTION
#=========================================
wgc_recursive

# EX OUTPUT
#=========================================
# wget -r -l1 --no-parent -k -p $cloneurl


echo -e "\033[32mCOMPLETE$C_DEFAULT - "


