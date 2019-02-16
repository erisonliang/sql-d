# SqlD Help - Executing

<div align="right">
	<a href="https://github.com/RealOrko/sql-d/blob/master/docs/_.md#sqld-help---contents">[Back to Contents]</a>
</div>

  * [SqlD.Start](#sqldstart)
  * [SqlD.UI](#sqldui)
  * [Kill](#kill)
  * [Runtimes](#runtimes)

## SqlD.Start

<div align="right">
	<a href="#sqld-help---executing">[Back to Top]</a>
</div>

To execute SqlD browse to `./build/sqld.start/[RID]/` where RID = [`linux-x64`, `osx-64`, `win-x64`]. This will start a headless instance of SqlD. 

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

  - [Building SqlD.Start](https://github.com/RealOrko/sql-d/blob/master/docs/building.md#sqldstart)
  - [Building SqlD.UI](https://github.com/RealOrko/sql-d/blob/master/docs/building.md#sqldui)
  - [Configuration](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#services)

## SqlD.UI

<div align="right">
	<a href="#sqld-help---executing">[Back to Top]</a>
</div>

To execute SqlD.UI browse to `./build/sqld.ui/[RID]/` where RID = [`linux-x64`, `osx-64`, `win-x64`]. Use this to manage SqlD instances.

`./SqlD.UI`

Browse to http://localhost:5000.

 *See Also*:

  - [Building SqlD.UI](https://github.com/RealOrko/sql-d/blob/master/docs/building.md#sqldui)
  - [Building SqlD.Start](https://github.com/RealOrko/sql-d/blob/master/docs/building.md#sqldstart)
  - [Configuration](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#services)

## Kill

<div align="right">
	<a href="#sqld-help---executing">[Back to Top]</a>
</div>

If you want to kill all rogue processes as a result of develop/debug/run/terminate workflows:

*Windows 10*:
 - `./kill`

*OSX/Linux*:
 - `./kill.sh`

 *See Also*:

  - [Building SqlD.Start](https://github.com/RealOrko/sql-d/blob/master/docs/building.md#sqldstart)
  - [Building SqlD.UI](https://github.com/RealOrko/sql-d/blob/master/docs/building.md#sqldui)
  - [Configuration](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#services)

## Runtimes

<div align="right">
	<a href="#sqld-help---executing">[Back to Top]</a>
</div>

SqlD is designed to support Windows 10(`win-x64`), MacOSX(`osx-x64`), Linux(`linux-x64`) and Docker(`microsoft/dotnet:2.1-aspnetcore-runtime`).

 *See Also*:

  - [Building SqlD.Start](https://github.com/RealOrko/sql-d/blob/master/docs/building.md#sqldstart)
  - [Building SqlD.UI](https://github.com/RealOrko/sql-d/blob/master/docs/building.md#sqldui)
  - [Configuration](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#services)
