#!/bin/bash

exe='d:\Soft\locate\locate.exe'
exe=$(cygpath $exe)

function main() {
  CtrlCMsg=" (Ctrl-C - exit)"
  # use whole path name to search
  cmd="$exe -w $*"
  echo "$cmd"
  found=$($cmd | dos2unix)
  if [[ -z $found ]]; then
    read -p "Nothing was found. Try another query$CtrlCMsg: " q
    main $q
    return
  fi
  count=$(echo "$found" | wc -l)
  echo
  echo "$found" | awk '{ printf "%d. %s\t%d\n", NR, $s, NR }'
  echo
  if [[ $count == 1 ]]; then
    sleep 1
    executeItem "$(echo "$found")"
    return
  fi
  REPLY=
  while [[ -z $REPLY ]]; do
    read -p "Select item number (from 1 to $count) or enter new query$CtrlCMsg: "
    if [[ "$REPLY" =~ ^[[:digit:]]+$ && ! ( "$REPLY" -lt 1 || "$REPLY" -gt "$count" ) ]]; then
      executeItem "$(echo "$found" | head -n $REPLY | tail -n 1)"
    else
      main $REPLY
    fi
  done
}

function executeItem() {
  if echo "$1" | grep -qsP "(Makefile|sh|asm|h|cpp|c|txt|vim|js|py|xml|json|sed|awk)$"; then
    cygstart gvim "$1"
  else
    cygstart "$1"
  fi
}

main $*
