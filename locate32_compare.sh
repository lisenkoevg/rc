#!/bin/bash

tl="/cygdrive/d/soft/totalcmd/totalcmd64.exe /N /S=c"
f=/tmp/locate32_compare
ff=$1

main() {
  echo \"${ff}\" > ${f}_$BASHPID
  wait_another
  if [[ `ls ${f}_[0-9]* | wc -l` -eq 2 ]]; then
    comm=`cat ${f}_[0-9]*`
    echo $tl $comm > ${f}.sh
    chmod +x ${f}.sh 
    ${f}.sh
  fi
  rm -f $f.sh ${f}_*
}

wait_another() {
  i=0
  limit=10
  while [[ $i -lt $limit ]] && [[ ! `ls ${f}_[0-9]* | wc -l` -eq 2 ]] ; do
    sleep 0.1
    echo $i $BASHPID wait>> $f.log
    (( i++ ))
  done
  if [[ ! `ls ${f}_[0-9]* | sort | head -n1` =~ $BASHPID ]] ; then
    echo $i $BASHPID exit>> $f.log
    exit
  fi
  echo $i $BASHPID continue>> $f.log
}

main
