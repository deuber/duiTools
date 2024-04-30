@echo off
setlocal enabledelayedexpansion

::this is needed cuz Windows sucks
::If linux no need for this crap

IF EXIST "C:\Users\%username%\bin\trunk" (@echo Required Tools Exist) ELSE (GOTO :EXIT)

::move to where tools live 
cd C:\Users\%username%\bin\trunk

::run the UI
python dui.py 

:EXIT
@echo --------------------------------------
@echo ERROR: missing required trunk folder 
@echo See Help doc to checkout tools
@echo https://cns.net.plm.eds.com/polarion/#/project/support/wiki/How%20To/Diagtool%20scripts
@echo Required location: C:\Users\%username%\bin\trunk
@echo Exiting program
@echo --------------------------------------
goto :eof

 
