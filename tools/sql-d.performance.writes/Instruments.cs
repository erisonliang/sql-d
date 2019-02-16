using System;
using System.Diagnostics;
using System.Threading;
using System.Threading.Tasks;
using SqlD.Logging;

namespace SqlD.Tools.Performance.Writes
{
	public static class Instruments
	{
		private static Stopwatch stopWatch;

		private static long totalRecords;
		private static double totalSeconds;
		private static long totalRealtimeRecords;
		private static long previousTotalRealtimeRecords;

		private static Task totalPrintTask;
		private static Task totalSecondsTask;
		private static Task totalRealtimeRecordsTask;

		private static CancellationTokenSource totalPrintTaskCancelSource;
		private static CancellationTokenSource totalSecondsTaskCancelSource;
		private static CancellationTokenSource totalRealtimeRecordsTaskCancelSource;

		public static void Start()
		{
			totalPrintTaskCancelSource = new CancellationTokenSource();
			totalSecondsTaskCancelSource = new CancellationTokenSource();
			totalRealtimeRecordsTaskCancelSource = new CancellationTokenSource();

			stopWatch = Stopwatch.StartNew();

			totalSecondsTask = Task.Factory.StartNew(() =>
			{
				while (!totalSecondsTaskCancelSource.Token.IsCancellationRequested)
				{
					Interlocked.Exchange(ref totalSeconds, stopWatch.Elapsed.TotalSeconds);
					Thread.Sleep(TimeSpan.FromSeconds(1));
				}
			});

			totalRealtimeRecordsTask = Task.Factory.StartNew(() =>
			{
				while (!totalRealtimeRecordsTaskCancelSource.Token.IsCancellationRequested)
				{
					Interlocked.Exchange(ref previousTotalRealtimeRecords, totalRealtimeRecords);
					Interlocked.Exchange(ref totalRealtimeRecords, 0);
					Thread.Sleep(TimeSpan.FromSeconds(1));
				}
			});

			totalPrintTask = Task.Factory.StartNew(() =>
			{
				Log.Out.Info("Starting performance reporter for WRITES (RT = Realtime, AV = Accumulative Value)");
				while (!totalPrintTaskCancelSource.Token.IsCancellationRequested)
				{
					Log.Out.Info($"RT: {previousTotalRealtimeRecords}/sec AV: {Math.Round(totalRecords / totalSeconds, 0)}/sec");
					Thread.Sleep(TimeSpan.FromSeconds(1));
				}
			});
		}

		public static void IncrementRecordsBy(int instancesCount)
		{
			Interlocked.Exchange(ref totalRecords, totalRecords + instancesCount);
			Interlocked.Exchange(ref totalRealtimeRecords, totalRealtimeRecords + instancesCount);
		}

		public static void Stop()
		{
			totalPrintTaskCancelSource.Cancel();
			totalSecondsTaskCancelSource.Cancel();
			totalRealtimeRecordsTaskCancelSource.Cancel();

			Task.WaitAll(totalPrintTask, totalSecondsTask, totalRealtimeRecordsTask);
		}
	}
}