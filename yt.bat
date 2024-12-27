@echo off
set dir=%~dp0
set command=yt-dlp.exe --console-title %*
echo %command% >> %dir%yt.log 2>&1
%command%
