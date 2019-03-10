@ECHO off

ECHO.
ECHO [SQL-D]:KILL/
ECHO.

tasklist /FI "IMAGENAME eq dotnet.exe" 2>NUL | find /I /N "dotnet.exe">NUL
if "%ERRORLEVEL%"=="0" ( taskkill /IM dotnet.exe /F )

tasklist /FI "IMAGENAME eq VBCSCompiler.exe" 2>NUL | find /I /N "VBCSCompiler.exe">NUL
if "%ERRORLEVEL%"=="0" ( taskkill /IM VBCSCompiler.exe /F )

tasklist /FI "IMAGENAME eq SqlD.Start.exe" 2>NUL | find /I /N "SqlD.Start.exe">NUL
if "%ERRORLEVEL%"=="0" ( taskkill /IM SqlD.Start.exe /F )

tasklist /FI "IMAGENAME eq SqlD.Start.win-x64.exe" 2>NUL | find /I /N "SqlD.Start.win-x64.exe">NUL
if "%ERRORLEVEL%"=="0" ( taskkill /IM "SqlD.Start.win-x64.exe" /F )
