#!/bin/bash

root=d:/Soft/nirsoft/NirSoft/x64
cfg=$root/regscanner.cfg
exe=$root/regscanner.exe

query="$*"
ts=$(date +%Y%m%d_%H%M%S)
function main() {
  if [[ -z "$query" ]]; then
    echo Query string is not specified
    return;
  fi
  queryCP1251=$(echo $query | iconv -f UTF-8 -t CP1251)
  sed -i -E -e "s/^Find=.*$/Find=$queryCP1251/" "$cfg"
#   grep --color "Find=" "$cfg"
  echo Scanning registry for string \"$query\" and saving to $ts ...
  $exe /sreg $ts.reg
#   sed -i "1i $query\n\n" $ts.reg
#   $exe /stext $ts.txt
}

main
