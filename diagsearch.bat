@echo off
setlocal enabledelayedexpansion


REM Author David Deuber

REM =============================================================
REM This tool does a recursive search on your PDT results
REM First arguement is required directory where you want to search
REM ==============================================================



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

rem Start fresh changelog
del %logDir%\change.log 2>nul



@echo --------------------------------
del %logDir%\polarion.log 2>nul
@echo creating file %logDir%/polarion.log
@echo ############################################################## >  %logDir%/polarion.log
@echo THIS LOG CONTAINS INFORMATION ON POLARION VERSION AND CONFIGURATION >>  %logDir%/polarion.log
@echo Each instance running Polarion must have the same Polarion version >>  %logDir%/polarion.log
@echo This log file shows if extensions are used >>  %logDir%/polarion.log
@echo This log file shows if patches are used >>  %logDir%/polarion.log
@echo This log file shows nodeId >>  %logDir%/polarion.log
@echo This log file shows what os is used (linux or Windows) >>  %logDir%/polarion.log
@echo This log file shows in what context Polarion was started  >>  %logDir%/polarion.log
@echo This log file shows in when Polarion was started  >>  %logDir%/polarion.log
@echo This log file shows Architecture, should be 64bit >>  %logDir%/polarion.log
@echo This log file shows Linux distribution name >>  %logDir%/polarion.log
@echo This log shows server start mode, reindex or normal>>  %logDir%/polarion.log
@echo ############################################################## >>  %logDir%/polarion.log
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
%1\* | findstr /v  "backup" | findstr /v  "bkp"| findstr /v  "orig" | findstr /v  "#" |  FINDSTR /v /r "data_jobs_logs" |  FINDSTR /v /r "metadata_logs" |  FINDSTR /v  "log4all.log"   >>  %logDir%/polarion.log
@echo opening  %logDir%/polarion.log
start %editor%  %logDir%/polarion.log



@echo --------------------------------
del %logDir%\svn.log 2>nul
@echo creating file %logDir%/svn.log
@echo ############################################################## > %logDir%/svn.log
@echo THIS LOG CONTAINS INFORMATION ON SVN VERSION AND CONFIGURATION  >> %logDir%/svn.log
@echo General recommendation for Subversion 1.9 on any 2016 or later environment  >> %logDir%/svn.log
@echo For improved performance use SVN Protocol  >> %logDir%/svn.log
@echo Always use SVN Path Authz short_circuit !!! >> %logDir%/svn.log
@echo Warning: IF repoSystem=svn missing below it then not used >> %logDir%/svn.log
@echo Make sure correct format settings are (format is NOT yet in Diag tool results) correct. >> %logDir%/svn.log
@echo Ask customer to provide contents of format file located in Polarion\data\svn\repo\db. >> %logDir%/svn.log
@echo See https://subversion.apache.org/docs/release-notes/1.9.html for which format >> %logDir%/svn.log

@echo ############################################################## >> %logDir%/svn.log
findstr /s /p /c:"mod_dav_svn.so=" ^
/s /p /c:"SVNInMemoryCacheSize" ^
/s /p /c:"repoSystem=" ^
/s /p /c:"short_circuit" ^
%1\* | findstr /v  "#" | findstr /v /i  "\\data_jobs_logs\\ \\metadata_logs\\ \\data_svn_access\\" |  FINDSTR /v /r "data_jobs_logs" |  FINDSTR /v /r "metadata_logs"  |  FINDSTR /v  "log4all.log"  >> %logDir%/svn.log
@echo opening %logDir%/svn.log
start %editor% %logDir%/svn.log

@echo --------------------------------
del %logDir%\apache.log 2>nul
@echo creating file %logDir%/apache.log
@echo ############################################################## > %logDir%/apache.log
@echo THIS LOG CONTAINS INFORMATION ON APACHE VERSION AND CONFIGURATION  >> %logDir%/apache.log
@echo This log file only shows apache version>>  %logDir%/apache.log
@echo If cluster environment SAME timeout should be used on all servers >>  %logDir%/apache.log
@echo ############################################################## >> %logDir%/apache.log
findstr /s /p /c:"Server version:" ^
/s /p /c:"timeout=" ^
%1\* | findstr ^/v  "#" |  FINDSTR /v /r "data_jobs_logs" |  FINDSTR /v /r "metadata_logs"  |  FINDSTR /v  "log4all.log"  >> %logDir%/apache.log
@echo opening %logDir%/apache.log
start %editor% %logDir%/apache.log

