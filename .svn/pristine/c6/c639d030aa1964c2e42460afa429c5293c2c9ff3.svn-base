@echo off
setlocal enabledelayedexpansion

REM ======================================================
REM This tool does a recursive search to find a timestamp
REM First input is the directory that you want to search in
REM Second arguement is the timestamp you want to search for
REM Timestamp MUST be in quotes
REM Example findtime 888888 "2017-05-10 07"
REM ======================================================

::default editor
set editor="C:\Program Files\glogg\glogg.exe"

set argCount=0
for %%x in (%*) do (
   set /A argCount+=1
   set "argVec[!argCount!]=%%~x"
)

IF %argCount% lss 2 (goto MISSING )
IF %argCount% equ 2 (goto TWO )
IF %argCount% gtr 2 (goto MAX )

:TWO
rem take input from user and clean up if needed
set logDir=%1
rem Does string have a trailing slash? if so remove it 
IF %logDir:~-1%==\ SET logDir=%logDir:~0,-1%
IF EXIST %logDir% (@echo logdir found) ELSE (GOTO :NODIR)
set logDir=%logDir%_diagsearch_logs
@echo saving results to %logDir%
mkdir %logDir% 2>nul

@echo --------------------------------
del %logDir%\time_stamp.log 2>nul
@echo creating file %logDir%/time_stamp.log
@echo ############################################################## >  %logDir%/time_stamp.log
@echo THIS LOG PROVIDES TIMESTAMP SEARCH results >>  %logDir%/time_stamp.log
@echo ############################################################## >>  %logDir%/time_stamp.log
findstr  /s /p /c:%2 ^
%1\* | findstr /v  "#"  |   FINDSTR /v /r "data_jobs_logs" |  FINDSTR /v /r "metadata_logs"  |  FINDSTR /v  "log4all.log" >>  %logDir%/time_stamp.log
@echo opening  %logDir%/time_stamp.log
start %editor%  %logDir%/time_stamp.log
goto :eof

:NODIR
@echo Warning: Directory not found
@echo findtime requires two arguements:
@echo Example find_time 888888 "2017-05-10 07"
@echo Note that your timestamp needs to be in quotes 
@echo Exiting script
goto :eof

rem :EXIT
rem @echo Warning: Glogg appears to be missing
rem @echo Download Glogg to "C:\Program Files\"
rem @echo Exiting program
rem goto :eof

:MISSING
@echo Warning: find_time requires two arguements:
@echo The directory where you want to search for and what you want to search for
@echo Example find_time 888888 "2017-05-10 07"
@echo Note that your timestamp needs to be in quotes 
@echo Exiting script
goto :eof

:MAX
@echo Warning: find_time requires two arguements:
@echo The directory where you want to search for and what you want to search for
@echo Example find_time 888888 "2017-05-10 07"
@echo Note that your timestamp needs to be in quotes 
@echo Exiting script
goto :eof





