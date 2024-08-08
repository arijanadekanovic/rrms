using Microsoft.Extensions.DependencyInjection;

namespace RRMS.Microservices.SharedKernel.Extensions;

public static class ServiceCollectionExtensions
{
    public static IServiceCollection RegisterOptions<TOptions>(this IServiceCollection services, string path) where TOptions : class
    {
        services
            .AddOptions<TOptions>()
            .BindConfiguration(path)
            .ValidateDataAnnotations()
            .ValidateOnStart();

        return services;
    }
}
