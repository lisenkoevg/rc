@echo off
set freq=1000
set dur=100
set n=1

if not "%1"=="" (
  set freq=%1
)
if not "%2"=="" (
  set dur=%2
)
if not "%3"=="" (
  set n=%3
)

for /l %%i in (1,1,%n%) do (
  nircmdc beep %freq% %dur%
)
echo %errorlevel%
goto :eof