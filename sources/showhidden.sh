#!/bin/bash
# Name:	showhidden.sh
# Desc: toggle finder hidden files view on/off

# BEGIN 
# ==============================================
echo -e "\033[1;37;42m                                                             \033[1;37;40m"
echo -e "\033[1;37;42m     \033[1;31;42mgshowhidden.sh\033[1;37;42m - toggle finder to show hidden files     \033[1;37;40m"
echo -e "\033[1;37;42m                                                             \033[1;37;40m"

# FUNCTIONS 
# ==============================================
show_hidden () {
  #defaults write com.apple.finder AppleShowAllFiles TRUE
  set -x
  /usr/bin/defaults write com.apple.finder AppleShowAllFiles TRUE
  killall finder
  set +x
}

hide_hidden () {
  set -x
	/usr/bin/defaults write com.apple.finder AppleShowAllFiles FALSE
  killall finder
  set +x
}

# VARS
# ==============================================
SHOWORHIDE=''


# DIRECORY 
# ==============================================
echo -ne  "do you want to \033[32m[1] show\033[37m or \033[31m[2] hide\033[37m hidden files > "; read SHOWORHIDE

if [[ "$SHOWORHIDE" = show || "$SHOWORHIDE" = s || "$SHOWORHIDE" = 1 ]] ; then
	show_hidden
	echo "ok, hidden files are shown now. restarting finder."
elif [[ "$SHOWORHIDE" = hide  || "$SHOWORHIDE" = h || "$SHOWORHIDE" = 2 ]] ; then
    hide_hidden
    echo "ok, hidden files are hidden again. restarting finder."
else
   echo -e "you didn't pick one! exiting..."
   exit
fi
