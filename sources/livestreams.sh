#!/bin/bash

# DEFAULTS
#=========================================
STREAM_URLS=(
  ['International Space Station']='http://www.ustream.tv/channel/live-iss-stream',
  ['TwitchTV: GTA V (sodapoppin)']='http://www.twitch.tv/sodapoppin'
)

# BEGIN 
# ==============================================
echo -ne  "choose a livestream"
echo -ne STREAM_URLS


# if [[ "$DEFAULTDIR" = auto || "$DEFAULTDIR" = a || "$DEFAULTDIR" = 1 || "$DEFAULTDIR" = "" ]] ; then
#   echo ""
#     echo -e "\033[32mauto\033[37m - the auto select directory is \033[36m $WGETDEFAULTDIR \033[37m"
#     echo -n "-------------------------------------------------------------------------" 
#   echo ""
#   cd "$WGETDEFULTDIR"

# elif [[ "$DEFAULTDIR" = list  || "$DEFAULTDIR" = l || "$DEFAULTDIR" = 2 ]] ; then

#   echo ""
#     echo -e "select an existing directory in \033[35m($WGETDEFAULTDIR)\033[37m"
#     select d in */; do test -n "$d" && break; echo ">>> Invalid Selection"; done
#   cd "$d" && pwd

# elif [[ "$DEFAULTDIR" = new  || "$DEFAULTDIR" = n || "$DEFAULTDIR" = 3 ]] ; then

#   echo -e "new folder name > "; read NEWDIR
#   mkdir "$NEWDIR"
#   cd "$NEWDIR"

# else
#   echo -e "\033[33m*----------------------------------------------------------*\033[37m"
#     echo -e "You must answer \033[32mYES (yes, y, Y)\033[37m or \033[31mNO (no, n, N)\033[37m "
#     echo -e "\033[33m*----------------------------------------------------------*\033[37m"
# fi


do_livestream () {
  wget $R $LEV $NP $CL $PR $WURL
}


# EXECUTE FIRST FUNCTION
#=========================================
wgc_recursive