#!/bin/bash

echo -n "Enter the filename of the svg without the extension and press [ENTER]: "
read svgfilename

inkscape --export-png $svgfilename.png -w 512 -h 512 $svgfilename.svg

echo "complete"
