#!/bin/bash

exe='d:\Soft\locate\locate.exe'
exe=$(cygpath $exe)

function main() {
  cmd="$exe -w $*"
  found=$($cmd | dos2unix)
  if [[ -z $found ]]; then
    read -p "Nothing was found. Try another query: " q
    main $q
    return
  fi
  count=$(echo "$found" | wc -l)
  echo
  echo "$found" | nl -n'rn' -w3 -s'. '
  echo
  if [[ $count == 1 ]]; then
    sleep 1
    cygstart "$(echo "$found")"
    return
  fi
  REPLY=
  while [[ -z $REPLY ]]; do
    read -p "Select item number (from 1 to $count) or enter new query: "
    if [[ "$REPLY" =~ ^[[:digit:]]+$ && ! ( "$REPLY" -lt 1 || "$REPLY" -gt "$count" ) ]]; then
      cygstart "$(echo "$found" | head -n $REPLY | tail -n 1)"
    else
      main $REPLY
    fi
  done
}

main $*
