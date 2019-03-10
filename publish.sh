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
