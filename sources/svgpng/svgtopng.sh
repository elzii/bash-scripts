#!/bin/bash
# This is a program that keeps your address book up to date.

echo "Hello, "$USER".  Let's convert some SVGs. This script requires XQuarts"

echo -n "Enter the path to the file (with no trailing slash) and press [ENTER]: "
read exportpath

echo -n "Enter the filename of the svg without the extension and press [ENTER]: "
read svgfilename

echo -n "Specify WIDTH (in px) and press [ENTER]: "
read pngwidth

echo -n "Specify HEIGHT (in px) and press [ENTER]: "
read pngheight

inkscape --export-png $svgfilename.png -w $pngwidth -h $pngheight $exportpath/$svgfilename.svg

echo "Complete"
