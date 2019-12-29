using Microsoft.Extensions.DependencyInjection;

namespace SqlD.UI.Services.Query.Actions
{
    public static class ServiceInstaller
    {
        public static void AddActions(this IServiceCollection services)
        {
            services.AddTransient<CommandAction>();
            services.AddTransient<DescribeAction>();
            services.AddTransient<QueryAction>();
            services.AddTransient<UnknownAction>();
        }
    }
}