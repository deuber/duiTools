@echo off

REM Author David Deuber

REM =============================================================
REM this tool unzips all your files within a dir
REM No arguement needed
REM ==============================================================



REM Got zip files? 
IF NOT EXIST *.zip  (GOTO :EXIT_NONE)


echo Unzipping the following files

for %%a in (*.zip) do diagUnzip.bat  %%a 



goto :eof


:EXIT
echo ------------------------------------------
@echo Warning: No zip files here
@echo Exiting program
echo ------------------------------------------
goto :eof

:EXIT_NONE
echo ------------------------------------------
@echo Warning: No original zip files here
@echo Are you running from the location?
@echo Exiting program
echo ------------------------------------------
goto :eof



:EXIT_ALREADY_DONE
echo ------------------------------------------
@echo Warning: log4all.log aleady exists
@echo Warning: If you need to run again remove log4all.log and exit Glogg first
@echo Exiting program
echo ------------------------------------------
goto :eof



