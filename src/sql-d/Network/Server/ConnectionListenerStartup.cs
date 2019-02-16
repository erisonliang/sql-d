using System.Reflection;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.DependencyInjection;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using SqlD.Configuration;
using SqlD.Configuration.Model;
using SqlD.Network.Server.Middleware;

namespace SqlD.Network.Server
{
    internal class ConnectionListenerStartup
    {
        public static Assembly StartAssembly;
        public static EndPoint ListenerAddress;
        public static DbConnection DbConnection;
        public static EndPoint[] ForwardAddresses;
        public string DbConnectionDbName = DbConnection.DatabaseName;

        public string DbConnectionName = DbConnection.Name;
        public SqlDPragmaModel PragmaOptions = DbConnection.PragmaOptions;

        public void ConfigureServices(IServiceCollection services)
        {
            var configuration = SqlDConfig.Get(StartAssembly);

            services.AddSingleton(configuration);
            services.AddSingleton(ListenerAddress);
            services.AddSingleton(x => SqlDStart.NewDb().ConnectedTo(DbConnectionName, DbConnectionDbName, PragmaOptions));

            services.AddCors();
            services.AddMvc()
                .SetCompatibilityVersion(CompatibilityVersion.Version_2_2)
                .AddJsonOptions(options =>
                {
                    options.SerializerSettings.Converters.Add(new StringEnumConverter());
                    options.SerializerSettings.NullValueHandling = NullValueHandling.Ignore;
                });

            services.AddSwaggerDocument(settings =>
            {
                settings.DocumentName = "v1";
                settings.Title = "[ sql-d ]";
                settings.Version = "1.0.0";
            });
        }

        public void Configure(IApplicationBuilder app)
        {
            app.UseStaticFiles();

            var middleware = new ForwardingMiddleware(ForwardAddresses);
            app.Use(async (ctx, next) => await middleware.InvokeAsync(ctx, next));

            app.UseCors(x => x.AllowAnyOrigin());
            app.UseMvc();

            app.UseSwagger();
            app.UseSwaggerUi3();
        }
    }
}