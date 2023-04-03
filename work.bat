@echo off
setlocal enabledelayedexpansion

set "ApplicationsList=applications.txt"

if not exist "%ApplicationsList%" (
    echo Error: Applications list file not found.
    exit /b 1
)

for /F "usebackq tokens=1,2 delims=;" %%A in ("%ApplicationsList%") do (
    set "AppName=%%A"
    set "AppPath=%%B"
    tasklist /FI "IMAGENAME eq !AppName!" 2>NUL | find /I /N "!AppName!">NUL
    if "!ERRORLEVEL!"=="1" (
        echo !AppName! not running. Starting...
        start "" "!AppPath!"
    ) else (
        echo !AppName! already running.
    )
)

endlocal
exit /b 0
