<<<<<<< HEAD
@echo off

echo ----------------------------
echo This script zips AND then deletes folders in the dir
echo ----------------------------


FOR /d %%X IN (*) DO (
    
    ECHO Compressing %%X
    "c:\Program Files\7-Zip\7z.exe" a "%%X" ".\%%X\*"

    ECHO Deleting dir %%X
    rmdir /S /Q "%%X"
)






=======
@echo off

echo ----------------------------
echo This script zips AND then deletes folders in the dir
echo ----------------------------


FOR /d %%X IN (*) DO (
    
    ECHO Compressing %%X
    "c:\Program Files\7-Zip\7z.exe" a "%%X" ".\%%X\*"

    ECHO Deleting dir %%X
    rmdir /S /Q "%%X"
)






>>>>>>> origin/main
