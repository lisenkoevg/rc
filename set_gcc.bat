@echo off
setlocal
set this=%~dpn0.bat
set basedir=c:/cygwin64/bin
set exe=c++ g++ cpp gcc gcc-ar gcc-nm gcc-ranlib gcov gcov-dump gcov-tool lto-dump
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
    findlinks -nobanner %basedir%/%%i.exe | grep exe -B 1
    echo ================================================
  )
) else (
  if "%SESSIONNAME%"=="Console" (
    nircmd elevate cmd.exe /c %this% %*
    goto :eof
  )
  for %%i in (%exe%) do (
    rm -f %basedir%/%%i.exe
REM     echo mklink /h "%basedir%/%%i.exe" "%basedir%/%prefix%-%%i.exe"
    ln "%basedir%/%prefix%-%%i.exe" "%basedir%/%%i.exe"
  )
  ln -f --symbolic gcc.exe cc.exe
  ln -f --symbolic gcc.exe cc.exe
  pause
)
endlocal
