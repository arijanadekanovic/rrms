﻿using RRMS.Microservices.API.Options;
using RRMS.Microservices.Infrastructure.Options;
using RRMS.Microservices.SharedKernel.Extensions;

namespace RRMS.Storage.API.Configuration.Extensions;

internal static class AppOptionsConfiguration
{
    internal static IServiceCollection ConfigureAppOptions(this IServiceCollection services)
    {
        services
            .RegisterOptions<AccessTokenOptions>("AuthOptions:AccessTokenOptions")
            .RegisterOptions<AppOptions>("AppOptions")
            .RegisterOptions<CORSOptions>("CORSOptions")
            .RegisterOptions<DatabaseOptions>("DatabaseOptions")
            .RegisterOptions<EmailOptions>("EmailOptions");

        return services;
    }
}
