# SqlD Help - Configuration

<div align="right">
	<a href="https://github.com/RealOrko/sql-d/blob/master/docs/_.md#sqld-help---contents">[Back to Contents]</a>
</div>

  * [Defaults](#defaults)
  * [Authority](#authority)
  * [Process Model](#process-model)
  * [Registries](#registries)
  * [Services](#services)
    * [Example](#services--example)
    * [Database](#services--database)
    * [Host/Port](#services--host--port)
    * [Tags](#services--tags)
    * [Pragma](#services--pragma)
    * [Forwarding](#services--forwarding)

## Defaults

<div align="right">
	<a href="#sqld-help---configuration">[Back to Top]</a>
</div>

The default configuration of SqlD is as follows:

```json
"SqlD": {
	"enabled": true,
	"authority": "localhost",
	"processmodel": {
		"distributed": true
	},
	"registries": [{
		"host": "localhost",
		"port": 50095
	}],
	"services": [{
		"name": "sql-d-registry-1",
		"database": "sql-d-registry-1.db",
		"host": "localhost",
		"port": 50095,
		"tags": ["registry"],
		"pragma": {
			"journalMode": "OFF",
			"synchronous": "OFF",
			"tempStore": "OFF",
			"lockingMode": "OFF",	
			"countChanges": "OFF",
			"pageSize": "65536",
			"cacheSize": "10000", 
			"queryOnly": "OFF"
		}
	}, {
		"name": "sql-d-slave-1",
		"database": "sql-d-slave-1.db",
		"host": "localhost",
		"port": 50101,
		"tags": ["slave 1"],
		"pragma": {
			"journalMode": "OFF",
			"synchronous": "OFF",
			"tempStore": "OFF",
			"lockingMode": "OFF",
			"countChanges": "OFF",
			"pageSize": "65536",
			"cacheSize": "10000",
			"queryOnly": "OFF"
		}
	}, {
		"name": "sql-d-slave-2",
		"database": "sql-d-slave-2.db",
		"host": "localhost",
		"port": 50102,
		"tags": ["slave 2"],
		"pragma": {
			"journalMode": "OFF",
			"synchronous": "OFF",
			"tempStore": "OFF",
			"lockingMode": "OFF",
			"countChanges": "OFF",
			"pageSize": "65536",
			"cacheSize": "10000",
			"queryOnly": "OFF"
		}
	}, {
		"name": "sql-d-slave-3",
		"database": "sql-d-slave-3.db",
		"host": "localhost",
		"port": 50103,
		"tags": ["slave 3"],
		"pragma": {
			"journalMode": "OFF",
			"synchronous": "OFF",
			"tempStore": "OFF",
			"lockingMode": "OFF",
			"countChanges": "OFF",
			"pageSize": "65536",
			"cacheSize": "10000",
			"queryOnly": "OFF"
		}
	}, {
		"name": "sql-d-master-1",
		"database": "sql-d-master-1.db",
		"host": "localhost",
		"port": 50100,
		"tags": ["master"],
		"pragma": {
			"journalMode": "OFF",
			"synchronous": "OFF",
			"tempStore": "OFF",
			"lockingMode": "OFF",
			"countChanges": "OFF",
			"pageSize": "65536",
			"cacheSize": "10000",
			"queryOnly": "OFF"
		},
		"forwardingTo": [{
			"host": "localhost",
			"port": 50101
		}, {
			"host": "localhost",
			"port": 50102
		}, {
			"host": "localhost",
			"port": 50103
		}]
	}]
}
```

 *See Also*:

  - [Services](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#services)
  - [Executing SqlD.Start](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldstart)
  - [Executing SqlD.UI](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldui)

## Authority

<div align="right">
	<a href="#sqld-help---configuration">[Back to Top]</a>
</div>

For setting the authority for SqlD instance send registration commands when they start up. This is useful for authorities backed on to public DNS entries.

```json
"SqlD": {
	"authority": "localhost"
}
```

 *See Also*:

  - [Services](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#services)
  - [Executing SqlD.Start](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldstart)
  - [Executing SqlD.UI](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldui)

## Process Model

<div align="right">
	<a href="#sqld-help---configuration">[Back to Top]</a>
</div>

When spawning new SqlD instances via SqlD.Start/SqlD.UI, this will make sure they are run as separate processes guaranteeing process isolation.

```json
"SqlD": {
	"processmodel": {
		"distributed": true
	}
}
```

 *See Also*:

  - [Services](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#services)
  - [Executing SqlD.Start](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldstart)
  - [Executing SqlD.UI](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldui)

## Registries

<div align="right">
	<a href="#sqld-help---configuration">[Back to Top]</a>
</div>

For specifying the registry URL over HTTP to call when a SqlD instance starts up. The time will be recorded as UTC.

```json
"SqlD": {
	"registries": [{
		"host": "localhost",
		"port": 50095
	}]
}
```

 *See Also*:

  - [Services](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#services)
  - [Executing SqlD.Start](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldstart)
  - [Executing SqlD.UI](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldui)

## Services

<div align="right">
	<a href="#sqld-help---configuration">[Back to Top]</a>
</div>

A service defines an actual SqlD instance with a host and a port number. If [distributed=true](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#process-model) then SqlD 
instances are launched as separate processes guaranteeing process isolation. 

The order of precedance of the SqlD instance service definitions are also important. 

You need to be sure that any SqlD instance service you forward to is defined above the SqlD instance service with the `forwardingTo` dependency. Also be sure not to create cyclic dependencies
with your `forwardingTo` SqlD instance service definitions.

 *See Also*:

  - [Example](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#services--example)
  - [Process Model](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#process-model)
  - [Registries](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#registries)
  - [Executing SqlD.Start](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldstart)
  - [Executing SqlD.UI](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldui)

### Services / Example

<div align="right">
	<a href="#sqld-help---configuration">[Back to Top]</a>
</div>

An example of a service that forwards traffic to other url's.

```json
"SqlD": {
	"services": [{
		"name": "sql-d-master-1",
		"database": "sql-d-master-1.db",
		"host": "localhost",
		"port": 50100,
		"tags": ["master"],
		"pragma": {
			"journalMode": "OFF",
			"synchronous": "OFF",
			"tempStore": "OFF",
			"lockingMode": "OFF",
			"countChanges": "OFF",
			"pageSize": "65536",
			"cacheSize": "10000",
			"queryOnly": "OFF"
		},
		"forwardingTo": [{
			"host": "localhost",
			"port": 50101
		},
		{
			"host": "localhost",
			"port": 50102
		},
		{
			"host": "localhost",
			"port": 50103
		}]
	}]
}
```

 *See Also*:

  - [Services](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#services)
  - [Executing SqlD.Start](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldstart)
  - [Executing SqlD.UI](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldui)


### Services / Database

<div align="right">
	<a href="#sqld-help---configuration">[Back to Top]</a>
</div>

The persisted file path of the SqlD database file.

```json
"SqlD": {
	"services": [{
		"database": "sql-d-registry-1.db"
	}]
}
```

 *See Also*:

  - [Services](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#services)
  - [Executing SqlD.Start](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldstart)
  - [Executing SqlD.UI](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldui)

### Services / Host & Port

<div align="right">
	<a href="#sqld-help---configuration">[Back to Top]</a>
</div>

The host/port is the uri the SqlD instance will serve traffic from. 

```json
"SqlD": {
	"services": [{
		"host": "localhost",
		"port": 50095
	}]
}
```

 *See Also*:

  - [Services](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#services)
  - [Executing SqlD.Start](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldstart)
  - [Executing SqlD.UI](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldui)

### Services / Tags

<div align="right">
	<a href="#sqld-help---configuration">[Back to Top]</a>
</div>

For distinguishing SqlD instances when queried via the [SqlD UI API](https://github.com/RealOrko/sql-d/blob/master/docs/sqld-ui-api.md).

```json
"SqlD": {
	"services": [{
		"tags": ["registry", "insert additional tag classification here ... "]
	}]
}
```

 *See Also*:

  - [Services](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#services)
  - [Executing SqlD.Start](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldstart)
  - [Executing SqlD.UI](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldui)

### Services / Pragma

<div align="right">
	<a href="#sqld-help---configuration">[Back to Top]</a>
</div>

For defining pragma values that are passed directly to sqlite. 

```json
"SqlD": {
	"services": [{
		"pragma": {
			"journalMode": "OFF",
			"synchronous": "OFF",
			"tempStore": "OFF",
			"lockingMode": "OFF",	
			"countChanges": "OFF",
			"pageSize": "65536",
			"cacheSize": "10000", 
			"queryOnly": "OFF"
		}
	}]
}
```

Here are links to the supported pragma parameters for services:

 - [Journal Mode](https://www.sqlite.org/pragma.html#pragma_journal_mode)
 - [Synchronous](https://www.sqlite.org/pragma.html#pragma_synchronous)
 - [Temporary Store](https://www.sqlite.org/pragma.html#pragma_temp_store)
 - [Locking Mode](https://www.sqlite.org/pragma.html#pragma_locking_mode)
 - [Count Changes](https://www.sqlite.org/pragma.html#pragma_count_changes)
 - [Page Size](https://www.sqlite.org/pragma.html#pragma_page_size)
 - [Cache Size](https://www.sqlite.org/pragma.html#pragma_cache_size)
 - [Query Only](https://www.sqlite.org/pragma.html#pragma_query_only)

 *See Also*:

  - [Services](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#services)
  - [Executing SqlD.Start](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldstart)
  - [Executing SqlD.UI](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldui)

### Services / Forwarding

<div align="right">
	<a href="#sqld-help---configuration">[Back to Top]</a>
</div>

An example of a write forwarding configuration block for a SqlD instance:

```json
"SqlD": {
	"services": [{
		"forwardingTo": [{
			"host": "localhost",
			"port": 50101
		}, {
			"host": "localhost",
			"port": 50102
		}, {
			"host": "localhost",
			"port": 50103
		}]
	}]
}
```

These are services you would like to replicate your writes to. 
 - No opinions exist yet as to how you synchronise data or avoid data corruption. 
 - The default configuration for SqlD.Start/SqlD.UI is to have `master` which replicates to `slave 1`, `slave 2` and `slave 3`. 
 - Forwarding will also retry a failing request for a total of 5 times with a linear backoff of 250ms. This cannot be changed through config just yet.

 *See Also*:

  - [Services](https://github.com/RealOrko/sql-d/blob/master/docs/configuration.md#services)
  - [Executing SqlD.Start](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldstart)
  - [Executing SqlD.UI](https://github.com/RealOrko/sql-d/blob/master/docs/executing.md#sqldui)
