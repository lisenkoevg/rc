#!/bin/bash

set -o errexit -o errtrace

locatePath=$(cygpath d:/Soft/locate)
exe="$locatePath/locate.exe"
exe32="$locatePath/locate32.exe"
db="-D default -D yandex.disk"
totalcmd=D:/Soft/totalcmd/TOTALCMD64.EXE
CtrlCMsg=" (Ctrl-C - exit)"

found=0
count=0
is_first=1
is_exit=0
initial_query=

main() {
  trap 'trapErr' ERR
  if [ -z "$initial_query" ]; then
    initial_query="$*"
  fi
  if [ -z "$1" ]; then
    exit
  fi
  search $*

  if [[ $count == 1 ]]; then
    sleep 1
    executeItem "$(echo "$found")"
    return
  fi

  readLoop
}

search() {
  # use whole path name to search
  cmd="$exe $db -w $*"
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
}

readLoop() {
  REPLY=
  while [[ -z $REPLY ]]; do
    readInput
    if [[ ! ( "$N" -lt 1 || "$N" -gt "$count" ) ]]; then
      item=$(echo "$found" | head -n $N | tail -n 1)
      executeItem "$item" $action || break
    else
      main $REPLY
    fi
  done
}

readInput() {
  opts="bcdtlex"
  msg=$(cat <<-EOF
  Select item number from 1 to $count to execute, prepend number with [$opts]:
  'b' - open folder in bash,
  'c' - copy full name to clipboard,
  'd' - delete file,
  't' - open folder in total commander,
  'l' - open file in total commander lister,
  'e' - open folder in explorer,
  'x' - (combine with action above) exit after action\nor enter new query$CtrlCMsg:
EOF
)
  if [ $is_first == "1" ]; then
    echo -e "$msg"
    is_first=0
  fi
  read
  if [[ ${#REPLY[@]} < 5 ]]; then
    N=$(echo "$REPLY" | grep -oP "\d+" || true)
    REPLY=${REPLY/$N/}
    action=$(echo "$REPLY" | grep -oP "[$opts]+" || true)
    if $(echo $action | grep -sq x); then
      is_exit=1
      action=${action/x/}
    fi
  else
    main $REPLY
  fi
}

function executeItem() {
  if [ -z "$2" ]; then
    if echo "$1" | grep -qsP "(Makefile|sh|asm|h|cpp|c|txt|vim|js|py|xml|json|sed|awk|bat|cmd|ps1)$"; then
      # fix spaces in path, ex. C:\Program Files\...
      cygstart gvim $(cygpath -ms "$1")
    else
      cygstart "$1"
    fi
    is_exit=1
  elif [ "$2" == "b" ]; then
    $BASH -i -c "cd $(cygpath -m $(dirname $item)); bash"
    is_exit=1
  elif [ "$2" == "c" ]; then
    nircmd clipboard set "$item"
  elif [ "$2" == "d" ]; then
    rm -f "$item"
    $exe32 -U -D yandex.disk
    main $initial_query
    return
  elif [ "$2" == "t" ]; then
    cygstart $totalcmd /O /T /P=L "$(dirname $item)"
  elif [ "$2" == "l" ]; then
    cygstart $totalcmd /O /S=L "$item"
  elif [ "$2" == "e" ]; then
    cygstart explorer $(dirname "$item")
  fi
  if [ "$is_exit" == "0" ]; then
    echo -n "enter new command: "
    readLoop
  fi
  return 1
}

trapErr() {
  echo "trap err $?"
}

main $*
