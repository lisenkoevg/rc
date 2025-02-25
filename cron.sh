#!/bin/bash

log=c:/bin/cron.log
backupDir=d:/YandexDisk/Backup

echo === >> $log
date >> $log
ts=$(date +%Y%m%d_%H%M%S)

{
#TypeAndRun History.ini
src=d:/Soft/TypeAndRun/History.ini
dest=$backupDir/TypeAndRun/History_${ts}.ini
cp $src $dest
[[ $(stat -c%s $dest) -lt 10000 ]] && ( echo ERROR: file has too small size && stat $dest )

} >> $log 2>&1
