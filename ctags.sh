#!/bin/bash

# Find all source files *.c *.cpp *.h files in current directory recursively
# Scan them for included headers
# generate tags file with ctags using found sources and headers

set -o errexit

includes="-I d:/include -I d:/include/x86_64-linux-gnu -I d:/include/c++/14"
includesQt=" QtGui QtWidgets QtCore"
includesQt="${includesQt// / -I d:/Qt/6.7.0/mingw_64/include/} -I d:/Qt/6.7.0/mingw_64/include/ -I ."

ctagsArgs='--c++-kinds=+p --fields=+iaS --extras=+q --tag-relative=always'

noPrefindFiles=0

main() {
  processArgs $*
  if [ $noPrefindFiles == 1 ]; then
    ctags $ctagsArgs -R .
  else
    files=$(find -type f \( -name '*.c' -o -name '*.h' -o -name '*.cpp' \) -printf "%p ")
#     echo files: "$files"
    files_included=$(g++ $includes $includesQt -M $files | sed -e 's/[\\ ]/\n/g' | sed -e '/^$/d' -e '/\.o:[ \t]*$/d' | grep -v cygdrive)
#     echo included: "$files_included"
    echo "$files_included"  | ctags -L - $ctagsArgs || read -p "Press any key..."
  fi
}

processArgs() {
  while getopts ":n" opt; do
    case $opt in
      n ) noPrefindFiles=1 ;;
      \? | h) usage ;;
      * ) usage ;;
    esac
  done
  shift $((OPTIND - 1))
}

usage() {
  echo "Usage: $(basename $0) [-n]"
  echo "  -n   use . ("dot") as ctags source, else pre-analyse source files *.c(pp) and *.h using g++ -M flag"
  exit 1
}

main $*
