using RRMS.Microservices.API.Options;
using RRMS.Microservices.Infrastructure.Options;
using RRMS.Microservices.SharedKernel.Extensions;

namespace RRMS.API.Configuration.Extensions;

internal static class AppOptionsConfiguration
{
    internal static IServiceCollection ConfigureAppOptions(this IServiceCollection services)
    {
        services
            .RegisterOptions<AccessTokenOptions>("AuthOptions:AccessTokenOptions")
            .RegisterOptions<RefreshTokenOptions>("AuthOptions:RefreshTokenOptions")
            .RegisterOptions<CORSOptions>("CORSOptions")
            .RegisterOptions<DatabaseOptions>("DatabaseOptions")
            .RegisterOptions<EmailOptions>("EmailOptions");

        return services;
    }
}
