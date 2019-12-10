using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using SqlD.Configuration;
using SqlD.Configuration.Model;
using SqlD.Network;

namespace SqlD.UI
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        public void ConfigureServices(IServiceCollection services)
        {
            var configuration = SqlDConfig.Get(typeof(Startup).Assembly);

            services.AddSingleton(configuration);
            services.AddSingleton(EndPoint.FromUri("http://localhost:5000"));
            services.AddSingleton(x => SqlDStart.NewDb().ConnectedTo("sql-d/ui", "sql-d.ui.db", SqlDPragmaModel.Default));

            services
                .AddMvc((options) => { options.EnableEndpointRouting = false; })
                .AddJsonOptions(options => { options.JsonSerializerOptions.IgnoreNullValues = true; });
            
            services.AddOpenApiDocument(settings =>
            {
                settings.DocumentName = "v1";
                settings.Title = "[ sql-d/ui ]";
                settings.Version = "1.0.0";
            });
        }

        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
            }

            app.UseStaticFiles();
            app.UseRouting();
            app.UseMvc();

            app.UseOpenApi();
            app.UseSwaggerUi3();
        }
    }
}
