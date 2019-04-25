#!/usr/bin/env bash

#set -x

echo ''
echo '[SQL-D]:INSTALL/'
echo ''

mkdir -p ./build

DOTNETPATH=$(which dotnet)
if [ ! -f "$DOTNETPATH" ]; then
	echo "Please install Microsoft/dotnetcore from https://www.microsoft.com/net/core"
	exit 1
fi

WGETPATH=$(which wget)
if [ ! -f "$WGETPATH" ]; then
	echo "Please install wget using: brew install wget"
    echo "For more please see: https://brew.sh/"
	exit 1
fi

dotnet tool install --global dotnet-cli-zip
wget -O ./build/sql-d.start.osx-x64.nupkg https://www.nuget.org/api/v2/package/sql-d.start.osx-x64/1.0.8
z -e ./build/sql-d.start.osx-x64.nupkg ./build/sql-d.start.osx-x64/
rm -rf ~/.sql-d/
mkdir ~/.sql-d/
cp -R ./build/sql-d.start.osx-x64/contentFiles/any/any/sql-d.start/osx-x64/* ~/.sql-d/
chmod +x ~/.sql-d/SqlD.Start.osx-x64
sudo mkdir -p /usr/local/bin
sudo ln -fs ~/.sql-d/SqlD.Start.osx-x64 /usr/local/bin/sql-d

dotnet tool install --global dotnet-cli-zip
wget -O ./build/sql-d.ui.osx-x64.nupkg https://www.nuget.org/api/v2/package/sql-d.ui.osx-x64/1.0.8
z -e ./build/sql-d.ui.osx-x64.nupkg ./build/sql-d.ui.osx-x64/
rm -rf ~/.sql-d.ui/
mkdir ~/.sql-d.ui/
cp -R ./build/sql-d.ui.osx-x64/contentFiles/any/any/sql-d.ui/osx-x64/* ~/.sql-d.ui/
chmod +x ~/.sql-d.ui/SqlD.UI.osx-x64
sudo mkdir -p /usr/local/bin
sudo ln -fs ~/.sql-d.ui/SqlD.UI.osx-x64 /usr/local/bin/sql-d.ui

echo "[SQL-D]: Please type 'sql-d -w' to launch and browse to http://localhost:5000/swagger"
echo "[SQL-D]: For more sql-d options, please type 'sql-d' and hit enter"
echo "[SQL-D]: Example: sql-d -n newservice1 -s "localhost:9000" -d "newservice1.db" -r "localhost:9000" -w"
