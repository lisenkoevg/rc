@echo off
set dir=%~dp0
set args=%*

if "%1" == "" (
  echo Usage: %0 ^<link^>
  echo Usage: %0 comments ^<link^>
  echo Usage: %0 commentsOnly ^<link^>
  echo Usage: %0 convertComments ^<json-file^> [output-file]
  goto :eof
)

if "%1" == "convertComments" (
  set prettyCommentsFilename="comments.txt"
  if not "%3" == "" set prettyCommentsFilename=%3
  bash json_pp < %2 | grep -Po "\btext. :.*$" > "%prettyCommentsFilename%"
  goto :eof
)

if "%1" == "comments" set args=--write-comments %args:comments =%
if "%1" == "commentsOnly" set args=--write-comments --no-download %args:commentsOnly =%
set command=yt-dlp.exe --retries 100 --console-title --windows-filenames %args%
REM echo %command%
echo %command% >> %dir%yt.log 2>&1
%command%
