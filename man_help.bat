@echo off
setlocal EnableDelayedExpansion

set q=%*
set last=%q:~-1%
set ch=*

if "%last%" == "%ch%" (
  set query=%q:~0,-1%
) else (
  echo 2
  set query=\%q%
)
start "" "https://duckduckgo.com/?sites=man7.org&q=%query%"
s
