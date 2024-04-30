<<<<<<< HEAD
@echo off
setlocal enabledelayedexpansion


REM Author David Deuber

REM =============================================================
REM This tool does a recursive search on your PDT results
REM First arguement is required directory where you want to search
REM ==============================================================

echo.
echo.

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
set results=%logDir%
set logDir=%logDir%_diagsearch_logs
@echo Saving search results to %logDir%
@echo Diagsearch will look for strings within all files within the PDT results 
@echo This might take a awhile depending on the size of your PDT results
mkdir %logDir% 2>nul

del %logDir%\changelog 2>nul
@echo start: %time% >  %logDir%/changelog.log



@echo --------------------------------
del %logDir%\polarion.log 2>nul
@echo creating file %logDir%/polarion.log
@echo ############################################################## >  %logDir%/polarion.log
@echo TEST >>  %logDir%/polarion.log
@echo ############################################################## >>  %logDir%/polarion.log
@echo opening  %logDir%/polarion.log
start %editor%  %logDir%/polarion.log

@echo --------------------------------
del %logDir%\svn.log 2>nul
@echo creating file %logDir%/svn.log
@echo ############################################################## > %logDir%/svn.log
@echo TEST >> %logDir%/svn.log
@echo ############################################################## >> %logDir%/svn.log
@echo opening %logDir%/svn.log
start %editor% %logDir%/svn.log

@echo --------------------------------
del %logDir%\apache.log 2>nul
@echo creating file %logDir%/apache.log
@echo ############################################################## > %logDir%/apache.log
@echo TEST  >> %logDir%/apache.log
@echo ############################################################## >> %logDir%/apache.log
@echo opening %logDir%/apache.log
start %editor% %logDir%/apache.log

@echo --------------------------------
del %logDir%\java.log 2>nul
@echo creating file %logDir%/java.log
@echo ############################################################## > %logDir%/java.log
@echo TEST  >> %logDir%/java.log
@echo ############################################################## >> %logDir%/java.log
@echo opening %logDir%/java.log
start %editor% %logDir%/java.log

@echo --------------------------------
del %logDir%\timeout.log 2>nul
@echo creating %logDir%/timeout.log
@echo ############################################################## > %logDir%/timeout.log
@echo TEST>> %logDir%/timeout.log
@echo ############################################################## >> %logDir%/timeout.log
@echo opening %logDir%/timeout.log
start %editor% %logDir%/timeout.log

@echo --------------------------------
del %logDir%\ram.log 2>nul
@echo creating %logDir%/ram.log
@echo ############################################################## > %logDir%/ram.log
@echo TEST >> %logDir%/ram.log
@echo ############################################################## >> %logDir%/ram.log
@echo opening %logDir%/ram.log
start %editor% %logDir%/ram.log

@echo --------------------------------
del %logDir%\cpu.log 2>nul
@echo creating %logDir%/cpu.log
@echo ############################################################## > %logDir%/cpu.log
@echo TEST >> %logDir%/cpu.log
@echo ############################################################## >> %logDir%/cpu.log
@echo opening %logDir%/cpu.log
start %editor% %logDir%/cpu.log


@echo --------------------------------
del %logDir%\pso_se.log 2>nul
@echo creating %logDir%/pso_se.log
@echo ############################################################## > %logDir%/pso_se.log
@echo TEST >> %logDir%/pso_se.log
@echo ############################################################## >> %logDir%/pso_se.log
@echo opening %logDir%/pso_se.log
start %editor% %logDir%/pso_se.log


@echo --------------------------------
del %logDir%\scriptIssues.log 2>nul
@echo creating %logDir%/scriptIssues.log
@echo ############################################################## > %logDir%/scriptIssues.log
@echo TEST >> %logDir%/scriptIssues.log
@echo ############################################################## >> %logDir%/scriptIssues.log
@echo opening %logDir%/scriptIssues.log
start %editor% %logDir%/scriptIssues.log


@echo --------------------------------
del %logDir%\postgreSQL.log 2>nul
@echo creating %logDir%/postgreSQL.log
@echo ############################################################## > %logDir%/postgreSQL.log
@echo TEST >> %logDir%/postgreSQL.log
@echo ############################################################## >> %logDir%/postgreSQL.log
@echo opening %logDir%/postgreSQL.log
start %editor% %logDir%/postgreSQL.log




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
@echo What you want to search for?
goto :eof





