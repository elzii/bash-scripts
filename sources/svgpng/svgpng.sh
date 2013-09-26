#!/bin/bash
# This is a program that keeps your address book up to date.

echo "Hello, "$USER".  Let's convert some SVGs."

echo -n "Enter the filename of the svg without the extension and press [ENTER]: "
read svgfilename

inkscape --export-png $svgfilename.png -w 512 -h 512 $svgfilename.svg

echo "complete"
