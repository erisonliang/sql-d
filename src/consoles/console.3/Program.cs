using System.Diagnostics;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using SqlD;
using SqlD.Configuration.Model;
using SqlD.Tests.Framework;
using SqlD.Tests.Framework.Network;

namespace SqlD.Console_3
{
	internal class Program
	{
		private static void Main(string[] args)
		{
			var stopWatch = Stopwatch.StartNew();

			var listener = SqlDStart.NewListener().Hosting(typeof(SqlDStart).Assembly, "remote-db", "remote-target.db", SqlDPragmaModel.Default, WellKnown.EndPoints.Alpha);

			var remoteClient = SqlDStart.NewClient().ConnectedTo(WellKnown.EndPoints.Alpha);

			remoteClient.CreateTable<AnyTable>();

			var instances = GenFu.A.ListOf<AnyTable>(25);
			remoteClient.InsertMany(instances);
			remoteClient.UpdateMany(instances);

			remoteClient.Query<AnyTable>();
			remoteClient.DeleteMany(instances);

			listener.Dispose();

			stopWatch.Stop();

			System.Console.WriteLine($"Ran in {stopWatch.Elapsed.TotalSeconds}");

			//CreateTable();
			//ExecuteSingleConnectionMultipleThreadTest();
			//DropTable();

			System.Console.WriteLine("Finished!");
			System.Console.ReadLine();
		}

		private static void ExecuteSingleConnectionMultipleThreadTest()
		{
			var stopWatch = Stopwatch.StartNew();

			var numberOfIterations = 100000;

			var waitForInserts = new ManualResetEvent(false);
			var waitForUpdates = new ManualResetEvent(false);
			var waitForDeletes = new ManualResetEvent(false);

			var insertInstance = GenFu.GenFu.New<AnyTable>();

			StartInsertThread(numberOfIterations, insertInstance, waitForInserts);
			StartUpdateThread(numberOfIterations, waitForUpdates);
			StartDeleteThread(numberOfIterations, waitForDeletes);

			waitForInserts.WaitOne();
			waitForUpdates.WaitOne();
			waitForDeletes.WaitOne();

			stopWatch.Stop();

			System.Console.WriteLine($"\r\n\r\nRead/Write of {numberOfIterations} objects in {stopWatch.Elapsed.TotalMilliseconds}ms\r\n\r\n");
		}

		private static void StartUpdateThread(int numberOfIterations, ManualResetEvent waitForReads)
		{
			Task.Factory.StartNew(() =>
			{
				var connection = SqlDStart.NewDb().ConnectedTo("sql-d.db", SqlDPragmaModel.Default);

				for (var counter = 0; counter < numberOfIterations; counter++)
				{
					var result = connection.Query<AnyTable>("ORDER BY Id ASC LIMIT 1").FirstOrDefault();
					if (result != null)
					{
						connection.Update(result);
					}
					//Console.Write(".");
				}
				waitForReads.Set();
			});
		}

		private static void StartDeleteThread(int numberOfIterations, ManualResetEvent waitForReads)
		{
			Task.Factory.StartNew(() =>
			{
				var connection = SqlDStart.NewDb().ConnectedTo("sql-d.db", SqlDPragmaModel.Default);

				for (var counter = 0; counter < numberOfIterations; counter++)
				{
					var result = connection.Query<AnyTable>("ORDER BY Id ASC LIMIT 1").FirstOrDefault();
					if (result != null)
					{
						connection.Delete(result);
					}
					//Console.Write(".");
				}
				waitForReads.Set();
			});
		}

		private static void StartInsertThread(int numberOfIterations, AnyTable insertInstance, ManualResetEvent waitForWrites)
		{
			Task.Factory.StartNew(() =>
			{
				var connection = SqlDStart.NewDb().ConnectedTo("sql-d.db", SqlDPragmaModel.Default);

				for (var counter = 0; counter < numberOfIterations; counter++)
				{
					connection.Insert(insertInstance);
					//Console.Write("+");
				}
				waitForWrites.Set();
			});
		}


		private static void DropTable()
		{
			var connection = SqlDStart.NewDb().ConnectedTo("sql-d.db", SqlDPragmaModel.Default);
			connection.DropTable<AnyTable>();
		}

		private static void CreateTable()
		{
			var connection = SqlDStart.NewDb().ConnectedTo("sql-d.db", SqlDPragmaModel.Default);
			connection.CreateTable<AnyTable>();
		}
	}
}