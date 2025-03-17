#!/bin/bash

if [[ ! -z "$1" ]]; then
  term="$1"
  title "MAN: $term"
  if [ -z "$2" ]; then
    man "$term"
  else
    shift
    MANPAGER="less -i -p \"$*\"" man "$term"
  fi
fi
