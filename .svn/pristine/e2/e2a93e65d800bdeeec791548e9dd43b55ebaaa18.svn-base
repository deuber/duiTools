@echo off
setlocal enabledelayedexpansion

rem Check that a filename was provided as an argument
if "%1" == "" (
    echo Error: No Main log provided
    exit /b 1
)

set "filename=%1"

rem Open the file and read its contents
for /f "delims=" %%a in (%filename%) do (
    set "contents=%%a"
)

set "html_file=%filename%.html"

rem Build the command to run the jar file
set "command=java -jar C:\Users\o9cxuh\bin\trunk\plpa-1.0.1.jar -h %html_file% %filename%"

rem Run the command and capture the output
for /f "delims=" %%a in ('!command!') do (
    set "result=%%a"
    echo !result!
)

rem Open the resulting html file in the default web browser
start "" "file://%CD%\%html_file%"
