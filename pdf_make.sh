#!/bin/bash

declare -a ranges
file=
fontSize=8
orientation=a4portrait
execute=
noLineNumbers=0

function main() {
  process_args $*
  tmpfile=$$_$file
  pdf=${file}_${ranges[@]}.pdf
  # '11,22 33,44' => '11,22p;33,44p;'
  ranges_sed=$(echo ${ranges[@]} | sed -E 's/([[:digit:]]|$)(\s|$)/\1p;/g')
  if [ $noLineNumbers -eq 0 ]; then
    nl -ba -w4 -s"  " $file | sed -n -e $ranges_sed > $tmpfile
  else
    cat $file | sed -n -e $ranges_sed > $tmpfile
  fi
  createPdf="-create-pdf-papersize $orientation -font Courier-Bold -font-size $fontSize"
  addPageNr="AND -bottomright 20 -font Courier-Bold -font-size 8 -add-text %Page"
  addFontInfo="AND -bottomleft 20 -font Courier-Bold -font-size 8 -add-text Font-size:$fontSize"
  addTitle="AND -topright 30 -font Courier-Bold -font-size 11 -add-text $file"
  cmd='cpdf -typeset "$tmpfile" $createPdf $addPageNr $addTitle $addFontInfo -o "$pdf"'
  eval $cmd
  [ $? == 0 -a -n $execute ] && cygstart "$pdf"
  rm -f "$tmpfile"
}

function process_args() {
  while getopts ":l:s:o:xN" opt; do
    case $opt in
      l ) ranges[${#ranges[@]}]=$OPTARG ;;
      s ) fontSize=$OPTARG ;;
      o ) orientation=$OPTARG ;;
      x ) execute=1 ;;
      N ) noLineNumbers=1 ;;
      \? | h ) showUsageExit
    esac
  done
  shift $((OPTIND - 1))
  [ ${#ranges} -eq 0 ] && ranges[0]="1,\$"
  file=$1
  [ -z $file ] && showUsageExit
  [ ! -f $file ] && echo "File $file not found" && exit 1
}

function showUsageExit() {
  echo -e $(cat<<EOL
    Usage: $0 [options] file\n\n
    -l from1,to1 [-l from2,to2] - line ranges (default 1,end)\n
    -o orientation (a4portrait | a4landscape) (default a4portrait)\n
    -s font size (default $fontSize)\n
    -N no line numbers
\n
EOL
)
  exit
}

main $*
