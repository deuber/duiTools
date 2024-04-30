<<<<<<< HEAD
@echo off
setlocal enabledelayedexpansion

REM Author David Deuber

REM =============================================================
REM This tool renames the unzipped diagtool results 
REM ==============================================================


rem Timestamp the rename log
@echo %date% %time% >> pdt_diagsearch_logs/rename.log



set argCount=0
for %%x in (%*) do (
   set /A argCount+=1
   set "argVec[!argCount!]=%%~x"
)

IF %argCount% equ 0 (goto BLANK )
IF %argCount% equ 1 (goto ONE )
IF %argCount% gtr 1 (goto MAX )

:ONE

rem take input from user this is the unpacked zip file

set diagResults_dir=%1
rem Does string have a trailing slash? if so remove it 
IF %diagResults_dir:~-1%==\ SET diagResults_dir=%diagResults_dir:~0,-1%



IF NOT EXIST %diagResults_dir% (GOTO :NOFILE)



REM OLD
REM for /F "delims=" %%a in ('findstr /s /p /c:"Using logging context" %diagResults_dir%\*') do set context=%%a


REM Look for "NODE" in main log 
for /F "delims=" %%f in ('findstr /s /p /c:"Using logging context NODE" %diagResults_dir%\*') do set context=NODE
IF "%context%"=="NODE" (
@echo "Using logging context NODE" FOUND IN MAIN LOG = NODE
GOTO :NODE 
)


REM Look for "com.polarion.application=polarion.coordinator" in polarion.properties
for /F "delims=" %%f in ('findstr /s /p /c:"com.polarion.application=polarion.coordinator" %diagResults_dir%\*') do set context=COORDINATOR
IF "%context%"=="COORDINATOR" (
@echo COORDINATOR FOUND IN POLARION.PROPERTIES = COORDINATOR
GOTO :COORDINATOR 
)

REM Look for "COORDINATOR" in main log 
for /F "delims=" %%f in ('findstr /s /p /c:"Using logging context COORDINATOR" %diagResults_dir%\*') do set context=COORDINATOR
IF "%context%"=="COORDINATOR" (
@echo "Using logging context COORDINATOR" FOUND IN MAIN LOG = COORDINATOR
GOTO :COORDINATOR 
)

REM Look for LoadBalancer 
for /F "delims=" %%f in ('findstr /s /p /c:"BalancerMember" %diagResults_dir%\*') do set context=SHAREDSERVER
IF "%context%"=="SHAREDSERVER" (
@echo "BalancerMember" FOUND LOADBALANCER = SHAREDSERVER
GOTO :SHAREDSERVER 
)

REM Look for "STANDALONE" in main log 
for /F "delims=" %%f in ('findstr /s /p /c:"STANDALONE" %diagResults_dir%\*') do set context=STANDALONE
IF "%context%"=="STANDALONE" (
@echo STANDALONE FOUND IN MAIN LOG = STANDALONE  
GOTO :STANDALONE 
)

REM IF no logs or configuration in PDT 
IF "%context%"=="" (
@echo WARNING: THESE DIAGTOOL RESULTS ARE MISSING LOGS AND CONFIGS = NO_CONTEXT
GOTO :NO_CONTEXT
)

REM Get Polarion Context if found
for %%i in (%context%) do set "context=%%i"915  




