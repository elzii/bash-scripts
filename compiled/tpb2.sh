#!/bin/sh
search() {
  q="$*"
  q=`echo $q | tr ' ' '+'`
  results=`wget -U Mozilla -qO - "http://thepiratebay.org/search/$q/0/7/0" \
    | egrep -o '(http\:\/\/.*\.torrent)|(Size\ .*B\,)|([[:digit:]]*)' \
    | sed 's///g' \
    | sed 's/<\/td>//g' \
    | sed 's/Size\ //g' \
    | sed 's/\&nbsp\;//g' \
    | sed 's/\,//g' \
    | sed 's!http://torrents.thepiratebay.org!!g' \
    | sed ':a;N;$!ba;s/\n/\ /g' \
    | sed 's!\ \/!\n\/!g' \
    | sed 's/MiB\ /M\ /g' \
    | sed 's/GiB\ /G\ /g' \
    | sed 's/KiB\ /K\ /g' \
    | cat`
  IFS=$'\n'
  longest=0
  for line in $results
  do
    length=`echo "$line" | awk '{print $1}' | wc -L`
    if [ $length -gt $longest ]
    then
      longest=$length
    fi
  done
  nth=0
  for line in $results
  do
    whites=""
    length=`echo $line | awk '{print $1}' | wc -L`
    nth=`echo "$nth + 1" | bc -l`
    spaces=`echo "$longest + 1 - $length" | bc -l`
    for i in `seq 1 $spaces`
    do
      whites=`echo "$whites "`
    done
    torrent=`echo $line | awk '{print $1}' | sed 's!\/[[:digit:]]*\/!!' | sed 's!\.[[:digit:]]*\.TPB\.torrent!!' | sed 's/_/\ /g'`
    size=`echo $line | awk '{print $2}'`
    size=`printf '%10s' "$size"`
    seeds=`echo $line | awk '{print $3}'`
    seeds=`printf '%5s' "$seeds"`
    peers=`echo $line | awk '{print $4}'`
    peers=`printf '%5s' "$peers"`
    if [ $nth -lt 10 ]
    then
      nth=" $nth"
    fi
    echo -e "$nth  $torrent$whites\033[1;34m$size\t\033[1;31m$seeds\t\033[1;32m$peers\033[0m"
  done
}
download() {
  echo -n "Download? "
  read num
  if [ $num -eq 0 ]
  then
    exit 1
  else
    i=0
    for line in $results
    do
      i=`echo "$i + 1" | bc -l`
      if [ $i -eq $num ]
      then
        link=`echo "$line" | awk '{print $1}'`
        echo "Downloading torrent file."
        transmission-remote -a "http://torrents.thepiratebay.org$link"
        echo "Torrent added."
        exit 0
      fi
    done
  fi
}
search $*
download
unset IFS
exit 0