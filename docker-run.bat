@echo off
setlocal enabledelayedexpansion

:: Print a new line
echo.

:: Get the directory of the script
for %%A in ("%~dp0") do set "script_dir=%%~fA"

:: Check if X Server is running on Windows (Can download/install from here: https://sourceforge.net/projects/vcxsrv/files/latest/download)
set "vcxsrv_command="C:\Program Files\VcXsrv\xlaunch.exe2" -run "%script_dir%windows-vcxsrv-config.xlaunch""
set "vcxsrvProcessName=vcxsrv.exe"
tasklist | find /i "%vcxsrvProcessName%" > nul
if %errorlevel% equ 0 (
    echo %vcxsrvProcessName% is already running! Assuming the settings are correct, we should be good to go!
) else (
    echo %vcxsrvProcessName% is not running, attempting to start with the following command:
    echo !vcxsrv_command!
    echo.
    !vcxsrv_command!
    CALL echo Return code from starting vcxsrv: %%errorlevel%%
    :: This checks if greater than or equal to for some reason
    echo If that return code was anything other than 0, then you probably don't have VcXsrv installed: https://sourceforge.net/projects/vcxsrv/files/latest/download
)

:: Construct the Docker command
set "docker_command=docker run -it --rm --net=host --ipc=host -e DISPLAY=host.docker.internal:0.0 --mount type=bind,source="%script_dir%",target=/root/nltk-docker nltk-docker"

:: Launch the command
echo.
echo Launching a Docker Container with the following command:
echo !docker_command!
echo.
!docker_command!
