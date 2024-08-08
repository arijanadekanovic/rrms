using Microsoft.Extensions.DependencyInjection;
using RRMS.Microservices.Configuration.Extensions;

namespace RRMS.Storage.Application.Configuration;

public static class ServicesConfiguration
{
    public static IServiceCollection ConfigureApplication(this IServiceCollection services)
    {
        services.ConfigureMediatR(typeof(ServicesConfiguration).Assembly);

        return services;
    }
}
