@echo off
setlocal enabledelayedexpansion

REM ======================================================
REM This tool does a recursive search to find a string
REM First input is the directory that you want to search in
REM Second arguement is the string you want to search for
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
rem set logDir=%logDir%_diagsearch_logs
set findme=%2



@echo --------------------------------
del search_%findme%.log 2>nul
@echo creating file search_%findme%.log
@echo ############################################################## >  search_%findme%.log
@echo THIS LOG PROVIDES SEARCH results >>  search_%findme%.log
@echo ############################################################## >>  search_%findme%.log
findstr  /s /p /c:%findme% ^
%1\* | findstr /v  "#"  |   FINDSTR /v /r "data_jobs_logs" |  FINDSTR /v /r "metadata_logs"  |  FINDSTR /v  "log4all.log" >>  search_%findme%.log
@echo opening  search_%findme%.log
start %editor%  search_%findme%.log
goto :eof


:NODIR
@echo Warning: Directory not found
@echo findstring requires two arguements:
@echo The directory where you want to search for and what you want to search for
@echo Example search_time 888888 "your string here"
@echo Exiting script
goto :eof


rem :EXIT
rem @echo Warning: Glogg appears to be missing
rem @echo Download Glogg to "C:\Program Files\"
rem @echo Exiting program
rem goto :eof

:MISSING
@echo Warning: findstring requires two arguements:
@echo The directory where you want to search for and what you want to search for
@echo Example search_time 888888 "your string here"
@echo Exiting script
goto :eof

:MAX
@echo Warning: findstring requires two arguements:
@echo The directory where you want to search for and what you want to search for
@echo Example search_time 888888 "your string here"
@echo Exiting script
goto :eof





