@echo off

::restarts Apache/Polarion/Service

@echo ####################################
@echo CD to C:\Polarion\polarion
chdir C:\Polarion\polarion 

@echo ####################################
@echo Restarting Apache:
net stop  Apache2Polarion > nul 
net start Apache2Polarion > nul 


@echo ####################################
@echo Stopping Polarion:
net stop polarion > nul 


@echo ####################################
@echo Uninstalling and Installing service:
call service.bat -uninstall > nul 
call service.bat -install > nul 



@echo ####################################
@echo Starting Polarion:
net start polarion > nul 


@echo ####################################
@echo Run check:

net start | FIND "Polarion"

