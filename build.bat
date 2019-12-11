@ECHO off

ECHO.
ECHO [SQL-D]:BUILD/
ECHO.

ECHO "Please make sure you call `publish` first. This will fail otherwise."

SET Configuration=Release
SET TargetFramework=netcoreapp3.1

dotnet restore .\tests\sql-d\SqlD.Tests.csproj

dotnet add .\tests\sql-d\SqlD.Tests.csproj package sql-d --source %CD%\build --package-directory .\build
dotnet add .\tests\sql-d\SqlD.Tests.csproj package sql-d.start.win-x64 --source %CD%\build --package-directory .\build
dotnet add .\tests\sql-d\SqlD.Tests.csproj package sql-d.start.linux-x64 --source %CD%\build --package-directory .\build
dotnet add .\tests\sql-d\SqlD.Tests.csproj package sql-d.start.osx-x64 --source %CD%\build --package-directory .\build

dotnet build .\tests\sql-d\SqlD.Tests.csproj -r win-x64 -c Debug --source %CD%\build
dotnet test .\tests\sql-d\SqlD.Tests.csproj -r win-x64 -c Debug
