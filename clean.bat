@ECHO off

CALL kill.bat

ECHO.
ECHO [SQL-D]:CLEAN/
ECHO.

git clean -x -f -d || EXIT /B 1
dotnet nuget locals global-packages --clear || EXIT /B 1
