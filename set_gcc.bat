@echo off
setlocal
set this=%~dpn0.bat
set basedir=c:\cygwin64\bin
set exe=cc cpp gcc gcc-ar gcc-nm gcc-ranlib gcov gcov-dump gcov-tool lto-dump
set prefix=
if "%1"=="mingw" (
  set prefix=x86_64-w64-mingw32
)
if "%1"=="cygwin" (
  set prefix=x86_64-pc-cygwin
)
if "%prefix%"=="" (
  echo Run: %this% mingw ^| cygwin
  for %%i in (%exe%) do (
    findlinks -nobanner %basedir%\%%i.exe | grep exe -B 1
    echo ================================================
  )
) else (
  if "%SESSIONNAME%"=="Console" (
    nircmd elevate cmd.exe /c %this% %*
    goto :eof
  )
  for %%i in (%exe%) do (
    del /f %basedir%\%%i.exe
    mklink /h "%basedir%\%%i.exe" "%basedir%\%prefix%-%%i.exe"
  )
  pause
)
endlocal
