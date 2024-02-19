@echo off
set dir=%~dp0
set command=d:\Soft\youtube-dl\yt-dlp.exe %*
echo %command% >> %dir%yt.log 2>&1
%command%
