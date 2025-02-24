@echo off

setlocal
set keyName=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
set keyValue=TypeAndRun

set exeDir=D:\Soft\TypeAndRun
REM set configDir=%~dp0%
REM set configDir=%configDir:~0,-1%
set configDir=c:\bin\TypeAndRun
set settings=TypeAndRun.ini
set config=Config.ini

set value="\"%exeDir%\TypeAndRun.exe\" --settings=\"%configDir%\%settings%\" --config=\"%configDir%\%config%\""
set cmd_line="%exeDir%\TypeAndRun.exe" --settings="%configDir%\%settings%" --config="%configDir%\%config%"

set arch=64

if "%1" == "register" (
  reg query %keyName% /v %keyValue% /reg:%arch%
  reg add %keyName% /v %keyValue% /t REG_SZ /d %value% /f /reg:%arch%
  reg query %keyName% /v %keyValue% /reg:%arch%
) else (
  pskill -nobanner -accepteula TypeAndRun.exe
  start "" %cmd_line%
)
endlocal
