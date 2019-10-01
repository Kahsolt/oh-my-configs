#!/bin/bash

LIST=MAKE.list

while read item
do
  dstdir=.$(dirname "$item")/
  mkdir -pv $dstdir
  echo "cp: $item -> $dstdir"
  cp -Ru $item $dstdir
done < $LIST