using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace SqlD.UI.Blazor
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var config = typeof(Program).Assembly.SqlDGo("appsettings.json");
            try
            {
                CreateHostBuilder(args).Build().Run();
            }
            finally
            {
                SqlDStart.SqlDStop(config);
            }
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<Startup>();
                });
    }
}