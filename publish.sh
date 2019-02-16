#!/usr/bin/env bash

OperatingSystem='?'

case "$(uname -s)" in

   Darwin)
     OperatingSystem=mac
     ;;

   Linux)
     OperatingSystem=linux
     ;;

   CYGWIN*|MINGW32*|MSYS*)
     OperatingSystem=win
     ;;

   *)
     OperatingSystem='?'
     ;;
esac

echo $OperatingSystem

./kill.sh

export PATH=$PATH:./.dotnet

DOTNETPATH=$(which dotnet)
if [ ! -f "$DOTNETPATH" ]; then
	echo "Please install Microsoft/dotnetcore from: https://www.microsoft.com/net/core"
	exit 1
fi

echo ''
echo '[SQL-D]:BUILD/SQLD.START'
echo ''
echo '  DESCRIPTION: '
echo '     Publishes an embedded project src\src\sql-d.start to build\sql-d.start\* and zips it up. This is the process launcher used within the Process namespace in src\sql-d. This affects all scale in/out activities for src\sql-d.ui'
echo ''
echo '  USAGE: '
echo '     publish <target> <configuration>'
echo ''
echo '  WHERE:'
echo '     <target>:'
echo '        all = Target windows'
echo '        win-x64 = Target windows'
echo '        osx-x64 = Target mac osx'
echo '        linux-x64 = Target linux'
echo '     <configuration>:'
echo '        Debug = Debug compilation'
echo '        Release = Release compilation'
echo ''
echo '  EXAMPLES:'
echo '     Executes pre-stage process'
echo '        > publish '
echo '     Executes pre-stage process only targetting windows using a release compile'
echo '        > publish win-x64 release'
echo '     Executes pre-stage build process only targetting linux using a debug compile'
echo '        > publish linux-x64 debug'

rm -rf ./build

Stage=all
Target=all
Configuration=Release
SolutionPath=./sql-d.sln
ProjectPath=./sql-d.csproj
LibProjectPath=./src/sql-d/SqlD.csproj
StartBuildPath=./build/sql-d.start
StartProjectPath=./src/sql-d.start/SqlD.Start.csproj
UIBuildPath=./build/sql-d.ui
UIProjectPath=./src/sql-d.ui/SqlD.UI.csproj
TestProjectPath=./tests/sql-d/SqlD.Tests.csproj
TestStartProjectPath=./tests/sql-d.start/SqlD.Start.Tests.csproj

if [ ! "$1" == "" ]; then
	Target="$1"
fi

if [ ! "$2" == "" ]; then
	Configuration="$2"
fi

if [ ! "$3" == "" ]; then
	Stage="$3"
fi

if [ "$Stage" == "pb" ] || [ "$Stage" == "all" ]; then 

	echo ''
	echo '[SQL-D]:BUILD/SQL.START/RESTORE'
	echo ''

	if [ ! -d $StartBuildPath ]; then
		mkdir -p $StartBuildPath
	fi

	if [ ! -f "$StartBuildPath/win-x64.zip" ]; then
		touch "$StartBuildPath/win-x64.zip"
	fi 
	if [ ! -f "$StartBuildPath/linux-x64.zip" ]; then
		touch "$StartBuildPath/linux-x64.zip"
	fi 
	if [ ! -f "$StartBuildPath/osx-x64.zip" ]; then
		touch "$StartBuildPath/osx-x64.zip"
	fi 

	dotnet restore $LibProjectPath
	dotnet restore $StartProjectPath

	
	echo ''
	echo '[SQL-D]:BUILD/SQLD.START/PUBLISH'
	echo ''

	if [ "$Target" == "all" ] || [ "$Target" == "win-x64" ]; then
		dotnet publish $StartProjectPath -c $Configuration -r win-x64 -o ../../$StartBuildPath/win-x64 --self-contained
		rm -rf $StartBuildPath/win-x64.zip
		cd $StartBuildPath/win-x64/
		zip -r ../win-x64.zip *
		cd -
	fi

	if [ "$Target" == "all" ] || [ "$Target" == "osx-64" ]; then
		dotnet publish $StartProjectPath -c $Configuration -r osx-x64 -o ../../$StartBuildPath/osx-x64 --self-contained
		rm -rf $StartBuildPath/osx-x64.zip
		cd $StartBuildPath/osx-x64/
		zip -r ../osx-x64.zip *
		cd -
	fi

	if [ "$Target" == "all" ] || [ "$Target" == "linux-x64" ]; then
		dotnet publish $StartProjectPath -c $Configuration -r linux-x64 -o ../../$StartBuildPath/linux-x64 --self-contained
		rm -rf $StartBuildPath/linux-x64.zip
		cd $StartBuildPath/linux-x64/
		zip -r ../linux-x64.zip *
		cd -
	fi
	
fi

echo ''
echo '[SQL-D]:BUILD/SQLD.START/END/'
echo '	Success'
echo ''
