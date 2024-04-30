@echo off
setlocal enabledelayedexpansion


:: Author David Deuber

:: =============================================================
:: Sets your e here
::set e="glogg"
set e="klogg"
:: ==============================================================

if %e%=="glogg" (
    set editor="C:\Program Files\glogg\glogg.exe"
) else if %e%=="klogg" (
    set editor="C:\Program Files\klogg\klogg.exe"
) else (
    goto :EXIT
)


IF EXIST %editor% (echo.) ELSE (GOTO :EXIT)
@echo  %editor%
goto :eof

:EXIT
@echo Warning: %e% editor appears to be missing
@echo Download it to default location "C:\Program Files\"
@echo Exiting program
goto :eof


