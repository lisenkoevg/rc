@echo off
set dir=%~dp0
set command=d:\Soft\pdf\k2pdfopt\k2pdfopt.exe %*
echo %command% >> %dir%k2.log 2>&1
%command%
