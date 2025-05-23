#!/bin/bash

exe='d:\Soft\locate\locate.exe'
exe=$(cygpath $exe)

function main() {
  if [ -z "$1" ]; then
    exit
  fi
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
    msg="Select item number from 1 to $count to execute, prepend number with:\n'c' - copy to clipboard,\n't' - open folder in total commander,\n'e' - open folder in explorer\nor enter new query$CtrlCMsg:"
    echo -e "$msg"
    read
    N=$(echo "$REPLY" | grep -oP "\d+")
    action=$(echo "$REPLY" | grep -oP "[cet]")
    if [[ ! ( "$N" -lt 1 || "$N" -gt "$count" ) ]]; then
      item=$(echo "$found" | head -n $N | tail -n 1)
      executeItem "$item" $action
    else
      main $REPLY
    fi
  done
}

function executeItem() {
  if [ -z "$2" ]; then
    if echo "$1" | grep -qsP "(Makefile|sh|asm|h|cpp|c|txt|vim|js|py|xml|json|sed|awk)$"; then
      cygstart gvim "$1"
    else
      cygstart "$1"
    fi
  elif [ "$2" == "c" ]; then
    nircmd clipboard set "$item"
  fi
}

main $*
