@echo off

REM : Navigate where to main log folder
REM : Run command Eg. 'usersLog log4j-20220524-1822-05.log'

set mainlog=%1
if not defined mainlog (
    echo Usage: %0 mainlog
    echo Usage: cd to where the main file exists
    echo Example: %0 "log4j-20220524-1822-05.log"
    exit /b 1
)

if /i not "%~x1"==".log" (
    echo Usage: %0 mainlog
    echo Error: Only .log files are allowed.
    exit /b 1
)

set outputfile=%mainlog%_loggedIn.log

findstr /s /p /c:"logged in with" /s /p /c:"com.polarion.platform.realm.PolarionRealm" %mainlog% > "%outputfile%"
type "%outputfile%"
echo Opening "%outputfile%"
start "" "%outputfile%"

