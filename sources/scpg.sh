#!/bin/bash

# BEGIN 
# ==============================================
echo -e "\033[1;37;42m                                              \033[1;37;40m"
echo -e "\033[1;37;42m     \033[1;36;42mscpg.sh\033[1;37;42m - a guided scp script   \033[1;37;40m"
echo -e "\033[1;37;42m                                              \033[1;37;40m"

# DEFAULTS
#=========================================


# DIRECORY 
# ==============================================
echo -ne  "choose wget download directory \033[35m($WGETDEFAULTDIR)\033[37m  [\033[32mauto - 1\033[37m  \033[33mlist - 2  \033[36mnew - 3\033[37m]  > "; read DEFAULTDIR
cd "$WGETDEFAULTDIR"

if [[ "$DEFAULTDIR" = auto || "$DEFAULTDIR" = a || "$DEFAULTDIR" = 1 || "$DEFAULTDIR" = "" ]] ; then
	echo ""
    echo -e "\033[32mauto\033[37m - the auto select directory is \033[36m $WGETDEFAULTDIR \033[37m"
    echo -n "-------------------------------------------------------------------------" 
	echo ""
	cd "$WGETDEFULTDIR"

elif [[ "$DEFAULTDIR" = list  || "$DEFAULTDIR" = l || "$DEFAULTDIR" = 2 ]] ; then

	echo ""
    echo -e "select an existing directory in \033[35m($WGETDEFAULTDIR)\033[37m"
    select d in */; do test -n "$d" && break; echo ">>> Invalid Selection"; done
	cd "$d" && pwd

elif [[ "$DEFAULTDIR" = new  || "$DEFAULTDIR" = n || "$DEFAULTDIR" = 3 ]] ; then

	echo -e "new folder name > "; read NEWDIR
	mkdir "$NEWDIR"
	cd "$NEWDIR"

else
	echo -e "\033[33m*----------------------------------------------------------*\033[37m"
   	echo -e "You must answer \033[32mYES (yes, y, Y)\033[37m or \033[31mNO (no, n, N)\033[37m "
   	echo -e "\033[33m*----------------------------------------------------------*\033[37m"
fi


