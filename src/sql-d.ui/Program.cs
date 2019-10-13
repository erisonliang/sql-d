using System;
using System.IO;
using System.Reflection;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using SqlD.Logging;

namespace SqlD.UI
{
    public class Program
    {
        private static readonly Uri EntryAssemblyCodeBase = new Uri(Assembly.GetEntryAssembly().CodeBase);
        private static readonly string RootDirectoryPath = Path.GetDirectoryName(EntryAssemblyCodeBase.LocalPath);

        public static void Main(string[] args)
        {
	        var config = typeof(Program).Assembly.SqlDGo("appsettings.json");
	        try
	        {
		        BuildWebHost(args)?.Run();
	        }
	        finally
	        {
				SqlDStart.SqlDStop(config);
	        }
		}

		public static IWebHost BuildWebHost(string[] args)
	    {
		    try
		    {

                Log.Out.Info($"Entry assembly: {EntryAssemblyCodeBase}");
                Log.Out.Info($"Content Root: {RootDirectoryPath}");
                Log.Out.Info($"Current directory: {Environment.CurrentDirectory}");

                return WebHost.CreateDefaultBuilder(args)
					.UseKestrel(opts => {
						opts.ListenAnyIP(5000);
					})
					.UseContentRoot(RootDirectoryPath)
				    .UseStartup<Startup>()
				    .Build();
		    }
		    catch (Exception err)
		    {
				Log.Out.Error(err.ToString());
				Log.Out.Info("Press any key to continue....");
			    return null;
		    }
	    }
    }
}
