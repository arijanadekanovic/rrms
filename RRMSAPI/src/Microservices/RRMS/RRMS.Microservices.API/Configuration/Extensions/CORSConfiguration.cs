using Microsoft.Extensions.DependencyInjection;
using RRMS.Microservices.API.Options;

namespace RRMS.Microservices.API.Configuration.Extensions;

public static class CORSConfiguration
{
    public static IServiceCollection ConfigureCORS(this IServiceCollection services, CORSOptions corsOptions)
    {
        services.AddCors(options => options.AddDefaultPolicy(
               policy => policy.WithOrigins(corsOptions.AllowedOrigins).AllowAnyHeader().AllowAnyMethod()));

        return services;
    }
}
