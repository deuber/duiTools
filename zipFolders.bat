@echo off
set folder=%1
if "%folder%" == "" (
  echo Please specify a folder path as the first argument.
  goto end
)

for /d %%f in ("%folder%\*") do (
  "C:\Program Files\7-Zip\7z.exe" a -tzip "%folder%\%%~nf.zip" "%%f"
)

:end