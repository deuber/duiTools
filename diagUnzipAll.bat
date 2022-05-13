@echo off

REM Author David Deuber

REM =============================================================
REM this tool unzips all your files within a dir
REM No arguement needed
REM ==============================================================


echo. 
echo.

rem Unzipping all diagtool results
for %%a in (*diagtool*.zip) do diagUnzip.bat  %%a 



goto :eof


:EXIT
echo ------------------------------------------
@echo Warning: No zip files here
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



