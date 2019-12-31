using System;
using Microsoft.AspNetCore.Http;
using SqlD.Network;
using SqlD.Network.Server.Api.Registry.Model;
using SqlD.UI.Services.Extensions;

namespace SqlD.UI.Models.Registry
{
	public class RegistryEntryViewModel
	{
		public RegistryEntryViewModel()
		{
			Uri = string.Empty;
			Name = string.Empty;
			Database = string.Empty;
			AuthorityUri = string.Empty;
			State = string.Empty;
			Tags = string.Empty;
			LastUpdated = DateTime.UtcNow;
			this.EndPoint = new EndPoint();
		}

		public RegistryEntryViewModel(RegistryEntry entry, IHttpContextAccessor accessor)
		{
			Uri = entry.Uri;
			Name = entry.Name;
			Database = entry.Database;
			AuthorityUri = entry.AuthorityUri;
			State = entry.State.ToString();
			Tags = string.Join(", ", entry.TagsAsArray);
			LastUpdated = entry.LastUpdated;
			EndPoint = EndPoint.FromUri(entry.Uri);
			RedirectedUri = EndPoint.GetRedirectedUri(accessor);
			RedirectedAuthorityUri = AuthorityUri.GetRedirectedUri(accessor);
		}

		public DateTime LastUpdated { get; set; }
		public string Tags { get; set; }
		public string Name { get; set; }
		public string State { get; set; }
		public string Database { get; set; }
		public string AuthorityUri { get; set; }
		public string Uri { get; set; }
		public EndPoint EndPoint { get; set; }
		public bool Selected { get; set; }
		public string RedirectedUri { get; set; }
		public string RedirectedAuthorityUri { get; set; }

		public string Host
		{
			get => EndPoint.Host;
			set => EndPoint.Host = value;
		}

		public int Port
		{
			get => EndPoint.Port;
			set => EndPoint.Port = value;
		}

		public override string ToString()
		{
			return $"{nameof(Name)}: {Name}, {nameof(Database)}: {Database}, {nameof(Uri)}: {Uri}";
		}
	}
}