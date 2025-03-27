#!/bin/bash

dir=D:/temp/clipboard
ts=$(date +%Y%m%d_%H%M%S)
name=$dir/$ts

nircmd clipboard saveimage $name.png

if [[ $1 == "add" ]]; then
  name=$dir/clip
fi
nircmd clipboard addfile $name.txt
