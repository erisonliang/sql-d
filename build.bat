@ECHO off

CALL kill.bat

ECHO.
ECHO [SQL-D]:BUILD/
ECHO.
ECHO   USAGE: 
ECHO      build ^<target^> ^<configuration^> ^<stage^>
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
ECHO      ^<stage^>:
ECHO         all = Build everything
ECHO         pb = Pre-build process
ECHO         pbp = Publish pre-build to ^'./build/sql-d.start/^<target^>^'
ECHO         b = Full build
ECHO         bp = Publish build to ^'./build/sql-d.ui/^<target^>^'
ECHO.
ECHO   EXAMPLES:
ECHO      Executes entire build process
ECHO         ^> build
ECHO      Executes entire build process only targetting windows using a release compile
ECHO         ^> build win-x64 release
ECHO      Executes entire build process only targetting linux using a debug compile
ECHO         ^> build linux-x64 debug all

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
SET TestStartProjectPath=./tests/sql-d.start/SqlD.Start.Tests.csproj

GOTO SET_TARGET

:SET_TARGET
ECHO.
ECHO [SQL-D]:BUILD/SET_TARGET/
ECHO.
IF "%1" NEQ "" (SET Target=%1)
ECHO Target=%Target%
GOTO SET_CONFIG

:SET_CONFIG
ECHO.
ECHO [SQL-D]:BUILD/SET_CONFIG/
ECHO.
IF "%2" NEQ "" (SET Configuration=%2)
ECHO Configuration=%Configuration%
IF "%3" == "" GOTO PRE_BUILD
IF "%3" == "all" GOTO PRE_BUILD
IF "%3" == "pb" GOTO PRE_BUILD
IF "%3" == "pbp" GOTO PRE_BUILD_PUBLISH
IF "%3" == "b" GOTO BUILD
IF "%3" == "bp" GOTO BUILD_PUBLISH
GOTO PRE_BUILD

:PRE_BUILD
ECHO.
ECHO [SQL-D]:BUILD/PRE_BUILD/
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
ECHO [SQL-D]:BUILD/PRE_BUILD_PUBLISH/
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
ECHO [SQL-D]:BUILD/BUILD/
ECHO.

dotnet clean %LibProjectPath%

dotnet clean %StartProjectPath%

dotnet clean %UIProjectPath%

dotnet clean %TestProjectPath%

dotnet build %LibProjectPath%

dotnet build %StartProjectPath%

dotnet build %UIProjectPath%

dotnet build %TestProjectPath%

dotnet test %TestProjectPath% || EXIT /B 1

dotnet test %TestStartProjectPath% || EXIT /B 1

GOTO BUILD_PUBLISH

:BUILD_PUBLISH
ECHO.
ECHO [SQL-D]:BUILD/BUILD_PUBLISH/
ECHO.
IF %Target%==all (
	dotnet publish %UIProjectPath% -c %Configuration% -r win10-x64 -o ../../%UIBuildPath%/win-x64 --self-contained || EXIT /B 1
	dotnet publish %UIProjectPath% -c %Configuration% -r osx-x64 -o ../../%UIBuildPath%/osx-x64 --self-contained || EXIT /B 1
	dotnet publish %UIProjectPath% -c %Configuration% -r linux-x64 -o ../../%UIBuildPath%/linux-x64 --self-contained || EXIT /B 1
)
IF %Target%==win-x64 (
	dotnet publish %UIProjectPath% -c %Configuration% -r win10-x64 -o ../../%UIBuildPath%/win-x64 --self-contained || EXIT /B 1
)
IF %Target%==osx-x64 (
	dotnet publish %UIProjectPath% -c %Configuration% -r osx-x64 -o ../../%UIBuildPath%/osx-x64 --self-contained || EXIT /B 1
)
IF %Target%==linux-x64 (
	dotnet publish %UIProjectPath% -c %Configuration% -r linux-x64 -o ../../%UIBuildPath%/linux-x64 --self-contained || EXIT /B 1
)
REM IF %Target%==all (
REM 	IF EXIST %cd%\%UIBuildPath%/win-x64.zip ( DEL /Q /F %UIBuildPath:/=\%\win-x64.zip || EXIT /B 1 )
REM 	%Bin7za% a -r -y %UIBuildPath%/win-x64.zip %UIBuildPath%/win-x64/*.* || EXIT /B 1
REM 	%Bin7za% e -r -y %UIBuildPath%/win-x64.zip -o%UIBuildPath%/win-x64/ *.* || EXIT /B 1
REM 	IF EXIST %cd%\%UIBuildPath%/osx-x64.zip ( DEL /Q /F %UIBuildPath:/=\%\osx-x64.zip || EXIT /B 1 )
REM 	%Bin7za% a -r -y %UIBuildPath%/osx-x64.zip %UIBuildPath%/osx-x64/*.* || EXIT /B 1
REM 	%Bin7za% e -r -y %UIBuildPath%/osx-x64.zip -o%UIBuildPath%/osx-x64/ *.* || EXIT /B 1
REM 	IF EXIST %cd%\%UIBuildPath%/linux-x64.zip ( DEL /Q /F %UIBuildPath:/=\%\linux-x64.zip || EXIT /B 1 )
REM 	%Bin7za% a -r -y %UIBuildPath%/linux-x64.zip %UIBuildPath%/linux-x64/*.* || EXIT /B 1
REM 	%Bin7za% e -r -y %UIBuildPath%/linux-x64.zip -o%UIBuildPath%/linux-x64/ *.* || EXIT /B 1
REM )
REM IF %Target%==win-x64 (
REM 	IF EXIST %cd%\%UIBuildPath%/win-x64.zip ( DEL /Q /F %UIBuildPath:/=\%\win-x64.zip || EXIT /B 1 )
REM 	%Bin7za% a -r -y %UIBuildPath%/win-x64.zip %UIBuildPath%/win-x64/*.* || EXIT /B 1
REM 	%Bin7za% e -r -y %UIBuildPath%/win-x64.zip -o%UIBuildPath%/win-x64/ *.* || EXIT /B 1
REM )
REM IF %Target%==osx-x64 (
REM 	IF EXIST %cd%\%UIBuildPath%/osx-x64.zip ( DEL /Q /F %UIBuildPath:/=\%\osx-x64.zip || EXIT /B 1 )
REM 	%Bin7za% a -r -y %UIBuildPath%/osx-x64.zip %UIBuildPath%/osx-x64/*.* || EXIT /B 1
REM 	%Bin7za% e -r -y %UIBuildPath%/osx-x64.zip -o%UIBuildPath%/osx-x64/ *.* || EXIT /B 1
REM )
REM IF %Target%==linux-x64 (
REM 	IF EXIST %cd%\%UIBuildPath%/linux-x64.zip ( DEL /Q /F %UIBuildPath:/=\%\linux-x64.zip || EXIT /B 1 )
REM 	%Bin7za% a -r -y %UIBuildPath%/linux-x64.zip %UIBuildPath%/linux-x64/*.* || EXIT /B 1
REM 	%Bin7za% e -r -y %UIBuildPath%/linux-x64.zip -o%UIBuildPath%/linux-x64/ *.* || EXIT /B 1
REM )
GOTO END

:END
ECHO.
ECHO [SQL-D]:BUILD/END/
ECHO	Success
ECHO.

