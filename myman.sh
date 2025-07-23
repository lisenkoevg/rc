#!/bin/bash
HISTSIZE=0
if [[ ! -z "$1" ]]; then
  search="$1"
  title "MAN: $search"
  if [ -z "$2" ]; then
    man "$search"
  else
    shift
    MANPAGER="less -i -p \"$*\"" man "$search"
  fi
fi
