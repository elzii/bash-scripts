#!/bin/bash

help__() {
        echo
		echo "USAGE: ${0} http[s]://host[:port] [CookieFile]"
}

: ${1? "Host Missing $(help__)"}

HOST=$1
COOKIE=""

if [ "$2" != "" ]
then
	COOKIE="--load-cookies=$2"
fi

wget -t 1 -e robots=off $COOKIE -r -nd --spider --no-check-certificate $HOST 2>&1 | while read line 
			do
				echo "$line" | grep -P "\-\-\d{4}" | cut -d " " -f 4
			done
