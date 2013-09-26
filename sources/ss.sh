#!/bin/bash
userid="45845710"
myfile=$(date +%Y%m%d%S).png
scrot -s "/home/mononofu/Dropbox/public/$myfile" 
echo "http://dl.dropbox.com/u/$userid/$myfile | xclip -selection c
notify-send "Done"