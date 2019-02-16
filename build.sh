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

DOTNETPATH=$(which dotnet)
if [ ! -f "$DOTNETPATH" ]; then
	echo "Please install Microsoft/dotnetcore from: https://www.microsoft.com/net/core"
	exit 1
fi

echo ''
echo ''
echo '[SQL-D]:BUILD/'
echo ''
echo '  DESCRIPTION: '
echo '     Controls the entire build plane for source in src\sql-d\* && src\sql-d.ui\*'
echo ''
echo '  USAGE: '
echo '     build <target> <configuration> <stage>'
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
echo '     <stage>:'
echo '        all = Build everything'
echo '        pb = Pre-build process'
echo '        pbp = Publish pre-build to ./build/sql-d.start/<target>'
echo '        b = Full build'
echo '        bp = Publish build to ./build/sql-d.ui/<target>'
echo ''
echo '  EXAMPLES:'
echo '     Executes entire build process'
echo '        > build'
echo '     Executes entire build process only targetting windows using a release compile'
echo '        > build win-x64 release'
echo '     Executes entire build process only targetting linux using a debug compile'
echo '        > build linux-x64 debug all'

rm -rf ./build

Stage=all
Target=all
Configuration=Release
CurrentDirectory=$(pwd)
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


./publish.sh "$@"

echo ''
echo '[SQL-D]:BUILD/SQLD.UI/CLEAN'
echo ''

dotnet clean $LibProjectPath
dotnet clean $UIProjectPath
dotnet clean $TestProjectPath
dotnet clean $TestStartProjectPath

echo ''
echo '[SQL-D]:BUILD/SQLD.UI/BUILD'
echo ''
dotnet build $LibProjectPath
dotnet build $UIProjectPath
dotnet build $TestProjectPath
dotnet build $TestStartProjectPath
dotnet test $TestProjectPath
dotnet test $TestStartProjectPath

if [ "$Target" == "pb" ] || [ "$Target" == "all" ]; then 

	echo ''
	echo '[SQL-D]:BUILD/SQLD.UI/PUBLISH/'
	echo ''

	if [ "$Target" == "all" ] || [ "$Target" == "win-x64" ]; then
		dotnet publish $UIProjectPath -c $Configuration -r win-x64 -o ../../$UIBuildPath/win-x64 --self-contained
		rm -rf $UIBuildPath/win-x64.zip
		cd $UIBuildPath/win-x64/
		zip -r ../win-x64.zip *
		cd $CurrentDirectory
	fi

	if [ "$Target" == "all" ] || [ "$Target" == "osx-64" ]; then
		dotnet publish $UIProjectPath -c $Configuration -r osx-x64 -o ../../$UIBuildPath/osx-x64 --self-contained
		rm -rf $UIBuildPath/osx-x64.zip
		cd $UIBuildPath/osx-x64/
		zip -r ../osx-x64.zip *
		cd $CurrentDirectory
	fi

	if [ "$Target" == "all" ] || [ "$Target" == "linux-x64" ]; then
		dotnet publish $UIProjectPath -c $Configuration -r linux-x64 -o ../../$UIBuildPath/linux-x64 --self-contained
		rm -rf $UIBuildPath/linux-x64.zip
		cd $UIBuildPath/linux-x64/
		zip -r ../linux-x64.zip *
		cd $CurrentDirectory
	fi
	
fi

echo ''
echo '[SQL-D]:BUILD/SQLD.UI/END/'
echo '	Success'
echo ''

