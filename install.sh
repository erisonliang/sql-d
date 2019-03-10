#!/usr/bin/env bash

#set -x

echo ''
echo '[SQL-D]:INSTALL/'
echo ''

dotnet tool install --global dotnet-cli-zip
wget -O ./build/sql-d.start.linux-x64.nupkg https://www.nuget.org/api/v2/package/sql-d.start.linux-x64/1.0.2
z -e ./build/sql-d.start.linux-x64.nupkg ./build/sql-d.start.linux-x64/
rm -rf ~/.sql-d/
mkdir ~/.sql-d/
cp -R ./build/sql-d.start.linux-x64/contentFiles/any/any/sql-d.start/linux-x64/* ~/.sql-d/
chmod +x ~/.sql-d/SqlD.Start.linux-x64
sudo ln -fs ~/.sql-d/SqlD.Start.linux-x64 /usr/bin/sql-d
xdg-open http://localhost:5000/swagger
