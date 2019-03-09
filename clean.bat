@ECHO off

CALL kill.bat

ECHO.
ECHO [SQL-D]:CLEAN/
ECHO.
ECHO   USAGE: 
ECHO      clean 
ECHO.

git clean -x -f -d || EXIT /B 1
dotnet nuget locals global-packages --clear || EXIT /B 1

GOTO END

:END
ECHO.
ECHO [SQL-D]:CLEAN/END/
ECHO.
