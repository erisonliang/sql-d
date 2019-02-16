# SqlD Help - Building

<div align="right">
	<a href="https://github.com/RealOrko/sql-d/blob/master/docs/_.md#sqld-help---contents">[Back to Contents]</a>
</div>

  * [SqlD.Start](#sqldstart)
  * [SqlD.UI](#sqldui)
  * [Clean](#clean)

## SqlD.Start

<div align="right">
	<a href="#sqld-help---building">[Back to Top]</a>
</div>

SqlD has its own process hosting mechanism for hosting SqlD instances called SqlD.Start. This will launch a single instance of SqlD without the presence of a user interface, also know 
as a headless instance. This instance can also be used as a service registry. 

*Windows 10*:
 - `./publish`

*OSX/Linux*:
 - `./publish.sh`

You have to run this before attempting to run/debug from Visual Studio/Code.

This will publish artifacts to `./build/sql-d.start`.

 *See Also*:

  - [About](https://github.com/RealOrko/sql-d/blob/master/docs/about.md)
  - [Prerequisites](https://github.com/RealOrko/sql-d/blob/master/docs/prerequisites.md)
  - [Executing SqlD.Start](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldstart)
  - [Executing SqlD.UI](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldui)

## SqlD.UI

<div align="right">
	<a href="#sqld-help---building">[Back to Top]</a>
</div>

SqlD.UI is a user interface for interacting with SqlD instances on single host. You can create/query/delete SqlD instances and re-route forwarding traffic which is 
[default configured](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#defaults). Browse to http://localhost:5000. 

*Windows 10*:
 - `./build`

*OSX/Linux*:
 - `./build.sh`

This command will call `./publish`|`./publish.sh` first.

This will publish build artifacts to a `./build/sql-d.ui`. 

 *See Also*:

  - [About](https://github.com/RealOrko/sql-d/blob/master/docs/about.md)
  - [Prerequisites](https://github.com/RealOrko/sql-d/blob/master/docs/prerequisites.md)
  - [Executing SqlD.UI](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldui)
  - [Executing SqlD.Start](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldstart)

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
  - [Executing SqlD.UI](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldui)
  - [Executing SqlD.Start](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldstart)
