using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using RRMS.Infrastructure.Configuration.Extensions;
using RRMS.Microservices.Infrastructure.Configuration.Extensions;

namespace RRMS.Infrastructure.Configuration;

public static class ServicesConfiguration
{
    public static IServiceCollection ConfigureInfrastructure(this IServiceCollection services, IConfiguration configuration)
    {
        services
            .ConfigureDatabase(configuration)
            .ConfigureIdentity()
            .ConfigureCurrentUser();

        return services;
    }
}