@echo --------------------------------
del %logDir%\java.log 2>nul
@echo creating file %logDir%/java.log
@echo ############################################################## > %logDir%/java.log
@echo THIS LOG CONTAINS INFORMATION ON JAVA VERSION AND CONFIGURATION  >> %logDir%/java.log
@echo Further Polarion service releases will no longer operate on Java version older than 1.8. >> %logDir%/java.log
@echo This log shows Java version, number of processors, Xms and Xms settings and Total physical memory size  >> %logDir%/java.log
@echo The Xmx value typically should be Total physical memory divided by two >> %logDir%/java.log
@echo If you see java.lang.OutOfMemoryErrors, ask for heap dump (.hprof) found in /polarion/data folder >> %logDir%/java.log
@echo Send the dumps to Omega for analysis >> %logDir%/java.log
@echo ############################################################## >> %logDir%/java.log
findstr /s /p /c:"environment.jvm.systemProperty.java.endorsed.dirs" ^
/s /p /c:"Total physical memory size" ^
/s /p /c:"Number of processors" ^
/s /p /c:"Xms" ^
/s /p /c:"Xmx" ^
/s /p /c:"java.runtime.version: " ^
/s /p /c:"java.lang.OutOfMemoryError" ^
%1\* | findstr /v /c:"#" | findstr /v /c:"420m" | findstr /v /c:"256m" | findstr /v /c:"shared" |  FINDSTR /v /r "data_jobs_logs" |  FINDSTR /v /r "metadata_logs" |  FINDSTR /v  "log4all.log"  >> %logDir%/java.log
@echo opening %logDir%/java.log
start %editor% %logDir%/java.log


@echo --------------------------------
del %logDir%\ram.log 2>nul
@echo creating %logDir%/ram.log
@echo ############################################################## > %logDir%/ram.log
@echo THIS LOG CONTAINS INFORMATION ABOUT RAM USAGE >> %logDir%/ram.log
@echo  If Gen pool shows very random results, you could have issues with lack of memory >> %logDir%/ram.log
@echo  Out of Memory messages mean you need to review XMX and XMS settings >> %logDir%/ram.log
@echo ############################################################## >> %logDir%/ram.log
findstr /s /p /c:"Old Gen pool" ^
 /s /p /c:"Out of memory" ^
 %1\* | findstr /v /c:"#" |  FINDSTR /v /r "data_jobs_logs" |  FINDSTR /v /r "metadata_logs"  |  FINDSTR /v  "log4all.log"  >> %logDir%/ram.log
@echo opening %logDir%/ram.log
start %editor% %logDir%/ram.log

@echo --------------------------------
del %logDir%\cpu.log 2>nul
@echo creating %logDir%/cpu.log
@echo ############################################################## > %logDir%/cpu.log
@echo THIS LOG CONTAINS INFORMATION ABOUT CPU NAME and PERFORMANCE >> %logDir%/cpu.log
@echo On Windows see PROCESSOR_IDENTIFIER to identify the cpu>> %logDir%/cpu.log
@echo On Linux see model name to identify the cpu>> %logDir%/cpu.log
@echo Google search the cpu name to get more info about processor, adequate?  >> %logDir%/cpu.log
@echo Also see Enterprise guide for cpu recommendations  >> %logDir%/cpu.log
@echo ############################################################## >> %logDir%/cpu.log
findstr /s /p /c:"environmentVariable.PROCESSOR_IDENTIFIER" ^
/s /p /c:"model name" ^
/s /p /c:"Number of processors" ^
%1\* | findstr /v /c:"cpuinfo" |  FINDSTR /v /r "data_jobs_logs" |  FINDSTR /v /r "metadata_logs" |  FINDSTR /v  "log4all.log"   >> %logDir%/cpu.log
@echo ############################################################## >> %logDir%/cpu.log
@echo Searching for string "Total time for which application threads were stopped"  >> %logDir%/cpu.log
@echo Warning: High total time of threads were stopped indicates issues with garbage collection >> %logDir%/cpu.log
@echo To better visualize garbage collection upload your gc.log here http://gceasy.io/ >> %logDir%/cpu.log
@echo Grep on "Full GC" withn Glogg UI >> %logDir%/cpu.log
@echo If Full GC cycles don't resolve to Zero, the cpu might not be fast enough or inadequate memory >> %logDir%/cpu.log
@echo ############################################################## >> %logDir%/cpu.log
findstr  /s /p /c:"Total time for which application threads were stopped" ^
/s /p /c:"Full GC cycles" ^
%1\* | findstr /v /c:"#" |  FINDSTR /v /r "data_jobs_logs" |  FINDSTR /v /r "metadata_logs"  |  FINDSTR /v  "log4all.log"  >> %logDir%/cpu.log
@echo opening %logDir%/cpu.log
start %editor% %logDir%/cpu.log


