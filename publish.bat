@ECHO off

CALL kill.bat

ECHO.
ECHO [SQL-D]:PUBLISH/
ECHO.

IF EXIST .\build ( RMDIR /S /Q .\build )
IF NOT EXIST .\build ( MKDIR .\build )

SET Configuration=Release
SET TargetFramework=netcoreapp3.1

SET LibProjectPath=./src/sql-d/SqlD.csproj
dotnet build %LibProjectPath% || EXIT /B 1
dotnet pack %LibProjectPath% -o ./build --include-symbols || EXIT /B 1
	
SET StartLinuxX64ProjectPath=./src/sql-d.start.linux-x64/SqlD.Start.linux-x64.csproj
dotnet publish %StartLinuxX64ProjectPath% -r linux-x64 --self-contained || EXIT /B 1
dotnet pack %StartLinuxX64ProjectPath% -o ./build --include-symbols || EXIT /B 1
	
SET StartOsxX64ProjectPath=./src/sql-d.start.osx-x64/SqlD.Start.osx-x64.csproj
dotnet publish %StartOsxX64ProjectPath% -r osx-x64 --self-contained || EXIT /B 1
dotnet pack %StartOsxX64ProjectPath% -o ./build --include-symbols || EXIT /B 1

SET StartWinX64ProjectPath=./src/sql-d.start.win-x64/SqlD.Start.win-x64.csproj
dotnet publish %StartWinX64ProjectPath% -r win-x64 --self-contained || EXIT /B 1
dotnet pack %StartWinX64ProjectPath% -o ./build --include-symbols || EXIT /B 1

dotnet add .\src\sql-d.ui\SqlD.UI.csproj package sql-d --source %CD%\build --package-directory .\build
dotnet add .\src\sql-d.ui\SqlD.UI.csproj package sql-d.start.win-x64 --source %CD%\build --package-directory .\build
dotnet add .\src\sql-d.ui\SqlD.UI.csproj package sql-d.start.linux-x64 --source %CD%\build --package-directory .\build
dotnet add .\src\sql-d.ui\SqlD.UI.csproj package sql-d.start.osx-x64 --source %CD%\build --package-directory .\build

SET UIProjectPath=./src/sql-d.ui/SqlD.UI.csproj
dotnet build %UIProjectPath% -c Release

dotnet add .\src\sql-d.ui.linux-x64\SqlD.UI.linux-x64.csproj package sql-d --source %CD%\build --package-directory .\build
dotnet add .\src\sql-d.ui.linux-x64\SqlD.UI.linux-x64.csproj package sql-d.start.linux-x64 --source %CD%\build --package-directory .\build

SET UILinuxX64ProjectPath=./src/sql-d.ui.linux-x64/SqlD.UI.linux-x64.csproj
dotnet publish %UILinuxX64ProjectPath% -r linux-x64 --self-contained
xcopy /E /F /Y /S src\sql-d.ui.linux-x64\bin\Release\%TargetFramework%\Views src\sql-d.ui.linux-x64\bin\Release\%TargetFramework%\linux-x64\publish\Views\
xcopy /E /F /Y /S src\sql-d.ui.linux-x64\bin\Release\%TargetFramework%\sql-d.start src\sql-d.ui.linux-x64\bin\Release\%TargetFramework%\linux-x64\publish\sql-d.start\
dotnet pack %UILinuxX64ProjectPath% -o ./build --include-symbols

dotnet add .\src\sql-d.ui.osx-x64\SqlD.UI.osx-x64.csproj package sql-d --source %CD%\build --package-directory .\build
dotnet add .\src\sql-d.ui.osx-x64\SqlD.UI.osx-x64.csproj package sql-d.start.osx-x64 --source %CD%\build --package-directory .\build

SET UIOsxX64ProjectPath=./src/sql-d.ui.osx-x64/SqlD.UI.osx-x64.csproj
dotnet publish %UIOsxX64ProjectPath% -r osx-x64 --self-contained || EXIT /B 1
xcopy /E /F /Y /S src\sql-d.ui.osx-x64\bin\Release\%TargetFramework%\Views src\sql-d.ui.osx-x64\bin\Release\%TargetFramework%\osx-x64\publish\Views\
xcopy /E /F /Y /S src\sql-d.ui.osx-x64\bin\Release\%TargetFramework%\sql-d.start src\sql-d.ui.osx-x64\bin\Release\%TargetFramework%\osx-x64\publish\sql-d.start\
dotnet pack %UIOsxX64ProjectPath% -o ./build --include-symbols || EXIT /B 1

dotnet add .\src\sql-d.ui.win-x64\SqlD.UI.win-x64.csproj package sql-d --source %CD%\build --package-directory .\build
dotnet add .\src\sql-d.ui.win-x64\SqlD.UI.win-x64.csproj package sql-d.start.win-x64 --source %CD%\build --package-directory .\build

SET UIWinX64ProjectPath=./src/sql-d.ui.win-x64/SqlD.UI.win-x64.csproj
dotnet publish %UIWinX64ProjectPath% -r win-x64 --self-contained || EXIT /B 1
xcopy /E /F /Y /S src\sql-d.ui.win-x64\bin\Release\%TargetFramework%\Views src\sql-d.ui.win-x64\bin\Release\%TargetFramework%\win-x64\publish\Views\
xcopy /E /F /Y /S src\sql-d.ui.win-x64\bin\Release\%TargetFramework%\sql-d.start src\sql-d.ui.win-x64\bin\Release\%TargetFramework%\win-x64\publish\sql-d.start\
dotnet pack %UIWinX64ProjectPath% -o ./build --include-symbols || EXIT /B 1
