@echo off
REM Copy necessary javascript etc. files to distribution server.
XCOPY C:\SOURCE\NAiR Y:\NAiR /S /E /Y /EXCLUDE:exclusivePublish.txt

REM Copy initialize.bat over there
copy C:\SOURCE\NAiR\initialize.bat Y:\NAiR

REM Execute initialize.bat on remote distribution server.
psexec.exe \\polarbear.chn.agilent.com -d -s -w E:\nixin\NAiR E:\nixin\NAiR\initialize.bat -i