using System;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using SqlD.Configuration.Model;
using SqlD.Network.Server.Api.Registry.Model;

namespace SqlD.Network.Server.Api.Registry.Controllers
{
    [ApiController]
	[Route("api/registry")]
	public class RegistryController : Controller
	{
		private readonly EndPoint authorityAddress;
		private readonly DbConnection dbConnection;

		public RegistryController(DbConnection dbConnection, EndPoint serverAddress, SqlDConfiguration configuration)
		{
			this.dbConnection = dbConnection;
			this.dbConnection.CreateTable<RegistryEntry>();
			this.authorityAddress = new EndPoint(configuration.Authority, serverAddress.Port);
		}

	    [HttpGet]
	    public IActionResult Get()
	    {
		    return this.Intercept(() =>
		    {
			    var registrationResponse = new RegistrationResponse()
			    {
				    Authority = authorityAddress,
				    Registry = dbConnection.Query<RegistryEntry>().OrderBy(x => x.Id).ToList()
			    };

			    return Ok(registrationResponse);
		    });
        }

		[HttpPost]
		public IActionResult Register([FromBody] Registration registration)
		{
			return this.Intercept(() =>
			{
				RegisterOrUpdateEntry(registration);

				var registrationResponse = new RegistrationResponse()
				{
					Authority = authorityAddress,
					Registration = registration,
					Registry = dbConnection.Query<RegistryEntry>().OrderByDescending(x => x.Id).ToList()
				};

				return Ok(registrationResponse);
			});
		}

		[HttpPost("unregister")]
		public IActionResult Unregister([FromBody] Registration registration)
		{
			return this.Intercept(() =>
			{
				UnregisterOrDeleteEntry(registration);

				var registrationResponse = new RegistrationResponse()
				{
					Authority = authorityAddress,
					Registration = registration,
					Registry = dbConnection.Query<RegistryEntry>().OrderByDescending(x => x.Id).ToList()
				};

				return Ok(registrationResponse);
			});
		}

		private void RegisterOrUpdateEntry(Registration registration)
		{
			dbConnection.CreateTable<RegistryEntry>();
			var entry = dbConnection.Query<RegistryEntry>($"WHERE Uri = '{registration.Source.ToUrl()}'").FirstOrDefault();

			if (entry == null)
			{
				entry = new RegistryEntry()
				{
					Name = registration.Name,
					Database = registration.Database,
					Uri = registration.Source.ToUrl(),
					Tags = string.Join(",", registration.Tags.Select(x => x.Trim())),
					LastUpdated = DateTime.UtcNow,
                    AuthorityUri = authorityAddress.ToUrl()
				};

				dbConnection.Insert(entry);
			}
			else
			{
				entry.LastUpdated = DateTime.UtcNow;
				dbConnection.Update(entry);
			}
		}

		private void UnregisterOrDeleteEntry(Registration registration)
		{
			dbConnection.CreateTable<RegistryEntry>();
			var entry = dbConnection.Query<RegistryEntry>($"WHERE Uri = '{registration.Source.ToUrl()}'").FirstOrDefault();
			if (entry != null)
			{
				dbConnection.Delete(entry);
			}
		}
	}
}