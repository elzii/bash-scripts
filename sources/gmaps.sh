#!/bin/sh

echo "where to?"
read F1
F=`echo $F1 | sed s/\ /+/g`

open "http://maps.google.com/maps?f=q&hl=en&q=$F"
