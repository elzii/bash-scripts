#!/bin/bash

# make a multi-layer favicon.ico via ImageMagick
# todo 
#  maybe convert to Perl with Image::Magick ?
#  check if image has 1:1 aspect ratio, warn if not
#  ensure image file is sane size

FILE=$1
EXT=`echo $1 | awk -F . '{print $NF}'`
BASE=`basename $FILE .$EXT`
shopt -s nocasematch

if [ -f $FILE ];
then
    case "$EXT" in 
        jpg | gif)
            echo Hint: non-png files are suboptimal
            echo Creating  $BASE.ico 
        ;;
        png )
            echo Good, a png file, creating $BASE.ico
        ;;
        *)
            echo Must use a jpg, gif, or \(preferred\) png image
            exit
        ;;
    esac
else
    echo no file $FILE
    exit
fi 

SIZES=""
for SIZE in 16 32 64 128
do 
    convert -resize x$SIZE $FILE -background transparent $BASE-${SIZE}.png
    if [ $SIZES ];
    then
        SIZES=$SIZES,$SIZE
    else
        SIZES=$SIZE
    fi
done
convert $BASE-{$SIZES}.png -background transparent -colors 256 $BASE.ico
rm $BASE-{$SIZES}.png 