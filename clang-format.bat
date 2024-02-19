@echo off

REM "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\Llvm\x64\bin\clang-format.exe"
REM -lines=1:103 "-style={BasedOnStyle: google, IndentWidth: 2, UseTab: false}" -assume-filename="uncomment.c"  --

set p="C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\Llvm\x64\bin\clang-format.exe"
set d=%~dp0clang-format.log
REM set args=-style={BasedOnStyle: google, IndentWidth: 2, UseTab: false}"
set args=--style=llvm

echo %args% %* >> %d% 
%p% %args% %*
