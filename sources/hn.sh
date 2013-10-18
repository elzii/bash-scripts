#!/usr/bin/env sh

help()
{
  cat <<EOF

  NAME:
    hn -- Hacker News without leaving your terminal.

  SYNOPSIS:
    hn [-c] [-h] [-l LIMIT]

  OPTIONS:
    -c    Colorize the output.
    -l    Limit to LIMIT articles.
    -h    prints a summary of the help options.

  EXAMPLES:
    hn
      GoDaddy supports SOPA, redditor proposes "Move your Domain Day"
      http://www.reddit.com/r/politics/comments/nmnie/godaddy_supports_sopa_im_transferring_51_domains/

      StackOverflow also planning to switch from GoDaddy due to SOPA concerns.
      http://meta.stackoverflow.com/q/116891/1588

      GoDaddy has not withdrawn its official congressional support for SOPA
      http://www.reddit.com/r/technology/comments/npair/godaddy_has_not_withdrawn_its_official/

      ...

    hn -l 1
      GoDaddy supports SOPA, redditor proposes "Move your Domain Day"
      http://www.reddit.com/r/politics/comments/nmnie/godaddy_supports_sopa_im_transferring_51_domains/
EOF
}

hackernews()
{
  # Set the default limit to 90 (3 lines * 30 articles) lines or use 3 times
  # the given value.
  if [ "$limit" = "" ]
  then
    limit=90
  else
    limit=$((3 * $limit))
  fi

  # GNU sed uses -r for expanded regular expressions but OS X does not use GNU
  # sed. Instead it relies on -E argument.
  sed_attributes="-re"
  if [ "`uname`" = "Darwin" ]
  then
    sed_attributes="-Ee"
  fi

  attributes="title|link"
  curl -s "https://news.ycombinator.com/rss" |
    grep -Eio "<item>.*</item>" |
    grep -Eio "<($attributes)>[^<>]*</($attributes)>" |
    sed $sed_attributes "s/<title>([^<>]*)<\/title>/$highlight_title\1/" \
        -e "s/<link>([^<>]*)<\/link>/$highlight_link\1★/" \
        -e "s/&#x2F;/\//g" \
        -e "s/&#x27;/'/g" |
    tr "★" "\n" |
    head -n $limit
  printf "\033[0m"
}

set_color()
{
  highlight_title=`echo "\033[0;1;38;5;202m"`
  if [ "$highlight_title" = "\033[0;1;38;5;202m" ]
  then
    highlight_title=""
  fi

  highlight_link=`echo "\033[0;38;5;68m"`
  if [ "$highlight_link" = "\033[0;38;5;68m" ]
  then
    highlight_link=""
  fi
}

while getopts "chl:" OPTION
do
  case "$OPTION" in
    h)
      help
      exit 1;
      ;;
    c)
      set_color
      ;;
    l)
      limit=$OPTARG
      if ! [ $limit -ge 1 ] || ! [ $limit -le 30 ]
      then
        echo "hackernews: valid range is [1-30] for -- l"
        exit 1;
      fi
      ;;
    ?)
      help
      exit 1;
      ;;
  esac
done

hackernews