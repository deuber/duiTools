@echo off
echo ------------------
echo loading my aliases
echo This cmd prompt has Admin privedges
echo ------------------



rem cuz I hate windows
doskey ls=dir $*
doskey mv=move $*
doskey rm=del $*
doskey cp=copy $*
doskey which=where
doskey u=cd ../
doskey uu=cd ../../
doskey home=cd %homepath%
doskey designer="C:\Program Files (x86)\Qt Designer\designer.exe"

rem diagtools aliases
doskey doall  = diagdoall
doskey dotest = diagdoall -test
doskey donobo = diagdoall -nocombo
doskey dohelp = diagdoall -help

doskey cp=copy $*
doskey which=where


doskey restart_polarion=C:\Windows\System32\net.exe stop polarion $T C:\Windows\System32\net.exe start polarion


doskey tail=Wintail.exe $*


doskey u=cd ../
doskey uu=cd ../../
doskey home=cd %homepath%

cd %homepath%

doskey c_home=cd C:\Users\%username%\Desktop\customers
doskey p_home=cd C:\Polarion
doskey bin=cd C:\Users\%username%\bin
doskey trunk=cd C:\Users\%username%\bin\trunk


doskey p_home=cd C:\Polarion
doskey p_logs=cd C:\Polarion\data\logs
doskey net_pol=net $* Polarion
doskey net_sql=net $* PostgreSQLPolarion
doskey net_svn=net $* PolarionSvnserve
doskey net_apache=net $*  Apache2Polarion



doskey new=dir /O:D /T:W /A:-D $T echo %DATE%
doskey h = doskey /history
doskey kill    = taskkill /PID $*
doskey man     = help $*
doskey ps      = tasklist $*
doskey pwd     = cd
doskey nuke     = rd /s /q $* 



doskey e="C:\Program Files\Sublime Text 3\sublime_text.exe" $*
doskey ea="C:\Program Files\Sublime Text 3\sublime_text.exe" C:\Users\%username%\bin\a.cmd
doskey np="C:\Program Files\Notepad++\notepad++" $*
doskey glogit="C:\Program Files\glogg\glogg" $*
doskey explorer.chdir=explorer .

rem since I always do this
IF NOT EXIST zipDir (mkdir C:\Users\%username%\Desktop\customers 2>nul)
cd C:\Users\%username%\Desktop\customers