=======
@echo off
setlocal enabledelayedexpansion


REM Author David Deuber

REM =============================================================
REM This tool does a recursive search on your PDT results
REM First arguement is required directory where you want to search
REM ==============================================================

echo.
echo.

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
set results=%logDir%
set logDir=%logDir%_diagsearch_logs
@echo Saving search results to %logDir%
@echo Diagsearch will look for strings within all files within the PDT results 
@echo This might take a awhile depending on the size of your PDT results
mkdir %logDir% 2>nul

del %logDir%\changelog 2>nul
@echo start: %time% >  %logDir%/changelog.log



@echo --------------------------------
del %logDir%\polarion.log 2>nul
@echo creating file %logDir%/polarion.log
@echo ############################################################## >  %logDir%/polarion.log
@echo TEST >>  %logDir%/polarion.log
@echo ############################################################## >>  %logDir%/polarion.log
@echo opening  %logDir%/polarion.log
start %editor%  %logDir%/polarion.log

@echo --------------------------------
del %logDir%\svn.log 2>nul
@echo creating file %logDir%/svn.log
@echo ############################################################## > %logDir%/svn.log
@echo TEST >> %logDir%/svn.log
@echo ############################################################## >> %logDir%/svn.log
@echo opening %logDir%/svn.log
start %editor% %logDir%/svn.log

@echo --------------------------------
del %logDir%\apache.log 2>nul
@echo creating file %logDir%/apache.log
@echo ############################################################## > %logDir%/apache.log
@echo TEST  >> %logDir%/apache.log
@echo ############################################################## >> %logDir%/apache.log
@echo opening %logDir%/apache.log
start %editor% %logDir%/apache.log

@echo --------------------------------
del %logDir%\java.log 2>nul
@echo creating file %logDir%/java.log
@echo ############################################################## > %logDir%/java.log
@echo TEST  >> %logDir%/java.log
@echo ############################################################## >> %logDir%/java.log
@echo opening %logDir%/java.log
start %editor% %logDir%/java.log

@echo --------------------------------
del %logDir%\timeout.log 2>nul
@echo creating %logDir%/timeout.log
@echo ############################################################## > %logDir%/timeout.log
@echo TEST>> %logDir%/timeout.log
@echo ############################################################## >> %logDir%/timeout.log
@echo opening %logDir%/timeout.log
start %editor% %logDir%/timeout.log

@echo --------------------------------
del %logDir%\ram.log 2>nul
@echo creating %logDir%/ram.log
@echo ############################################################## > %logDir%/ram.log
@echo TEST >> %logDir%/ram.log
@echo ############################################################## >> %logDir%/ram.log
@echo opening %logDir%/ram.log
start %editor% %logDir%/ram.log

@echo --------------------------------
del %logDir%\cpu.log 2>nul
@echo creating %logDir%/cpu.log
@echo ############################################################## > %logDir%/cpu.log
@echo TEST >> %logDir%/cpu.log
@echo ############################################################## >> %logDir%/cpu.log
@echo opening %logDir%/cpu.log
start %editor% %logDir%/cpu.log


@echo --------------------------------
del %logDir%\pso_se.log 2>nul
@echo creating %logDir%/pso_se.log
@echo ############################################################## > %logDir%/pso_se.log
@echo TEST >> %logDir%/pso_se.log
@echo ############################################################## >> %logDir%/pso_se.log
@echo opening %logDir%/pso_se.log
start %editor% %logDir%/pso_se.log


@echo --------------------------------
del %logDir%\scriptIssues.log 2>nul
@echo creating %logDir%/scriptIssues.log
@echo ############################################################## > %logDir%/scriptIssues.log
@echo TEST >> %logDir%/scriptIssues.log
@echo ############################################################## >> %logDir%/scriptIssues.log
@echo opening %logDir%/scriptIssues.log
start %editor% %logDir%/scriptIssues.log


@echo --------------------------------
del %logDir%\postgreSQL.log 2>nul
@echo creating %logDir%/postgreSQL.log
@echo ############################################################## > %logDir%/postgreSQL.log
@echo TEST >> %logDir%/postgreSQL.log
@echo ############################################################## >> %logDir%/postgreSQL.log
@echo opening %logDir%/postgreSQL.log
start %editor% %logDir%/postgreSQL.log




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
@echo What you want to search for?
goto :eof





>>>>>>> origin/main
