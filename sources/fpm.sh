#!/bin/bash

# vars
HOMEDIR="/Users/`whoami`"
TEMPDIR="/Users/`whoami`/temp/fpm_temp"
WP_THEMEDIR="wp-content/themes/"
USERNAME="`whoami`"

# colors
C_DEFAULT="\033[0m"
C_RED="\033[31m"
C_GREEN="\033[32m"
C_ORANGE="\033[33m"
C_BLUE="\033[34m"
C_PINK="\033[35m"
C_AQUA="\033[36m"
C_WHITE="\033[37m"

# if no parameter is passed, run the installer
  echo -e ""
  echo -ne "$C_ORANGE Running depedency check... $C_DEFAULT \n"
  echo -e " ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"

    # init missing dependecies array
    MISSING_DEP=()

    # check deps
    # -------------------------------------------------------------------------------

    # wget
    if [[ -f "/usr/local/bin/wget" ]]; then 
      echo -ne "$C_BLUE wget $C_DEFAULT installed $C_ORANGE>>> $C_WHITE"
      which wget 
      echo -ne "$C_DEFAULT"
    else MISSING_DEP+=('wget'); fi
    # curl
    if [[ -f "/usr/bin/curl" ]]; then 
      echo -ne "$C_BLUE curl $C_DEFAULT installed $C_ORANGE>>> $C_WHITE"
      which curl 
      echo -ne "$C_DEFAULT"
    else MISSING_DEP+=('curl'); fi
    # rvm
    if [[ -d "$HOMEDIR/.rvm" ]]; then 
      echo -ne "$C_BLUE rvm  $C_DEFAULT installed $C_ORANGE>>> $C_WHITE"
      which rvm 
      echo -ne "$C_DEFAULT"
    else MISSING_DEP+=('rvm'); fi
    # node
    if [[ -f "/usr/local/bin/node" ]]; then 
      echo -ne "$C_BLUE node $C_DEFAULT installed $C_ORANGE>>> $C_WHITE"
      which node 
      echo -ne "$C_DEFAULT"
    else MISSING_DEP+=('node'); fi
    # npm
    if [[ -f "/usr/local/bin/npm" ]]; then 
      echo -ne "$C_BLUE npm  $C_DEFAULT installed $C_ORANGE>>> $C_WHITE"
      which npm 
      echo -ne "$C_DEFAULT"
    else MISSING_DEP+=('npm'); fi
    # brew
    if [[ -f "/usr/local/bin/brew" ]]; then 
      echo -ne "$C_BLUE brew $C_DEFAULT installed $C_ORANGE>>> $C_WHITE"
      which brew 
      echo -ne "$C_DEFAULT"
    else MISSING_DEP+=('brew'); fi
    # ruby
    if [[ -d "$HOMEDIR/.rvm/rubies" ]]; then 
      echo -ne "$C_BLUE ruby $C_DEFAULT installed $C_ORANGE>>> $C_WHITE"
      which ruby 
      echo -ne "$C_DEFAULT"
    else MISSING_DEP+=('ruby'); fi
    # git
    if [[ -f "/usr/local/bin/git" ]]; then 
      echo -ne "$C_BLUE git  $C_DEFAULT installed $C_ORANGE>>> $C_WHITE"
      which git 
      echo -ne "$C_DEFAULT"
    else MISSING_DEP+=('git'); fi

    # check if missing dep array is null
    if [ ${#MISSING_DEP[@]} = 0 ]; then
        echo -e " ___________________________"
        echo -ne "$C_GREEN All dependencies installed! $C_DEFAULT \n"
        echo -e ""
    # handle missing dependencies
    else
        echo -ne "$C_RED $MISSING_DEP $C_DEFAULT not installed \n"
        echo -e " ___________________________"

        # if RVM
        if [[ $MISSING_DEP == rvm ]]; then
          echo -e " Would you like to install $C_RED $MISSING_DEP$C_DEFAULT ?"; read INSTALL_RVM
          elif [[ "$INSTALL_RVM" = 1 || "$INSTALL_RVM" = y || "$INSTALL_RVM" = yes ]]; then
            curl -L https://get.rvm.io | bash
        fi

        # if brew
        if [[ $MISSING_DEP == brew ]]; then
          echo -e " Would you like to install $C_RED $MISSING_DEP$C_DEFAULT ?"; read INSALL_BREW
          elif [[ "$INSTALL BREW" = 1 || "$INSTALL BREW" = y || "$INSTALL BREW" = yes ]]; then
            ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
        fi
        
    fi

  # read inputs
  echo -ne ""
  echo -ne  "Download latest version of$C_AQUA Wordpress $C_DEFAULT   > "; read GET_WP
  echo -ne  "Get latest version of $C_RED Fifty Framework $C_DEFAULT > "; read GET_FFW
  echo -ne  "After preparing project, run$C_GREEN GIT INIT $C_DEFAULT  > "; read GET_FFW
  echo -ne ""

  #
  # fpm_get_ffw()
  # get latest version of fifty-framework from github, clone it into theme directory
  #
  fpm_get_wp() {

    # GET_WP = 1,y,yes
    # --------------------------------------------------------------------
    if [[ "$GET_WP" = 1 || "$GET_WP" = y || "$GET_WP" = yes ]] ; then

      # make temp dir if it doesnt exist, get wp latest, extract it and delete temp folder
      mkdir -p $TEMPDIR                                         && \
      cd $TEMPDIR                                               && \
      curl -sS http://wordpress.org/latest.zip > wp_latest.zip  && \
      unzip wp_latest.zip                                       && \
      rm wp_latest.zip                                          && \
      
      cd -                                                      && \
      mv $TEMPDIR/wordpress ./                                  && \
      mv wordpress/* ./                                         && \
      rm -rf wordpress                                          && \

      fpm_get_ffw
     
    # GET_WP = 1,y,yes
    # --------------------------------------------------------------------
    elif [[ "$GET_WP" = 2  || "$GET_WP" = n || "$GET_WP" = no ]] ; then

      fpm_get_ffw

    # INCORRECT INPUT 
    # --------------------------------------------------------------------
    else
       echo -e "You must answer \033[32mYES (yes, y, 1)$C_DEFAULT or \033[31mNO (no, n, 2)$C_DEFAULT "
    fi  
  }


  #
  # fpm_get_ffw()
  # get latest version of fifty-framework from github, clone it into theme directory
  #
  fpm_get_ffw() {
    echo "cloning latest $C_RED Fifty Framework $C_DEFAULT into $WP_THEMEDIR"

    # GET_FFW = 1,y,yes
    # --------------------------------------------------------------------
    if [[ "$GET_FFW" = 1 || "$GET_FFW" = y || "$GET_FFW" = yes ]] ; then

      if [ -d "$WP_THEMEDIR" ]; then
        # theme dir doesnt exists, get wp first or something went wrong
        cd $WP_THEMEDIR
      fi

      git clone git@github.com:fiftyandfifty/fifty-framework    && \
      ls

    # GET_FFW = 2,n,no
    # --------------------------------------------------------------------
    elif [[ "$GET_FFW" = 2  || "$GET_FFW" = n || "$GET_FFW" = no ]] ; then

      echo "Backing out."

    # INCORRECT INPUT
    # --------------------------------------------------------------------
    else
       echo -e "You must answer \033[32mYES (yes, y, 1)$C_DEFAULT or \033[31mNO (no, n, 2)$C_DEFAULT "
    fi  

  }

  #
  # fpm_git_init
  # init git repository
  # 
  



  # run first function in chain
  fpm_get_wp


  # dir read
  while read dir 
  do
    [ -d "$dir" ] || die "Directory $dir does not exist"
    rm -rf "$dir"
  done 




# init first function
# fpm_get_wp

# complete
echo -e "\033[32mCOMPLETE$C_DEFAULT"