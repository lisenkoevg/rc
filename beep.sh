#!/bin/bash

# [[ "$0" =~ \.sh$ ]] && ln -s "$0" /bin/beep

soundDevice=Speakers
freq=${1:-2000}
duration=${2:-200}
beepVolume=10

currentVolume=$(svcl /Stdout /GetPercent "$soundDevice")
svcl /SetVolume "$soundDevice" $beepVolume
nircmd beep $freq $duration
svcl /SetVolume "$soundDevice" $currentVolume

