@echo off
setlocal enabledelayedexpansion

REM =============================================================
REM This tool does a recursive search on your PDT results for possible Data Order Issues
REM First arguement is required directory where you want to search
REM ==============================================================

::default editor
set editor="C:\Program Files\glogg\glogg.exe"

set argCount=0
for %%x in (%*) do (
   set /A argCount+=1
   set "argVec[!argCount!]=%%~x"
)

IF %argCount% equ 0 (goto BLANK )
IF %argCount% equ 1 (goto ONE )
IF %argCount% gtr 1 (goto MAX )

:ONE
rem take input from user and clean up if needed
set logDir=%1
rem Does string have a trailing slash? if so remove it 
IF %logDir:~-1%==\ SET logDir=%logDir:~0,-1%
IF EXIST %logDir% (@echo Running recursive search in %logDir%) ELSE (GOTO :NODIR)
set logDir=%logDir%_diagsearch_logs
@echo Saving search results to %logDir%
@echo dataOrder allows you to see if revisions are in order. 
@echo If out of order see DPP-127777
@echo This might take a awhile depending on the size of your PDT results
mkdir %logDir% 2>nul

@echo --------------------------------
del %logDir%\dataOrder.log 2>nul
@echo creating %logDir%/dataOrder.log
@echo ############################################################## > %logDir%/dataOrder.log
@echo This tool Finds "Finished processing of revision" which relates to DPP-127777  >> %logDir%/dataOrder.log
@echo If revisions are out of order, customer will need to reindex again  >> %logDir%/dataOrder.log
@echo Consult Jiri before reporting to customer >> %logDir%/dataOrder.log
@echo ############################################################## >> %logDir%/dataOrder.log
findstr /s /p /c:"Finished processing of revision" ^
 %1\* | findstr /v /c:"#" >> %logDir%/dataOrder.log
@echo opening %logDir%/dataOrder.log
start %editor% %logDir%/dataOrder.log

goto :eof

:NODIR
@echo Warning: Directory not found
@echo diagsearch requires one arguement, the directory where you want to search 
@echo Exiting script
goto :eof

rem :EXIT
rem @echo Warning: Glogg appears to be missing
rem @echo Download Glogg to "C:\Program Files\"
rem @echo Exiting program
rem goto :eof

:BLANK
@echo Warning: No arguement given
@echo What Directory do you want to search in?
goto :eof


:MAX
@echo Warning: Too many arguements
@echo You only need to specify the directory
goto :eof





