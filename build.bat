@ECHO off

CALL kill.bat

ECHO.
ECHO [SQL-D]:BUILD/
ECHO.

ECHO "Please make sure you call `publish` first. This will fail otherwise."

SET Configuration=Release
SET TargetFramework=netcoreapp2.2

dotnet add .\tests\sql-d\SqlD.Tests.csproj package sql-d --package-directory .\build
dotnet add .\tests\sql-d\SqlD.Tests.csproj package sql-d.start.win-x64 --package-directory .\build
dotnet build .\tests\sql-d\SqlD.Tests.csproj -r win-x64 -c Debug
dotnet test .\tests\sql-d\SqlD.Tests.csproj -r win-x64 -c Debug

git checkout .\tests\sql-d\SqlD.Tests.csproj
