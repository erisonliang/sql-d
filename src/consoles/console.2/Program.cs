using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using SqlD.Configuration;
using SqlD.Configuration.Model;
using SqlD.Logging;

namespace SqlD.Console_2
{
	internal class Program
	{
		private static CancellationTokenSource readFromApiForeverTaskCancelSource;

		private static void Main(string[] args)
		{
			var config = SqlDConfig.Get(typeof(Program).Assembly);

			EnsureTableCreated(config);

			InitReadFromApiForever();

			var tasks = new List<Task>();

			var instances = GenFu.GenFu.ListOf<AnyTable>(10);

			for (var i = 0; i < Environment.ProcessorCount; i++)
			{
				tasks.Add(Task.Factory.StartNew(() =>
				{
					ReadFromApiForever(config, instances, "slave 1", "slave 2", "slave 3");
				}));
			}

			Instruments.Start();

			Log.Out.Info("Press <enter> to exit!");
			Console.ReadLine();

			Instruments.Stop();

			DisposeReadFromApiForever();

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

		public static void InitReadFromApiForever()
		{
			readFromApiForeverTaskCancelSource = new CancellationTokenSource();
		}

		public static void DisposeReadFromApiForever()
		{
			readFromApiForeverTaskCancelSource.Cancel();
		}

		public static void ReadFromApiForever(SqlDConfiguration config, List<AnyTable> instances, params string[] whereTagsEqual)
		{
			while (!readFromApiForeverTaskCancelSource.Token.IsCancellationRequested)
			{
				// Read
				foreach (var tag in whereTagsEqual)
				{
					foreach (var sqlDServiceModel in config.Services.Where(s => s.Tags.Contains(tag)))
					{
						var client = SqlDStart.NewClient().ConnectedTo(sqlDServiceModel.ToEndPoint());

						try
						{
							client.Query<AnyTable>($"LIMIT {instances.Count};").ToList();
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