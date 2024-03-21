#!/bin/bash

# [[ "$0" =~ \.sh$ ]] && ln -s "$0" /bin/beep

soundDevice=Speakers
let freq=${1:-2000}
let duration=${2:-200}
let beepVolume=10

currentVolume=$(svcl /Stdout /GetPercent "$soundDevice")
let currentVolume=${currentVolume%.*}
[ "$currentVolume" -gt "$beepVolume" ] && svcl /SetVolume "$soundDevice" $beepVolume
nircmd beep $freq $duration
[ "$currentVolume" -gt "$beepVolume" ] && svcl /SetVolume "$soundDevice" $currentVolume

