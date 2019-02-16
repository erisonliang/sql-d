@ECHO off

CALL kill.bat

ECHO.
ECHO [SQL-D]:CLEAN/
ECHO.
ECHO   USAGE: 
ECHO      clean 
ECHO.

git clean -x -f -d
GOTO END

:END
ECHO.
ECHO [SQL-D]:CLEAN/END/
ECHO.
