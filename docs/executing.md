# SqlD Help - Executing

<div align="right">
	<a href="https://github.com/RealOrko/sql-d/blob/master/docs/_.md#sqld-help---contents">[Back to Contents]</a>
</div>

  * [SqlD.Start](#executing-sqldstart)
  * [SqlD.Start via Docker](#executing-sqldstart-via-docker)
  * [SqlD.UI](#executing-sqldui)
  * [Kill](#kill)
  * [Runtimes](#runtimes)

## Executing SqlD.Start

<div align="right">
	<a href="#sqld-help---executing">[Back to Top]</a>
</div>

*Linux*:
```
dotnet publish ./src/sql-d.start.linux-x64 -c Release -f netcoreapp3.0 -r linux-x64
./src/sql-d.start.linux-x64/bin/Release/netcoreapp3.0/linux-x64/publish/SqlD.Start.linux-x64
```

*OSX*:
```
dotnet publish ./src/sql-d.start.osx-x64 -c Release -f netcoreapp3.0 -r osx-x64
./src/sql-d.start.osx-x64/bin/Release/netcoreapp3.0/osx-x64/publish/SqlD.Start.osx-x64
```

*Windows 10*:
```
dotnet publish .\src\sql-d.start.win-x64 -c Release -f netcoreapp3.0 -r win-x64
.\src\sql-d.start.win-x64\bin\Release\netcoreapp3.0\win-x64\publish\SqlD.Start.win-x64.exe
```

Then please browse to http://localhost:5000.

SqlD.Start command parameters:

`./SqlD.Start`

```
   -name -n
      Name of the Service being launched eg. -n "Shiny-New-Service"

   -server -s
      Service to launch eg. -s "localhost:54321"

   -database -d
      Database for services eg. -d "localhost_54321.db"

   -pragmajournalmode -pj
      For setting the pragma journal mode eg. -pj "WAL"

   -pragmasynchronous -ps
      For setting the pragma synchronous eg. -ps "OFF"

   -pragmatempstore -pt
      For setting the pragma temp store eg. -pt "OFF"

   -pragmalockingmode -pl
      For setting the pragma locking mode eg. -pl "OFF"

   -pragmacountchanges -pc
      For setting the pragma count changes eg. -pc "OFF"

   -pragmapagesize -pps
      For setting the pragma page size in bytes eg. -pps "65536"

   -pragmacachesize -pcs
      For setting the pragma cache size in bytes eg. -pcs "10000"

   -pragmaqueryonly -pqo
      For setting the pragma query only eg. -pqo "OFF"

   -registry -r
      Registry for services eg. -r "localhost:54300"

   -forward -f
      Forward all writes to target eg. -f "localhost:54321"

   -tags -t
      For tagging the service eg. -t "development"

   -wait -w
      Make a process wait, enter to quit eg. -w
```

 *See Also*:

  - [Configuration](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#services)
  - [Building SqlD.Start](https://github.com/RealOrko/sql-d/blob/master/docs/building.md#building-sqldstart)

## Executing SqlD.Start via Docker

<div align="right">
	<a href="#sqld-help---executing">[Back to Top]</a>
</div>

To run a SqlD.Start instance via docker please see the [docker.sh](https://github.com/RealOrko/sql-d/blob/master/docker.sh) script.

*OSX/Linux*:
```
docker run -t realorko/sql-d:latest -p 5000:5000`
```

 *See Also*:

  - [Configuration](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#services)
  - [Building SqlD.Start via Docker](https://github.com/RealOrko/sql-d/blob/master/docs/building.md#building-sqldstart-via-docker)

## Executing SqlD.UI

<div align="right">
	<a href="#sqld-help---executing">[Back to Top]</a>
</div>

Here are the commands for executing the SqlD.UI:

*Linux*:
```
dotnet publish ./src/sql-d.ui -c Release -f netcoreapp3.0 -r linux-x64
./src/sql-d.ui/bin/Release/netcoreapp3.0/linux-x64/publish/SqlD.UI
```

*OSX*:
```
dotnet publish ./src/sql-d.ui -c Release -f netcoreapp3.0 -r osx-x64
./src/sql-d.ui/bin/Release/netcoreapp3.0/osx-x64/publish/SqlD.UI
```

*Windows 10*:
```
dotnet publish .\src\sql-d.start.win-x64 -c Release -f netcoreapp3.0 -r win-x64
.\src\sql-d.ui\bin\Release\netcoreapp3.0\win-x64\publish\SqlD.UI.exe
```

Then please browse to http://localhost:5000.

*See Also*:

  - [Configuration](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#services)
  - [Building SqlD.UI](https://github.com/RealOrko/sql-d/blob/master/docs/building.md#building-sqldui)

## Kill

<div align="right">
	<a href="#sqld-help---executing">[Back to Top]</a>
</div>

If you want to kill all rogue processes as a result of develop/debug/run/terminate workflows:

*Windows 10*:
```
./kill
```

*OSX/Linux*:
```
./kill.sh
```

## Runtimes

<div align="right">
	<a href="#sqld-help---executing">[Back to Top]</a>
</div>

SqlD is designed to support Windows 10(`win-x64`), MacOSX(`osx-x64`), Linux(`linux-x64`) and Docker(`microsoft/dotnet:2.1-aspnetcore-runtime`).

*See Also*:

  - [Building SqlD.Start](https://github.com/RealOrko/sql-d/blob/master/docs/building.md#building-sqldstart)
  - [Building SqlD.UI](https://github.com/RealOrko/sql-d/blob/master/docs/building.md#building-sqldui)
  - [Configuration](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#services)
