@echo off
set vimExe=gvim
REM echo %0 | grep -q gvim || set vimExe=vim
for /f "delims=" %%i in ('echo %* ^| sed ^'s,~,c:/cygwin64/home/Evgen,^'') do (
  start "" "C:\Users\Evgen\Documents\Vim\vim90\%vimExe%.exe" "%%i"
)
