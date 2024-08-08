using Microsoft.Extensions.DependencyInjection;
using RRMS.Microservices.Infrastructure.Configuration.Extensions;
using RRMS.Storage.Infrastructure.Configuration.Extensions;

namespace RRMS.Storage.Infrastructure.Configuration;

public static class ServicesConfiguration
{
    public static IServiceCollection ConfigureInfrastructure(this IServiceCollection services)
    {
        services
            .ConfigureCurrentUser()
            .ConfigureServices();

        return services;
    }
}