REM rename as NODE plus NodeID
:NODE
for /F "delims=" %%a in ('findstr /s /p /c:"nodeId" %diagResults_dir%\*') do set nodeId=%%a
IF "%nodeId%"=="" (GOTO :NO_CONTEXT)
REM get NodeID Name only
for %%a in (%nodeId:"\"= %) do set nodeId=%%a

set newNameN=%context%.%nodeId%.%random:~-1%%random:~-1%%random:~-1%%random:~-1%.pdt
@echo Renaming %diagResults_dir% to %newNameN%
@echo %diagResults_dir% to %newNameN% >> pdt_diagsearch_logs/rename.log
IF EXIST %newNameN% (GOTO :EXISTS)
move %diagResults_dir% %newNameN% >nul
goto :eof


REM rename as COORDINATOR
:COORDINATOR
set newNameC=%context%.%random:~-1%%random:~-1%%random:~-1%%random:~-1%.pdt
@echo Renaming %diagResults_dir% to %newNameC%
@echo %diagResults_dir% to %newNameC% >> pdt_diagsearch_logs/rename.log
IF EXIST %newNameC% (GOTO :EXISTS)
move %diagResults_dir% %newNameC% >nul
goto :eof


REM rename as STANDALONE
:STANDALONE
set newNameS=%context%.%random:~-1%%random:~-1%%random:~-1%%random:~-1%.pdt
@echo Renaming %diagResults_dir% to %newNameS%
@echo %diagResults_dir% to %newNameS% >> pdt_diagsearch_logs/rename.log
IF EXIST %newNameS% (GOTO :EXISTS)
move %diagResults_dir% %newNameS% >nul
goto :eof

REM rename as SHAREDSERVER
:SHAREDSERVER
IF NOT EXIST pdt\ mkdir pdt
set newNameSS=SHAREDSERVER.%random:~-1%%random:~-1%%random:~-1%%random:~-1%.pdt
@echo Renaming %diagResults_dir% to %newNameSS%
@echo %diagResults_dir% to %newNameSS% >> pdt_diagsearch_logs/rename.log
move %diagResults_dir% %newNameSS% >nul
goto :eof

REM rename as NO_CONTEXT
:NO_CONTEXT
IF NOT EXIST pdt\ mkdir pdt
set newNameNO=NO_CONTEXT.%random:~-1%%random:~-1%%random:~-1%%random:~-1%.pdt
@echo Renaming %diagResults_dir% to %newNameNO%
@echo %diagResults_dir% to %newNameNO% >> pdt_diagsearch_logs/rename.log
move %diagResults_dir% %newNameNO% >nul
goto :eof




:NOFILE
@echo Warning: File not found
@echo  requires one arguement, the uncompressed PDT
goto :eof

:DONE_ALREADY
@echo Warning: This file is already exists
goto :eof

:EXISTS
@echo Warning: This file is already exists, will not rename this dir
@echo Warning: You have multiple diagtool results from same instance
goto :eof


:BLANK
@echo Warning: No arguement given
@echo What diagsearch folder do want to rename?
goto :eof

:MAX
@echo Warning: Too many arguements
@echo You only need to add a zipped file
goto :eof



=======
@echo off
setlocal enabledelayedexpansion

REM Author David Deuber

REM =============================================================
REM This tool renames the diagtool results based on context 
REM ==============================================================


rem Timestamp the rename log
@echo %date% %time% >> pdt_diagsearch_logs/rename.log



set argCount=0
for %%x in (%*) do (
   set /A argCount+=1
   set "argVec[!argCount!]=%%~x"
)

IF %argCount% equ 0 (goto BLANK )
IF %argCount% equ 1 (goto ONE )
IF %argCount% gtr 1 (goto MAX )

:ONE


rem take input from user 
set diagResults_dir=%1
rem Does string have a trailing slash? if so remove it 
IF %diagResults_dir:~-1%==\ SET diagResults_dir=%diagResults_dir:~0,-1%




IF NOT EXIST %diagResults_dir% (GOTO :NOFILE)


for /F "delims=" %%a in ('findstr /s /p /c:"Using logging context" %diagResults_dir%\*') do set context=%%a

IF "%context%"=="" (GOTO :NO_CONTEXT)

REM Get Polarion Context if found
for %%i in (%context%) do set "context=%%i"915	

IF "%context%"=="COORDINATOR" (
GOTO :COORDINATOR
) ELSE IF "%context%"=="NODE" (
GOTO :NODE
) ELSE IF "%context%"=="STANDALONE" (
GOTO :STANDALONE
) ELSE (
GOTO :NO_CONTEXT
)



REM rename as NODE plus NodeID
:NODE
for /F "delims=" %%a in ('findstr /s /p /c:"nodeId" %diagResults_dir%\*') do set nodeId=%%a
IF "%nodeId%"=="" (GOTO :NO_CONTEXT)
REM get NodeID Name only
for %%a in (%nodeId:"\"= %) do set nodeId=%%a

set newNameN=%context%.%nodeId%.%random:~-1%%random:~-1%%random:~-1%%random:~-1%.pdt
@echo Moving %newNameN% to pdt_diagsearch_logs folder
@echo %diagResults_dir% to %newNameN% >> pdt_diagsearch_logs/rename.log
IF EXIST %newNameN% (GOTO :EXISTS)
move %diagResults_dir% %newNameN% >nul
goto :eof



REM rename as COORDINATOR
:COORDINATOR
set newNameC=%context%.%random:~-1%%random:~-1%%random:~-1%%random:~-1%.pdt
@echo Moving %newNameC% to pdt_diagsearch_logs folder
@echo %diagResults_dir% to %newNameC% >> pdt_diagsearch_logs/rename.log
IF EXIST %newNameC% (GOTO :EXISTS)
move %diagResults_dir% %newNameC% >nul
goto :eof


REM rename as STANDALONE
:STANDALONE
set newNameS=%context%.%random:~-1%%random:~-1%%random:~-1%%random:~-1%.pdt
@echo Moving %newNameS% to pdt_diagsearch_logs folder
@echo %diagResults_dir% to %newNameS% >> pdt_diagsearch_logs/rename.log
IF EXIST %newNameS% (GOTO :EXISTS)
move %diagResults_dir% %newNameS% >nul
goto :eof




:NOFILE
@echo Warning: File not found
@echo  requires one arguement, the uncompressed PDT
goto :eof

:DONE_ALREADY
@echo Warning: This file is already exists
goto :eof

:EXISTS
@echo Warning: This file is already exists, will not rename this dir
@echo Warning: You have multiple diagtool results from same instance
goto :eof

:NO_CONTEXT
IF NOT EXIST pdt\ mkdir pdt
set newNameNO=NO_CONTEXT.%random:~-1%%random:~-1%%random:~-1%%random:~-1%.pdt
@echo Moving %newNameNO% to pdt_diagsearch_logs folder
@echo %diagResults_dir% to %newNameNO% >> pdt_diagsearch_logs/rename.log
move %diagResults_dir% %newNameNO% >nul
goto :eof




:BLANK
@echo Warning: No arguement given
@echo What diagsearch folder do want to rename?
goto :eof

:MAX
@echo Warning: Too many arguements
@echo You only need to add a zipped file
goto :eof



>>>>>>> origin/main
