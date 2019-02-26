@ECHO off

CALL kill.bat

ECHO.
ECHO [SQL-D]:PUBLISH-NUGET/
ECHO.

dotnet nuget push ./build/sql-d/sql-d.1.0.2.nupkg -s https://api.nuget.org/v3/index.json -k %NUGET_API_PUBLISH_KEY%
dotnet nuget push ./build/sql-d/sql-d.start.linux-x64.1.0.2.nupkg -s https://api.nuget.org/v3/index.json -k %NUGET_API_PUBLISH_KEY%
dotnet nuget push ./build/sql-d/sql-d.start.osx-x64.1.0.2.nupkg -s https://api.nuget.org/v3/index.json -k %NUGET_API_PUBLISH_KEY%
dotnet nuget push ./build/sql-d/sql-d.start.linu-x64.1.0.2.nupkg -s https://api.nuget.org/v3/index.json -k %NUGET_API_PUBLISH_KEY%
GOTO END

:END
ECHO.
ECHO [SQL-D]:PUBLISH-NUGET/END/
ECHO	Success
ECHO.