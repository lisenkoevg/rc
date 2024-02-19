#!/bin/bash

str=$1
str=${str//\\/\/}
str=${str/:/}
str="/cygdrive/$str"

if [ -f "$str" ] || [ ! -d "$str" ]; then
  str=`dirname "$str"`
fi
if [ ! -d "$str" ]; then
  str=/cygdrive/d/work
fi
cd "$str"

$SHELL
