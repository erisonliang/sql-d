using System.IO;
using System.Reflection;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using SqlD.Configuration.Model;
using SqlD.Extensions.System.Reflection;

namespace SqlD.Configuration
{
	public class SqlDConfig
	{
		private static readonly object Synchronise = new object();

		public static SqlDConfiguration Get(Assembly entryAssembly, string settingsFile = "appsettings.json")
		{
			lock (Synchronise)
			{
				var workingDirectory = entryAssembly.GetDirectory();

				var configuration = new ConfigurationBuilder()
					.SetBasePath(workingDirectory)
					.AddJsonFile(settingsFile)
					.Build();

				var section = configuration.GetSection("SqlD");
				var config = section.Get<SqlDConfiguration>();
				return config;
			}
		}

		public static void Set(Assembly entryAssembly, SqlDConfiguration config, string settingsFile = "appsettings.json")
		{
			lock (Synchronise)
			{
				var workingDirectory = entryAssembly.GetDirectory();
				var settingsFilePath = Path.Combine(workingDirectory, settingsFile);

				var json = File.ReadAllText(settingsFilePath);
				var jsonInstance = JObject.Parse(json);
				jsonInstance["SqlD"] = JObject.Parse(JsonConvert.SerializeObject(config));

				json = JsonConvert.SerializeObject(jsonInstance, Formatting.Indented);
				File.WriteAllText(settingsFilePath, json);
			}
		}
	}
}