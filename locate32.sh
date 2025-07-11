#!/bin/bash

exe='d:\Soft\locate\locate.exe'
exe=$(cygpath $exe)
totalcmd=D:/Soft/totalcmd/TOTALCMD64.EXE

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
  opts="bctle"
  REPLY=
  is_first=
  while [[ -z $REPLY ]]; do
    msg=$(cat <<-EOF
	Select item number from 1 to $count to execute, prepend number with [$opts]:
	'b' - open folder in bash,
	'c' - copy to clipboard,
	't' - open folder in total commander,
	'l' - open file in total commander lister,
	'e' - open folder in explorer\nor enter new query$CtrlCMsg:
EOF
)
    if [ -z $is_first ]; then
      echo -e "$msg"
    fi
    read
    N=$(echo "$REPLY" | grep -oP "\d+")
    action=$(echo "$REPLY" | grep -oP "[$opts]")
    if [[ ! ( "$N" -lt 1 || "$N" -gt "$count" ) ]]; then
      item=$(echo "$found" | head -n $N | tail -n 1)
      executeItem "$item" $action || { REPLY= ; is_first=1; }
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
  elif [ "$2" == "b" ]; then
    $BASH -i -c "cd $(cygpath -m $(dirname $item)); bash"
  elif [ "$2" == "c" ]; then
    nircmd clipboard set "$item"
  elif [ "$2" == "t" ]; then
    cygstart $totalcmd /O /T /P=L "$item"
  elif [ "$2" == "l" ]; then
    cygstart $totalcmd /O /S=L "$item"
    return 1
  elif [ "$2" == "e" ]; then
    cygstart explorer $(dirname "$item")
  fi
}

main $*
