#!/usr/bin/env bash

wget -O ./sql-d.zip https://www.nuget.org/api/v2/package/sql-d/1.0.1
dotnet tool install -g dotnet-cli-zip --version 1.0.3
z -e ./sql-d.zip ./sql-d
z -e ./sql-d/content/any/any/Process/linux-x64.zip ./bin
chmod u+x ./bin/SqlD.Start
ln -sf $(pwd)/bin/SqlD.Start /usr/bin/sqld