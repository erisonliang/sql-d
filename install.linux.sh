#!/usr/bin/env bash

#set -x

echo ''
echo '[SQL-D]:INSTALL/'
echo ''

DOTNETPATH=$(which dotnet)
if [ ! -f "$DOTNETPATH" ]; then
	echo "Please install Microsoft/dotnetcore from https://www.microsoft.com/net/core"
	exit 1
fi

WGETPATH=$(which wget)
if [ ! -f "$WGETPATH" ]; then
	echo "Please install wget using your package manager eg. For Ubuntu: apt install wget"
	exit 1
fi

dotnet tool install --global dotnet-cli-zip
wget -O ./build/sql-d.start.linux-x64.nupkg https://www.nuget.org/api/v2/package/sql-d.start.linux-x64/1.0.5
z -e ./build/sql-d.start.linux-x64.nupkg ./build/sql-d.start.linux-x64/
rm -rf ~/.sql-d/
mkdir ~/.sql-d/
cp -R ./build/sql-d.start.linux-x64/contentFiles/any/any/sql-d.start/linux-x64/* ~/.sql-d/
chmod +x ~/.sql-d/SqlD.Start.linux-x64
sudo ln -fs ~/.sql-d/SqlD.Start.linux-x64 /usr/bin/sql-d

echo "[SQL-D]: Please type 'sql-d -w' to launch and browse to http://localhost:5000/swagger"
echo "[SQL-D]: For more sql-d options, please type 'sql-d' and hit enter"
echo "[SQL-D]: Example ~> sql-d -n newservice1 -s "localhost:9000" -d "newservice1.db" -r "localhost:9000" -w"
