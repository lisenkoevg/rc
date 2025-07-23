#!/bin/bash

main() {
  set -o errexit errtrace
  trap errHandler ERR

  cat *_u > sample1

  t1=$(date +%s%3N)
  i=1
  for f in *_z; do
    if ((i%10 == 0)); then echo -n $i; else echo -n .; fi
    {
      dd if=$f bs=16 skip=1 status=none count=63
      dd if=$f bs=1024 skip=1 status=none
    } | unzstd > ${f/_z/_x}
    i=$((i+1))
  done
  echo
  t2=$(date +%s%3N)
  echo $((t2 - t1))ms

  cat *_x > sample2
  diff -s sample1 sample2

  rm sample1 sample2 *_x
}

errHandler() {
  echo errHandler err:$? $f
}

main $*
