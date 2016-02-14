REM Check if the script is running in the Azure emulator and if so do not run

REM if "%EMULATED%"=="true" goto :end

set timehour=%time:~0,2%
set timestamp=%date:~-4,4%%date:~-10,2%%date:~-7,2%-%timehour: =0%%time:~3,2%
set startuptasklog=%PathToInstallLogs%\startuptasklog-%timestamp%.txt

echo !!! Actors.Host !!! >> %startuptasklog%


If "%UseServerGC%"=="False" GOTO :ValidateBackground
If "%UseServerGC%"=="0" GOTO :ValidateBackground
SET UseServerGC="True"

:ValidateBackground
If "%UseBackgroundGC%"=="False" GOTO :CommandExecution
If "%UseBackgroundGC%"=="0" GOTO :CommandExecution
SET UseBackgroundGC="True"

:CommandExecution
PowerShell.exe -executionpolicy unrestricted -command ".\GCSettingsManagement.ps1" -serverGC %UseServerGC% -backgroundGC %UseBackgroundGC%

echo !!! ServerGC.cmd completed: %date:~-4,4%%date:~-10,2%%date:~-7,2%-%timehour: =0%%time:~3,2% >> %startuptasklog%

:end
Exit /b