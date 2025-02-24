#!/bin/bash

inFile=$1
level=${2:-0}
cpdf -split-bookmarks $level "$1" -o @B.pdf