@echo --------------------------------
del %logDir%\pso_se.log 2>nul
@echo creating %logDir%/pso_se.log
@echo ############################################################## > %logDir%/pso_se.log
@echo THIS LOG CONTAINS DETAILS ABOUT PSO SCRIPT ENGINE IF USED >> %logDir%/pso_se.log
@echo Check to make sure if PSO_SE version will work with Polarion version >> %logDir%/pso_se.log
@echo See https://professionalservices.polarion.com/support/ScriptingEngine >> %logDir%/pso_se.log
@echo Often missed when updating PSO_SE is removal of .metadata and .config see link above >> %logDir%/pso_se.log
@echo ############################################################## >> %logDir%/pso_se.log
findstr /s /p /c:"Scripting Engine Service Title" ^
/s /p /c:"Scripting Engine Service ver:" ^
/s /p /c:"Specification Version:" ^
/s /p /c:"Scripting Engine Package Service Vendor:" ^
/s /p /c:"SE Library Service Title:" ^
/s /p /c:"SE Library Service ver:" ^
/s /p /c:"SE Library Service Vendor:" ^
%1\*  |  FINDSTR /v /r "data_jobs_logs" |  FINDSTR /v /r "metadata_logs"  |  FINDSTR /v  "log4all.log"  >> %logDir%/pso_se.log
@echo opening %logDir%/pso_se.log
start %editor% %logDir%/pso_se.log


@echo --------------------------------
del %logDir%\scriptIssues.log 2>nul
@echo creating %logDir%/scriptIssues.log
@echo ############################################################## > %logDir%/scriptIssues.log
@echo THIS LOG CONTAINS ISSUES THAT ARE LIKELY A RESULT OF BROKEN OR MISSING SCRIPTS >> %logDir%/scriptIssues.log
@echo Shows missing Post-Hook scripts >> %logDir%/scriptIssues.log
@echo Shows missing Pre-Hook scripts >> %logDir%/scriptIssues.log
@echo Shows Errors while parsing velocity >> %logDir%/scriptIssues.log >> %logDir%/scriptIssues.log
@echo ############################################################## >> %logDir%/scriptIssues.log
findstr /s /p /c:"No Post-Hook script found" ^
/s /p /c:"No Pre-Hook script found" ^
/s /p /c:"Error while parsing velocity" ^
 %1\* | findstr /v /c:"#" |  FINDSTR /v /r "data_jobs_logs" |  FINDSTR /v /r "metadata_logs"  |  FINDSTR /v  "log4all.log" >> %logDir%/scriptIssues.log
@echo opening %logDir%/scriptIssues.log
start %editor% %logDir%/scriptIssues.log


@echo --------------------------------
del %logDir%\postgreSQL.log 2>nul
@echo creating %logDir%/postgreSQL.log
@echo ############################################################## > %logDir%/postgreSQL.log
@echo THIS LOG CONTAINS INFORMATION ON POSTGRESQL VERSION AND CONFIGURATION>> %logDir%/postgreSQL.log
@echo max_connections should be less than 10 * number of CPUs >> %logDir%/postgreSQL.log
@echo shared_buffers should be 10% - 15% of total system RAM >> %logDir%/postgreSQL.log
@echo In general use PostgreSQL 9.2 or greater >> %logDir%/postgreSQL.log
@echo ############################################################## >> %logDir%/postgreSQL.log
findstr /s /p /c:"(PostgreSQL)" ^
%1\* | findstr /v /c:"#" |  FINDSTR /v /r "data_jobs_logs" |  FINDSTR /v /r "metadata_logs" |  FINDSTR /v  "log4all.log"   >> %logDir%/postgreSQL.log
@echo opening %logDir%/postgreSQL.log
start %editor% %logDir%/postgreSQL.log
goto :eof

:NODIR
@echo Warning: Directory not found
@echo diagsearch requires one arguement, the directory where you want to search 
@echo Exiting script
goto :eof

rem :EXIT
rem @echo --------------------------------------
rem @echo ERROR: missing required editor
rem @echo Download or fix your path %editor% 
rem @echo Exiting program
rem @echo --------------------------------------
rem goto :eof


:BLANK
@echo Warning: No arguement given
@echo What Directory do you want to search in?
goto :eof

:MAX
@echo Warning: Too many arguements
@echo What you want to search for?
goto :eof





