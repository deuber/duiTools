<<<<<<< HEAD
@echo off
setlocal enabledelayedexpansion

REM Author David Deuber

REM =============================================================
REM This tool renames the diagtool results based on context 
REM ==============================================================


@echo ------------------------------
set argCount=0
for %%x in (%*) do (
   set /A argCount+=1
   set "argVec[!argCount!]=%%~x"
)

IF %argCount% equ 0 (goto BLANK )
IF %argCount% equ 1 (goto ONE )
IF %argCount% equ 2 (goto TWO )
IF %argCount% equ 3 (goto THREE )
IF %argCount% gtr 3 (goto MAX )

:THREE
rem take input from user 
rem diagUpload CustomerName IR_NUMBER ZIP_FILE

set CustomerName=%1
set IR_folder=%2
set zipFile=%3

IF NOT EXIST %zipFile% (GOTO :NOZIP)

set diagResults_dir= "\\10.123.30.101\polarion\Support\"

REM set diagResults_dir= "\\storage.labs.polarion.com\polarion\Support\%1\%2"

IF NOT EXIST %diagResults_dir% (GOTO :NOFILE)

set diagResults_dir_IR= \\10.123.30.101\polarion\Support\%1\%2


set uploaded_file= \\storage.labs.polarion.com\polarion\Support\%1\%2

IF EXIST %diagResults_dir_IR% (GOTO :DIR_EXISTS)
IF NOT EXIST %diagResults_dir_IR% (GOTO :MAKEDIR)


:ONE
@echo Warning: No arguements
@echo The tool requires 3 arguements
@echo eg. diagUpload CustomerName IR_NUMBER ZIP_FILE
@echo Warning: Exiting Tool
@echo ------------------------------
goto :eof

:TWO
@echo Warning: Not enough arguements
@echo The tool requires 3 arguements
@echo eg. diagUpload CustomerName IR_NUMBER ZIP_FILE
@echo Warning: Exiting Tool
@echo ------------------------------
goto :eof


:DIR_EXISTS
@echo Copying %3 to %diagResults_dir_IR%
xcopy   %3  %diagResults_dir_IR%
@echo You can find their upload here:
@echo %uploaded_file% 
@echo ------------------------------
goto :eof


:MAKEDIR
@echo Creating new dirs %1 and %2 within %diagResults_dir%
mkdir %diagResults_dir_IR%
@echo Copying %3 to %diagResults_dir_IR%
xcopy  %3  %diagResults_dir_IR%
@echo You can find their upload here:
@echo %uploaded_file% 
@echo ------------------------------
goto :eof


goto :eof


:NOZIP
@echo Warning: %2% Does not exist
@echo The tool requires 3 arguements
@echo eg. diagUpload CustomerName IR_NUMBER ZIP_FILE
@echo Warning: Exiting Tool
@echo ------------------------------
goto :eof


:NOFILE
@echo Warning: %diagResults_dir% Directory not found 
@echo The tool requires 3 arguements
@echo eg. diagUpload CustomerName IR_NUMBER ZIP_FILE
@echo Warning: Exiting Tool
@echo ------------------------------
goto :eof



:BLANK
@echo Warning: No arguements given? 
@echo The tool requires 3 arguements
@echo eg. diagUpload CustomerName IR_NUMBER ZIP_FILE
@echo Warning: Exiting Tool
@echo ------------------------------
goto :eof

:MAX
@echo Warning: Too many arguements
@echo The tool requires 3 arguements
@echo eg. diagUpload IR_NUMBER ZIP_FILE
@echo Warning: Exiting Tool
@echo ------------------------------
goto :eof





=======
@echo off
setlocal enabledelayedexpansion

REM Author David Deuber

REM =============================================================
REM This tool renames the diagtool results based on context 
REM ==============================================================


@echo ------------------------------
set argCount=0
for %%x in (%*) do (
   set /A argCount+=1
   set "argVec[!argCount!]=%%~x"
)

IF %argCount% equ 0 (goto BLANK )
IF %argCount% equ 1 (goto ONE )
IF %argCount% equ 2 (goto TWO )
IF %argCount% equ 3 (goto THREE )
IF %argCount% gtr 3 (goto MAX )

:THREE
rem take input from user 
rem diagUpload CustomerName IR_NUMBER ZIP_FILE

set CustomerName=%1
set IR_folder=%2
set zipFile=%3

IF NOT EXIST %zipFile% (GOTO :NOZIP)

set diagResults_dir= "\\10.123.30.101\polarion\Support\"

REM set diagResults_dir= "\\storage.labs.polarion.com\polarion\Support\%1\%2"

IF NOT EXIST %diagResults_dir% (GOTO :NOFILE)

set diagResults_dir_IR= \\10.123.30.101\polarion\Support\%1\%2


set uploaded_file= \\storage.labs.polarion.com\polarion\Support\%1\%2

IF EXIST %diagResults_dir_IR% (GOTO :DIR_EXISTS)
IF NOT EXIST %diagResults_dir_IR% (GOTO :MAKEDIR)


:ONE
@echo Warning: No arguements
@echo The tool requires 3 arguements
@echo eg. diagUpload CustomerName IR_NUMBER ZIP_FILE
@echo Warning: Exiting Tool
@echo ------------------------------
goto :eof

:TWO
@echo Warning: Not enough arguements
@echo The tool requires 3 arguements
@echo eg. diagUpload CustomerName IR_NUMBER ZIP_FILE
@echo Warning: Exiting Tool
@echo ------------------------------
goto :eof


:DIR_EXISTS
@echo Copying %3 to %diagResults_dir_IR%
xcopy   %3  %diagResults_dir_IR%
@echo You can find their upload here:
@echo %uploaded_file% 
@echo ------------------------------
goto :eof


:MAKEDIR
@echo Creating new dirs %1 and %2 within %diagResults_dir%
mkdir %diagResults_dir_IR%
@echo Copying %3 to %diagResults_dir_IR%
xcopy  %3  %diagResults_dir_IR%
@echo You can find their upload here:
@echo %uploaded_file% 
@echo ------------------------------
goto :eof


goto :eof


:NOZIP
@echo Warning: %2% Does not exist
@echo The tool requires 3 arguements
@echo eg. diagUpload CustomerName IR_NUMBER ZIP_FILE
@echo Warning: Exiting Tool
@echo ------------------------------
goto :eof


:NOFILE
@echo Warning: %diagResults_dir% Directory not found 
@echo The tool requires 3 arguements
@echo eg. diagUpload CustomerName IR_NUMBER ZIP_FILE
@echo Warning: Exiting Tool
@echo ------------------------------
goto :eof



:BLANK
@echo Warning: No arguements given? 
@echo The tool requires 3 arguements
@echo eg. diagUpload CustomerName IR_NUMBER ZIP_FILE
@echo Warning: Exiting Tool
@echo ------------------------------
goto :eof

:MAX
@echo Warning: Too many arguements
@echo The tool requires 3 arguements
@echo eg. diagUpload IR_NUMBER ZIP_FILE
@echo Warning: Exiting Tool
@echo ------------------------------
goto :eof





>>>>>>> origin/main
