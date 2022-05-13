@echo off
setlocal enabledelayedexpansion

REM Author David Deuber

REM Run diagdoall with or without options based on imput.


if "%~1" == "-help" (
    goto :HELP
) else if "%~1" == "-nocombo" (
    goto :RUNIT
) else if "%~1" == "-test" (
    goto :RUNIT
) else if "%~1" == "" (
    goto :RUNIT
) else (
    goto :INVALID
)



:RUNIT
::default editor
set editor="C:\Program Files\glogg\glogg.exe"

@echo -------------------------------------------------------    
@echo This tool will unpack and parse Daigtool results
@echo Run Diagdoall -help for more information
@echo -------------------------------------------------------

REM diagtool results exist? 
IF NOT EXIST *diagtool*.zip  (GOTO :EXIT_NONE)


REM create required folders if missing
IF NOT EXIST zipDir (mkdir zipDir 2>nul)
IF NOT EXIST pdt (mkdir pdt 2>nul)
IF NOT EXIST pdt_diagsearch_logs (mkdir pdt_diagsearch_logs 2>nul)


@echo -------------------------------------------------------
@echo Step One: Unzip all .zip files
@echo -------------------------------------------------------
@echo running diagUnzipAll.bat
rem start time
set unzipRenameStart=%date% %time%
CMD /c  diagUnzipAll.bat

@echo -------------------------------------------------------
@echo Step Two: Rename and move Diagtool results folders
@echo -------------------------------------------------------
@echo running diagRenameAll.bat
CMD /c diagRenameAll.bat
rem end time
set unzipRenameEnd=%date% %time%

IF "%~1"=="-nocombo" @echo HEADS UP: SKIPPING MAIN LOG COMBO & (GOTO SKIP)
IF "%~1"=="-test" @echo HEADS UP: SKIPPING DIAGSEARCH AND LOG COMBO & (GOTO SKIPSEARCH)
@echo -------------------------------------------------------
@echo Step Three: Combine log4j files within each instance
@echo -------------------------------------------------------
@echo running diaglog4jComboAll.bat
rem start time
set log4jComboStart=%date% %time%
CMD /c diaglog4jComboAll.bat pdt
rem end time
set log4jComboEnd=%date% %time%

:SKIP
@echo -------------------------------------------------------
@echo Last Four: Run Diasearch log parsing tool
@echo -------------------------------------------------------
@echo running diagsearch pdt
set diagsearchStart=%date% %time%
CMD /c  diagsearch pdt
set diagsearchEnd=%date% %time%

:SKIPSEARCH
@echo -------------------------------------------------------
@echo Additional logging
@echo -------------------------------------------------------



REM Runtime history log
@echo -------------------------------------------------------------------------------- >>pdt_diagsearch_logs/runtimes.log
@echo Unzip and Rename Start: %unzipRenameStart% >> pdt_diagsearch_logs/runtimes.log
@echo Unzip and Rename   End: %unzipRenameEnd%   >> pdt_diagsearch_logs/runtimes.log
@echo -------------------------------------------------------------------------------- >>pdt_diagsearch_logs/runtimes.log
@echo log4j Combo      Start: %log4jComboStart% >> pdt_diagsearch_logs/runtimes.log
@echo Log4j Combo        End: %log4jComboEnd%   >> pdt_diagsearch_logs/runtimes.log
@echo -------------------------------------------------------------------------------- >>pdt_diagsearch_logs/runtimes.log
@echo Diagsearch       Start: %unzipRenameStart% >> pdt_diagsearch_logs/runtimes.log
@echo Diagsearch         End: %unzipRenameEnd%   >> pdt_diagsearch_logs/runtimes.log




