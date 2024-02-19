@echo off

set command=d:\Soft\aria\aria2c.exe --seed-time=0 %2 %3 %4 %5
if "%1"=="" (
  echo Usage:
  echo aria "name_for_logging" link
  echo aria meta "magnet_link"
  goto :eof
)
title aria
REM goto :eof

if "%1"=="meta" (
  echo "%~2" | grep ^^\"magnet: && (
    set command=d:\Soft\aria\aria2c.exe --bt-metadata-only=true --bt-save-metadata=true "%~2"
  )
)
echo %1 %cd% %command%>> c:\bin\aria.log
%command% & nircmdc beep 2000 100
