@echo off
setlocal enabledelayedexpansion

rem Define the path where your PHP versions are stored
@REM for example C:\laragon\bin\php
set phpDir=

rem Get list of available PHP versions
set i=0
for /D %%d in ("%phpDir%\*") do (
    set /A i+=1
    set "phpVersions[!i!]=%%~nxd"
)

rem Display the list
:menu
cls
echo Select the PHP version to use:
for /L %%i in (1,1,%i%) do (
    echo [%%i] !phpVersions[%%i]!
)

rem Get the user's selection
set /p choice=Enter the number corresponding to the version you want:

rem Validate the choice
if "!phpVersions[%choice%]!"=="" (
    echo Invalid selection! Try again.
    pause
    goto menu
)

rem Set the selected PHP version
set "selectedVersion=!phpVersions[%choice%]!"

rem Get the current PATH for the user from the registry
for /f "tokens=2*" %%P in ('reg query "HKCU\Environment" /v PATH 2^>nul') do set "userPath=%%Q"

rem Create a new PATH, excluding any old PHP directories
set "newPath="
for %%P in ("%userPath:;=";"%") do (
    echo %%P | find /i "%phpDir%\php-" >nul
    if errorlevel 1 (
        rem Only add the path if it's not empty
        if not "%%~P"=="" (
            set "newPath=!newPath!;%%~P"
        )
    )
)

rem Remove leading semicolons and add the new PHP version
if not "!newPath!"=="" (
    set "newPath=!newPath:~1!"
)
set "newPath=!newPath!;%phpDir%\%selectedVersion%;%phpDir%\%selectedVersion%\ext%"

rem Update user PATH using PowerShell (to avoid truncation issues)
powershell -Command "[System.Environment]::SetEnvironmentVariable('PATH', '%newPath%', [System.EnvironmentVariableTarget]::User)"

echo PHP version switched to "%selectedVersion%" for user.
exit
