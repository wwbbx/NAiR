@echo off
REM Copy necessary javascript etc. files to distribution server.
XCOPY C:\SOURCE\NAiR Y:\NAiR /S /E /Y /EXCLUDE:exclusivePublish.txt

REM Copy initialize.js over remote distribution server
copy C:\SOURCE\NAiR\initialize.js Y:\NAiR

REM Execute initialize.bat on remote distribution server.
psexec.exe \\polarbear.chn.agilent.com -d -s -i "C:\Program Files\nodejs\node.exe" E:\nixin\NAiR\initialize.js