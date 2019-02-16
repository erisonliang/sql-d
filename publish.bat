@ECHO off

CALL kill.bat

ECHO.
ECHO [SQL-D]:PUBLISH/
ECHO.
ECHO   USAGE: 
ECHO      publish ^<target^> ^<configuration^>
ECHO.
ECHO   WHERE:
ECHO      ^<target^>:
ECHO         all = Target windows
ECHO         win-x64 = Target windows
ECHO         osx-x64 = Target mac osx
ECHO         linux-x64 = Target linux
ECHO      ^<configuration^>:
ECHO         Debug = Debug compilation
ECHO         Release = Release compilation
ECHO.
ECHO   EXAMPLES:
ECHO      Executes pre-stage process
ECHO         ^> publish 
ECHO      Executes pre-stage process only targetting windows using a release compile
ECHO         ^> publish win-x64 release
ECHO      Executes pre-stage build process only targetting linux using a debug compile
ECHO         ^> publish linux-x64 debug

IF EXIST .\build ( DEL /F /S /Q .\build >NUL )

SET Target=win-x64
SET Bin7za=%cd%/tools/7-zip.commandline/18.1.0/tools/x64/7za
SET Configuration=Release
SET SolutionPath=./sql-d.sln
SET ProjectPath=./sql-d.csproj
SET LibProjectPath=./src/sql-d/SqlD.csproj
SET LibBuildPath=./build/sql-d
SET StartBuildPath=./build/sql-d.start
SET StartProjectPath=./src/sql-d.start/SqlD.Start.csproj
SET UIBuildPath=./build/sql-d.ui
SET UIProjectPath=./src/sql-d.ui/SqlD.UI.csproj
SET TestProjectPath=./tests/sql-d/SqlD.Tests.csproj
GOTO SET_TARGET

:SET_TARGET
ECHO.
ECHO [SQL-D]:PUBLISH/SET_TARGET/
ECHO.
IF "%1" NEQ "" (SET Target=%1)
ECHO Target=%Target%
GOTO SET_CONFIG

:SET_CONFIG
ECHO.
ECHO [SQL-D]:PUBLISH/SET_CONFIG/
ECHO.
IF "%2" NEQ "" (SET Configuration=%2)
ECHO Configuration=%Configuration%
GOTO PRE_BUILD

:PRE_BUILD
ECHO.
ECHO [SQL-D]:PUBLISH/PRE_BUILD/
ECHO.
IF NOT EXIST %cd%\%LibBuildPath:/=\% ( MKDIR %LibBuildPath:/=\% || EXIT /B 1 )
IF NOT EXIST %cd%\%StartBuildPath:/=\% ( MKDIR %StartBuildPath:/=\% || EXIT /B 1 )
IF NOT EXIST %cd%\%StartBuildPath:/=\%/win-x64.zip ( ECHO. 2>%StartBuildPath%\win-x64.zip || EXIT /B 1 )
IF NOT EXIST %cd%\%StartBuildPath:/=\%/osx-x64.zip ( ECHO. 2>%StartBuildPath%\osx-x64.zip || EXIT /B 1 )
IF NOT EXIST %cd%\%StartBuildPath:/=\%/linux-x64.zip ( ECHO. 2>%StartBuildPath%\linux-x64.zip || EXIT /B 1 )
dotnet restore %ProjectPath% --packages ./tools || EXIT /B 1
dotnet restore %LibProjectPath% || EXIT /B 1
dotnet restore %StartProjectPath% || EXIT /B 1
dotnet restore %UIProjectPath% || EXIT /B 1
GOTO PRE_BUILD_PUBLISH

