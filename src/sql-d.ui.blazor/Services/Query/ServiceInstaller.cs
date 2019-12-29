using Microsoft.Extensions.DependencyInjection;
using SqlD.UI.Services.Query.Actions;

namespace SqlD.UI.Services.Query
{
    public static class ServiceInstaller
    {
        public static void AddQuery(this IServiceCollection services)
        {
            services.AddActions();
            services.AddTransient<QueryCache>();
        }
    }
}