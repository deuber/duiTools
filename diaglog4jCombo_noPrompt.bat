@echo off


REM Author David Deuber


REM =============================================================
REM this tool combines all your log4j files into one file
REM run from the dir containing your log4j files
REM ==============================================================

REM ==============================================
set maxfile=30
REM limit the number of files to be combined
REM ==============================================

REM Don't run if exists
if EXIST log4all.log (GOTO :EXIT_ALREADY_DONE)

::default editor
set editor="C:\Program Files\glogg\glogg.exe"


REM Got log4j?

IF EXIST *.log* (echo Combining log4j files into one log4all.log) ELSE (GOTO :EXIT_NONE)
@echo Please wait 
@echo This can take time depending on size of files
@echo OR.....
@echo If this taking too long, killl the diagdoall with Cntrl-C
@echo Run instead running "diagdoall -nocombo"
@echo This will skip then this step
@echo See also "diagdoall -help"

REM move .csv out of the way
REM make excel dir if needed
if EXIST *csv* (if not exist excel_files mkdir excel_files )
REM move excel files to excek dir 
if EXIST *csv* ( move *csv* excel_files  >nul ) 





echo.
for %%a in (log4j*) do echo %%a 
echo.


REM Counting number of log4j files, too many might be bad
set i=0
for %%a in (log4j*) do set /a i+=1
if %i% gtr %maxfile% GOTO :EXIT_TOO_MANY

@echo off
FOR %%i IN ("%CD%\..") DO SET "folderName=%%~nxi"
echo Parent folder: %folderName%
set "logName=%folderName:~0,-4%"
echo new logName log4all.%logName%.log 



for %%a in (log4j*) do echo [%%a] >> log4all.%logName%.log & type "%%a" >> log4all.%logName%.log 


start %editor%  log4all.%logName%.log


goto :eof


rem :EXIT
rem echo ------------------------------------------
rem @echo Warning: Glogg or 7zip appears to be missing
rem @echo Download Glogg to "C:\Program Files\"
rem @echo Download 7-Zip to "C:\Program Files\"
rem @echo Exiting program
rem echo ------------------------------------------
rem goto :eof

:EXIT_NONE
echo ------------------------------------------
@echo Warning: No log files found to combine
@echo Exiting diaglog4Combo
echo ------------------------------------------
goto :eof

:EXIT_TOO_MANY
echo ------------------------------------------
@echo Warning: Too many log4j files
@echo Exiting program
echo ------------------------------------------

:EXIT_ALREADY_DONE
echo ------------------------------------------
@echo Warning: log4all.log aleady exists here
echo ------------------------------------------

goto :eof



