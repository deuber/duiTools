@echo off
setlocal enabledelayedexpansion

REM Author David Deuber

REM =============================================================
REM This tool unzips any .zip file
REM First arguement is name of .zip file
REM ==============================================================

REM OLD way using 7zip
REM IF EXIST "C:\Program Files\7-Zip\7z.exe" (set ziptool="C:\Program Files\7-Zip\7z.exe") ELSE (GOTO :EXIT)
REM 4-12-2023 - using tar command to work with both Windows 11 and 10
REM tar.exe file is a part of the Microsoft Windows system
REM https://learn.microsoft.com/en-us/virtualization/community/team-blog/2017/20171219-tar-and-curl-come-to-windows

REM NEW way using TAR for Windows 10 and 11 users
where tar > nul 2>&1
if %errorlevel% equ 0 (
  echo Running: & where tar 
  ver | findstr /i "Version"
) else (
  echo Warning: "tar" command does not exist.
  (GOTO :EXIT)
)



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
set zipFile=%1
set uNzipFile=%zipFile:~0,-4%



IF NOT EXIST %zipFile% (GOTO :NOFILE)
IF EXIST %uNzipFile% (GOTO :DONE_ALREADY)


IF NOT EXIST zipDir (mkdir zipDir 2>nul)



@echo unpacking %zipFile% 

REM OLD way using 7zip
REM %ziptool% -r  x %zipFile% -oc:%uNzipFile% -y > nul


REM new Tar command to work with Windows 11 and 10
mkdir %uNzipFile% 2>nul
tar -zxf %zipFile% -C %uNzipFile%


@echo moving %zipFile% to zipDir
move %zipFile% zipDir 






goto :eof

:NOFILE
@echo Warning: %zipFile% file not found
@echo This tool requires one arguement, a zipped file
@echo Exiting script
goto :eof

:DONE_ALREADY
@echo Warning: This file is already unzipped
@echo Exiting script
goto :eof


:EXIT
REM @echo Warning: 7-Zip appears to be missing
REM @echo Download 7-Zip to "C:\Program Files\"

@echo Download tar.exe to C:\Windows\System32
@echo Exiting program
goto :eof

:BLANK
@echo Warning: No arguement given
@echo What file do want to unzip?
goto :eof

:MAX
@echo Warning: Too many arguements
@echo You only need to add a zipped file
goto :eof




