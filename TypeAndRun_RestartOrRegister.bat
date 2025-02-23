@echo off

set keyName=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
set keyValue=TypeAndRun

set exeDir=D:\Soft\TypeAndRun
REM set configDir=%~dp0%
REM set configDir=%configDir:~0,-1%
set configDir=c:\bin\TypeAndRun
set settings=TypeAndRun.ini
set config=Config.ini

set value="\"%exeDir%\TypeAndRun.exe\" --settings=\"%configDir%\%settings%\" --config=\"%configDir%\%config%\"" /f /reg:64
set cmd="%exeDir%\TypeAndRun.exe" --settings="%configDir%\%settings%" --config="%configDir%\%config%"


if "%1" == "register" (
  reg query %keyName% /v %keyValue% /reg:64
  reg add %keyName% /v %keyValue% /t REG_SZ /d %value%
  reg query %keyName% /v %keyValue% /reg:64
) else (
  pskill -nobanner -accepteula TypeAndRun.exe
  start "" %cmd%
)
