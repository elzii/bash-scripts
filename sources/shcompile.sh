#!/bin/bash

echo -e "-------------------------------------------------------------------"
echo -e "\033[36m shcompile \033[37m - compile a shell script into an executable"
echo -e "-------------------------------------------------------------------"

cd ~/Dropbox/Development/bash/sources/
ls *.sh

echo -e -n "script to compile? (omit .sh extension) > "
read shscript

echo -e -n "compiling $shscript.sh to $shscript"

chmod +x $shscript.sh
shc -v -r -T -f $shscript.sh
rm $shscript.sh.x.c
mv $shscript.sh.x ../$shscript
cd ../

source ~/.bash_profile
echo -e "\033[32m COMPLETE \033[37m - \031[32m$shscript.sh \033[33m >> \033[35m $shscript"
ls