# SqlD Help - Building

<div align="right">
	<a href="https://github.com/RealOrko/sql-d/blob/master/docs/_.md#sqld-help---contents">[Back to Contents]</a>
</div>

  * [SqlD.Start](#building-sqldstart)
  * [SqlD.Start via Docker](#building-sqldstart-via-docker)
  * [SqlD.UI](#building-sqldui)
  * [Clean](#clean)

## Building SqlD.Start

<div align="right">
	<a href="#sqld-help---building">[Back to Top]</a>
</div>

SqlD has its own process hosting mechanism for hosting SqlD instances called SqlD.Start. This will launch a single instance of SqlD without the presence of a user interface, also known 
as a `headless instance`. It can also be used as a service registry. NuGet packages for SqlD.Start can be found in the `./build` directory. If you would like to bump the 
published NuGet package versions locally please edit `./version.props` between `publish` runs.

*Windows 10*:
 - `./publish`

*OSX/Linux*:
 - `./publish.sh`

If you add the folder `./build` as a nuget source then you can upgrade to newer local development versions and run the tests and ui against them by upgrading NuGets for projects `./src/sql-d.ui` 
and `./tests/sql-d`. 

 *See Also*:

  - [About](https://github.com/RealOrko/sql-d/blob/master/docs/about.md)
  - [Prerequisites](https://github.com/RealOrko/sql-d/blob/master/docs/prerequisites.md)
  - [Executing SqlD.Start](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#executing-sqldstart)

## Building SqlD.Start via Docker

<div align="right">
	<a href="#sqld-help---building">[Back to Top]</a>
</div>

To build a SqlD.Start instance via docker please see the [docker.sh](https://github.com/RealOrko/sql-d/blob/master/docker.sh) script.

*OSX/Linux*:
 - `docker build -t realorko/sql-d .`
 - `docker run -d -p 5000:5000 -t realorko/sql-d`
 - `docker-machine start father`
 - `eval $(docker-machine env father)`

*See Also*:

  - [About](https://github.com/RealOrko/sql-d/blob/master/docs/about.md)
  - [Prerequisites](https://github.com/RealOrko/sql-d/blob/master/docs/prerequisites.md)
  - [Executing SqlD.Start via Docker](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#executing-sqldstart-via-docker)

## Building SqlD.UI

<div align="right">
	<a href="#sqld-help---building">[Back to Top]</a>
</div>

SqlD.UI is a user interface for interacting with SqlD instances on single host. You can create/query/delete SqlD instances and re-route forwarding traffic which is 
[default configured](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#defaults). Browse to http://localhost:5000. This component is not available
on NuGet just yet. You will have to compile and run it from source.

 - `git clone git@github.com:RealOrko/sql-d.git`
 - `cd ./sql-d`
 - `dotnet restore ./src/sql-d.ui/SqlD.UI.csproj`
 - `dotnet build ./src/sql-d.ui/SqlD.UI.csproj`

Please be sure to call `./publish`|`./publish.sh` first if you are making changes to SqlD itself. Incrementing build numbers `./version.props` and registering `./build` as a NuGet source 
will allow you to upgrade packages `sql-d.*` in `src/sql-d.ui` and `tests/sql-d` locally for testing.

 *See Also*:

  - [About](https://github.com/RealOrko/sql-d/blob/master/docs/about.md)
  - [Prerequisites](https://github.com/RealOrko/sql-d/blob/master/docs/prerequisites.md)
  - [Executing SqlD.UI](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#executing-sqldui)

## Clean

<div align="right">
	<a href="#sqld-help---building">[Back to Top]</a>
</div>

If you want to get rid of all build artifacts and newly created files. The nuclear option, please be careful.

*Windows 10*:
 - `./clean`

*OSX/Linux*:
 - `./clean.sh`

 *See Also*:

  - [About](https://github.com/RealOrko/sql-d/blob/master/docs/about.md)
  - [Prerequisites](https://github.com/RealOrko/sql-d/blob/master/docs/prerequisites.md)
