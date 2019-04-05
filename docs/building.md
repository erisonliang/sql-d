# SqlD Help - Building

<div align="right">
	<a href="https://github.com/RealOrko/sql-d/blob/master/docs/_.md#sqld-help---contents">[Back to Contents]</a>
</div>

  * [SqlD.Start](#building-sqldstart)
  * [SqlD.Start via Docker](#building-sqldstart-via-docker)
  * [SqlD.UI](#building-sqldui)
  * [Clean](#clean)

## Building Everything

<div align="right">
	<a href="#sqld-help---building">[Back to Top]</a>
</div>

If you would like to run a full build and publish all the NuGet's to the `./build` directory please call the `publish` command. The `build` command will install NuGet's
from the `./build` directory and execute the tests. 

*Windows 10*:
```
./publish
./build
```

*OSX/Linux*:
```
./publish.sh
./build.sh
```

If you add the folder `./build` as a nuget source then you can upgrade to newer local development versions and run the tests and ui against them by upgrading NuGets for projects 
`./src/sql-d.ui` and `./tests/sql-d`. Please do not commit changes to `version.props`.

*See Also*:

  - [About](https://github.com/RealOrko/sql-d/blob/master/docs/about.md)
  - [Prerequisites](https://github.com/RealOrko/sql-d/blob/master/docs/prerequisites.md)

## Building SqlD.Start

<div align="right">
	<a href="#sqld-help---building">[Back to Top]</a>
</div>

SqlD has its own process hosting mechanism for hosting SqlD instances called SqlD.Start. This will launch a single instance of SqlD without the presence of a user interface, also known 
as a `headless instance`. It can also be used as a service registry. NuGet packages for SqlD.Start can be found in the `./build` directory. 

*Windows 10*:
```
git clone git@github.com:RealOrko/sql-d.git
cd ./sql-d
dotnet restore ./src/sql-d.start.win-x64/
dotnet build ./src/sql-d.start.win-x64/
```

*OSX*:
```
git clone git@github.com:RealOrko/sql-d.git
cd ./sql-d
dotnet restore ./src/sql-d.start.osx-x64/
dotnet build ./src/sql-d.start.osx-x64/
```

*Linux*:
```
git clone git@github.com:RealOrko/sql-d.git
cd ./sql-d
dotnet restore ./src/sql-d.start.linux-x64/
dotnet build ./src/sql-d.start.linux-x64/
```

If you add the folder `./build` as a nuget source then you can upgrade to newer local development versions and run the tests and ui against them by upgrading NuGets for projects 
`./src/sql-d.ui` and `./tests/sql-d`. Please do not commit changes to `version.props`.

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
```
docker build -t realorko/sql-d .
docker run -d -p 5000:5000 -t realorko/sql-d
docker-machine start father
eval $(docker-machine env father)
```

*See Also*:

  - [About](https://github.com/RealOrko/sql-d/blob/master/docs/about.md)
  - [Prerequisites](https://github.com/RealOrko/sql-d/blob/master/docs/prerequisites.md)
  - [Executing SqlD.Start via Docker](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#executing-sqldstart-via-docker)

## Building SqlD.UI

<div align="right">
	<a href="#sqld-help---building">[Back to Top]</a>
</div>

SqlD.UI is a user interface for interacting with SqlD instances on single host. You can create/query/delete SqlD instances and re-route forwarding traffic which is 
[default configured](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#defaults). 

```
git clone git@github.com:RealOrko/sql-d.git
cd ./sql-d
dotnet restore ./src/sql-d.ui/
dotnet build ./src/sql-d.ui/
```

If you add the folder `./build` as a nuget source then you can upgrade to newer local development versions and run the tests and ui against them by upgrading NuGets for projects 
`./src/sql-d.ui` and `./tests/sql-d`. Please do not commit changes to `version.props`.

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
```
./clean
```

*OSX/Linux*:
```
./clean.sh
```

 *See Also*:

  - [About](https://github.com/RealOrko/sql-d/blob/master/docs/about.md)
  - [Prerequisites](https://github.com/RealOrko/sql-d/blob/master/docs/prerequisites.md)
