#!/usr/bin/env bash

# set -xe

export PATH=$PATH:./.dotnet

DOTNETPATH=$(which dotnet)
if [ ! -f "$DOTNETPATH" ]; then
	echo "Please install Microsoft/dotnetcore from: https://www.microsoft.com/net/core"
	exit 1
fi

echo ''
echo '[SQL-D]:PUBLISH/'
echo ''

rm -rf ./build
mkdir ./build

Configuration=Release
TargetFramework=netcoreapp2.2

export LibProjectPath=./src/sql-d/SqlD.csproj
dotnet build $LibProjectPath
dotnet pack $LibProjectPath -o ../../build
	
export StartLinuxX64ProjectPath=./src/sql-d.start.linux-x64/SqlD.Start.linux-x64.csproj
dotnet publish $StartLinuxX64ProjectPath -r linux-x64 -f $TargetFramework --self-contained
dotnet pack $StartLinuxX64ProjectPath -o ../../build --include-symbols
	
export StartOsxX64ProjectPath=./src/sql-d.start.osx-x64/SqlD.Start.osx-x64.csproj
dotnet publish $StartOsxX64ProjectPath -r osx-x64 -f $TargetFramework --self-contained
dotnet pack $StartOsxX64ProjectPath -o ../../build --include-symbols

export StartWinX64ProjectPath=./src/sql-d.start.win-x64/SqlD.Start.win-x64.csproj
dotnet publish $StartWinX64ProjectPath -r win-x64 -f $TargetFramework --self-contained
dotnet pack $StartWinX64ProjectPath -o ../../build --include-symbols

export UIProjectPath=./src/sql-d.ui/SqlD.UI.csproj
dotnet build $UIProjectPath
	
export UILinuxX64ProjectPath=./src/sql-d.ui.linux-x64/SqlD.UI.linux-x64.csproj
dotnet publish $UILinuxX64ProjectPath -r linux-x64 --self-contained
cp -rf src\sql-d.ui.linux-x64\bin\Release\netcoreapp2.2\Views src\sql-d.ui.linux-x64\bin\Release\netcoreapp2.2\linux-x64\publish\Views\
dotnet pack $UILinuxX64ProjectPath -o ../../build --include-symbols
	
export UIOsxX64ProjectPath=./src/sql-d.ui.osx-x64/SqlD.UI.osx-x64.csproj
dotnet publish $UIOsxX64ProjectPath -r osx-x64 --self-contained || EXIT /B 1
cp -rf src\sql-d.ui.osx-x64\bin\Release\netcoreapp2.2\Views src\sql-d.ui.osx-x64\bin\Release\netcoreapp2.2\osx-x64\publish\Views\
dotnet pack $UIOsxX64ProjectPath -o ../../build --include-symbols || EXIT /B 1

export UIWinX64ProjectPath=./src/sql-d.ui.win-x64/SqlD.UI.win-x64.csproj
dotnet publish $UIWinX64ProjectPath -r win-x64 --self-contained || EXIT /B 1
cp -rf src\sql-d.ui.win-x64\bin\Release\netcoreapp2.2\Views src\sql-d.ui.win-x64\bin\Release\netcoreapp2.2\win-x64\publish\Views\
dotnet pack $UIWinX64ProjectPath -o ../../build --include-symbols || EXIT /B 1
