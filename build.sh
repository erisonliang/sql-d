#!/usr/bin/env bash

# set -xe

DOTNETPATH=$(which dotnet)
if [ ! -f "$DOTNETPATH" ]; then
	echo "Please install Microsoft/dotnetcore from: https://www.microsoft.com/net/core"
	exit 1
fi

echo ''
echo '[SQL-D]:BUILD/'
echo ''

echo "Please make sure you call ./publish.sh first. This will fail otherwise."

Runtime='?'

case "$(uname -s)" in
   Darwin)
     Runtime="osx-x64"
     ;;
   Linux)
     Runtime="linux-x64"
     ;;
esac

Configuration=Release
TargetFramework=netcoreapp3.0

dotnet add ./tests/sql-d/SqlD.Tests.csproj package sql-d --source $(pwd)/build --package-directory $(pwd)/build 
dotnet add ./tests/sql-d/SqlD.Tests.csproj package "sql-d.start.linux-x64" --source $(pwd)/build --package-directory $(pwd)/build
dotnet add ./tests/sql-d/SqlD.Tests.csproj package "sql-d.start.osx-x64" --source $(pwd)/build --package-directory $(pwd)/build
dotnet add ./tests/sql-d/SqlD.Tests.csproj package "sql-d.start.win-x64" --source $(pwd)/build --package-directory $(pwd)/build
dotnet build ./tests/sql-d/SqlD.Tests.csproj -r $Runtime --source $(pwd)/build
dotnet test ./tests/sql-d/SqlD.Tests.csproj -r $Runtime
