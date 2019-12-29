using Microsoft.Extensions.DependencyInjection;

namespace SqlD.UI.Services.Client
{
    public static class ServiceInstaller
    {
        public static void AddClient(this IServiceCollection services)
        {
            services.AddTransient<ClientFactory>();
        }
    }
}