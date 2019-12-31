using System.Collections.Generic;
using System.Net;
using Microsoft.AspNetCore.Http;
using SqlD.UI.Models.Discovery;
using SqlD.UI.Models.Registry;

namespace SqlD.UI.Models.Root
{
	public class RootTableResultViewModel
	{
		public string Table { get; }
		public List<LinkViewModel> Links { get; } = new List<LinkViewModel>();

		public RootTableResultViewModel(string table, RegistryViewModel registry)
		{
			Table = table;
			foreach (var registryEntry in registry.Entries)
			{
				if (registryEntry.Tags.Contains("registry")) continue;
				Links.Add(new LinkViewModel($"/api/query/describe {table}/{WebUtility.UrlEncode(registryEntry.RedirectedUri)}", "describe", registryEntry.RedirectedAuthorityUri, registryEntry.RedirectedUri, registryEntry.Tags));
				Links.Add(new LinkViewModel($"/api/query/select * from {table} limit 100/{WebUtility.UrlEncode(registryEntry.RedirectedUri)}", "query", registryEntry.RedirectedAuthorityUri, registryEntry.RedirectedUri, registryEntry.Tags));
			}
		}
	}
}