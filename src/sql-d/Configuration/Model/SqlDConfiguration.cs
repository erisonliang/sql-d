using System.Collections.Generic;

namespace SqlD.Configuration.Model
{
	public class SqlDConfiguration
	{
		public bool Enabled { get; set; }
		public string Authority { get; set; }
		public SqlDProcessModel ProcessModel { get; set; }
		public List<SqlDServiceModel> Services { get; set; } = new List<SqlDServiceModel>();
		public List<SqlDRegistryModel> Registries { get; set; } = new List<SqlDRegistryModel>();

		public override string ToString()
		{
			return $"{nameof(Enabled)}: {Enabled}, {nameof(Services)}: {Services}, {nameof(Registries)}: {Registries}";
		}
	}
}