REM Changelog shows what changes have been made to tools
@echo -------------------------------------------------------------------------------- >pdt_diagsearch_logs/change.log
@echo Documentation: >>pdt_diagsearch_logs/change.log >>pdt_diagsearch_logs/change.log
@echo https://cns.net.plm.eds.com/polarion/#/project/support/wiki/How%20To/Diagtool%20scripts >>pdt_diagsearch_logs/change.log
@echo -------------------------------------------------------------------------------- >> pdt_diagsearch_logs/change.log
@echo Version: v2022.2 >> pdt_diagsearch_logs/change.log
@echo Updated 4-1-2022 >>pdt_diagsearch_logs/change.log 
@echo -------------------------------------------------------------------------------- >>pdt_diagsearch_logs/change.log
@echo Run "diagdoall -fast" to skip main log combo  >>pdt_diagsearch_logs/change.log
@echo Run "diagdoall -help" to show tool help >>pdt_diagsearch_logs/change.log
@echo Run "diagdoall -nocombo" TEST test no search >>pdt_diagsearch_logs/change.log
@echo Added random 4 digit number to prevent duplicates rename >>pdt_diagsearch_logs/change.log
@echo Rename  logging see tool.log >>pdt_diagsearch_logs/change.log
@echo Runtime logging see tool.log >>pdt_diagsearch_logs/change.log
@echo Version logging see tool.log >>pdt_diagsearch_logs/change.log
@echo Fixed issue "--more--" after unpacking files >>pdt_diagsearch_logs/change.log
@echo Can be run on Shared Server or ANY Diagtool Results missing "context" >>pdt_diagsearch_logs/change.log
@echo Diagdoall will exit if no zipped Diagtool results found >>pdt_diagsearch_logs/change.log
@echo Timeout.log merged into Apache.log >>pdt_diagsearch_logs/change.log
@echo New "do" aliases in a.cmd >>pdt_diagsearch_logs/change.log
@echo New UI option, see help about required Python/Pyqt >>pdt_diagsearch_logs/change.log


REM combine additional logs and view tool.log
@echo -------------------------------------------------------------------------------- > pdt_diagsearch_logs/tool.log
@echo TOOL HISTORY: >> pdt_diagsearch_logs/tool.log
type pdt_diagsearch_logs\change.log >> pdt_diagsearch_logs/tool.log
@echo -------------------------------------------------------------------------------- >> pdt_diagsearch_logs/tool.log
@echo RENAME HISTORY: >>pdt_diagsearch_logs/tool.log
@echo -------------------------------------------------------------------------------- >> pdt_diagsearch_logs/tool.log
type pdt_diagsearch_logs\rename.log >> pdt_diagsearch_logs/tool.log
@echo -------------------------------------------------------------------------------- >> pdt_diagsearch_logs/tool.log
@echo RUNTIME HISTORY: >>pdt_diagsearch_logs/tool.log
@echo -------------------------------------------------------------------------------- >> pdt_diagsearch_logs/tool.log
type pdt_diagsearch_logs\runtimes.log >> pdt_diagsearch_logs/tool.log
@echo -------------------------------------------------------------------------------- >> pdt_diagsearch_logs/tool.log
@echo opening pdt_diagsearch_logs/tool.log
start %editor% pdt_diagsearch_logs/tool.log



@echo -------------------------------------------------------
@echo All Diagtool results unpacked, renamed and parsed log files loaded 
@echo -------------------------------------------------------
goto :eof


:HELP
REM =============================================================
echo.
@echo This tool runs multiple diagtools in one command
echo.
@echo Run "diagdoall -help" to show tool help 
@echo Run "diagdoall -nocombo" to skip main log combo 
@echo Run "diagdoall -test" fast "no search" test
echo.
@echo See full documentation:
@echo https://cns.net.plm.eds.com/polarion/#/project/support/wiki/How%20To/Diagtool%20scripts
echo.
REM ==============================================================
goto :eof


:EXIT_NONE
echo ------------------------------------------
echo.
@echo Warning: No .zip files found with here with name including "diagtool_results"
@echo If your zipped files are in fact diagtool results, rename the file to include string "diagtool_results"
@echo Or are you running diagdoall from the wrong location?
@echo Please try again, nothing here todo
echo.
echo ------------------------------------------
goto :eof

:INVALID
REM =============================================================
echo.
@echo Invalid argument: Must be "-help" OR "-nocombo" OR "-test" or NO arguement
@echo Run "diagdoall -help" to learn how this tool works
echo.
REM ==============================================================
goto :eof

rem :EXIT
rem @echo --------------------------------------
rem @echo ERROR: missing required editor
rem @echo Download or fix your path %editor% 
rem @echo Exiting program
rem @echo --------------------------------------
rem goto :eof