:PRE_BUILD_PUBLISH
ECHO.
ECHO [SQL-D]:PUBLISH/PRE_BUILD_PUBLISH/
ECHO.
IF %Target%==all (
	dotnet publish %StartProjectPath% -c %Configuration% -r win10-x64 -o ../../%StartBuildPath%/win-x64 --self-contained || EXIT /B 1
	dotnet publish %StartProjectPath% -c %Configuration% -r osx-x64 -o ../../%StartBuildPath%/osx-x64 --self-contained || EXIT /B 1
	dotnet publish %StartProjectPath% -c %Configuration% -r linux-x64 -o ../../%StartBuildPath%/linux-x64 --self-contained || EXIT /B 1
)
IF %Target%==win-x64 (
	dotnet publish %StartProjectPath% -c %Configuration% -r win10-x64 -o ../../%StartBuildPath%/win-x64 --self-contained || EXIT /B 1
)
IF %Target%==osx-x64 (
	dotnet publish %StartProjectPath% -c %Configuration% -r osx-x64 -o ../../%StartBuildPath%/osx-x64 --self-contained || EXIT /B 1
)
IF %Target%==linux-x64 (
	dotnet publish %StartProjectPath% -c %Configuration% -r linux-x64 -o ../../%StartBuildPath%/linux-x64 --self-contained || EXIT /B 1
)
IF %Target%==all (
	IF EXIST %cd%\%StartBuildPath%/win-x64.zip ( DEL /Q /F %StartBuildPath:/=\%\win-x64.zip || EXIT /B 1 )
	%Bin7za% a -r -y %StartBuildPath%/win-x64.zip %StartBuildPath%/win-x64/*.* || EXIT /B 1
	%Bin7za% e -r -y %StartBuildPath%/win-x64.zip -o%StartBuildPath%/win-x64/ *.* || EXIT /B 1
	IF EXIST %cd%\%StartBuildPath%/osx-x64.zip ( DEL /Q /F %StartBuildPath:/=\%\osx-x64.zip || EXIT /B 1 )
	%Bin7za% a -r -y %StartBuildPath%/osx-x64.zip %StartBuildPath%/osx-x64/*.* || EXIT /B 1
	%Bin7za% e -r -y %StartBuildPath%/osx-x64.zip -o%StartBuildPath%/osx-x64/ *.* || EXIT /B 1
	IF EXIST %cd%\%StartBuildPath%/linux-x64.zip ( DEL /Q /F %StartBuildPath:/=\%\linux-x64.zip || EXIT /B 1 )
	%Bin7za% a -r -y %StartBuildPath%/linux-x64.zip %StartBuildPath%/linux-x64/*.* || EXIT /B 1
	%Bin7za% e -r -y %StartBuildPath%/linux-x64.zip -o%StartBuildPath%/linux-x64/ *.* || EXIT /B 1
)
IF %Target%==win-x64 (
	IF EXIST %cd%\%StartBuildPath%/win-x64.zip ( DEL /Q /F %StartBuildPath:/=\%\win-x64.zip || EXIT /B 1 )
	%Bin7za% a -r -y %StartBuildPath%/win-x64.zip %StartBuildPath%/win-x64/*.* || EXIT /B 1
	%Bin7za% e -r -y %StartBuildPath%/win-x64.zip -o%StartBuildPath%/win-x64/ *.* || EXIT /B 1
)
IF %Target%==osx-x64 (
	IF EXIST %cd%\%StartBuildPath%/osx-x64.zip ( DEL /Q /F %StartBuildPath:/=\%\osx-x64.zip || EXIT /B 1 )
	%Bin7za% a -r -y %StartBuildPath%/osx-x64.zip %StartBuildPath%/osx-x64/*.* || EXIT /B 1
	%Bin7za% e -r -y %StartBuildPath%/osx-x64.zip -o%StartBuildPath%/osx-x64/ *.* || EXIT /B 1
)
IF %Target%==linux-x64 (
	IF EXIST %cd%\%StartBuildPath%/linux-x64.zip ( DEL /Q /F %StartBuildPath:/=\%\linux-x64.zip || EXIT /B 1 )
	%Bin7za% a -r -y %StartBuildPath%/linux-x64.zip %StartBuildPath%/linux-x64/*.* || EXIT /B 1
	%Bin7za% e -r -y %StartBuildPath%/linux-x64.zip -o%StartBuildPath%/linux-x64/ *.* || EXIT /B 1
)
GOTO BUILD

:BUILD
ECHO.
ECHO [SQL-D]:PUBLISH/BUILD/
ECHO.

dotnet clean %LibProjectPath%

dotnet clean %StartProjectPath%

dotnet clean %UIProjectPath%

dotnet clean %TestProjectPath%

dotnet build %LibProjectPath%

dotnet build %StartProjectPath%

dotnet build %UIProjectPath%

dotnet build %TestProjectPath%

GOTO END

:END
ECHO.
ECHO [SQL-D]:PUBLISH/END/
ECHO	Success
ECHO.