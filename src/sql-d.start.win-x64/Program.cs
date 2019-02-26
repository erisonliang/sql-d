using System;
using System.Linq;
using SqlD.Configuration;
using SqlD.Configuration.Model;
using SqlD.Options;

namespace SqlD.Start.win_x64
{
	internal class Program
	{
		private static void Main(string[] args)
		{
		    if (args.Length == 0)
		    {
                CommandParser.Info<Arguments>();
		        return;
		    }

			var entryAssembly = typeof(Program).Assembly;
			var config = SqlDConfig.Get(entryAssembly);

			try
			{
				config.ProcessModel.Distributed = false;
				var arguments = ArgumentsParser.Parse<Arguments>(args);

				if (arguments.Registries.Any())
				{
					config.Registries.Clear();
					config.Registries.AddRange(
						arguments.Registries.Select(x =>
							new SqlDRegistryModel()
							{
								Host = x.Split(':')[0],
								Port = int.Parse(x.Split(':')[1])
							}));
				}

				if (!string.IsNullOrEmpty(arguments.Service))
				{
					if (!arguments.Registries.Any())
					{
						config.Registries.Add(
							new SqlDRegistryModel()
							{
								Host = arguments.Service.Split(':')[0],
								Port = int.Parse(arguments.Service.Split(':')[1])
							});
					}

					config.Services.Clear();
					config.Services.Add(
						new SqlDServiceModel
						{
							Name = arguments.Name,
							Database = arguments.Database,
							Host = arguments.Service.Split(':')[0],
							Port = int.Parse(arguments.Service.Split(':')[1]),
							Tags = arguments.Tags.ToList(),
							Pragma = new SqlDPragmaModel()
							{
								CountChanges = arguments.PragmaCountChanges,
								JournalMode = arguments.PragmaJournalMode,
								LockingMode = arguments.PragmaLockingMode,
								Synchronous = arguments.PragmaSynchronous,
								TempStore = arguments.PragmaTempStore,
								PageSize = arguments.PragmaPageSize,
								CacheSize = arguments.PragmaCacheSize,
								QueryOnly = arguments.PragmaQueryOnly
							}
						});
				}

				if (arguments.Forwards.Any())
				{
					foreach (var forward in arguments.Forwards)
					{
						config.Services.ForEach(x => x.ForwardingTo.Add(new SqlDForwardingModel()
						{
							Host = forward.Split(':')[0],
							Port = int.Parse(forward.Split(':')[1])
						}));
					}
				}

				entryAssembly.SqlDGo(config);

				if (arguments.Wait)
				{
					Console.WriteLine("Press enter to quit...");
					Console.ReadLine();
				}
			}
			catch (Exception err)
			{
				Console.WriteLine(err);
				Console.ReadLine();
			}
			finally
			{
				SqlDStart.SqlDStop(config);
			}
		}
	}
}