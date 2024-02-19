@echo off
title vpn
REM nircmdc.exe elevate "c:\Program Files (x86)\OpenConnect-GUI\openconnect.exe" --servercert=10590e6389b6d6ca40604b4fa063738e835944ff -u vpn-lysenko rba.remaccess.ru/vpn
nircmdc.exe elevate "c:\Program Files (x86)\OpenConnect-GUI\openconnect.exe" -u vpn-lysenko rba.remaccess.ru/vpn