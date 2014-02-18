@echo off
REM Switch to E:
E:

REM Enter AiRService directory
cd E:\nixin\NAiR\AiRService

REM Execute npm install
"C:\Program Files\nodejs\npm.cmd" install

REM Enter AiR directory
cd E:\nixin\NAiR\AiR

REM Execute npm install command
"C:\Program Files\nodejs\npm.cmd" install