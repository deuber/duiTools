@echo off
setlocal enabledelayedexpansion


REM Author David Deuber

REM =============================================================
REM This tool parses Polarion Mail log file
REM First arguement is required file 
REM ==============================================================

set pFile=%1


set argCount=0
for %%x in (%*) do (
   set /A argCount+=1
   set "argVec[!argCount!]=%%~x"
)

IF %argCount% equ 0 (goto BLANK )
IF %argCount% equ 1 (goto ONE )
IF %argCount% gtr 1 (goto MAX )

::default editor
set editor="C:\Program Files\glogg\glogg.exe"


:ONE
IF EXIST %pFile% (@echo Parsing file: %pFile%) ELSE (GOTO :MISSING)


REM =============================================================
REM Create the dir for parse results based on file name
REM ==============================================================


set pFileResults=%pFile%_parseResults
@echo Creating results folder: %pFileResults%
mkdir  "%pFileResults%" 2>nul

@echo --------------------------------
del %pFileResults%\polarion.log 2>nul
@echo creating file %pFileResults%/polarion.log
@echo ############################################################## >  %pFileResults%/polarion.log
@echo THIS LOG CONTAINS INFORMATION ON POLARION VERSION AND CONFIGURATION >>  %pFileResults%/polarion.log
@echo Each instance running Polarion must have the same Polarion version >>  %pFileResults%/polarion.log
@echo This log file shows if extensions are used >>  %pFileResults%/polarion.log
@echo This log file shows if patches are used >>  %pFileResults%/polarion.log
@echo This log file shows nodeId >>  %pFileResults%/polarion.log
@echo This log file shows what os is used (linux or Windows) >>  %pFileResults%/polarion.log
@echo This log file shows in what context Polarion was started  >>  %pFileResults%/polarion.log
@echo This log file shows in when Polarion was started  >>  %pFileResults%/polarion.log
@echo This log file shows Architecture, should be 64bit >>  %pFileResults%/polarion.log
@echo This log file shows Linux distribution name >>  %pFileResults%/polarion.log
@echo This log shows server start mode, reindex or normal>>  %pFileResults%/polarion.log
@echo ############################################################## >>  %pFileResults%/polarion.log
findstr  /s /p /c:"AppLaunchersManager  - Version" ^
 /s /p /c:"AppLaunchersManager  - Build" ^
 /s /p /c:"AppLaunchersManager  - Extensions" ^
 /s /p /c:"AppLaunchersManager  - Patches" ^
 /s /p /c:"AppLaunchersManager - Version" ^
 /s /p /c:"AppLaunchersManager - Build" ^
 /s /p /c:"AppLaunchersManager - Extensions" ^
 /s /p /c:"AppLaunchersManager - Patches" ^
 /s /p /c:"nodeId" ^
 /s /p /c:"org.osgi.framework.os.name" ^
 /s /p /c:"Cluster service" ^
 /s /p /c:"Using logging context" ^
 /s /p /c:"Architecture:" ^
 /s /p /c:"Linux distribution name:" ^
 /s /p /c:"Server start mode:" ^
 /s /p /c:"Polarion started" ^
%pFile%  >>  %pFileResults%/polarion.log
@echo opening  %pFileResults%/polarion.log
start %editor%  %pFileResults%/polarion.log


@echo --------------------------------
del %pFileResults%\activitites.log 2>nul
@echo creating file %pFileResults%/activitites.log
@echo ############################################################## >  %pFileResults%/activitites.log
@echo THIS LOG CONTAINS INFORMATION ON ACTIVITIES: >>  %pFileResults%/activitites.log
@echo 1) DB History creator >>  %pFileResults%/activitites.log
@echo 2) Indexing Phases >>  %pFileResults%/activitites.log
@echo ############################################################## >>  %pFileResults%/activitites.log
findstr  /s /p /c:"Phase:" ^
 /s /p /c:"com.polarion.platform.startup - Platform startup" ^
 /s /p /c:"com.polarion.platform.jobs.info " ^
%pFile%  >>  %pFileResults%/activitites.log
@echo opening  %pFileResults%/activitites.log
start %editor%  %pFileResults%/activitites.log



@echo --------------------------------
del %pFileResults%\TxLogger.log 2>nul
@echo creating file %pFileResults%/TxLogger.log
@echo ############################################################## >  %pFileResults%/TxLogger.log
@echo THIS LOG CONTAINS INFORMATION ON TX logger ACTIVITIES: >>  %pFileResults%/TxLogger.log
@echo ############################################################## >>  %pFileResults%/TxLogger.log
findstr  /s /p /c:"INFO  TXLOGGER" ^
 /s /p /c:"foobar" ^
 /s /p /c:"foobar" ^
%pFile%  >>  %pFileResults%/TxLogger.log
@echo opening  %pFileResults%/TxLogger.log
start %editor%  %pFileResults%/TxLogger.log

@echo --------------------------------
del %pFileResults%\Errors.log 2>nul
@echo creating file %pFileResults%/Errors.log
@echo ############################################################## >  %pFileResults%/Errors.log
@echo THIS LOG CONTAINS INFORMATION ON ERRORS: >>  %pFileResults%/Errors.log
@echo ############################################################## >>  %pFileResults%/Errors.log
findstr  /s /p /c:"ERROR" ^
 /s /p /c:"error" ^
 /s /p /c:"foobar" ^
%pFile%  >>  %pFileResults%/Errors.log
@echo opening  %pFileResults%/Errors.log
start %editor%  %pFileResults%/Errors.log


@echo --------------------------------
del %pFileResults%\Stack.log 2>nul
@echo creating file %pFileResults%/Stack.log
@echo ############################################################## >  %pFileResults%/Stack.log
@echo THIS LOG CONTAINS INFORMATION ON Stack: >>  %pFileResults%/Stack.log
@echo ############################################################## >>  %pFileResults%/Stack.log
findstr  /s /p /c:"StackTraceException" ^
 /s /p /c:"foobar" ^
 /s /p /c:"foobar" ^
%pFile%  >>  %pFileResults%/Stack.log
@echo opening  %pFileResults%/Stack.log
start %editor%  %pFileResults%/Stack.log



goto :eof


:MISSING
@echo Warning: File not found
@echo pSearch requires one arguement, the Polarion File you want to parse
@echo Exiting script
goto :eof


:BLANK
@echo Warning: No arguement given
@echo What Polarion Main file to you want to parse? 
goto :eof

:MAX
@echo Warning: Too many arguements
@echo What you want to search for?
goto :eof





