﻿using System.Collections.Generic;
using System.Linq;
using System.Net;
using Microsoft.AspNetCore.Http;
using SqlD.Network.Server.Api.Db.Model;
using SqlD.UI.Models.Discovery;
using SqlD.UI.Models.Registry;

namespace SqlD.UI.Models.Query
{
	public class DescribeResultViewModel
	{
		public DescribeResultViewModel(string error)
		{
			Error = error;
		}

		public DescribeResultViewModel(DescribeResponse response, RegistryViewModel registry)
		{
			this.Table = response.Query.TableName;
			this.Columns = response.Columns;
			this.Rows = response.Results;
			this.Links.Add(new LinkViewModel($"/api", "tables", registry.Entries.First().RedirectedUri, string.Empty, string.Empty));
			foreach (var registryEntry in registry.Entries)
			{
				if (registryEntry.Tags.Contains("registry")) continue;
				Links.Add(new LinkViewModel($"/api/query/describe {Table}/{WebUtility.UrlEncode(registryEntry.RedirectedUri)}", "describe", registryEntry.RedirectedAuthorityUri, registryEntry.RedirectedUri, registryEntry.Tags));
				Links.Add(new LinkViewModel($"/api/query/select * from {Table} limit 100/{WebUtility.UrlEncode(registryEntry.RedirectedUri)}", "query", registryEntry.RedirectedAuthorityUri, registryEntry.RedirectedUri, registryEntry.Tags));
			}
		}

		public string Error { get; set; }
		public string Table { get; set; }
		public string[] Columns { get; set; }
		public List<List<object>> Rows { get; set; }
		public List<LinkViewModel> Links { get; } = new List<LinkViewModel>();

	}
}