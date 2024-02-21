#!/bin/bash

[ -z "$1" ] && {
  printf "Trim trailing whitespace symbols.\n"
  printf "Usage: $0 <file>\n"
  exit 1
}
[ ! -f "$1" ] && {
  printf "File '%s' not exist.\n" "$1"
  exit 1
}
sed -En '/\s+$/q1' "$1" || 
  sed -E 's/\s+$//' -i "$1"
