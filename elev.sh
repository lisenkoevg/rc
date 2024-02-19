#!/bin/bash -

cygwin="c:/cygwin64/bin"
command="$1"
shift
args="$@"
if [ -f "${cygwin}/$command" ]
then
  echo nircmdc elevate ${cygwin}/$command $args
else
  echo nircmdc elevate $command $args
fi
# cmd /c echo %PATH% | tr ';' '\n' |
  # while read -r dir
  # do
    # echo $dir
  # done 
