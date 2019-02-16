using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using SqlD.Configuration;
using SqlD.Configuration.Model;
using SqlD.Console_2;
using SqlD.Logging;

namespace SqlD.Console_1
{
	internal class Program
	{
		private static CancellationTokenSource writeToApiForeverTaskCancelSource;

		private static void Main(string[] args)
		{
			SqlDConfiguration config = null;

			config = SqlDConfig.Get(typeof(Program).Assembly);

			EnsureTableCreated(config);

			InitWriteToApiForever();

			var instances = GenFu.GenFu.ListOf<AnyTable>(10);

			var tasks = new List<Task>();

			for (var i = 0; i < Environment.ProcessorCount; i++)
			{
				tasks.Add(Task.Factory.StartNew(() =>
				{
					WriteToApiForever(config, instances, "master");
				}));
			}

			Instruments.Start();

			Log.Out.Info("Press <enter> to exit!");
			Console.ReadLine();

			Instruments.Stop();

			DisposeWriteToApiForever();

			Task.WaitAll(tasks.ToArray());
		}

		public static void EnsureTableCreated(SqlDConfiguration config)
		{
			foreach (var sqlDServiceModel in config.Services.Where(s => !s.Tags.Contains("registry")))
			{
				var client = SqlDStart.NewClient().ConnectedTo(sqlDServiceModel.ToEndPoint());
				client.CreateTable<AnyTable>();
			}
		}

		public static void InitWriteToApiForever()
		{
			writeToApiForeverTaskCancelSource = new CancellationTokenSource();
		}

		public static void DisposeWriteToApiForever()
		{
			writeToApiForeverTaskCancelSource.Cancel();
		}

		public static void WriteToApiForever(SqlDConfiguration config, List<AnyTable> instances, params string[] whereTagsEqual)
		{
			while (!writeToApiForeverTaskCancelSource.Token.IsCancellationRequested)
			{
				// Write
				foreach (var tag in whereTagsEqual)
				{
					foreach (var sqlDServiceModel in config.Services.Where(s => s.Tags.Contains(tag)))
					{
						var client = SqlDStart.NewClient().ConnectedTo(sqlDServiceModel.ToEndPoint());

						try
						{
							client.InsertMany(instances, false);
							Instruments.IncrementRecordsBy(instances.Count);
						}
						catch (Exception err)
						{
							Console.WriteLine(err.ToString());
						}
					}
				}
			}
		}
	}
}