# FUNCTIONS
#=========================================
wgc_recursive () {
	echo -ne "recursive? (-r)                                              \033[33m[\033[32mY\033[33m/\033[31mN\033[33m]\033[37m > "; read RECURSIVE
	if [[ "$RECURSIVE" = yes || "$RECURSIVE" = y || "$RECURSIVE" = Y || "$RECURSIVE" = "" ]] ; then
		R="-r"	
   		wgc_levels

	elif [[ "$RECURSIVE" = no  || "$RECURSIVE" = n || "$RECURSIVE" = N ]] ; then
		R=""
	    wgc_levels
	else
		echo -e "\033[33m*----------------------------------------------------------*\033[37m"
	   	echo -e "\033[31mInvalid\033[37m - You must answer \033[32mYES (yes, y, Y)\033[37m or \033[31mNO (no, n, N)\033[37m "
	   	echo -e "\033[33m*----------------------------------------------------------*\033[37m"
	   	wgc_recursive
	fi
}
wgc_levels () {
	echo -ne "levels? (-l #) - max recursive depth, 0=infinite, 1=current) \033[33m[0-5]\033[37m > "; read LEVELNUM
	if [[ "$LEVELNUM" = 0 || "$LEVELNUM" = 1 || "$LEVELNUM" = 2 || "$LEVELNUM" = 3 || "$LEVELNUM" = 4 || "$LEVELNUM" = 5 ]] ; then
		LEV="-l $LEVELNUM"
		wgc_noparent
	else 
		echo -e "\033[33m*----------------------------------------------------------*\033[37m"
		echo -e "\033[31m*INVALID*\033[37m >> Enter a number betwen 0 to 5"
		echo -e "\033[33m*----------------------------------------------------------*\033[37m"
		wgc_levels
	fi
}
wgc_noparent() {
	echo -ne "no parent? (--no-parent) - don't ascend to parent dir        \033[33m[\033[32mY\033[33m/\033[31mN\033[33m]\033[37m > "; read NOPARENT
	if [[ "$NOPARENT" = yes || "$NOPARENT" = y || "$NOPARENT" = Y || "$NOPARENT" = "" ]] ; then
    NP="--no-parent"
    wgc_convertlinks

	elif [[ "$NOPARENT" = no  || "$NOPARENT" = n || "$NOPARENT" = N ]] ; then
		NP=""
	    wgc_convertlinks
	else
		echo -e "\033[33m*----------------------------------------------------------*\033[37m"
	   	echo -e "\033[33m*INVALID*\033[37m - You must answer \033[32mYES (yes, y, Y)\033[37m or \033[31mNO (no, n, N)\033[37m "
	   	echo -e "\033[33m*----------------------------------------------------------*\033[37m"
	   	wgc_noparent
	fi
}
wgc_convertlinks() {
	echo -ne "convert links? (-k) - point to local files after dl          \033[33m[\033[32mY\033[33m/\033[31mN\033[33m]\033[37m > "; read CONVERTLINKS
	if [[ "$CONVERTLINKS" = yes || "$CONVERTLINKS" = y || "$CONVERTLINKS" = Y || "$CONVERTLINKS" = "" ]] ; then
	CL="-k"	
    wgc_pagereqs

	elif [[ "$CONVERTLINKS" = no  || "$CONVERTLINKS" = n || "$CONVERTLINKS" = N ]] ; then
		$CL=""
	    wgc_pagereqs
	else
		echo -e "\033[33m*----------------------------------------------------------*\033[37m"
	   	echo -e "\033[31m*INVALID*\033[37m - You must answer \033[32mYES (yes, y, Y)\033[37m or \033[31mNO (no, n, N)\033[37m "
	   	echo -e "\033[33m*----------------------------------------------------------*\033[37m"
	   	wgc_convertlinks
	fi
}
wgc_pagereqs () {
	echo -ne "page requirements? (-p) - get images, etc needed to display  \033[33m[\033[32mY\033[33m/\033[31mN\033[33m]\033[37m > "; read PAGEREQS
	if [[ "$PAGEREQS" = yes || "$PAGEREQS" = y || "$PAGEREQS" = Y  || "$PAGEREQS" = "" ]] ; then
    PR="-p"
    wgc_url

	elif [[ "$PAGEREQS" = no  || "$PAGEREQS" = n || "$PAGEREQS" = N ]] ; then
	    PR=""
	    wgc_url
	else
		echo -e "\033[33m*----------------------------------------------------------*\033[37m"
	   	echo -e "\033[31m*INVALID*\033[37m - You must answer \033[32mYES (yes, y, Y)\033[37m or \033[31mNO (no, n, N)\033[37m " 
	   	echo -e "\033[33m*----------------------------------------------------------*\033[37m"
	   	wgc_pagereqs
	fi
}
wgc_url () {
	echo -ne "URL? - enter the url that you wish to download contents of         > "; read WGETURL
    if [[ "$WGETURL" = "" ]] ; then
    	echo -e "\033[33m*----------------------------------------------------------*\033[37m"
    	echo -e "\033[31m*INVALID*\033[37m - You must enter a URL "
    	echo -e "\033[33m*----------------------------------------------------------*\033[37m"
    	wgc_url
	else
		WURL="$WGETURL"
	   	wgc_confirm
	fi
}
wgc_confirm () {
	echo -ne "run\033[36m wget $R $LEV $NP $CL $PR $WURL\033[37m ? \033[33m[\033[32mY\033[33m/\033[31mN\033[33m]\033[37m > "; read CONFIRM
	if [[ "$CONFIRM" = yes || "$CONFIRM" = y || "$CONFIRM" = Y || "$CONFIRM" = "" ]] ; then
    do_wget

	elif [[ "$CONFIRM" = no  || "$CONFIRM" = n || "$CONFIRM" = N ]] ; then
	    exit
	else
	   echo -e "\033[31m*----------------------------------------------------------*\033[37m"
	   echo -e "\033[33m*INVALID*\033[37m - You must answer \033[32mYES (yes, y, Y)\033[37m or \033[31mNO (no, n, N)\033[37m " 
	   echo -e "\033[33m*----------------------------------------------------------*\033[37m"
	   wgc_confirm
	fi
}
do_wget () {
	wget $R $LEV $NP $CL $PR $WURL
}



# EXECUTE FIRST FUNCTION
#=========================================
wgc_recursive

# EX OUTPUT
#=========================================
# wget -r -l1 --no-parent -k -p $cloneurl


echo -e "\033[32mCOMPLETE\033[37m - "


